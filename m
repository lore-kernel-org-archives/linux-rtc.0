Return-Path: <SRS0=4QPc=X4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45764C10F14
	for <linux-rtc@archiver.kernel.org>; Thu,  3 Oct 2019 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E938207FF
	for <linux-rtc@archiver.kernel.org>; Thu,  3 Oct 2019 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfJCTz7 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:55:59 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48405 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbfJCTz7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 3 Oct 2019 15:55:59 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 09B5740003;
        Thu,  3 Oct 2019 19:55:57 +0000 (UTC)
Date:   Thu, 3 Oct 2019 21:55:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: use timeu64_t for range_max
Message-ID: <20191003195557.GL575@piout.net>
References: <20190927110446.GA6289@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927110446.GA6289@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 27/09/2019 13:04:46+0200, Emmanuel Nicolet wrote:
> Hi,
> for rtc drivers where rtc->range_max is set U64_MAX, like the PS3 rtc,
> rtc_valid_range() always returns -ERANGE. This is because the local
> variable range_max has type time64_t, so the test
> 	if (time < range_min || time > range_max)
> 		return -ERANGE;
> becomes (time < range_min || time > -1), which always evaluates to true.
> timeu64_t should be used, since it's the type of rtc->range_max.
> 
> Signed-off-by: Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
> ---
>  drivers/rtc/interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
