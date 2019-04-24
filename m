Return-Path: <SRS0=SQ63=S2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD3C10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1272320878
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 10:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfDXKSV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:18:21 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34489 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDXKSV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 24 Apr 2019 06:18:21 -0400
Received: from localhost (alyon-652-1-29-238.w109-213.abo.wanadoo.fr [109.213.12.238])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 021DD240003;
        Wed, 24 Apr 2019 10:18:18 +0000 (UTC)
Date:   Wed, 24 Apr 2019 12:18:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        javier@dowhile0.org
Subject: Re: [PATCH] spi: Epson RX-6610: declare missing of table
Message-ID: <20190424101818.GA14604@piout.net>
References: <1555960132-8569-1-git-send-email-dagmcr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555960132-8569-1-git-send-email-dagmcr@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 22/04/2019 21:08:52+0200, Daniel Gomez wrote:
> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
> 
> Before this patch:
> modinfo drivers/rtc/rtc-rx6110.ko | grep alias
> alias:          spi:rx6110
> 
> After this patch:
> modinfo drivers/rtc/rtc-rx6110.ko | grep alias
> alias:          spi:rx6110
> alias:          of:N*T*Cepson,rx6110C*
> alias:          of:N*T*Cepson,rx6110
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/rtc/rtc-rx6110.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Applied after adjusting the subject, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
