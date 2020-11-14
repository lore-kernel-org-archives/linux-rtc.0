Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C300FC5519F
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0EF221F9
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKNWQm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Nov 2020 17:16:42 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:65503 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKNWQm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Nov 2020 17:16:42 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 364A7240002;
        Sat, 14 Nov 2020 22:16:38 +0000 (UTC)
Date:   Sat, 14 Nov 2020 23:16:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: Fix memleak in sun6i_rtc_clk_init
Message-ID: <20201114221638.GP4556@piout.net>
References: <1605327501-15110-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605327501-15110-1-git-send-email-tangyouling@loongson.cn>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

Thank you for the patch.

On 14/11/2020 12:18:21+0800, Youling Tang wrote:
> When rtc->base or rtc->int_osc or rtc->losc or rtc->ext_losc is NULL,
> we should free clk_data and rtc before the function returns to prevent
> memleak.
> 

I think this is fixed by 28d211919e422f58c1e6c900e5810eee4f1ce4c8 in my
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?id=28d211919e422f58c1e6c900e5810eee4f1ce4c8

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
