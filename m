Return-Path: <rtc-linux+bncBCNNJWF7RUMRBIGM5CYQKGQE4UFAY6A@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id el2si190828pbb.0.2015.11.04.07.37.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:04 -0800 (PST)
Received: by mail-pa0-x22d.google.com with SMTP id z6so57706706pas.2
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:04 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 1/9] rtc-pcf2123: Document all registers and
 useful bits
Date: Wed,  4 Nov 2015 07:36:32 -0800
Message-Id: <ad6500ca32145d4f0b9cbfbc4b815d734e2da5e8.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
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

Document all 16 registers in the pcf2123, as well as
useful bit masks from the Control1 and seconds registers

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index d1953bb..7756210 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -47,6 +47,7 @@
 
 #define DRV_VERSION "0.6"
 
+/* REGISTERS */
 #define PCF2123_REG_CTRL1	(0x00)	/* Control Register 1 */
 #define PCF2123_REG_CTRL2	(0x01)	/* Control Register 2 */
 #define PCF2123_REG_SC		(0x02)	/* datetime */
@@ -56,7 +57,27 @@
 #define PCF2123_REG_DW		(0x06)
 #define PCF2123_REG_MO		(0x07)
 #define PCF2123_REG_YR		(0x08)
-
+#define PCF2123_REG_ALRM_MN	(0x09)	/* Alarm Registers */
+#define PCF2123_REG_ALRM_HR	(0x0a)
+#define PCF2123_REG_ALRM_DM	(0x0b)
+#define PCF2123_REG_ALRM_DW	(0x0c)
+#define PCF2123_REG_OFFSET	(0x0d)	/* Clock Rate Offset Register */
+#define PCF2123_REG_TMR_CLKOUT	(0x0e)	/* Timer Registers */
+#define PCF2123_REG_CTDWN_TMR	(0x0f)
+#define PCF2123_REG_MAX		(PCF2123_REG_CTDWN_TMR)
+
+/* PCF2123_REG_CTRL1 BITS */
+#define CTRL1_CLEAR		(0x00)	/* Clear */
+#define CTRL1_CORRECTION_INT	(0x02)	/* Correction Interrupt */
+#define CTRL1_12_HOUR		(0x04)	/* 12 hour time */
+#define CTRL1_STOP		(0x20)	/* Stop the clock */
+#define CTRL1_SW_RESET		(0x58)	/* Software reset */
+#define CTRL1_EXT_TEST		(0x80)	/* External Clock Test mode */
+
+/* PCF2123_REG_SC BITS */
+#define OSC_HAS_STOPPED		(0x80)	/* Clock has been stopped */
+
+/* READ/WRITE ADDRESS BITS */
 #define PCF2123_SUBADDR		(1 << 4)
 #define PCF2123_WRITE		((0 << 7) | PCF2123_SUBADDR)
 #define PCF2123_READ		((1 << 7) | PCF2123_SUBADDR)
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
