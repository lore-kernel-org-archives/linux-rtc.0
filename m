Return-Path: <rtc-linux+bncBCPM5SUWUYIRBZGUVG4AKGQE5SRMEQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id r4si1058429pfr.1.2016.04.10.07.59.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Apr 2016 07:59:48 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id vv3so32517pab.0
        for <rtc-linux@googlegroups.com>; Sun, 10 Apr 2016 07:59:48 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/4] rtc: ds1302: fix write value for day of week register
Date: Sun, 10 Apr 2016 23:59:24 +0900
Message-Id: <1460300366-25248-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The valid range of day of week register for DS1302 is 1 to 7.  But the
set_time callback for rtc-ds1302 attempts to write the value of
tm->tm_wday which is in the range 0 to 6.  While the get_time callback
correctly decodes the register.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1302.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 5e05653..454248f 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -66,7 +66,7 @@ static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *time)
 	*bp++ = bin2bcd(time->tm_hour);
 	*bp++ = bin2bcd(time->tm_mday);
 	*bp++ = bin2bcd(time->tm_mon + 1);
-	*bp++ = time->tm_wday;
+	*bp++ = time->tm_wday + 1;
 	*bp++ = bin2bcd(time->tm_year % 100);
 	*bp++ = RTC_CMD_WRITE_DISABLE;
 
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
