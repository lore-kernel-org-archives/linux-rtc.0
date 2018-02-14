Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39416 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVbY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Feb 2018 16:31:24 -0500
Date: Wed, 14 Feb 2018 22:31:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: p.bruenn@beckhoff.com, linux-rtc@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] rtc: mxc_v2: Fix _iomem pointer notation
Message-ID: <20180214213123.GF8219@piout.net>
References: <1518403126-28456-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518403126-28456-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 12/02/2018 at 00:38:46 -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Fix the iomem pointer notation in order to fix the following sparse
> warnings:
> 
> drivers/rtc/rtc-mxc_v2.c:280:18: warning: incorrect type in argument 1 (different address spaces)
> drivers/rtc/rtc-mxc_v2.c:280:18:    expected void const volatile [noderef] <asn:2>*addr
> drivers/rtc/rtc-mxc_v2.c:280:18:    got void *[noderef] <asn:2>ioaddr
> drivers/rtc/rtc-mxc_v2.c:329:44: warning: incorrect type in argument 1 (different address spaces)
> drivers/rtc/rtc-mxc_v2.c:329:44:    expected void *[noderef] <asn:2>ioaddr
> drivers/rtc/rtc-mxc_v2.c:329:44:    got void [noderef] <asn:2>*
> drivers/rtc/rtc-mxc_v2.c:339:44: warning: incorrect type in argument 1 (different address spaces)
> drivers/rtc/rtc-mxc_v2.c:339:44:    expected void *[noderef] <asn:2>ioaddr
> drivers/rtc/rtc-mxc_v2.c:339:44:    got void [noderef] <asn:2>*
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/rtc/rtc-mxc_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
