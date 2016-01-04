Return-Path: <rtc-linux+bncBCNNJWF7RUMRBCHVVK2AKGQEXZHUK5I@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id p88si8636075pfi.0.2016.01.04.10.31.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 10:31:36 -0800 (PST)
Received: by mail-pa0-x241.google.com with SMTP id a20so10369311pag.3
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 10:31:36 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v2 1/8] rtc-pcf2123: define registers and bit macros
Date: Mon,  4 Jan 2016 10:31:19 -0800
Message-Id: <eaa3bff3d0e00c2071e32239e8e9d5a514d65ad0.1451929910.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1451928661.git.stillcompiling@gmail.com>
References: <cover.1451928661.git.stillcompiling@gmail.com>
In-Reply-To: <0000-cover-letter.patch>
References: <0000-cover-letter.patch>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add defines for all 16 registers in the pcf2123.
Add defines for useful bits from several registers
I've tried to document all the registers, and
as best as possible, all the special bits they employ

Use BIT() wherever possible in the bit definitions

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 50 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index ea8a31c..be3ec83 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -48,6 +48,7 @@
 
 #define DRV_VERSION "0.6"
 
+/* REGISTERS */
 #define PCF2123_REG_CTRL1	(0x00)	/* Control Register 1 */
 #define PCF2123_REG_CTRL2	(0x01)	/* Control Register 2 */
 #define PCF2123_REG_SC		(0x02)	/* datetime */
@@ -57,10 +58,53 @@
 #define PCF2123_REG_DW		(0x06)
 #define PCF2123_REG_MO		(0x07)
 #define PCF2123_REG_YR		(0x08)
+#define PCF2123_REG_ALRM_MN	(0x09)	/* Alarm Registers */
+#define PCF2123_REG_ALRM_HR	(0x0a)
+#define PCF2123_REG_ALRM_DM	(0x0b)
+#define PCF2123_REG_ALRM_DW	(0x0c)
+#define PCF2123_REG_OFFSET	(0x0d)	/* Clock Rate Offset Register */
+#define PCF2123_REG_TMR_CLKOUT	(0x0e)	/* Timer Registers */
+#define PCF2123_REG_CTDWN_TMR	(0x0f)
+
+/* PCF2123_REG_CTRL1 BITS */
+#define CTRL1_CLEAR		(0)	/* Clear */
+#define CTRL1_CORR_INT		BIT(1)	/* Correction irq enable */
+#define CTRL1_12_HOUR		BIT(2)	/* 12 hour time */
+#define CTRL1_SW_RESET	(BIT(3) | BIT(4) | BIT(6))	/* Software reset */
+#define CTRL1_STOP		BIT(5)	/* Stop the clock */
+#define CTRL1_EXT_TEST		BIT(7)	/* External clock test mode */
+
+/* PCF2123_REG_CTRL2 BITS */
+#define CTRL2_TIE		BIT(0)	/* Countdown timer irq enable */
+#define CTRL2_AIE		BIT(1)	/* Alarm irq enable */
+#define CTRL2_TF		BIT(2)	/* Countdown timer flag */
+#define CTRL2_AF		BIT(3)	/* Alarm flag */
+#define CTRL2_TI_TP		BIT(4)	/* Irq pin generates pulse */
+#define CTRL2_MSF		BIT(5)	/* Minute or second irq flag */
+#define CTRL2_SI		BIT(6)	/* Second irq enable */
+#define CTRL2_MI		BIT(7)	/* Minute irq enable */
+
+/* PCF2123_REG_SC BITS */
+#define OSC_HAS_STOPPED		BIT(7)	/* Clock has been stopped */
+
+/* PCF2123_REG_ALRM_XX BITS */
+#define ALRM_ENABLE		BIT(7)	/* MN, HR, DM, or DW alarm enable */
+
+/* PCF2123_REG_TMR_CLKOUT BITS */
+#define CD_TMR_4096KHZ		(0)	/* 4096 KHz countdown timer */
+#define CD_TMR_64HZ		(1)	/* 64 Hz countdown timer */
+#define CD_TMR_1HZ		(2)	/* 1 Hz countdown timer */
+#define CD_TMR_60th_HZ		(3)	/* 60th Hz countdown timer */
+#define CD_TMR_TE		BIT(3)	/* Countdown timer enable */
+
+/* PCF2123_REG_OFFSET BITS */
+#define OFFSET_SIGN_BIT		BIT(6)	/* 2's complement sign bit */
+#define OFFSET_COARSE		BIT(7)	/* Coarse mode offset */
+
+/* READ/WRITE ADDRESS BITS */
+#define PCF2123_WRITE		BIT(4)
+#define PCF2123_READ		(BIT(4) | BIT(7))
 
-#define PCF2123_SUBADDR		(1 << 4)
-#define PCF2123_WRITE		((0 << 7) | PCF2123_SUBADDR)
-#define PCF2123_READ		((1 << 7) | PCF2123_SUBADDR)
 
 static struct spi_driver pcf2123_driver;
 
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
