Return-Path: <SRS0=zPJc=NX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01679C43441
	for <linux-rtc@archiver.kernel.org>; Mon, 12 Nov 2018 22:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C345A2241E
	for <linux-rtc@archiver.kernel.org>; Mon, 12 Nov 2018 22:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C345A2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeKMINs (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:13:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58698 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbeKMINs (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 13 Nov 2018 03:13:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 906D5208CB; Mon, 12 Nov 2018 23:18:39 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6676920379;
        Mon, 12 Nov 2018 23:18:29 +0100 (CET)
Date:   Mon, 12 Nov 2018 23:18:29 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: sh: convert to SPDX identifiers
Message-ID: <20181112221829.GM29768@piout.net>
References: <87a7mkyt55.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7mkyt55.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 08/11/2018 06:43:22+0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> As original license mentioned, it is GPL-2.0 in SPDX.
> Then, MODULE_LICENSE() should be "GPL v2" instead of "GPL".
> See ${LINUX}/include/linux/module.h
> 
> 	"GPL"		[GNU Public License v2 or later]
> 	"GPL v2"	[GNU Public License v2]
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/rtc/rtc-sh.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
