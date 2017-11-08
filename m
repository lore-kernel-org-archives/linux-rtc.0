Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58635 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdKHDrT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 22:47:19 -0500
Date: Wed, 8 Nov 2017 04:47:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] rtc: pcf8563: fix output clock rate
Message-ID: <20171108034712.matghz4fyvpt6aa5@piout.net>
References: <20171107121217.31309-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107121217.31309-1-p.zabel@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/11/2017 at 13:12:17 +0100, Philipp Zabel wrote:
> The pcf8563_clkout_recalc_rate function erroneously ignores the
> frequency index read from the CLKO register and always returns
> 32768 Hz.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/rtc/rtc-pcf8563.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
