Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A562DC433F5
	for <linux-rtc@archiver.kernel.org>; Sun, 12 Sep 2021 12:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8A36108F
	for <linux-rtc@archiver.kernel.org>; Sun, 12 Sep 2021 12:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhILMoP (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 12 Sep 2021 08:44:15 -0400
Received: from mx-out.tlen.pl ([193.222.135.148]:37345 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbhILMoN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 12 Sep 2021 08:44:13 -0400
Received: (wp-smtpd smtp.tlen.pl 31825 invoked from network); 12 Sep 2021 14:42:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1631450576; bh=YfUmD7A5JyGcWACSZctlVE6B6BY0XST+i0j3N5PDBAE=;
          h=From:To:Cc:Subject;
          b=w3nfZo+sbGPEmU4rufv8oGWlH4UEty5v9f+m/NRsXioshATvTZU4ouJGugX0iGbNH
           aq6x5g13ssNzjisHAoE+ncT+XPb6GUvnmkhEx3Ou3mlbWluJkiR57ZAhDQs3LWuj7H
           YNI86JesbTQveDJmxeOLWfN0yHVQUWy7mxLEBkic=
Received: from aafh223.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.223])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 12 Sep 2021 14:42:54 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND 1/7] rtc-cmos: take rtc_lock while reading from CMOS
Date:   Sun, 12 Sep 2021 14:42:08 +0200
Message-Id: <20210912124214.81853-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912124214.81853-1-mat.jonczyk@o2.pl>
References: <20210912124214.81853-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 82d79725d5238b74d4a8e46355abd775
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [UdPk]                               
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Reading from the CMOS involves writing to the index register and then
reading from the data register. Therefore access to the CMOS has to be
serialized with rtc_lock. This invocation of CMOS_READ was not
serialized, which could cause trouble when other code is accessing CMOS
at the same time.

Use spin_lock_irq() like the rest of the function.

Nothing in kernel modifies the RTC_DM_BINARY bit, so there could be a
separate pair of spin_lock_irq() / spin_unlock_irq() before doing the
math.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Reviewed-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org
---
 drivers/rtc/rtc-cmos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 670fd8a2970e..2cd0fe728ab2 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -463,7 +463,10 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	min = t->time.tm_min;
 	sec = t->time.tm_sec;
 
+	spin_lock_irq(&rtc_lock);
 	rtc_control = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irq(&rtc_lock);
+
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		/* Writing 0xff means "don't care" or "match all".  */
 		mon = (mon <= 12) ? bin2bcd(mon) : 0xff;
-- 
2.25.1

