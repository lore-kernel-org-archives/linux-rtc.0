Return-Path: <SRS0=NhHM=5H=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9AFC1975A
	for <linux-rtc@archiver.kernel.org>; Sun, 22 Mar 2020 21:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A751206F9
	for <linux-rtc@archiver.kernel.org>; Sun, 22 Mar 2020 21:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCVVQg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:16:36 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55657 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCVVQg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 22 Mar 2020 17:16:36 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BF9F720003;
        Sun, 22 Mar 2020 21:16:34 +0000 (UTC)
Date:   Sun, 22 Mar 2020 22:16:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: omap: drop unused dt-bindings header
Message-ID: <20200322211634.GG221863@piout.net>
References: <20200321203737.29850-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200321203737.29850-1-uwe@kleine-koenig.org>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 21/03/2020 21:37:37+0100, Uwe Kleine-König wrote:
> The definitons in the dt-binding's gpio header only contains some
> constants to be used in device trees. It is not relevant for rtc-omap
> (as the gpio API hides the details) and in fact unused so it can just be
> dropped.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  drivers/rtc/rtc-omap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
