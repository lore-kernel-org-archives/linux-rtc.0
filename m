Return-Path: <rtc-linux+bncBC2IF264UIPRBEMDR3CQKGQEEP7WXOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id q4si141611wma.3.2017.02.14.14.15.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 14:15:44 -0800 (PST)
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
Date: Tue, 14 Feb 2017 23:15:29 +0100
Message-Id: <20170214221529.6434-4-enric.balletbo@collabora.com>
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

If the EC supports RTC host commands, expose an RTC device.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
---
Changes since v2:
 - Acked by Benson Leung
Changes since v1:
 - none

 drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
index 47268ec..ebe029d 100644
--- a/drivers/platform/chrome/cros_ec_dev.c
+++ b/drivers/platform/chrome/cros_ec_dev.c
@@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell cros_ec_rtc_devs[] = {
+	{
+		.name = "cros-ec-rtc",
+		.id   = -1,
+	},
+};
+
+static void cros_ec_rtc_register(struct cros_ec_dev *ec)
+{
+	int ret;
+
+	ret = mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
+			      ARRAY_SIZE(cros_ec_rtc_devs),
+			      NULL, 0, NULL);
+	if (ret)
+		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
+}
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	/* check whether this EC instance has RTC host command support */
+	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
+		cros_ec_rtc_register(ec);
+
 	return 0;
 
 dev_reg_failed:
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
