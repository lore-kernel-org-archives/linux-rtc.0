Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6DBC07E95
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2EC61CB0
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGGVmA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 7 Jul 2021 17:42:00 -0400
Received: from mx-out.tlen.pl ([193.222.135.175]:42412 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233017AbhGGVmA (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 7 Jul 2021 17:42:00 -0400
Received: (wp-smtpd smtp.tlen.pl 7797 invoked from network); 7 Jul 2021 23:39:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1625693957; bh=gbvEFDaYKmj7AweVDzc8BvhxA29PVVjPAl91NfU4MLE=;
          h=From:To:Cc:Subject;
          b=kLzWmANAzp8H+zsQjkM5ab+sS+5efUHkwty9GmZ7aA1G6y2EkQYS6pNRLCN7LyA+b
           beelK/zEYUJbLBBbALYEBozevA/7P7FYscy3sc6+nee9WpRSxxzu+x4aFoohsNsRbW
           PfUX3fiYl/wvAMoBHYuZyEtgvdbJw6uxauCvRYcg=
Received: from aafl140.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.141.140])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 7 Jul 2021 23:39:17 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH] rtc: mc146818: Use hours for checking RTC availability
Date:   Wed,  7 Jul 2021 23:38:44 +0200
Message-Id: <20210707213844.115181-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <113c6933-28c8-91cf-f802-5a38417da749@o2.pl>
References: <113c6933-28c8-91cf-f802-5a38417da749@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: ae8d76d5e50aa9d508fec2d75438d1c8
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EaOU]                               
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

To prevent an infinite loop, it is necessary to ascertain the RTC is
present. Previous code was checking if bit 6 in register 0x0D is
cleared. This caused a false negative on a motherboard with an AMD SB710
southbridge; according to the specification [1], bit 6 of register 0x0D
on this chipset is a scratchbit.

Use the RTC_HOURS register instead, which is expected to contain a value
not larger then 24, in BCD format.

Caveat: when I was playing with
        while true; do cat /sys/class/rtc/rtc0/time; done
I sometimes triggered this mechanism on my HP laptop. It appears that
CMOS_READ(RTC_VALID) was sometimes reading the number of seconds from
previous loop iteration. This happens very rarely, though, and this patch
does not make it any more likely.

[1] AMD SB700/710/750 Register Reference Guide, page 308,
https://developer.amd.com/wordpress/media/2012/10/43009_sb7xx_rrg_pub_1.00.pdf

Fixes: 211e5db19d15 ("rtc: mc146818: Detect and handle broken RTCs")
Fixes: ebb22a059436 ("rtc: mc146818: Dont test for bit 0-5 in Register D")
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org
---
 drivers/rtc/rtc-cmos.c         |  6 +++---
 drivers/rtc/rtc-mc146818-lib.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 670fd8a2970e..b0102fb31b3f 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -798,10 +798,10 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	spin_lock_irq(&rtc_lock);
 
-	/* Ensure that the RTC is accessible. Bit 6 must be 0! */
-	if ((CMOS_READ(RTC_VALID) & 0x40) != 0) {
+	/* Ensure that the RTC is accessible (RTC_HOURS is in BCD format) */
+	if (CMOS_READ(RTC_HOURS) > 0x24) {
 		spin_unlock_irq(&rtc_lock);
-		dev_warn(dev, "not accessible\n");
+		dev_warn(dev, "not accessible or not working correctly\n");
 		retval = -ENXIO;
 		goto cleanup1;
 	}
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index dcfaf09946ee..1d69c3c13257 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -21,9 +21,15 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 
 again:
 	spin_lock_irqsave(&rtc_lock, flags);
-	/* Ensure that the RTC is accessible. Bit 6 must be 0! */
-	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x40) != 0)) {
+
+	/*
+	 * Ensure that the RTC is accessible, to avoid an infinite loop.
+	 * RTC_HOURS is in BCD format.
+	 */
+	if (CMOS_READ(RTC_HOURS) > 0x24) {
 		spin_unlock_irqrestore(&rtc_lock, flags);
+		pr_warn_once("Real-time clock is not accessible or not "
+				"working correctly\n");
 		memset(time, 0xff, sizeof(*time));
 		return 0;
 	}
-- 
2.25.1

