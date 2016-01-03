Return-Path: <rtc-linux+bncBCOML4NU3EDRBHGCUO2AKGQEQFD2JGI@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.11])
        by gmr-mx.google.com with ESMTPS id 202si2321730wmf.2.2016.01.03.00.51.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:51:40 -0800 (PST)
Subject: [rtc-linux] [PATCH 2/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in abb5zes3_rtc_set_alarm()
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688E11A.90303@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:51:38 +0100
MIME-Version: 1.0
In-Reply-To: <5688DF2D.6090204@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Jan 2016 07:35:09 +0100

Pass the address of the data structure element "time" directly in a call
of the function "rtc_tm_to_time" instead of an extra initialisation
for one local variable at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 1291206..ed9b873 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -596,7 +596,6 @@ err:
 static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
-	struct rtc_time *alarm_tm = &alarm->time;
 	unsigned long rtc_secs, alarm_secs;
 	struct rtc_time rtc_tm;
 	int ret;
@@ -610,7 +609,7 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ret)
 		goto err;
 
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
+	ret = rtc_tm_to_time(&alarm->time, &alarm_secs);
 	if (ret)
 		goto err;
 
-- 
2.6.3

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
