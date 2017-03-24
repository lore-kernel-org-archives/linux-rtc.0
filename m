Return-Path: <rtc-linux+bncBC2IF264UIPRB55V2XDAKGQEMQL4IOI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id e72si342552wma.0.2017.03.24.10.44.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 10:44:23 -0700 (PDT)
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
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 3/7] iio: cros_ec_sensors: Use devm to setup the
 triggered buffer.
Date: Fri, 24 Mar 2017 18:44:03 +0100
Message-Id: <20170324174407.25401-4-enric.balletbo@collabora.com>
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

Use resourced managed function devm_iio_triggered_buffer_setup
to make error path simpler and be able to get rid of the remove
function.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

  This is an improvement that can wait to 4.12 merge window, again can be
picked independently of the other patches and can go through IIO Jonathan's
Cameron tree.

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   | 26 +++-------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index c17596f..38e8783 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -267,31 +267,12 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	else
 		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 cros_ec_sensors_capture, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			cros_ec_sensors_capture, NULL);
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_uninit_buffer;
-
-	return 0;
-
-error_uninit_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int cros_ec_sensors_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id cros_ec_sensors_ids[] = {
@@ -313,7 +294,6 @@ static struct platform_driver cros_ec_sensors_platform_driver = {
 		.name	= "cros-ec-sensors",
 	},
 	.probe		= cros_ec_sensors_probe,
-	.remove		= cros_ec_sensors_remove,
 	.id_table	= cros_ec_sensors_ids,
 };
 module_platform_driver(cros_ec_sensors_platform_driver);
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
