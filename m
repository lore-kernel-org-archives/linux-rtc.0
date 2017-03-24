Return-Path: <rtc-linux+bncBC2IF264UIPRB5VV2XDAKGQE6DBLEWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id l138si358153wmg.0.2017.03.24.10.44.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 10:44:22 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 2/7] iio: cros_ec_sensors: Fix return value to get
 raw and calibbias data.
Date: Fri, 24 Mar 2017 18:44:02 +0100
Message-Id: <20170324174407.25401-3-enric.balletbo@collabora.com>
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

The cros_ec_sensors_read function must return the type of value on all
cases. This was always true except for RAW and CALIBBIAS data which
returned an error or 0. This patch just fixes the mistake I introduced
when submitting the series.

Fixes: commit c14dca07a31d (iio: cros_ec_sensors: add ChromeOS EC
Contiguous Sensors driver)

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

  This is another FIX, so would be interesting see it merged in this release
cycle too. Like the above patch can be picked independently of the other
patches and should go through IIO Jonathan's Cameron tree.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index d6c372b..c17596f 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -61,7 +61,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 		ret = st->core.read_ec_sensors_data(indio_dev, 1 << idx, &data);
 		if (ret < 0)
 			break;
-
+		ret = IIO_VAL_INT;
 		*val = data;
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -76,7 +76,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
 			st->core.calib[i] =
 				st->core.resp->sensor_offset.offset[i];
-
+		ret = IIO_VAL_INT;
 		*val = st->core.calib[idx];
 		break;
 	case IIO_CHAN_INFO_SCALE:
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
