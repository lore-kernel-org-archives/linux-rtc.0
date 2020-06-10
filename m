Return-Path: <SRS0=zvBJ=7X=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E293C433DF
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Jun 2020 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC482067B
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Jun 2020 13:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mvTfZBfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFJNb2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:31:28 -0400
Received: from first.geanix.com ([116.203.34.67]:35968 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgFJNb2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 10 Jun 2020 09:31:28 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 09:31:27 EDT
Received: from zen.localdomain (unknown [85.191.123.149])
        by first.geanix.com (Postfix) with ESMTPSA id 29C992120D13;
        Wed, 10 Jun 2020 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591795456; bh=aH/LAv6QDCj7J8LsKV3AqjTJnLaNMvl7ZVWlpmJ4SJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mvTfZBfDXkP9iyPBo1Oq2OuqOOjvbpFTaI/PH1KTA10FVvuE85U4WNhD9kOwDXjXk
         KRBKo9QRnD/EF4Vwbt+G2rqeUXbOsQr7hN1RpaB1nmpIw/u2UJwgnf5T8Mugizaml+
         riQHQmbMrQY5ccVJt55jfFyMtu2P/TJ1atKn9muAANbQD6Ubgzuw6aqfC9zIUIn5U0
         qgYCqoFRozx9Bg1O6babPi2VVraBDld7ltmzU079arEnZyyHYZbP9OnowQrt4jown5
         JRvPKR/hpZlWBgY0BEbJki56+wOAd2d0ZKR45mLIsMkgOsb4bsRvrhPOn7Y7ISdxLs
         bdP92P4lRGPqg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>
Subject: [RFC] rtc: class: register for late suspend / early resume
Date:   Wed, 10 Jun 2020 15:24:03 +0200
Message-Id: <20200610132403.2539519-1-martin@geanix.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <87k10habur.fsf () nanos ! tec ! linutronix ! de>
References: <87k10habur.fsf () nanos ! tec ! linutronix ! de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When running on hardware with no persistent clock, and no non-stop
clocksource, the timekeeping resume code relies on the rtc class to
inject the suspend time.

Other drivers might call into the timekeeping code to sync time in their
devices. If such devices are resumed before the rtc class (and rtc is
the only time source running in suspend) they currently get the
pre-suspend time.

Move the rtc class suspend/resume functions to be called late/early in
the cycle to make sure timekeeping is synchronised when other devices
are resumed.

This works in our case on an i.MX6, where the rtc driver only has
_suspend_noirq()/_resume_noirq(). I imagine it fails with drivers that
has regular _suspend()/_resume() functions. Any hints are welcome.

--

 drivers/rtc/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 7c88d190c51fc..737b67a1045ab 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -183,7 +183,9 @@ static int rtc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rtc_class_dev_pm_ops, rtc_suspend, rtc_resume);
+static const struct dev_pm_ops rtc_class_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(rtc_suspend, rtc_resume)
+};
 #define RTC_CLASS_DEV_PM_OPS	(&rtc_class_dev_pm_ops)
 #else
 #define RTC_CLASS_DEV_PM_OPS	NULL
-- 
2.26.2

