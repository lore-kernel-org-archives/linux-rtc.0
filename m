Return-Path: <rtc-linux+bncBCDY7V7TLQIML5HOYQCRUBCFNYCT2@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com. [2607:f8b0:400e:c00::243])
        by gmr-mx.google.com with ESMTPS id f7si139494pfk.5.2017.02.08.16.39.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 16:39:33 -0800 (PST)
Received: by mail-pf0-x243.google.com with SMTP id y143so12498811pfb.1
        for <rtc-linux@googlegroups.com>; Wed, 08 Feb 2017 16:39:33 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [rtc-linux] [PATCH 2/2] rtc: ds1302: Remove duplicate initialization code
Date: Thu,  9 Feb 2017 09:39:23 +0900
Message-Id: <20170209003923.9207-1-iwamatsu@nigauri.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The dp variable is initialized twice with ds1302_rtc_set_time function.
This patch removes duplicate initialization code.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/rtc/rtc-ds1302.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 0ec4be62322b..bc0e80921eb1 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -47,7 +47,6 @@ static int ds1302_rtc_set_time(struct device *dev, struct rtc_time *time)
 	int		status;
 
 	/* Enable writing */
-	bp = buf;
 	*bp++ = RTC_ADDR_CTRL << 1 | RTC_CMD_WRITE;
 	*bp++ = RTC_CMD_WRITE_ENABLE;
 
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
