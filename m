Return-Path: <rtc-linux+bncBCL5RYHM6ECRBCOC7XDQKGQEEDFP32I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x229.google.com (mail-wr0-x229.google.com. [2a00:1450:400c:c0c::229])
        by gmr-mx.google.com with ESMTPS id w126si280453wmd.1.2017.04.25.07.45.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 07:45:28 -0700 (PDT)
Received: by mail-wr0-x229.google.com with SMTP id w50so86866927wrc.0
        for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 07:45:28 -0700 (PDT)
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	Gary Bisson <gary.bisson@boundarydevices.com>
Subject: [rtc-linux] [PATCH 3/4] rtc: m41t80: remove sqw sysfs entry
Date: Tue, 25 Apr 2017 16:45:16 +0200
Message-Id: <20170425144517.15962-4-gary.bisson@boundarydevices.com>
In-Reply-To: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
References: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In order to use the proper clock framework to control this feature.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 88 ------------------------------------------------
 1 file changed, 88 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 0c142653c309..2bdf494a9bd4 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -387,96 +387,8 @@ static ssize_t flags_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(flags);
 
-static ssize_t sqwfreq_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct m41t80_data *clientdata = i2c_get_clientdata(client);
-	int val, reg_sqw;
-
-	if (!(clientdata->features & M41T80_FEATURE_SQ))
-		return -EINVAL;
-
-	reg_sqw = M41T80_REG_SQW;
-	if (clientdata->features & M41T80_FEATURE_SQ_ALT)
-		reg_sqw = M41T80_REG_WDAY;
-	val = i2c_smbus_read_byte_data(client, reg_sqw);
-	if (val < 0)
-		return val;
-	val = (val >> 4) & 0xf;
-	switch (val) {
-	case 0:
-		break;
-	case 1:
-		val = 32768;
-		break;
-	default:
-		val = 32768 >> val;
-	}
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t sqwfreq_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct m41t80_data *clientdata = i2c_get_clientdata(client);
-	int almon, sqw, reg_sqw, rc;
-	unsigned long val;
-
-	rc = kstrtoul(buf, 0, &val);
-	if (rc < 0)
-		return rc;
-
-	if (!(clientdata->features & M41T80_FEATURE_SQ))
-		return -EINVAL;
-
-	if (val) {
-		if (!is_power_of_2(val))
-			return -EINVAL;
-		val = ilog2(val);
-		if (val == 15)
-			val = 1;
-		else if (val < 14)
-			val = 15 - val;
-		else
-			return -EINVAL;
-	}
-	/* disable SQW, set SQW frequency & re-enable */
-	almon = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
-	if (almon < 0)
-		return almon;
-	reg_sqw = M41T80_REG_SQW;
-	if (clientdata->features & M41T80_FEATURE_SQ_ALT)
-		reg_sqw = M41T80_REG_WDAY;
-	sqw = i2c_smbus_read_byte_data(client, reg_sqw);
-	if (sqw < 0)
-		return sqw;
-	sqw = (sqw & 0x0f) | (val << 4);
-
-	rc = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
-				       almon & ~M41T80_ALMON_SQWE);
-	if (rc < 0)
-		return rc;
-
-	if (val) {
-		rc = i2c_smbus_write_byte_data(client, reg_sqw, sqw);
-		if (rc < 0)
-			return rc;
-
-		rc = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
-					       almon | M41T80_ALMON_SQWE);
-		if (rc < 0)
-			return rc;
-	}
-	return count;
-}
-static DEVICE_ATTR_RW(sqwfreq);
-
 static struct attribute *attrs[] = {
 	&dev_attr_flags.attr,
-	&dev_attr_sqwfreq.attr,
 	NULL,
 };
 
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
