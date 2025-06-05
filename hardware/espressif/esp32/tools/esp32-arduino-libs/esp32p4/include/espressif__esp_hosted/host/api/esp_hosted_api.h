/*
* SPDX-FileCopyrightText: 2024 Espressif Systems (Shanghai) CO LTD
*
* SPDX-License-Identifier: Apache-2.0
*/

/** prevent recursive inclusion **/
#ifndef __ESP_HOSTED_API_H__
#define __ESP_HOSTED_API_H__

#ifdef __cplusplus
extern "C" {
#endif

/** Includes **/
#include "stdbool.h"
#include "esp_wifi.h"
#include "transport_drv.h"
#include "esp_wifi_remote.h"
#include "esp_hosted_config.h"
#include "esp_hosted_wifi_config.h"

/** Exported variables **/
#define ESP_HOSTED_CHANNEL_CONFIG_DEFAULT()  { \
	.secure = true,                            \
}

struct esp_remote_channel_config {
	esp_hosted_if_type_t if_type;
	bool secure;
};


/** Inline functions **/

/** Exported Functions **/
esp_err_t esp_hosted_init(void);
esp_err_t esp_hosted_deinit(void);
esp_err_t esp_hosted_reinit(void);

esp_err_t esp_hosted_setup(void);
esp_err_t esp_hosted_slave_reset(void);
esp_remote_channel_t esp_hosted_add_channel(esp_remote_channel_config_t config,
		esp_remote_channel_tx_fn_t *tx, const esp_remote_channel_rx_fn_t rx);
esp_err_t esp_hosted_remove_channel(esp_remote_channel_t channel);

esp_err_t esp_wifi_remote_init(const wifi_init_config_t *arg);
esp_err_t esp_wifi_remote_deinit(void);
esp_err_t esp_wifi_remote_set_mode(wifi_mode_t mode);
esp_err_t esp_wifi_remote_get_mode(wifi_mode_t* mode);
esp_err_t esp_wifi_remote_start(void);
esp_err_t esp_wifi_remote_stop(void);
esp_err_t esp_wifi_remote_connect(void);
esp_err_t esp_wifi_remote_disconnect(void);
esp_err_t esp_wifi_remote_set_config(wifi_interface_t interface, wifi_config_t *conf);
esp_err_t esp_wifi_remote_get_config(wifi_interface_t interface, wifi_config_t *conf);
esp_err_t esp_wifi_remote_get_mac(wifi_interface_t mode, uint8_t mac[6]);
esp_err_t esp_wifi_remote_set_mac(wifi_interface_t mode, const uint8_t mac[6]);

esp_err_t esp_wifi_remote_scan_start(const wifi_scan_config_t *config, bool block);
esp_err_t esp_wifi_remote_scan_stop(void);
esp_err_t esp_wifi_remote_scan_get_ap_num(uint16_t *number);
esp_err_t esp_wifi_remote_scan_get_ap_records(uint16_t *number, wifi_ap_record_t *ap_records);
esp_err_t esp_wifi_remote_clear_ap_list(void);
esp_err_t esp_wifi_remote_restore(void);
esp_err_t esp_wifi_remote_clear_fast_connect(void);
esp_err_t esp_wifi_remote_deauth_sta(uint16_t aid);
esp_err_t esp_wifi_remote_sta_get_ap_info(wifi_ap_record_t *ap_info);
esp_err_t esp_wifi_remote_set_ps(wifi_ps_type_t type);
esp_err_t esp_wifi_remote_get_ps(wifi_ps_type_t *type);
esp_err_t esp_wifi_remote_set_storage(wifi_storage_t storage);
esp_err_t esp_wifi_remote_set_bandwidth(wifi_interface_t ifx, wifi_bandwidth_t bw);
esp_err_t esp_wifi_remote_get_bandwidth(wifi_interface_t ifx, wifi_bandwidth_t *bw);
esp_err_t esp_wifi_remote_set_channel(uint8_t primary, wifi_second_chan_t second);
esp_err_t esp_wifi_remote_get_channel(uint8_t *primary, wifi_second_chan_t *second);
esp_err_t esp_wifi_remote_set_country_code(const char *country, bool ieee80211d_enabled);
esp_err_t esp_wifi_remote_get_country_code(char *country);
esp_err_t esp_wifi_remote_set_country(const wifi_country_t *country);
esp_err_t esp_wifi_remote_get_country(wifi_country_t *country);
esp_err_t esp_wifi_remote_ap_get_sta_list(wifi_sta_list_t *sta);
esp_err_t esp_wifi_remote_ap_get_sta_aid(const uint8_t mac[6], uint16_t *aid);
esp_err_t esp_wifi_remote_sta_get_rssi(int *rssi);
esp_err_t esp_wifi_remote_set_protocol(wifi_interface_t ifx, uint8_t protocol_bitmap);
esp_err_t esp_wifi_remote_get_protocol(wifi_interface_t ifx, uint8_t *protocol_bitmap);
esp_err_t esp_wifi_remote_set_max_tx_power(int8_t power);
esp_err_t esp_wifi_remote_get_max_tx_power(int8_t *power);
esp_err_t esp_wifi_remote_sta_get_aid(uint16_t *aid);
esp_err_t esp_hosted_ota(const char* image_url);

#if H_WIFI_DUALBAND_SUPPORT
esp_err_t esp_wifi_remote_set_band(wifi_band_t band);
esp_err_t esp_wifi_remote_get_band(wifi_band_t *band);
esp_err_t esp_wifi_remote_set_band_mode(wifi_band_mode_t band_mode);
esp_err_t esp_wifi_remote_get_band_mode(wifi_band_mode_t *band_mode);
esp_err_t esp_wifi_remote_set_protocols(wifi_interface_t ifx, wifi_protocols_t *protocols);
esp_err_t esp_wifi_remote_get_protocols(wifi_interface_t ifx, wifi_protocols_t *protocols);
esp_err_t esp_wifi_remote_set_bandwidths(wifi_interface_t ifx, wifi_bandwidths_t *bw);
esp_err_t esp_wifi_remote_get_bandwidths(wifi_interface_t ifx, wifi_bandwidths_t *bw);
#endif

#ifdef __cplusplus
}
#endif

#endif
