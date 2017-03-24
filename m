Return-Path: <rtc-linux+bncBC2IF264UIPRB7FV2XDAKGQEFQG5NOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id t131si301195wmf.1.2017.03.24.10.44.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 10:44:28 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 7/7] mfd: cros_ec: add RTC as mfd subdevice
Date: Fri, 24 Mar 2017 18:44:07 +0100
Message-Id: <20170324174407.25401-8-enric.balletbo@collabora.com>
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

If the EC supports RTC host commands, expose an RTC device.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index bbc17ab..1ff88b1 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -51,6 +51,11 @@ static const struct mfd_cell ec_pd_cell = {
 	.pdata_size = sizeof(pd_p),
 };
 
+static const struct mfd_cell ec_rtc_cell = {
+	.name = "cros-ec-rtc",
+	.id   = -1,
+};
+
 static irqreturn_t ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
@@ -238,6 +243,15 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
 	kfree(msg);
 }
 
+static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
+{
+	int ret;
+
+	ret = mfd_add_devices(ec_dev->dev, 0, &ec_rtc_cell, 1, NULL, 0, NULL);
+	if (ret)
+		dev_err(ec_dev->dev, "failed to add EC RTC\n");
+}
+
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec_dev);
 
+	/* Check whether this EC has RTC support */
+	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
+		cros_ec_rtc_register(ec_dev);
+
 	if (ec_dev->max_passthru) {
 		/*
 		 * Register a PD device as well on top of this device.
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
