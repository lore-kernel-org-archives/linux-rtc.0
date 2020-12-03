Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997F2C4361A
	for <linux-rtc@archiver.kernel.org>; Thu,  3 Dec 2020 22:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410F3223E8
	for <linux-rtc@archiver.kernel.org>; Thu,  3 Dec 2020 22:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgLCWxA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:53:00 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51637 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgLCWxA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 3 Dec 2020 17:53:00 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 64A4C1BF208;
        Thu,  3 Dec 2020 22:52:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] rtc: s3c: Disable all enable (RTC, tick) bits in the probe
Date:   Thu,  3 Dec 2020 23:52:17 +0100
Message-Id: <160703593364.102627.6281695169536420119.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201202111318.5353-1-m.szyprowski@samsung.com>
References: <CGME20201202111328eucas1p25b7a68b4fe94addf6088cc3ad4bedcf1@eucas1p2.samsung.com> <20201202111318.5353-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 2 Dec 2020 12:13:17 +0100, Marek Szyprowski wrote:
> Bootloader might use RTC hardware and leave it in the enabled state. Ensure
> that the potentially enabled periodic tick interrupts are disabled before
> enabling the driver, because they might cause lockup if tick interrupt
> happens after disabling RTC gate clock.

Applied, thanks!

[1/2] rtc: s3c: Disable all enable (RTC, tick) bits in the probe
      commit: 31b16d978f902bd9ac7fdc20738f67e39959cd5c
[2/2] rtc: s3c: Remove dead code related to periodic tick handling
      commit: ce9af89392024f57247187afc345991b784f9bae

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
