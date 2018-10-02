Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:34050 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBHtX (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Oct 2018 03:49:23 -0400
Date: Tue, 2 Oct 2018 02:08:49 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] rtc: cmos: Fix non-ACPI undefined reference to
 `hpet_rtc_interrupt'
In-Reply-To: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810020132270.20762@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fix a commit 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm 
instead of HPET") `rtc-cmos' regression causing a link error:

drivers/rtc/rtc-cmos.o: In function `cmos_platform_probe':
rtc-cmos.c:(.init.text+0x33c): undefined reference to `hpet_rtc_interrupt'
rtc-cmos.c:(.init.text+0x3f4): undefined reference to `hpet_rtc_interrupt'

with non-ACPI platforms using this driver.  The cause is the change of 
the condition guarding the use of `hpet_rtc_interrupt'.

Previously it was a call to `is_hpet_enabled'.  That function is static 
inline and has a hardcoded 0 result for non-ACPI platforms, which imply 
!HPET_EMULATE_RTC.  Consequently the compiler optimized the whole block 
away including the reference to `hpet_rtc_interrupt', which never made 
it to the link stage.

Now the guarding condition is a call to `use_hpet_alarm', which is not 
static inline and therefore the compiler may not be able to prove that 
it actually always returns 0 for non-ACPI platforms.  Consequently the 
build breaks with an unsatisfied reference, because `hpet_rtc_interrupt' 
is nowhere defined at link time.

Fix the problem by marking `use_hpet_alarm' inline.  As the `inline' 
keyword serves as an optimization hint rather than a requirement the 
compiler is still free to choose whether inlining will be beneficial or 
not for ACPI platforms.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org # 4.18+
---
 drivers/rtc/rtc-cmos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-rtc-cmos-use-hpet-alarm-inline.diff
Index: linux-20180812-4maxp64/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-20180812-4maxp64.orig/drivers/rtc/rtc-cmos.c
+++ linux-20180812-4maxp64/drivers/rtc/rtc-cmos.c
@@ -167,7 +167,7 @@ static inline int hpet_unregister_irq_ha
 #endif
 
 /* Don't use HPET for RTC Alarm event if ACPI Fixed event is used */
-static int use_hpet_alarm(void)
+static inline int use_hpet_alarm(void)
 {
 	return is_hpet_enabled() && !use_acpi_alarm;
 }
