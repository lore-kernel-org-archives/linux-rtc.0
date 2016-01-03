Return-Path: <rtc-linux+bncBCOML4NU3EDRBRGDUO2AKGQEYUIWQLI@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.11])
        by gmr-mx.google.com with ESMTPS id 185si2299971wmn.0.2016.01.03.00.54.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:54:28 -0800 (PST)
Subject: [rtc-linux] [PATCH 5/8] rtc-ab-b5ze-s3: Replace a variable
 initialisation by an assignment in _abb5zes3_rtc_read_alarm()
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688E1C1.3020401@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:54:25 +0100
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
Date: Sun, 3 Jan 2016 08:00:29 +0100

Replace an explicit initialisation for one local variable at the beginning
by an assignment.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 0986715..02e3443 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -382,7 +382,7 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 				    struct rtc_wkalrm *alarm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
-	struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
+	struct rtc_time rtc_tm, *alarm_tm;
 	unsigned long rtc_secs, alarm_secs;
 	u8 regs[ABB5ZES3_ALRM_SEC_LEN];
 	unsigned int reg;
@@ -396,6 +396,7 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 		goto err;
 	}
 
+	alarm_tm = &alarm->time;
 	alarm_tm->tm_sec  = 0;
 	alarm_tm->tm_min  = bcd2bin(regs[0] & 0x7f);
 	alarm_tm->tm_hour = bcd2bin(regs[1] & 0x3f);
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
