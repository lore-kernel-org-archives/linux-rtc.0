Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:34771 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeEUUfA (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 21 May 2018 16:35:00 -0400
Date: Mon, 21 May 2018 22:34:59 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] rtc: ds1742: don't explicitly specify word_size and
 stride of nvmem
Message-ID: <20180521203459.GC25500@piout.net>
References: <20180520152145.21177-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180520152145.21177-1-u.kleine-koenig@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/05/2018 17:21:45+0200, Uwe Kleine-König wrote:
> nvmem_register() assumes these values to be 1 if unset, so they don't
> need to be set explicitly.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/rtc/rtc-ds1742.c | 2 --
>  1 file changed, 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
