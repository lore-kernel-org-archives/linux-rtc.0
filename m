Return-Path: <SRS0=rvV4=QO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E1BC282C2
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Feb 2019 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B643C2080F
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Feb 2019 20:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfBGUnB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:43:01 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57689 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfBGUnB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 7 Feb 2019 15:43:01 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AF2A060007;
        Thu,  7 Feb 2019 20:42:58 +0000 (UTC)
Date:   Thu, 7 Feb 2019 21:42:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: x1205: Add DT probing support
Message-ID: <20190207204258.GJ4719@piout.net>
References: <20190131150642.26289-1-linus.walleij@linaro.org>
 <20190131150642.26289-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131150642.26289-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 31/01/2019 16:06:42+0100, Linus Walleij wrote:
> This makes it possible to probe the X1205 RTC from the
> device tree. This is needed when adding device tree boot
> support for the IXP4xx-based NSLU2 which has this RTC.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/rtc/rtc-x1205.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
