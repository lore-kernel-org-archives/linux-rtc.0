Return-Path: <SRS0=Ax4F=PS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6747C43387
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Jan 2019 21:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78820663
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Jan 2019 21:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfAJV0j (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:26:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33900 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfAJV0j (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 10 Jan 2019 16:26:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 067A3207B6; Thu, 10 Jan 2019 22:26:37 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id CABD2206A6;
        Thu, 10 Jan 2019 22:26:26 +0100 (CET)
Date:   Thu, 10 Jan 2019 22:26:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: isl1208: fix negative digital trim reporting
Message-ID: <20190110212627.GD2362@piout.net>
References: <20190102160002.23670-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102160002.23670-1-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 02/01/2019 16:00:17+0000, Trent Piepho wrote:
> isl1208_i2c_get_dtr() was returning the dtr value directly, but could
> also return a negative error code.  Negative trimming values, e.g. -20,
> would get interpreted as an error code, e.g. -ENOTDIR.
> 
> This patch offsets the dtr value by 100 so it's positive and won't alias
> an error code.
> 
> Also fix check that considered a return value of -1 to be success.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
Applied, thanks.

It would be great if you could also implement .read_offset and
.set_offset instead of the custom dtrim attribute.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
