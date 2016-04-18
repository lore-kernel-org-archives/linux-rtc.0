Return-Path: <rtc-linux+bncBDSJRCVEXEPBBXPI2K4AKGQEVYGZ7XY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout01.posteo.de (mout01.posteo.de. [185.67.36.65])
        by gmr-mx.google.com with ESMTPS id i196si1417944wmf.0.2016.04.18.03.18.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 03:18:05 -0700 (PDT)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id CA5C620A3F
	for <rtc-linux@googlegroups.com>; Mon, 18 Apr 2016 12:18:04 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [rtc-linux] [PATCH] rtc-pcf2123: use sign_extend32() for sign extension
Date: Mon, 18 Apr 2016 12:17:44 +0200
Message-Id: <1460974664-7525-1-git-send-email-martink@posteo.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/rtc/rtc-pcf2123.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index f22e060..b4478cc 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -96,7 +96,7 @@
 #define CD_TMR_TE		BIT(3)	/* Countdown timer enable */
 
 /* PCF2123_REG_OFFSET BITS */
-#define OFFSET_SIGN_BIT		BIT(6)	/* 2's complement sign bit */
+#define OFFSET_SIGN_BIT		6	/* 2's complement sign bit */
 #define OFFSET_COARSE		BIT(7)	/* Coarse mode offset */
 #define OFFSET_STEP		(2170)	/* Offset step in parts per billion */
 
@@ -217,7 +217,7 @@ static int pcf2123_read_offset(struct device *dev, long *offset)
 	if (reg & OFFSET_COARSE)
 		reg <<= 1; /* multiply by 2 and sign extend */
 	else
-		reg |= (reg & OFFSET_SIGN_BIT) << 1; /* sign extend only */
+		reg = sign_extend32(reg, OFFSET_SIGN_BIT);
 
 	*offset = ((long)reg) * OFFSET_STEP;
 
-- 
2.1.4

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
