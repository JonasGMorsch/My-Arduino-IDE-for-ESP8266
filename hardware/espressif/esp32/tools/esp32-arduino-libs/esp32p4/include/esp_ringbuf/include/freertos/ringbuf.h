/*
 * SPDX-FileCopyrightText: 2023-2025 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Type by which ring buffers are referenced. For example, a call to xRingbufferCreate()
 * returns a RingbufHandle_t variable that can then be used as a parameter to
 * xRingbufferSend(), xRingbufferReceive(), etc.
 */
typedef void * RingbufHandle_t;

typedef enum {
    /**
     * No-split buffers will only store an item in contiguous memory and will
     * never split an item. Each item requires an 8 byte overhead for a header
     * and will always internally occupy a 32-bit aligned size of space.
     */
    RINGBUF_TYPE_NOSPLIT = 0,
    /**
     * Allow-split buffers will split an item into two parts if necessary in
     * order to store it. Each item requires an 8 byte overhead for a header,
     * splitting incurs an extra header. Each item will always internally occupy
     * a 32-bit aligned size of space.
     */
    RINGBUF_TYPE_ALLOWSPLIT,
    /**
     * Byte buffers store data as a sequence of bytes and do not maintain separate
     * items, therefore byte buffers have no overhead. All data is stored as a
     * sequence of byte and any number of bytes can be sent or retrieved each
     * time.
     */
    RINGBUF_TYPE_BYTEBUF,
    RINGBUF_TYPE_MAX,
} RingbufferType_t;

/**
 * @brief Struct that is equivalent in size to the ring buffer's data structure
 *
 * The contents of this struct are not meant to be used directly. This
 * structure is meant to be used when creating a statically allocated ring
 * buffer where this struct is of the exact size required to store a ring
 * buffer's control data structure.
 *
 */
typedef struct xSTATIC_RINGBUFFER {
    /** @cond */    //Doxygen command to hide this structure from API Reference
    size_t xDummy1[2];
    UBaseType_t uxDummy2;
    void *pvDummy3[11];
    BaseType_t xDummy4;
    StaticList_t xDummy5[2];
    void * pvDummy6;
    portMUX_TYPE muxDummy;
    /** @endcond */
} StaticRingbuffer_t;

/**
 * @brief       Create a ring buffer
 *
 * @param[in]   xBufferSize Size of the buffer in bytes. Note that items require
 *              space for a header in no-split/allow-split buffers
 * @param[in]   xBufferType Type of ring buffer, see documentation.
 *
 * @note    xBufferSize of no-split/allow-split buffers will be rounded up to the nearest 32-bit aligned size.
 *
 * @return  A handle to the created ring buffer, or NULL in case of error.
 */
RingbufHandle_t xRingbufferCreate(size_t xBufferSize, RingbufferType_t xBufferType);

/**
 * @brief Create a ring buffer of type RINGBUF_TYPE_NOSPLIT for a fixed item_size
 *
 * This API is similar to xRingbufferCreate(), but it will internally allocate
 * additional space for the headers.
 *
 * @param[in]   xItemSize   Size of each item to be put into the ring buffer
 * @param[in]   xItemNum    Maximum number of items the buffer needs to hold simultaneously
 *
 * @return  A RingbufHandle_t handle to the created ring buffer, or NULL in case of error.
 */
RingbufHandle_t xRingbufferCreateNoSplit(size_t xItemSize, size_t xItemNum);

/**
 * @brief       Create a ring buffer but manually provide the required memory
 *
 * @param[in]   xBufferSize Size of the buffer in bytes.
 * @param[in]   xBufferType Type of ring buffer, see documentation
 * @param[in]   pucRingbufferStorage Pointer to the ring buffer's storage area.
 *              Storage area must have the same size as specified by xBufferSize
 * @param[in]   pxStaticRingbuffer Pointed to a struct of type StaticRingbuffer_t
 *              which will be used to hold the ring buffer's data structure
 *
 * @note    xBufferSize of no-split/allow-split buffers MUST be 32-bit aligned.
 *
 * @return  A handle to the created ring buffer
 */
RingbufHandle_t xRingbufferCreateStatic(size_t xBufferSize,
                                        RingbufferType_t xBufferType,
                                        uint8_t *pucRingbufferStorage,
                                        StaticRingbuffer_t *pxStaticRingbuffer);

/**
 * @brief       Insert an item into the ring buffer
 *
 * Attempt to insert an item into the ring buffer. This function will block until
 * enough free space is available or until it times out.
 *
 * @param[in]   xRingbuffer     Ring buffer to insert the item into
 * @param[in]   pvItem          Pointer to data to insert. NULL is allowed if xItemSize is 0.
 * @param[in]   xItemSize       Size of data to insert.
 * @param[in]   xTicksToWait    Ticks to wait for room in the ring buffer.
 *
 * @note    For no-split/allow-split ring buffers, the actual size of memory that
 *          the item will occupy will be rounded up to the nearest 32-bit aligned
 *          size. This is done to ensure all items are always stored in 32-bit
 *          aligned fashion.
 * @note    For no-split/allow-split buffers, an xItemSize of 0 will result in
 *          an item with no data being set (i.e., item only contains the header).
 *          For byte buffers, an xItemSize of 0 will simply return pdTRUE without
 *          copying any data.
 *
 * @return
 *      - pdTRUE if succeeded
 *      - pdFALSE on time-out or when the data is larger than the maximum permissible size of the buffer
 */
BaseType_t xRingbufferSend(RingbufHandle_t xRingbuffer,
                           const void *pvItem,
                           size_t xItemSize,
                           TickType_t xTicksToWait);

/**
 * @brief       Insert an item into the ring buffer in an ISR
 *
 * Attempt to insert an item into the ring buffer from an ISR. This function
 * will return immediately if there is insufficient free space in the buffer.
 *
 * @param[in]   xRingbuffer Ring buffer to insert the item into
 * @param[in]   pvItem      Pointer to data to insert. NULL is allowed if xItemSize is 0.
 * @param[in]   xItemSize   Size of data to insert.
 * @param[out]  pxHigherPriorityTaskWoken   Value pointed to will be set to pdTRUE if the function woke up a higher priority task.
 *
 * @note    For no-split/allow-split ring buffers, the actual size of memory that
 *          the item will occupy will be rounded up to the nearest 32-bit aligned
 *          size. This is done to ensure all items are always stored in 32-bit
 *          aligned fashion.
 * @note    For no-split/allow-split buffers, an xItemSize of 0 will result in
 *          an item with no data being set (i.e., item only contains the header).
 *          For byte buffers, an xItemSize of 0 will simply return pdTRUE without
 *          copying any data.
 *
 * @return
 *      - pdTRUE if succeeded
 *      - pdFALSE when the ring buffer does not have space.
 */
BaseType_t xRingbufferSendFromISR(RingbufHandle_t xRingbuffer,
                                  const void *pvItem,
                                  size_t xItemSize,
                                  BaseType_t *pxHigherPriorityTaskWoken);

/**
 * @brief Acquire memory from the ring buffer to be written to by an external
 *        source and to be sent later.
 *
 * Attempt to allocate buffer for an item to be sent into the ring buffer. This
 * function will block until enough free space is available or until it
 * times out.
 *
 * The item, as well as the following items ``SendAcquire`` or ``Send`` after it,
 * will not be able to be read from the ring buffer until this item is actually
 * sent into the ring buffer.
 *
 * @param[in]   xRingbuffer     Ring buffer to allocate the memory
 * @param[out]  ppvItem         Double pointer to memory acquired (set to NULL if no memory were retrieved)
 * @param[in]   xItemSize       Size of item to acquire.
 * @param[in]   xTicksToWait    Ticks to wait for room in the ring buffer.
 *
 * @note Only applicable for no-split ring buffers now, the actual size of
 *       memory that the item will occupy will be rounded up to the nearest 32-bit
 *       aligned size. This is done to ensure all items are always stored in 32-bit
 *       aligned fashion.
 * @note An xItemSize of 0 will result in a buffer being acquired, but the buffer
 *       will have a size of 0.
 *
 * @return
 *      - pdTRUE if succeeded
 *      - pdFALSE on time-out or when the data is larger than the maximum permissible size of the buffer
 */
BaseType_t xRingbufferSendAcquire(RingbufHandle_t xRingbuffer, void **ppvItem, size_t xItemSize, TickType_t xTicksToWait);

/**
 * @brief       Actually send an item into the ring buffer allocated before by
 *              ``xRingbufferSendAcquire``.
 *
 * @param[in]   xRingbuffer     Ring buffer to insert the item into
 * @param[in]   pvItem          Pointer to item in allocated memory to insert.
 *
 * @note Only applicable for no-split ring buffers. Only call for items
 *       allocated by ``xRingbufferSendAcquire``.
 *
 * @return
 *      - pdTRUE if succeeded
 *      - pdFALSE if fail for some reason.
 */
BaseType_t xRingbufferSendComplete(RingbufHandle_t xRingbuffer, void *pvItem);

/**
 * @brief   Retrieve an item from the ring buffer
 *
 * Attempt to retrieve an item from the ring buffer. This function will block
 * until an item is available or until it times out.
 *
 * @param[in]   xRingbuffer     Ring buffer to retrieve the item from
 * @param[out]  pxItemSize      Pointer to a variable to which the size of the retrieved item will be written.
 * @param[in]   xTicksToWait    Ticks to wait for items in the ring buffer.
 *
 * @note    A call to vRingbufferReturnItem() is required after this to free the item retrieved.
 * @note    It is possible to receive items with a pxItemSize of 0 on no-split buffers.
 * @note    To retrieve an item from an allow-split buffer, use `xRingbufferReceiveSplit()` instead.
 *
 * @return
 *      - Pointer to the retrieved item on success; *pxItemSize filled with the length of the item.
 *      - NULL on timeout, *pxItemSize is untouched in that case.
 */
void *xRingbufferReceive(RingbufHandle_t xRingbuffer, size_t *pxItemSize, TickType_t xTicksToWait);

/**
 * @brief   Retrieve an item from the ring buffer in an ISR
 *
 * Attempt to retrieve an item from the ring buffer. This function returns immediately
 * if there are no items available for retrieval
 *
 * @param[in]   xRingbuffer     Ring buffer to retrieve the item from
 * @param[out]  pxItemSize      Pointer to a variable to which the size of the
 *                              retrieved item will be written.
 *
 * @note    A call to vRingbufferReturnItemFromISR() is required after this to free the item retrieved.
 * @note    Byte buffers do not allow multiple retrievals before returning an item
 * @note    Two calls to RingbufferReceiveFromISR() are required if the bytes wrap around the end of the ring buffer.
 * @note    It is possible to receive items with a pxItemSize of 0 on no-split buffers.
 * @note    To retrieve an item from an allow-split buffer, use `xRingbufferReceiveSplitFromISR()` instead.
 *
 * @return
 *      - Pointer to the retrieved item on success; *pxItemSize filled with the length of the item.
 *      - NULL when the ring buffer is empty, *pxItemSize is untouched in that case.
 */
void *xRingbufferReceiveFromISR(RingbufHandle_t xRingbuffer, size_t *pxItemSize);

/**
 * @brief   Retrieve a split item from an allow-split ring buffer
 *
 * Attempt to retrieve a split item from an allow-split ring buffer. If the item
 * is not split, only a single item is retried. If the item is split, both parts
 * will be retrieved. This function will block until an item is available or
 * until it times out.
 *
 * @param[in]   xRingbuffer     Ring buffer to retrieve the item from
 * @param[out]  ppvHeadItem     Double pointer to first part (set to NULL if no items were retrieved)
 * @param[out]  ppvTailItem     Double pointer to second part (set to NULL if item is not split)
 * @param[out]  pxHeadItemSize  Pointer to size of first part (unmodified if no items were retrieved)
 * @param[out]  pxTailItemSize  Pointer to size of second part (unmodified if item is not split)
 * @param[in]   xTicksToWait    Ticks to wait for items in the ring buffer.
 *
 * @note    Call(s) to vRingbufferReturnItem() is required after this to free up the item(s) retrieved.
 * @note    This function should only be called on allow-split buffers
 * @note    It is possible to receive items with a pxItemSize of 0 on allow split buffers.
 *
 * @return
 *      - pdTRUE if an item (split or unsplit) was retrieved
 *      - pdFALSE when no item was retrieved
 */
BaseType_t xRingbufferReceiveSplit(RingbufHandle_t xRingbuffer,
                                   void **ppvHeadItem,
                                   void **ppvTailItem,
                                   size_t *pxHeadItemSize,
                                   size_t *pxTailItemSize,
                                   TickType_t xTicksToWait);

/**
 * @brief   Retrieve a split item from an allow-split ring buffer in an ISR
 *
 * Attempt to retrieve a split item from an allow-split ring buffer. If the item
 * is not split, only a single item is retried. If the item is split, both parts
 * will be retrieved. This function returns immediately if there are no items
 * available for retrieval
 *
 * @param[in]   xRingbuffer     Ring buffer to retrieve the item from
 * @param[out]  ppvHeadItem     Double pointer to first part (set to NULL if no items were retrieved)
 * @param[out]  ppvTailItem     Double pointer to second part (set to NULL if item is not split)
 * @param[out]  pxHeadItemSize  Pointer to size of first part (unmodified if no items were retrieved)
 * @param[out]  pxTailItemSize  Pointer to size of second part (unmodified if item is not split)
 *
 * @note    Calls to vRingbufferReturnItemFromISR() is required after this to free up the item(s) retrieved.
 * @note    This function should only be called on allow-split buffers
 * @note    It is possible to receive items with a pxItemSize of 0 on allow split buffers.
 *
 * @return
 *      - pdTRUE if an item (split or unsplit) was retrieved
 *      - pdFALSE when no item was retrieved
 */
BaseType_t xRingbufferReceiveSplitFromISR(RingbufHandle_t xRingbuffer,
                                          void **ppvHeadItem,
                                          void **ppvTailItem,
                                          size_t *pxHeadItemSize,
                                          size_t *pxTailItemSize);

/**
 * @brief   Retrieve bytes from a byte buffer, specifying the maximum amount of bytes to retrieve
 *
 * Attempt to retrieve data from a byte buffer whilst specifying a maximum number
 * of bytes to retrieve. This function will block until there is data available
 * for retrieval or until it times out.
 *
 * @param[in]   xRingbuffer     Ring buffer to retrieve the item from
 * @param[out]  pxItemSize      Pointer to a variable to which the size of the retrieved item will be written.
 * @param[in]   xTicksToWait    Ticks to wait for items in the ring buffer.
 * @param[in]   xMaxSize        Maximum number of bytes to return.
 *
 * @note    A call to vRingbufferReturnItem() is required after this to free up the data retrieved.
 * @note    This function should only be called on byte buffers
 * @note    Byte buffers do not allow multiple retrievals before returning an item
 * @note    Two calls to RingbufferReceiveUpTo() are required if the bytes wrap around the end of the ring buffer.
 *
 * @return
 *      - Pointer to the retrieved item on success; *pxItemSize filled with
 *        the length of the item.
 *      - NULL on timeout, *pxItemSize is untouched in that case.
 */
void *xRingbufferReceiveUpTo(RingbufHandle_t xRingbuffer,
                             size_t *pxItemSize,
                             TickType_t xTicksToWait,
                             size_t xMaxSize);

/**
 * @brief   Retrieve bytes from a byte buffer, specifying the maximum amount of
 *          bytes to retrieve. Call this from an ISR.
 *
 * Attempt to retrieve bytes from a byte buffer whilst specifying a maximum number
 * of bytes to retrieve. This function will return immediately if there is no data
 * available for retrieval.
 *
 * @param[in]   xRingbuffer Ring buffer to retrieve the item from
 * @param[out]  pxItemSize  Pointer to a variable to which the size of the retrieved item will be written.
 * @param[in]   xMaxSize    Maximum number of bytes to return. Size of 0 simply returns NULL.
 *
 * @note    A call to vRingbufferReturnItemFromISR() is required after this to free up the data received.
 * @note    This function should only be called on byte buffers
 * @note    Byte buffers do not allow multiple retrievals before returning an item
 *
 * @return
 *      - Pointer to the retrieved item on success; *pxItemSize filled with
 *        the length of the item.
 *      - NULL when the ring buffer is empty, *pxItemSize is untouched in that case.
 */
void *xRingbufferReceiveUpToFromISR(RingbufHandle_t xRingbuffer, size_t *pxItemSize, size_t xMaxSize);

/**
 * @brief   Return a previously-retrieved item to the ring buffer
 *
 * @param[in]   xRingbuffer Ring buffer the item was retrieved from
 * @param[in]   pvItem      Item that was received earlier
 *
 * @note    If a split item is retrieved, both parts should be returned by calling this function twice
 */
void vRingbufferReturnItem(RingbufHandle_t xRingbuffer, void *pvItem);

/**
 * @brief   Return a previously-retrieved item to the ring buffer from an ISR
 *
 * @param[in]   xRingbuffer Ring buffer the item was retrieved from
 * @param[in]   pvItem      Item that was received earlier
 * @param[out]  pxHigherPriorityTaskWoken   Value pointed to will be set to pdTRUE
 *                                          if the function woke up a higher priority task.
 *
 * @note    If a split item is retrieved, both parts should be returned by calling this function twice
 */
void vRingbufferReturnItemFromISR(RingbufHandle_t xRingbuffer, void *pvItem, BaseType_t *pxHigherPriorityTaskWoken);

/**
 * @brief   Delete a ring buffer
 *
 * @param[in]   xRingbuffer     Ring buffer to delete
 *
 * @note    This function will not deallocate any memory if the ring buffer was
 *          created using xRingbufferCreateStatic(). Deallocation must be done
 *          manually be the user.
 */
void vRingbufferDelete(RingbufHandle_t xRingbuffer);

/**
 * @brief   Get maximum size of an item that can be placed in the ring buffer
 *
 * This function returns the maximum size an item can have if it was placed in
 * an empty ring buffer.
 *
 * @param[in]   xRingbuffer     Ring buffer to query
 *
 * @note    The max item size for a no-split buffer is limited to
 *          ((buffer_size/2)-header_size). This limit is imposed so that an item
 *          of max item size can always be sent to an empty no-split buffer
 *          regardless of the internal positions of the buffer's read/write/free
 *          pointers.
 *
 * @return  Maximum size, in bytes, of an item that can be placed in a ring buffer.
 */
size_t xRingbufferGetMaxItemSize(RingbufHandle_t xRingbuffer);

/**
 * @brief   Get current free size available for an item/data in the buffer
 *
 * This gives the real time free space available for an item/data in the ring
 * buffer. This represents the maximum size an item/data can have if it was
 * currently sent to the ring buffer.
 *
 * @warning This API is not thread safe. So, if multiple threads are accessing
 *          the same ring buffer, it is the application's responsibility to
 *          ensure atomic access to this API and the subsequent Send
 *
 * @note    An empty no-split buffer has a max current free size for an item
 *          that is limited to ((buffer_size/2)-header_size). See API reference
 *          for xRingbufferGetMaxItemSize().
 *
 * @param[in]   xRingbuffer     Ring buffer to query
 *
 * @return  Current free size, in bytes, available for an entry
 */
size_t xRingbufferGetCurFreeSize(RingbufHandle_t xRingbuffer);

/**
 * @brief   Add the ring buffer to a queue set. Notified when data has been written to the ring buffer
 *
 * This function adds the ring buffer to a queue set, thus allowing a task to
 * block on multiple queues/ring buffers. The queue set is notified when the new
 * data becomes available to read on the ring buffer.
 *
 * @param[in]   xRingbuffer     Ring buffer to add to the queue set
 * @param[in]   xQueueSet       Queue set to add the ring buffer to
 *
 * @return
 *      - pdTRUE on success, pdFALSE otherwise
 */
BaseType_t xRingbufferAddToQueueSetRead(RingbufHandle_t xRingbuffer, QueueSetHandle_t xQueueSet);

/**
 * @brief   Check if the selected queue set member is a particular ring buffer
 *
 * This API checks if queue set member returned from xQueueSelectFromSet() is
 * a particular ring buffer. If so, this indicates the ring buffer has items
 * waiting to be retrieved.
 *
 * @param[in]   xRingbuffer     Ring buffer to check
 * @param[in]   xMember         Member returned from xQueueSelectFromSet
 *
 * @return
 *      - pdTRUE when selected queue set member is the ring buffer
 *      - pdFALSE otherwise.
 */
static inline BaseType_t xRingbufferCanRead(RingbufHandle_t xRingbuffer, QueueSetMemberHandle_t xMember)
{
    return (xMember == (QueueSetMemberHandle_t)xRingbuffer) ? pdTRUE : pdFALSE;
}

/**
 * @brief   Remove the ring buffer from a queue set
 *
 * This function removes a ring buffer from a queue set. The ring buffer must have been previously added to the queue
 * set using xRingbufferAddToQueueSetRead().
 *
 * @param[in]   xRingbuffer     Ring buffer to remove from the queue set
 * @param[in]   xQueueSet       Queue set to remove the ring buffer from
 *
 * @return
 *      - pdTRUE on success
 *      - pdFALSE otherwise
 */
BaseType_t xRingbufferRemoveFromQueueSetRead(RingbufHandle_t xRingbuffer, QueueSetHandle_t xQueueSet);

/**
 * @brief   Get information about ring buffer status
 *
 * Get information of a ring buffer's current status such as
 * free/read/write/acquire pointer positions, and number of items waiting to be retrieved.
 * Arguments can be set to NULL if they are not required.
 *
 * @param[in]   xRingbuffer     Ring buffer handle
 * @param[out]  uxFree          Pointer use to store free pointer position
 * @param[out]  uxRead          Pointer use to store read pointer position
 * @param[out]  uxWrite         Pointer use to store write pointer position
 * @param[out]  uxAcquire       Pointer use to store acquire pointer position
 * @param[out]  uxItemsWaiting  Pointer use to store number of items (bytes for byte buffer) waiting to be retrieved
 */
void vRingbufferGetInfo(RingbufHandle_t xRingbuffer,
                        UBaseType_t *uxFree,
                        UBaseType_t *uxRead,
                        UBaseType_t *uxWrite,
                        UBaseType_t *uxAcquire,
                        UBaseType_t *uxItemsWaiting);

/**
 * @brief   Debugging function to print the internal pointers in the ring buffer
 *
 * @param   xRingbuffer Ring buffer to show
 */
void xRingbufferPrintInfo(RingbufHandle_t xRingbuffer);

/**
 * @brief Retrieve the pointers to a statically created ring buffer
 *
 * @param[in] xRingbuffer Ring buffer
 * @param[out] ppucRingbufferStorage Used to return a pointer to the queue's storage area buffer
 * @param[out] ppxStaticRingbuffer Used to return a pointer to the queue's data structure buffer
 * @return pdTRUE if buffers were retrieved, pdFALSE otherwise.
 */
BaseType_t xRingbufferGetStaticBuffer(RingbufHandle_t xRingbuffer, uint8_t **ppucRingbufferStorage, StaticRingbuffer_t **ppxStaticRingbuffer);

/**
 * @brief Creates a ring buffer with specific memory capabilities
 *
 * This function is similar to xRingbufferCreate(), except that it allows the
 * memory allocated for the ring buffer to have specific capabilities (e.g.,
 * MALLOC_CAP_INTERNAL).
 *
 * @note A queue created using this function must only be deleted using
 * vRingbufferDeleteWithCaps()
 * @param[in] xBufferSize Size of the buffer in bytes
 * @param[in] xBufferType Type of ring buffer, see documentation.
 * @param[in] uxMemoryCaps Memory capabilities of the queue's memory (see
 * esp_heap_caps.h)
 * @return Handle to the created ring buffer or NULL on failure.
 */
RingbufHandle_t xRingbufferCreateWithCaps(size_t xBufferSize, RingbufferType_t xBufferType, UBaseType_t uxMemoryCaps);

/**
 * @brief Deletes a ring buffer previously created using xRingbufferCreateWithCaps()
 *
 * @param xRingbuffer Ring buffer
 */
void vRingbufferDeleteWithCaps(RingbufHandle_t xRingbuffer);

#ifdef __cplusplus
}
#endif
