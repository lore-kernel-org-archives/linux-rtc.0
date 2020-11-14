Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD8C5519F
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB40E24073
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKNWwy (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Nov 2020 17:52:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:29541 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKNWwy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Nov 2020 17:52:54 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E1B00240003;
        Sat, 14 Nov 2020 22:52:50 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     bcm-kernel-feedback-list@broadcom.com, a.zummo@towertech.it,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        Xu Wang <vulab@iscas.ac.cn>, linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: brcmstb-waketimer: Remove redundant null check before clk_disable_unprepare
Date:   Sat, 14 Nov 2020 23:52:45 +0100
Message-Id: <160539432950.849809.8243938283788159741.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113074538.65028-1-vulab@iscas.ac.cn>
References: <20201113074538.65028-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 13 Nov 2020 07:45:38 +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Applied, thanks!

[1/1] rtc: brcmstb-waketimer: Remove redundant null check before clk_disable_unprepare
      commit: 910d002d84df21da61cadba92dd510ece5e46312

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
