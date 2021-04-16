Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A574CC433ED
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 22:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69346611AC
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 22:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhDPWRM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:17:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37121 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhDPWRJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 16 Apr 2021 18:17:09 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EE667C0002;
        Fri, 16 Apr 2021 22:16:40 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Francois Gervais <fgervais@distech-controls.com>,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael McCormick <michael.mccormick@enatel.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rtc: pcf85063: fallback to parent of_node
Date:   Sat, 17 Apr 2021 00:16:40 +0200
Message-Id: <161861118020.865088.6364463756780633947.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210310211026.27299-1-fgervais@distech-controls.com>
References: <20210310211026.27299-1-fgervais@distech-controls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 10 Mar 2021 16:10:26 -0500, Francois Gervais wrote:
> The rtc device node is always or at the very least can possibly be NULL.
> 
> Since v5.12-rc1-dontuse/3c9ea42802a1fbf7ef29660ff8c6e526c58114f6 this
> will lead to a NULL pointer dereference.
> 
> To fix this we fallback to using the parent node which is the i2c client
> node as set by devm_rtc_allocate_device().
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf85063: fallback to parent of_node
      commit: 03531606ef4cda25b629f500d1ffb6173b805c05

I made the fallback unconditionnal because this should have been that way from
the beginning as you point out.

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
