/*
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright © 2019 Keith Packard
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials provided
 *    with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

ENTRY(_start)

/*
 * These values should be provided by the application. We'll include
 * some phony values here to make things link for testing
 */

MEMORY
{
	flash (rx!w) :
		ORIGIN = DEFINED(__flash) ? __flash : 0x10000000,
		LENGTH = DEFINED(__flash_size) ? __flash_size : 0x00010000
	ram (w!rx) :
		ORIGIN = DEFINED(__ram) ? __ram : 0x20000000,
		LENGTH = DEFINED(__ram_size) ? __ram_size : 0x00008000
}

PHDRS
{
	text PT_LOAD;
	ram PT_LOAD;
	ram_init PT_LOAD;
	tls PT_TLS;
}

SECTIONS
{
	PROVIDE(__stack = ORIGIN(ram) + LENGTH(ram));

	.init : {
		KEEP (*(.text.init.enter))
		KEEP (*(.data.init.enter))
		KEEP (*(SORT_BY_NAME(.init) SORT_BY_NAME(.init.*)))
	} >flash AT>flash :text

	.text : {

		/* code */
		*(.text.unlikely .text.unlikely.*)
		*(.text.startup .text.startup.*)
		*(.text .text.* .opd .opd.*)
		*(.gnu.linkonce.t.*)
		KEEP (*(.fini .fini.*))
		__text_end = .;

		PROVIDE (__etext = __text_end);
		PROVIDE (_etext = __text_end);
		PROVIDE (etext = __text_end);

		/* Need to pre-align so that the symbols come after padding */
		. = ALIGN(8);

		/* lists of constructors and destructors */
		PROVIDE_HIDDEN ( __preinit_array_start = . );
		KEEP (*(.preinit_array))
		PROVIDE_HIDDEN ( __preinit_array_end = . );

		PROVIDE_HIDDEN ( __init_array_start = . );
		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
		KEEP (*(.init_array .ctors))
		PROVIDE_HIDDEN ( __init_array_end = . );

		PROVIDE_HIDDEN ( __fini_array_start = . );
		KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
		KEEP (*(.fini_array .dtors))
		PROVIDE_HIDDEN ( __fini_array_end = . );

	} >flash AT>flash :text

	.rodata : {

		/* read-only data */
		*(.rdata)
		*(.rodata .rodata.*)
		*(.gnu.linkonce.r.*)

		*(.srodata.cst16)
		*(.srodata.cst8)
		*(.srodata.cst4)
		*(.srodata.cst2)
		*(.srodata .srodata.*)

	} >flash AT>flash :text

	.data.rel.ro : {

		/* data that needs relocating */
		*(.data.rel.ro .data.rel.ro.*)

	} >flash AT>flash :text

	/*
	 * Needs to be in its own segment with the PLT entries first
	 * so that the linker will compute the offsets to those
	 * entries correctly.
	 */
	.got : {
		*(.got.plt)
		*(.got)
	} >flash AT>flash :text

	.toc : {
		*(.toc .toc.*)
	} >flash AT>flash :text

	/* additional sections when compiling with C++ exception support */
	/*
	.except_ordered : {
		*(.gcc_except_table *.gcc_except_table.*)
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	} >flash AT>flash :text
	.eh_frame_hdr : {
		PROVIDE_HIDDEN ( __eh_frame_hdr_start = . );
		*(.eh_frame_hdr) *(.eh_frame_entry .eh_frame_entry.*)
		PROVIDE_HIDDEN ( __eh_frame_hdr_end = . );
	} >flash AT>flash :text
	.eh_frame : {
		PROVIDE_HIDDEN ( __eh_frame_start = . );
		KEEP (*(.eh_frame .eh_frame.*))
		PROVIDE_HIDDEN ( __eh_frame_end = . );
	} >flash AT>flash :text

	.except_unordered : {
		. = ALIGN(8);

		PROVIDE(__exidx_start = .);
		*(.ARM.exidx*)
		PROVIDE(__exidx_end = .);
	} >flash AT>flash :text
	*/

	/*
	 * Data values which are preserved across reset
	 */
	.preserve (NOLOAD) : {
		PROVIDE(__preserve_start__ = .);
		KEEP(*(SORT_BY_NAME(.preserve.*)))
		KEEP(*(.preserve))
		PROVIDE(__preserve_end__ = .);
	} >ram AT>ram :ram

	.data :  ALIGN_WITH_INPUT  {
		*(.data .data.*)
		*(.gnu.linkonce.d.*)

		/* Need to pre-align so that the symbols come after padding */
		. = ALIGN(8);

		PROVIDE( __global_pointer$ = . + 0x800 );
		PROVIDE( _gp = . + 0x8000);
		*(.sdata .sdata.* .sdata2.*)
		*(.gnu.linkonce.s.*)
	} >ram AT>flash :ram_init
	PROVIDE(__data_start = ADDR(.data));
	PROVIDE(__data_source = LOADADDR(.data));

	/* Thread local initialized data. This gets
	 * space allocated as it is expected to be placed
	 * in ram to be used as a template for TLS data blocks
	 * allocated at runtime. We're slightly abusing that
	 * by placing the data in flash where it will be copied
	 * into the allocate ram addresses by the existing
	 * data initialization code in crt0.
	 * BFD includes .tbss alignment when computing .tdata
	 * alignment, but for ld.lld we have to explicitly pad
	 * as it only guarantees usage as a TLS template works
	 * rather than supporting this use case.
	 */
	.tdata : /* For ld.lld:  ALIGN(__tls_align) */  ALIGN_WITH_INPUT  {
		*(.tdata .tdata.* .gnu.linkonce.td.*)
		PROVIDE(__data_end = .);
		PROVIDE(__tdata_end = .);
	} >ram AT>flash :tls :ram_init
	PROVIDE( __tls_base = ADDR(.tdata));
	PROVIDE( __tdata_start = ADDR(.tdata));
	PROVIDE( __tdata_source = LOADADDR(.tdata) );
	PROVIDE( __tdata_source_end = LOADADDR(.tdata) + SIZEOF(.tdata) );
	PROVIDE( __data_source_end = __tdata_source_end );
	PROVIDE( __tdata_size = SIZEOF(.tdata) );

	PROVIDE( __edata = __data_end );
	PROVIDE( _edata = __data_end );
	PROVIDE( edata = __data_end );
	PROVIDE( __data_size = __data_end - __data_start );
	PROVIDE( __data_source_size = __data_source_end - __data_source );

	.tbss (NOLOAD) : {
		*(.tbss .tbss.* .gnu.linkonce.tb.*)
		*(.tcommon)
		PROVIDE( __tls_end = . );
		PROVIDE( __tbss_end = . );
	} >ram AT>ram :tls :ram
	PROVIDE( __bss_start = ADDR(.tbss));
	PROVIDE( __tbss_start = ADDR(.tbss));
	PROVIDE( __tbss_offset = ADDR(.tbss) - ADDR(.tdata) );
	PROVIDE( __tbss_size = SIZEOF(.tbss) );
	PROVIDE( __tls_size = __tls_end - __tls_base );
	PROVIDE( __tls_align = MAX(ALIGNOF(.tdata), ALIGNOF(.tbss)) );
	PROVIDE( __tls_size_align = (__tls_size + __tls_align - 1) & ~(__tls_align - 1));
	PROVIDE( __arm32_tls_tcb_offset = MAX(8, __tls_align) );
	PROVIDE( __arm64_tls_tcb_offset = MAX(16, __tls_align) );

	/*
	 * Unlike ld.lld, ld.bfd does not advance the location counter for
	 * .tbss, but we actually need memory allocated for .tbss as we use
	 * it for the initial TLS storage.
	 * Create special section here just to make room.
	 */
        
        .tbss_space (NOLOAD) : {
		. = ADDR(.tbss);
		. = . + SIZEOF(.tbss);
	} >ram AT>ram :ram
	
	.bss (NOLOAD) : {
		*(.sbss*)
		*(.gnu.linkonce.sb.*)
		*(.bss .bss.*)
		*(.gnu.linkonce.b.*)
		*(COMMON)

		/* Align the heap */
		. = ALIGN(8);
		__bss_end = .;
	} >ram AT>ram :ram
	PROVIDE( __non_tls_bss_start = ADDR(.bss) );
	PROVIDE( __end = __bss_end );
	_end = __bss_end;
	PROVIDE( end = __bss_end );
	PROVIDE( __bss_size = __bss_end - __bss_start );

	/* Make the rest of memory available for heap storage */
	PROVIDE (__heap_start = __end);
	PROVIDE (__heap_end = __stack - (DEFINED(__stack_size) ? __stack_size : 0x00001000));
	PROVIDE (__heap_size = __heap_end - __heap_start);

        /* Allow a minimum heap size to be specified */
        .heap (NOLOAD) : {
                . += (DEFINED(__heap_size_min) ? __heap_size_min : 0);
        } >ram :ram

	/* Define a stack region to make sure it fits in memory */
	.stack (NOLOAD) : {
		. += (DEFINED(__stack_size) ? __stack_size : 0x00001000);
	} >ram :ram

	/* Throw away C++ exception handling information */

	

	/DISCARD/ : {
		*(.note .note.*)
		*(.eh_frame .eh_frame.*)
		*(.ARM.extab* .gnu.linkonce.armextab.*)
		*(.ARM.exidx*)
	}

	

	/* Stabs debugging sections.  */
	.stab          0 : { *(.stab) }
	.stabstr       0 : { *(.stabstr) }
	.stab.excl     0 : { *(.stab.excl) }
	.stab.exclstr  0 : { *(.stab.exclstr) }
	.stab.index    0 : { *(.stab.index) }
	.stab.indexstr 0 : { *(.stab.indexstr) }
	.comment       0 : { *(.comment) }
	.gnu.build.attributes : { *(.gnu.build.attributes .gnu.build.attributes.*) }
	/* DWARF debug sections.
	   Symbols in the DWARF debugging sections are relative to the beginning
	   of the section so we begin them at 0.  */
	/* DWARF 1.  */
	.debug          0 : { *(.debug) }
	.line           0 : { *(.line) }
	/* GNU DWARF 1 extensions.  */
	.debug_srcinfo  0 : { *(.debug_srcinfo) }
	.debug_sfnames  0 : { *(.debug_sfnames) }
	/* DWARF 1.1 and DWARF 2.  */
	.debug_aranges  0 : { *(.debug_aranges) }
	.debug_pubnames 0 : { *(.debug_pubnames) }
	/* DWARF 2.  */
	.debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
	.debug_abbrev   0 : { *(.debug_abbrev) }
	.debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end) }
	.debug_frame    0 : { *(.debug_frame) }
	.debug_str      0 : { *(.debug_str) }
	.debug_loc      0 : { *(.debug_loc) }
	.debug_macinfo  0 : { *(.debug_macinfo) }
	/* SGI/MIPS DWARF 2 extensions.  */
	.debug_weaknames 0 : { *(.debug_weaknames) }
	.debug_funcnames 0 : { *(.debug_funcnames) }
	.debug_typenames 0 : { *(.debug_typenames) }
	.debug_varnames  0 : { *(.debug_varnames) }
	/* DWARF 3.  */
	.debug_pubtypes 0 : { *(.debug_pubtypes) }
	.debug_ranges   0 : { *(.debug_ranges) }
	/* DWARF 5.  */
	.debug_addr     0 : { *(.debug_addr) }
	.debug_line_str 0 : { *(.debug_line_str) }
	.debug_loclists 0 : { *(.debug_loclists) }
	.debug_macro    0 : { *(.debug_macro) }
	.debug_names    0 : { *(.debug_names) }
	.debug_rnglists 0 : { *(.debug_rnglists) }
	.debug_str_offsets 0 : { *(.debug_str_offsets) }
	.debug_sup      0 : { *(.debug_sup) }
	.gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
}
/*
 * Check that sections that are copied from flash to RAM have matching
 * padding, so that a single memcpy() of __data_size copies the correct bytes.
 */
ASSERT( __data_size == __data_source_size,
	"ERROR: .data/.tdata flash size does not match RAM size");
