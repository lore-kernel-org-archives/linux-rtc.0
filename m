Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6578C433B4
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 22:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EBC610A1
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 22:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhDPWyr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:54:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48127 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhDPWyr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 16 Apr 2021 18:54:47 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8DE6D240004;
        Fri, 16 Apr 2021 22:54:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, Tian Tao <tiantao6@hisilicon.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-spear: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Sat, 17 Apr 2021 00:54:20 +0200
Message-Id: <161861365456.872735.12795353876804013883.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1615775970-59070-1-git-send-email-tiantao6@hisilicon.com>
References: <1615775970-59070-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 15 Mar 2021 10:39:30 +0800, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.

Applied, thanks!

[1/1] rtc: rtc-spear: replace spin_lock_irqsave by spin_lock in hard IRQ
      commit: 880f25d690150937e42a2e8b86c111aae8da6d08

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
