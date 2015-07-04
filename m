Return-Path: <rtc-linux+bncBDULZYNR2QMRBMGL4CWAKGQEQJOV2IA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-qk0-x22c.google.com (mail-qk0-x22c.google.com. [2607:f8b0:400d:c09::22c])
        by gmr-mx.google.com with ESMTPS id j14si895283ywa.5.2015.07.04.11.27.59
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2015 11:27:59 -0700 (PDT)
Received: by mail-qk0-x22c.google.com with SMTP id i195so91987156qke.3
        for <rtc-linux@googlegroups.com>; Sat, 04 Jul 2015 11:27:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: gregory.clement@free-electrons.com,
	rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-armada38x: Remove unused variable
 from armada38x_rtc_set_time()
Date: Sat,  4 Jul 2015 15:27:34 -0300
Message-Id: <1436034454-10473-1-git-send-email-festevam@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Fabio Estevam <fabio.estevam@freescale.com>

Remove the 'flags' variable in order to fix the following warning:

drivers/rtc/rtc-armada38x.c:91:22: warning: unused variable 'flags' [-Wunused-variable]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-armada38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 4b62d1a..2b08cac 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -88,7 +88,7 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
 	int ret = 0;
-	unsigned long time, flags;
+	unsigned long time;
 
 	ret = rtc_tm_to_time(tm, &time);
 
-- 
1.9.1

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
