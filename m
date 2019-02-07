Return-Path: <SRS0=rvV4=QO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A641C282C2
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Feb 2019 20:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145A20663
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Feb 2019 20:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBGUhd (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:37:33 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59803 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBGUhd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 7 Feb 2019 15:37:33 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B458020003;
        Thu,  7 Feb 2019 20:37:31 +0000 (UTC)
Date:   Thu, 7 Feb 2019 21:37:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/5] rtc: ds1307: Move register definitions to start of
 file
Message-ID: <20190207203731.GH4719@piout.net>
References: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 25/01/2019 15:35:54+0100, Uwe Kleine-König wrote:
> This allows to use the register offsets in all functions
> which is needed in one of the next patches.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/rtc/rtc-ds1307.c | 52 ++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
