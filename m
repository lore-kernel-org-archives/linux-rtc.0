Return-Path: <rtc-linux+bncBCOML4NU3EDRB5ODUO2AKGQEWXDQYYA@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id b4si904487wme.3.2016.01.03.00.55.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:55:16 -0800 (PST)
Subject: [rtc-linux] [PATCH 6/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_read_timer()
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688E1F2.1080705@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:55:14 +0100
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
Date: Sun, 3 Jan 2016 08:46:50 +0100

Pass the address of the data structure element "time" directly in a call
of the function "rtc_time_to_tm" instead of an extra initialisation
for one local variable at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 02e3443..e3a015a 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -326,7 +326,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 				    struct rtc_wkalrm *alarm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
-	struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
+	struct rtc_time rtc_tm;
 	u8 regs[ABB5ZES3_TIMA_SEC_LEN + 1];
 	unsigned long rtc_secs;
 	unsigned int reg;
@@ -362,7 +362,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 		goto err;
 
 	/* ... and convert back. */
-	rtc_time_to_tm(rtc_secs + timer_secs, alarm_tm);
+	rtc_time_to_tm(rtc_secs + timer_secs, &alarm->time);
 
 	ret = regmap_read(data->regmap, ABB5ZES3_REG_CTRL2, &reg);
 	if (ret) {
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
