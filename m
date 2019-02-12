Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B37C282C4
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F410222C2
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfBLXKV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:10:21 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:50471 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfBLXKV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Feb 2019 18:10:21 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6CB50100006;
        Tue, 12 Feb 2019 23:10:19 +0000 (UTC)
Date:   Wed, 13 Feb 2019 00:10:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v3 2/4] rtc: isl1208: Support more chip variations
Message-ID: <20190212231019.GD10129@piout.net>
References: <20190212023225.2710-1-tpiepho@impinj.com>
 <20190212023225.2710-2-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212023225.2710-2-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 12/02/2019 02:34:04+0000, Trent Piepho wrote:
> Add more support in the driver for dealing with differences in is1208
> compatible chips.  Put the 1208, 1209, 1218, and 1219 in the list and
> encode information about nvram size, tamper, and timestamp features.
> 
> This adds support for the isl1209, which has a tamper detect but no
> timestamp feature.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 77 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 55 insertions(+), 22 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
