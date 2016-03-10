Return-Path: <rtc-linux+bncBDU7VC56WAFBBXHBQ23QKGQEHXP6PWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id c140si195232wmh.1.2016.03.10.09.37.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 09:37:32 -0800 (PST)
Date: Thu, 10 Mar 2016 18:34:46 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/2] rtc: rv3029: Add thermometer hwmon support
Message-ID: <20160310183446.073c4b0e@wiggum>
In-Reply-To: <20160310183346.73aa0f24@wiggum>
References: <20160310183346.73aa0f24@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QHxFN135jcx.yU.yiVJgb62"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/QHxFN135jcx.yU.yiVJgb62
Content-Type: text/plain; charset=UTF-8

This adds support to
- enable/disable the thermometer
- set the temperature scanning interval
- read the current temperature that is used for temp compensation.
via hwmon interface

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/Kconfig        |   9 ++++
 drivers/rtc/rtc-rv3029c2.c | 120 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e593c55..b4fda4c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -601,6 +601,15 @@ config RTC_DRV_RV3029C2
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rv3029c2.
 
+config RTC_DRV_RV3029_HWMON
+	bool "HWMON support for RV3029"
+	depends on RTC_DRV_RV3029C2 && HWMON
+	depends on !(RTC_DRV_RV3029C2=y && HWMON=m)
+	default y
+	help
+	  Say Y here if you want to expose temperature sensor data on
+	  rtc-rv3029c2.
+
 config RTC_DRV_RV8803
 	tristate "Micro Crystal RV8803"
 	help
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 3bbb581..d0cbf08 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -18,6 +18,8 @@
 #include <linux/rtc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 
 
 /* Register map */
@@ -637,6 +639,123 @@ static void rv3029_trickle_config(struct i2c_client *client)
 	}
 }
 
+#ifdef CONFIG_RTC_DRV_RV3029_HWMON
+
+static int rv3029_read_temp(struct i2c_client *client, int *temp_mC)
+{
+	int ret;
+	u8 temp;
+
+	ret = rv3029_i2c_read_regs(client, RV3029_TEMP_PAGE, &temp, 1);
+	if (ret < 0)
+		return ret;
+
+	*temp_mC = ((int)temp - 60) * 1000;
+
+	return 0;
+}
+
+static ssize_t rv3029_hwmon_show_temp(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct i2c_client *client = dev_get_drvdata(dev);
+	int ret, temp_mC;
+
+	ret = rv3029_read_temp(client, &temp_mC);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", temp_mC);
+}
+
+static ssize_t rv3029_hwmon_set_update_interval(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t count)
+{
+	struct i2c_client *client = dev_get_drvdata(dev);
+	unsigned long interval_ms;
+	int ret;
+	u8 th_set_bits = 0;
+
+	ret = kstrtoul(buf, 10, &interval_ms);
+	if (ret < 0)
+		return ret;
+
+	if (interval_ms != 0) {
+		th_set_bits |= RV3029_EECTRL_THE;
+		if (interval_ms >= 16000)
+			th_set_bits |= RV3029_EECTRL_THP;
+	}
+	ret = rv3029_eeprom_update_bits(client, RV3029_CONTROL_E2P_EECTRL,
+					RV3029_EECTRL_THE | RV3029_EECTRL_THP,
+					th_set_bits);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t rv3029_hwmon_show_update_interval(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct i2c_client *client = dev_get_drvdata(dev);
+	int ret, interval_ms;
+	u8 eectrl;
+
+	ret = rv3029_eeprom_read(client, RV3029_CONTROL_E2P_EECTRL,
+				 &eectrl, 1);
+	if (ret < 0)
+		return ret;
+
+	if (eectrl & RV3029_EECTRL_THE) {
+		if (eectrl & RV3029_EECTRL_THP)
+			interval_ms = 16000;
+		else
+			interval_ms = 1000;
+	} else {
+		interval_ms = 0;
+	}
+
+	return sprintf(buf, "%d\n", interval_ms);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, rv3029_hwmon_show_temp,
+			  NULL, 0);
+static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
+			  rv3029_hwmon_show_update_interval,
+			  rv3029_hwmon_set_update_interval, 0);
+
+static struct attribute *rv3029_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_update_interval.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(rv3029_hwmon);
+
+static void rv3029_hwmon_register(struct i2c_client *client)
+{
+	struct device *hwmon_dev;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(
+		&client->dev, client->name, client, rv3029_hwmon_groups);
+	if (IS_ERR(hwmon_dev)) {
+		dev_warn(&client->dev,
+			"unable to register hwmon device %ld\n",
+			PTR_ERR(hwmon_dev));
+	}
+}
+
+#else /* CONFIG_RTC_DRV_RV3029_HWMON */
+
+static void rv3029_hwmon_register(struct i2c_client *client)
+{
+}
+
+#endif /* CONFIG_RTC_DRV_RV3029_HWMON */
+
 static const struct rtc_class_ops rv3029_rtc_ops = {
 	.read_time	= rv3029_rtc_read_time,
 	.set_time	= rv3029_rtc_set_time,
@@ -668,6 +787,7 @@ static int rv3029_probe(struct i2c_client *client,
 	}
 
 	rv3029_trickle_config(client);
+	rv3029_hwmon_register(client);
 
 	rtc = devm_rtc_device_register(&client->dev, client->name,
 				       &rv3029_rtc_ops, THIS_MODULE);
-- 
2.7.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Sig_/QHxFN135jcx.yU.yiVJgb62
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4bA2AAoJEPUyvh2QjYsOJjwP/RL5CjlMNE+paGzmRWH4eygJ
SQRZts6KgLmGSeyQ5Iqa6vj2l/MAdjfRNBtJkbAZDMMKYyAXGy41o8Z/4X1DLVRT
cl9Rt2UmytDVxygnz++fy+TUdXO3RB5ssiBysfWs4pefgNi7MqNEuq/xfOlco13H
OfrK8LAVq7674a69crMQesJeokiKe+LbKKYeI9FOYDe1J9hstrBuAtaTItRUQ+Yo
v1CEJMFDLnR0t65id66G246WIG1MQsWrpXLUXZ6KXjTZDdVjk/WuW74igIiGx+k2
EVVeNRqx26w2VLiSlxbk/Oyo+bKEoPDUGkq/dmR71l/khT1DT576Na3g6D6pYB/X
lZv+pf6UWgicXUSJxEjE2PZ+K8XqpoJ1TcBiSr1bJZOwG0SDLjAn8QRJGPvmxMMl
IcFOcEvnGsYrS1JO0RnLgDEB4rYuZ0EtnC8JqVIQh+L9YVQCiHsEmCn/gvoDFdI9
EXmefqPu7FZxa1V+tpGzuCqN59ivBYNGlSq3Idf4onW2ELAPpgvRB96q8znTKQsx
LcmHqkmnvoUY9XOyt2MmfmAfG34Jm7HI+cjdaAFNTIUvFP0RTFTB5EUfMzTu/X/Z
Jz9l5WQH/u1xDFsRTBmK9M2Tg7Dz36nhCkEtRVODBpDADXIm+ulApk6dOF+KWXfJ
h+LAA0MfNNUIB+AYF+Fq
=Rmr8
-----END PGP SIGNATURE-----

--Sig_/QHxFN135jcx.yU.yiVJgb62--
