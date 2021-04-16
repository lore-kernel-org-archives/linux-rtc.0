Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31916C433ED
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 23:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0304A610CC
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhDPXES (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:04:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55079 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhDPXES (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 16 Apr 2021 19:04:18 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2F897C0004;
        Fri, 16 Apr 2021 23:03:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, Tian Tao <tiantao6@hisilicon.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: cpcap: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Sat, 17 Apr 2021 01:03:51 +0200
Message-Id: <161861422670.875375.7331541067887651479.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1617757071-14266-1-git-send-email-tiantao6@hisilicon.com>
References: <1617757071-14266-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 7 Apr 2021 08:57:51 +0800, Tian Tao wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable because of requesting.
> 
> this patch is made base on "add IRQF_NO_AUTOEN for request_irq" which
> is being merged: https://lore.kernel.org/patchwork/patch/1388765/

Applied, thanks!

[1/1] rtc: cpcap: move to use request_irq by IRQF_NO_AUTOEN flag
      commit: 1663e293700c4aeff6f06eb1c6529bc07ed0523d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
