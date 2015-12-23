Return-Path: <rtc-linux+bncBDA5BKNJ6MIBBUVX5OZQKGQEJARBKPY@googlegroups.com>
MIME-Version: 1.0
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id p88si3955907pfi.0.2015.12.23.09.37.22
        for <rtc-linux@googlegroups.com>;
        Wed, 23 Dec 2015 09:37:22 -0800 (PST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rtc-linux] [PATCH v1 1/1] rtc: cmos: prevent kernel warning on IRQ
 flags mismatch
Date: Wed, 23 Dec 2015 19:37:19 +0200
Message-Id: <1450892239-74224-1-git-send-email-andriy.shevchenko@linux.intel.com>
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

The Microsoft Surface 3 tablet shares interrupt line between RTC and one of SPI
controllers. However, the rtc_cmos driver doesn't allow shared interrupts and
user sees the following warning

genirq: Flags mismatch irq 8. 00000080 (8086228E:02) vs. 00000000 (rtc0)
...
[<ffffffffa004eb01>] pxa2xx_spi_probe+0x151/0x600 [spi_pxa2xx_platform]

Allow RTC driver to use shared interrupts.

Seems we are on the safe side to do just this simple change since
cmos_interrupt() handler checks for the actual hardware status anyway.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-cmos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 8f7034b..84fb541 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -725,7 +725,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 			rtc_cmos_int_handler = cmos_interrupt;
 
 		retval = request_irq(rtc_irq, rtc_cmos_int_handler,
-				0, dev_name(&cmos_rtc.rtc->dev),
+				IRQF_SHARED, dev_name(&cmos_rtc.rtc->dev),
 				cmos_rtc.rtc);
 		if (retval < 0) {
 			dev_dbg(dev, "IRQ %d is already in use\n", rtc_irq);
-- 
2.6.4

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
