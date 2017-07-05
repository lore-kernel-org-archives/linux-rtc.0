Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59337 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbdGJH7f (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Jul 2017 03:59:35 -0400
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id AFDC1208BF
        for <linux-rtc@vger.kernel.org>; Mon, 10 Jul 2017 09:58:50 +0200 (CEST)
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH v2 2/2] RTC: s35390a: implement ioctls
Date: Wed,  5 Jul 2017 10:02:30 +0200
Message-Id:
 <bc0dd162f9b89349b41087f1fd710409cd9aaa8f.1499240924.git.fabien.lahoudere@collabora.co.uk>
In-Reply-To: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
In-Reply-To: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170705080230.WuX0ErnHE9_-bOO_xYFCOteQctXg7rfKCL6ZQVdUWoY@z>

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
