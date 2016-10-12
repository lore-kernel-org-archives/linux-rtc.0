Return-Path: <rtc-linux+bncBDUNBGN3R4KRBIPW7C7QKGQE65NSGZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bombadil.infradead.org (bombadil.infradead.org. [2001:1868:205::9])
        by gmr-mx.google.com with ESMTPS id co10si883236pad.1.2016.10.12.06.31.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 06:31:12 -0700 (PDT)
From: Christoph Hellwig <hch@lst.de>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: arnd@arndb.de,
	david-b@pacbell.net,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc-cmos: don't refer to asm-generic/rtc.h
Date: Wed, 12 Oct 2016 15:30:53 +0200
Message-Id: <1476279053-27967-1-git-send-email-hch@lst.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

That header has been gone for a while.  I've fixed up the Kconfig
comment, but the one in rtc-cmos.c doesn't make any sense to me
even looking at its history.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/rtc/Kconfig    | 4 ++--
 drivers/rtc/rtc-cmos.c | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d1e0807..9bc1b4d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -815,8 +815,8 @@ config RTC_DRV_RV3029_HWMON
 
 comment "Platform RTC drivers"
 
-# this 'CMOS' RTC driver is arch dependent because <asm-generic/rtc.h>
-# requires <asm/mc146818rtc.h> defining CMOS_READ/CMOS_WRITE, and a
+# this 'CMOS' RTC driver is arch dependent because it requires
+# <asm/mc146818rtc.h> defining CMOS_READ/CMOS_WRITE, and a
 # global rtc_lock ... it's not yet just another platform_device.
 
 config RTC_DRV_CMOS
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 43745ca..a2b12eb 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -698,9 +698,6 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	spin_unlock_irq(&rtc_lock);
 
-	/* FIXME:
-	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
-	 */
 	if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
 		dev_warn(dev, "only 24-hr supported\n");
 		retval = -ENXIO;
-- 
2.10.1.382.ga23ca1b

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
