Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIVCYG5QKGQEJAZLP4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f70si126397wmf.0.2016.06.26.15.03.13
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Jun 2016 15:03:13 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/5] rtc: ds17287: remove unused header
Date: Mon, 27 Jun 2016 00:02:59 +0200
Message-Id: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

ds17287rtc.h is unused since commit 15beb694c661 ("mips: ip32: add
platform data hooks to use DS1685 driver"), remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/linux/ds17287rtc.h | 66 ----------------------------------------------
 1 file changed, 66 deletions(-)
 delete mode 100644 include/linux/ds17287rtc.h

diff --git a/include/linux/ds17287rtc.h b/include/linux/ds17287rtc.h
deleted file mode 100644
index d85d3f497b96..000000000000
--- a/include/linux/ds17287rtc.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * ds17287rtc.h - register definitions for the ds1728[57] RTC / CMOS RAM
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * (C) 2003 Guido Guenther <agx@sigxcpu.org>
- */
-#ifndef __LINUX_DS17287RTC_H
-#define __LINUX_DS17287RTC_H
-
-#include <linux/rtc.h>			/* get the user-level API */
-#include <linux/mc146818rtc.h>
-
-/* Register A */
-#define DS_REGA_DV2	0x40		/* countdown chain */
-#define DS_REGA_DV1	0x20		/* oscillator enable */
-#define DS_REGA_DV0	0x10		/* bank select */
-
-/* bank 1 registers */
-#define DS_B1_MODEL	0x40		/* model number byte */
-#define DS_B1_SN1 	0x41		/* serial number byte 1 */
-#define DS_B1_SN2 	0x42		/* serial number byte 2 */
-#define DS_B1_SN3 	0x43		/* serial number byte 3 */
-#define DS_B1_SN4 	0x44		/* serial number byte 4 */
-#define DS_B1_SN5 	0x45		/* serial number byte 5 */
-#define DS_B1_SN6 	0x46		/* serial number byte 6 */
-#define DS_B1_CRC 	0x47		/* CRC byte */
-#define DS_B1_CENTURY 	0x48		/* Century byte */
-#define DS_B1_DALARM 	0x49		/* date alarm */
-#define DS_B1_XCTRL4A	0x4a		/* extendec control register 4a */
-#define DS_B1_XCTRL4B	0x4b		/* extendec control register 4b */
-#define DS_B1_RTCADDR2 	0x4e		/* rtc address 2 */
-#define DS_B1_RTCADDR3 	0x4f		/* rtc address 3 */
-#define DS_B1_RAMLSB	0x50		/* extended ram LSB */
-#define DS_B1_RAMMSB	0x51		/* extended ram MSB */
-#define DS_B1_RAMDPORT	0x53		/* extended ram data port */
-
-/* register details */
-/* extended control register 4a */
-#define DS_XCTRL4A_VRT2	0x80 		/* valid ram and time */
-#define DS_XCTRL4A_INCR	0x40		/* increment progress status */
-#define DS_XCTRL4A_BME	0x20		/* burst mode enable */
-#define DS_XCTRL4A_PAB	0x08		/* power active bar ctrl */
-#define DS_XCTRL4A_RF	0x04		/* ram clear flag */
-#define DS_XCTRL4A_WF	0x02		/* wake up alarm flag */
-#define DS_XCTRL4A_KF	0x01		/* kickstart flag */
-
-/* interrupt causes */
-#define DS_XCTRL4A_IFS	(DS_XCTRL4A_RF|DS_XCTRL4A_WF|DS_XCTRL4A_KF)
-
-/* extended control register 4b */
-#define DS_XCTRL4B_ABE	0x80 		/* auxiliary battery enable */
-#define DS_XCTRL4B_E32K	0x40		/* enable 32.768 kHz Output */
-#define DS_XCTRL4B_CS	0x20		/* crystal select */
-#define DS_XCTRL4B_RCE	0x10		/* ram clear enable */
-#define DS_XCTRL4B_PRS	0x08		/* PAB resec select */
-#define DS_XCTRL4B_RIE	0x04		/* ram clear interrupt enable */
-#define DS_XCTRL4B_WFE	0x02		/* wake up alarm interrupt enable */
-#define DS_XCTRL4B_KFE	0x01		/* kickstart interrupt enable */
-
-/* interrupt enable bits */
-#define DS_XCTRL4B_IFES	(DS_XCTRL4B_RIE|DS_XCTRL4B_WFE|DS_XCTRL4B_KFE)
-
-#endif /* __LINUX_DS17287RTC_H */
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
