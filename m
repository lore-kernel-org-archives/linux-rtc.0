Return-Path: <rtc-linux+bncBCZ3LK4RZYHRBZV33XBQKGQEF7U24OQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id l66si169870wml.0.2017.01.12.02.43.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 02:43:50 -0800 (PST)
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [rtc-linux] [PATCH 2/2] RTC: s35390a: implement ioctls
Date: Thu, 12 Jan 2017 11:43:38 +0100
Message-Id: <1484217818-27845-3-git-send-email-fabien.lahoudere@collabora.co.uk>
In-Reply-To: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
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
 drivers/rtc/rtc-s35390a.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index ef4ada9..2bd8301 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -63,6 +63,7 @@ struct s35390a {
 	struct rtc_device *rtc;
 	int twentyfourhour;
 	int isinvalid;
+	int lowvoltage;
 };
 
 static int s35390a_set_reg(struct s35390a *s35390a, int reg, char *buf, int len)
@@ -121,7 +122,9 @@ static int s35390a_reset(struct s35390a *s35390a, char *status1)
 		 * detection circuit is in operation.
 		 */
 		msleep(500);
-	else if (!(*status1 & S35390A_FLAG_BLD))
+	else if (*status1 & S35390A_FLAG_BLD)
+		s35390a->lowvoltage = 1;
+	else
 		/*
 		 * If both POC and BLD are unset everything is fine.
 		 */
@@ -393,12 +396,44 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
+		err = s35390a_reset(s35390a, &sts);
+		if (err < 0)
+			return err;
+		if (copy_to_user((void __user *)arg, &s35390a->lowvoltage,
+				 sizeof(int)))
+			return -EFAULT;
+
+	case RTC_VL_CLR:
+		/* update flag and clear register */
+		err = s35390a_reset(s35390a, &sts);
+		if ((err == 1) || (err == 0))
+			s35390a->lowvoltage = 0;
+		else
+			return err;
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
@@ -427,6 +462,7 @@ static int s35390a_probe(struct i2c_client *client,
 	s35390a->client[0] = client;
 	i2c_set_clientdata(client, s35390a);
 	s35390a->isinvalid = 0;
+	s35390a->lowvoltage = 0;
 
 	/* This chip uses multiple addresses, use dummy devices for them */
 	for (i = 1; i < 8; ++i) {
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
