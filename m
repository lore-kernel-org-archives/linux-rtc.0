Return-Path: <SRS0=ELV/=O6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FF1C43387
	for <linux-rtc@archiver.kernel.org>; Fri, 21 Dec 2018 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B0921906
	for <linux-rtc@archiver.kernel.org>; Fri, 21 Dec 2018 09:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeLUJXr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:23:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54406 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLUJXr (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 21 Dec 2018 04:23:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A9AFF20763; Fri, 21 Dec 2018 10:23:44 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7A57A20747;
        Fri, 21 Dec 2018 10:23:44 +0100 (CET)
Date:   Fri, 21 Dec 2018 10:23:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: Implement RTC_VL_READ,CLR ioctls
Message-ID: <20181221092344.GK2188@piout.net>
References: <20181207174053.10669-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207174053.10669-1-marex@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 07/12/2018 18:40:53+0100, Marek Vasut wrote:
> Implement standard ioctls for polling the battery status and clearing
> the battery low indication from userspace.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-abx80x.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
