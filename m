Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:34787 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeEUUfP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 21 May 2018 16:35:15 -0400
Date: Mon, 21 May 2018 22:35:14 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] rtc: nvmem: don't use IS_ERR_OR_NULL
Message-ID: <20180521203514.GD25500@piout.net>
References: <20180520152640.21489-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180520152640.21489-1-u.kleine-koenig@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/05/2018 17:26:40+0200, Uwe Kleine-König wrote:
> nvmem_register() never returns NULL, so IS_ERR is good enough here.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Some people don't like IS_ERR_OR_NULL because it is a hint that an API
> is badly designed or it it used in a wrong way. In this case it's the
> latter. :-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
