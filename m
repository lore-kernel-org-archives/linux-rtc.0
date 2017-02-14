Return-Path: <rtc-linux+bncBC2IF264UIPRBD4DR3CQKGQE3TVV7RQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id 14si219609wmn.2.2017.02.14.14.15.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 14:15:43 -0800 (PST)
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] [PATCH v3 2/4] mfd: cros_ec: Introduce RTC commands and
 events definitions.
Date: Tue, 14 Feb 2017 23:15:27 +0100
Message-Id: <20170214221529.6434-2-enric.balletbo@collabora.com>
In-Reply-To: <20170214221529.6434-1-enric.balletbo@collabora.com>
References: <20170214221529.6434-1-enric.balletbo@collabora.com>
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
Changes since v2:
 - none
Changes since v1:
 - Acked by Lee Jones

 include/linux/mfd/cros_ec_commands.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 80d401d..73f7a62 100644
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
@@ -790,6 +793,8 @@ enum ec_feature_code {
 	EC_FEATURE_USB_MUX = 23,
 	/* Motion Sensor code has an internal software FIFO */
 	EC_FEATURE_MOTION_SENSE_FIFO = 24,
+	/* EC has RTC feature that can be controlled by host commands */
+	EC_FEATURE_RTC = 27,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
@@ -1682,6 +1687,9 @@ struct ec_response_rtc {
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
