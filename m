Return-Path: <rtc-linux+bncBCZ3LK4RZYHRBIV26LFAKGQE42HSSWI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id r131si8283376wmd.2.2017.07.05.01.02.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 01:02:42 -0700 (PDT)
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [rtc-linux] [PATCH v2 2/2] RTC: s35390a: implement ioctls
Date: Wed,  5 Jul 2017 10:02:30 +0200
Message-Id: <bc0dd162f9b89349b41087f1fd710409cd9aaa8f.1499240924.git.fabien.lahoudere@collabora.co.uk>
In-Reply-To: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
In-Reply-To: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Implements RTC_VL_READ and RTC_VL_CLR ioctls.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/rtc/rtc-s35390a.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 5ebb132..9261ba6 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -397,12 +397,42 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return s35390a_set_datetime(to_i2c_client(dev), tm);
 }
 
+static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct s35390a *s35390a = i2c_get_clientdata(client);
+	char sts;
+	int err;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		/* s35390a_reset set lowvoltage flag and init RTC if needed */
+		err = s35390a_read_status(s35390a, &sts);
+		if (err < 0)
+			return err;
+		if (copy_to_user((void __user *)arg, &err, sizeof(int)))
+			return -EFAULT;
+		break;
+	case RTC_VL_CLR:
+		/* update flag and clear register */
+		err = s35390a_init(s35390a);
+		if (err < 0)
+			return err;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops s35390a_rtc_ops = {
 	.read_time	= s35390a_rtc_read_time,
 	.set_time	= s35390a_rtc_set_time,
 	.set_alarm	= s35390a_rtc_set_alarm,
 	.read_alarm	= s35390a_rtc_read_alarm,
-
+	.ioctl          = s35390a_rtc_ioctl,
 };
 
 static struct i2c_driver s35390a_driver;
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
