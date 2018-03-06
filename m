Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:48317 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeCFUU2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 6 Mar 2018 15:20:28 -0500
Date: Tue, 6 Mar 2018 21:20:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 1/4] rtc: isl1208: enable interrupt after context
 preparation
Message-ID: <20180306202026.GG3035@piout.net>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
 <1520246373-19023-2-git-send-email-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520246373-19023-2-git-send-email-Denis.Osterland@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/03/2018 at 10:43:53 +0000, Denis OSTERLAND wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> The interrupt handler got enabled very early. If the interrupt cause is
> triggering immediately before the context is fully prepared. This can
> lead to undefined behaviour. Therefor we move the interrupt enable code
> to the end of the probe function.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
