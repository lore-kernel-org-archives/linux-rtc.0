Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86BDC12002
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Jul 2021 21:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0553613F2
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Jul 2021 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhGPVID (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:08:03 -0400
Received: from mx-out.tlen.pl ([193.222.135.145]:17649 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhGPVID (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Jul 2021 17:08:03 -0400
Received: (wp-smtpd smtp.tlen.pl 11191 invoked from network); 16 Jul 2021 23:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1626469503; bh=78D/XVBXBKYEstCIhkP3KuOQ9/83xoUC4l8G6kPPPbg=;
          h=From:To:Cc:Subject;
          b=uB9PBYVmtZTC8+SB6ZbTkbwVZjmu5cbHBhFSA/lkoUjFYPU0pQy5TZfrgnQIP87Gd
           58qYQ/0cyE2NAK7W+x/n8FbJfJq6eSdiJdw+xFZ8j/ee6LMNiLXIBXwl8SHvDb6KUR
           +lmGtkDxosU7zpTjH0G8rUBJqYU0FF5CABGAufEs=
Received: from aaey41.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.128.41])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-rtc@vger.kernel.org>; 16 Jul 2021 23:05:02 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc-cmos: remove stale REVISIT comments
Date:   Fri, 16 Jul 2021 23:04:37 +0200
Message-Id: <20210716210437.29622-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: cce730fc3bc9d7cf797e29ca7373e195
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [8bMk]                               
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

It appears mc146818_get_time() and mc146818_set_time() now correctly
use the century register as specified in the ACPI FADT table. It is not
clear what else could be done here.

These comments were introduced by
        commit 7be2c7c96aff ("[PATCH] RTC framework driver for CMOS RTCs")
in 2007, which originally referenced function get_rtc_time() in
include/asm-generic/rtc.h .

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

---
 drivers/rtc/rtc-cmos.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 670fd8a2970e..eb15067a605e 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -229,19 +229,13 @@ static int cmos_read_time(struct device *dev, struct rtc_time *t)
 	if (!pm_trace_rtc_valid())
 		return -EIO;
 
-	/* REVISIT:  if the clock has a "century" register, use
-	 * that instead of the heuristic in mc146818_get_time().
-	 * That'll make Y3K compatility (year > 2070) easy!
-	 */
 	mc146818_get_time(t);
 	return 0;
 }
 
 static int cmos_set_time(struct device *dev, struct rtc_time *t)
 {
-	/* REVISIT:  set the "century" register if available
-	 *
-	 * NOTE: this ignores the issue whereby updating the seconds
+	/* NOTE: this ignores the issue whereby updating the seconds
 	 * takes effect exactly 500ms after we write the register.
 	 * (Also queueing and other delays before we get this far.)
 	 */
-- 
2.25.1

