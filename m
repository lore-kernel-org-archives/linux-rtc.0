Return-Path: <rtc-linux+bncBC2IF264UIPRB6NV2XDAKGQEVQ5KVRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id x188si718728wmx.0.2017.03.24.10.44.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 10:44:25 -0700 (PDT)
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Olof Johansson <olof@lixom.net>,
	bleung@chromium.org
Cc: martinez.javier@gmail.com,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] [PATCH 5/7] mfd: cros_ec: Introduce RTC commands and
 events definitions.
Date: Fri, 24 Mar 2017 18:44:05 +0100
Message-Id: <20170324174407.25401-6-enric.balletbo@collabora.com>
In-Reply-To: <20170324174407.25401-1-enric.balletbo@collabora.com>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Stephen Barber <smbarber@chromium.org>

The EC can function as a simple RT, this patch adds the RTC related
definitions needed by the rtc-cros-ec driver.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/cros_ec_commands.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 84e1abb..852ce34 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -286,6 +286,9 @@ enum host_event_code {
 	/* Hang detect logic detected a hang and warm rebooted the AP */
 	EC_HOST_EVENT_HANG_REBOOT = 21,
 
+	/* EC RTC event occurred */
+	EC_HOST_EVENT_RTC = 26,
+
 	/*
 	 * The high bit of the event mask is not used as a host event code.  If
 	 * it reads back as set, then the entire event mask should be
@@ -794,6 +797,8 @@ enum ec_feature_code {
 	EC_FEATURE_USB_MUX = 23,
 	/* Motion Sensor code has an internal software FIFO */
 	EC_FEATURE_MOTION_SENSE_FIFO = 24,
+	/* EC has RTC feature that can be controlled by host commands */
+	EC_FEATURE_RTC = 27,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
@@ -1704,6 +1709,9 @@ struct ec_response_rtc {
 #define EC_CMD_RTC_SET_VALUE 0x46
 #define EC_CMD_RTC_SET_ALARM 0x47
 
+/* Pass as param to SET_ALARM to clear the current alarm */
+#define EC_RTC_ALARM_CLEAR 0
+
 /*****************************************************************************/
 /* Port80 log access */
 
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
