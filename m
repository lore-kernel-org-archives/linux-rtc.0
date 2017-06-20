Return-Path: <rtc-linux+bncBDKNBMNKRMJRB4OZUPFAKGQE3EV66FA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id w136si3550808wmf.3.2017.06.20.02.37.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:53 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id d64so23691467wmf.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:53 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 23/51] rtc: ds1672: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:31 +0200
Message-Id: <1497951359-13334-24-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-ds1672.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 7bf46bf..ff2468c 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -30,7 +30,7 @@
  */
 static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
-	unsigned long time;
+	unsigned long long time;
 	unsigned char addr = DS1672_REG_CNT_BASE;
 	unsigned char buf[4];
 
@@ -60,7 +60,7 @@ static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 
 	time = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -96,7 +96,7 @@ static int ds1672_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return ds1672_get_datetime(to_i2c_client(dev), tm);
 }
 
-static int ds1672_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int ds1672_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	return ds1672_set_mmss(to_i2c_client(dev), secs);
 }
@@ -148,7 +148,7 @@ static ssize_t show_control(struct device *dev, struct device_attribute *attr,
 
 static const struct rtc_class_ops ds1672_rtc_ops = {
 	.read_time = ds1672_rtc_read_time,
-	.set_mmss = ds1672_rtc_set_mmss,
+	.set_mmss64 = ds1672_rtc_set_mmss64,
 };
 
 static int ds1672_probe(struct i2c_client *client,
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
