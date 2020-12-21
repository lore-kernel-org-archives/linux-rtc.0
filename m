Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7772C433DB
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Dec 2020 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7246120DD4
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Dec 2020 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgLUVkg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:40:36 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:55515 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLUVkf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Dec 2020 16:40:35 -0500
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A652E100004;
        Mon, 21 Dec 2020 21:39:53 +0000 (UTC)
Date:   Mon, 21 Dec 2020 22:39:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: update bindings
Message-ID: <20201221213953.GA3990390@piout.net>
References: <20201219013418.3474461-1-alexandre.belloni@bootlin.com>
 <c5290432-a6b0-2b96-585f-3abc2dcc56f6@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5290432-a6b0-2b96-585f-3abc2dcc56f6@prevas.dk>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 21/12/2020 22:17:54+0100, Rasmus Villemoes wrote:
> On 19/12/2020 02.34, Alexandre Belloni wrote:
> > pcf2127, pcf2129 and pca2129 support start-year and reset-source.
> > 
> 
> No, the 2129 variant doesn't even have a reset output pin. Not sure if
> there's any way to reflect that, and it probably doesn't matter, since
> nobody's going to add the reset-source property to a 2129 node. But the
> commit message is a bit misleading.
> 

Ah sure, I forgot about that., the simplest way is then to not mov
pcf/pca2129 out of trivial


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
