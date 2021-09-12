Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07850C433F5
	for <linux-rtc@archiver.kernel.org>; Sun, 12 Sep 2021 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CD9610A3
	for <linux-rtc@archiver.kernel.org>; Sun, 12 Sep 2021 12:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhILMon (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 12 Sep 2021 08:44:43 -0400
Received: from mx-out.tlen.pl ([193.222.135.148]:16242 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235166AbhILMom (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 12 Sep 2021 08:44:42 -0400
Received: (wp-smtpd smtp.tlen.pl 7772 invoked from network); 12 Sep 2021 14:43:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1631450606; bh=Fhf7rMoQ6L7izsQlV/8yihcnza8EcnJtUeazGGPlKI8=;
          h=From:To:Cc:Subject;
          b=XDgZQuVq6b7Y9SHZaqNLr8qdJPazsIflIAS/372xQNIgAWy2Hcl7KO52O1OcqCEIR
           ndVQmz8yganir4sjWdD+46y3vh6PwJEoFaxigAlyadvfWazJ3HyHqK8jBtfSBo+v7y
           6ASabbtBAlnbBUlBBWRIN5kG/je/cAnPDwSIOlZs=
Received: from aafh223.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.223])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 12 Sep 2021 14:43:26 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4/7] rtc-mc146818-lib: reduce RTC_UIP polling period
Date:   Sun, 12 Sep 2021 14:42:11 +0200
Message-Id: <20210912124214.81853-5-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912124214.81853-1-mat.jonczyk@o2.pl>
References: <20210912124214.81853-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2de05952312e8be5a898c95425994abe
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [wYNU]                               
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

A shorter period makes mc146818_get_time() more similar to
mach_get_cmos_time() in arch/x86/kernel/rtc.c, which performs the same
function, but is busy waiting for the RTC_UIP bit to clear.

Waiting 1ms every time is not necessary, for example on some AMD boxes
the RTC_UIP bit is documented as being high for around 270 microseconds
in some cases [1], which agreed with experiments on an SB710
southbridge. So 100us seems optimal.

[1] AMD SB700/710/750 Register Reference Guide, page 307,
https://developer.amd.com/wordpress/media/2012/10/43009_sb7xx_rrg_pub_1.00.pdf

        "SB700 A12: The UIP high pulse is 270 μS Typical when SS on SRC
        clock is OFF and 100μ min when SRC SS is ON." [sic]

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 drivers/rtc/rtc-mc146818-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 9175e11baf26..d1c42b0ef662 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -45,7 +45,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 #endif
 
 again:
-	if (iter_count > 10) {
+	if (iter_count > 100) {
 		pr_err_ratelimited("Unable to read current time from RTC\n");
 		memset(time, 0xff, sizeof(*time));
 		return 0;
@@ -57,7 +57,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	/*
 	 * Check whether there is an update in progress during which the
 	 * readout is unspecified. The maximum update time is ~2ms. Poll
-	 * every msec for completion.
+	 * every 100 usec for completion.
 	 *
 	 * Store the second value before checking UIP so a long lasting NMI
 	 * which happens to hit after the UIP check cannot make an update
@@ -67,7 +67,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 
 	if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
 		spin_unlock_irqrestore(&rtc_lock, flags);
-		mdelay(1);
+		udelay(100);
 		goto again;
 	}
 
-- 
2.25.1

