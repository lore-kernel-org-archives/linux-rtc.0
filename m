Return-Path: <rtc-linux+bncBCPM5SUWUYIRBNOR2C4AKGQEYOF57HI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id d22si2149101pfd.0.2016.04.17.17.22.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 17:22:13 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id d184so15317551pfc.1
        for <rtc-linux@googlegroups.com>; Sun, 17 Apr 2016 17:22:13 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Zhuang Yuyao <mlistz@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Zhuang Yuyao <zhuangyy@syan.com.cn>,
	Michael Tatarinov <kukabu@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: ds1307: ds3231 temperature s16 overflow
Date: Mon, 18 Apr 2016 09:21:42 +0900
Message-Id: <1460938902-3120-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Zhuang Yuyao <mlistz@gmail.com>

while retrieving temperature from ds3231, the result may be overflow
since s16 is too small for a multiplication with 250.

ie. if temp_buf[0] == 0x2d, the result (s16 temp) will be negative.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Zhuang Yuyao <mlistz@gmail.com>
Cc: Zhuang Yuyao <zhuangyy@syan.com.cn>
Cc: Michael Tatarinov <kukabu@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index cb0ffa8..90d1e5a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -863,7 +863,7 @@ out:
  * A user-initiated temperature conversion is not started by this function,
  * so the temperature is updated once every 64 seconds.
  */
-static int ds3231_hwmon_read_temp(struct device *dev, s16 *mC)
+static int ds3231_hwmon_read_temp(struct device *dev, s32 *mC)
 {
 	struct ds1307 *ds1307 = dev_get_drvdata(dev);
 	u8 temp_buf[2];
@@ -892,7 +892,7 @@ static ssize_t ds3231_hwmon_show_temp(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
-	s16 temp;
+	s32 temp;
 
 	ret = ds3231_hwmon_read_temp(dev, &temp);
 	if (ret)
-- 
2.5.0

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
