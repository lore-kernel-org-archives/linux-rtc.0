Return-Path: <rtc-linux+bncBCVK5RWD2QBRBJFLTHCQKGQEDFBYO4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from anchovy.45ru.net.au (anchovy3.45ru.net.au. [203.30.46.155])
        by gmr-mx.google.com with ESMTPS id f7si441386pfk.5.2017.02.16.17.45.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 17:45:08 -0800 (PST)
From: Phil Reid <preid@electromag.com.au>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
  akinobu.mita@gmail.com, preid@electromag.com.au, rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/3] rtc: ds3232: Cleanup whitespace around
 register and bit definitions.
Date: Fri, 17 Feb 2017 09:44:56 +0800
Message-Id: <1487295898-90177-2-git-send-email-preid@electromag.com.au>
In-Reply-To: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Whitespace was a combination of spaces and tabs.
Use spaces and align register / bit definitions.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/rtc/rtc-ds3232.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index b1f20d8..67066f1 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -23,28 +23,28 @@
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
-#define DS3232_REG_SECONDS	0x00
-#define DS3232_REG_MINUTES	0x01
-#define DS3232_REG_HOURS	0x02
-#define DS3232_REG_AMPM		0x02
-#define DS3232_REG_DAY		0x03
-#define DS3232_REG_DATE		0x04
-#define DS3232_REG_MONTH	0x05
-#define DS3232_REG_CENTURY	0x05
-#define DS3232_REG_YEAR		0x06
-#define DS3232_REG_ALARM1         0x07	/* Alarm 1 BASE */
-#define DS3232_REG_ALARM2         0x0B	/* Alarm 2 BASE */
-#define DS3232_REG_CR		0x0E	/* Control register */
-#	define DS3232_REG_CR_nEOSC        0x80
-#       define DS3232_REG_CR_INTCN        0x04
-#       define DS3232_REG_CR_A2IE        0x02
-#       define DS3232_REG_CR_A1IE        0x01
-
-#define DS3232_REG_SR	0x0F	/* control/status register */
-#	define DS3232_REG_SR_OSF   0x80
-#       define DS3232_REG_SR_BSY   0x04
-#       define DS3232_REG_SR_A2F   0x02
-#       define DS3232_REG_SR_A1F   0x01
+#define DS3232_REG_SECONDS      0x00
+#define DS3232_REG_MINUTES      0x01
+#define DS3232_REG_HOURS        0x02
+#define DS3232_REG_AMPM         0x02
+#define DS3232_REG_DAY          0x03
+#define DS3232_REG_DATE         0x04
+#define DS3232_REG_MONTH        0x05
+#define DS3232_REG_CENTURY      0x05
+#define DS3232_REG_YEAR         0x06
+#define DS3232_REG_ALARM1       0x07       /* Alarm 1 BASE */
+#define DS3232_REG_ALARM2       0x0B       /* Alarm 2 BASE */
+#define DS3232_REG_CR           0x0E       /* Control register */
+#       define DS3232_REG_CR_nEOSC   0x80
+#       define DS3232_REG_CR_INTCN   0x04
+#       define DS3232_REG_CR_A2IE    0x02
+#       define DS3232_REG_CR_A1IE    0x01
+
+#define DS3232_REG_SR           0x0F       /* control/status register */
+#       define DS3232_REG_SR_OSF     0x80
+#       define DS3232_REG_SR_BSY     0x04
+#       define DS3232_REG_SR_A2F     0x02
+#       define DS3232_REG_SR_A1F     0x01
 
 struct ds3232 {
 	struct device *dev;
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
