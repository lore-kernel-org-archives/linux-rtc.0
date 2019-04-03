Return-Path: <SRS0=SXQY=SF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7858FC10F06
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5043C2133D
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 21:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDCVAu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:00:50 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59751 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCVAt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Apr 2019 17:00:49 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E01C424000C;
        Wed,  3 Apr 2019 21:00:46 +0000 (UTC)
Date:   Wed, 3 Apr 2019 23:00:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] rtc: don't reference bogus function pointer in kdoc
Message-ID: <20190403210046.GU22216@piout.net>
References: <20190403151952.8415-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403151952.8415-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 03/04/2019 17:19:52+0200, Wolfram Sang wrote:
> The mentioned function pointer is long gone since early 2011. Remove the
> reference in the comment and reword it slightly.
> 
> Fixes: 51ba60c5bb3b ("RTC: Cleanup rtc_class_ops->update_irq_enable()")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> I stumbled over this when trying to understand UIE handling during my
> DA9063 debugging session.
> 
>  drivers/rtc/interface.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
