Return-Path: <SRS0=UFsi=ZH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374EEC432C3
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Nov 2019 11:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A192072B
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Nov 2019 11:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKOLA6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:00:58 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33705 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLA6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Nov 2019 06:00:58 -0500
X-Originating-IP: 90.66.177.178
Received: from localhost (lfbn-1-2888-178.w90-66.abo.wanadoo.fr [90.66.177.178])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0F7181BF213;
        Fri, 15 Nov 2019 11:00:56 +0000 (UTC)
Date:   Fri, 15 Nov 2019 12:00:56 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        val.krutov@erd.epson.com
Subject: Re: [PATCH] rtc: rx6110: Remove useless rx6110_remove
Message-ID: <20191115110056.GN3572@piout.net>
References: <20191108002113.14791-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108002113.14791-1-iwamatsu@nigauri.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 08/11/2019 09:21:13+0900, Nobuhiro Iwamatsu wrote:
> rx6110_remove is empty, remove it.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/rtc/rtc-rx6110.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
