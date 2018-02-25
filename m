Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:58872 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeBYULw (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 25 Feb 2018 15:11:52 -0500
Date: Sun, 25 Feb 2018 21:11:51 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: m41t80: move m41t80_rtc_mutex to the block where it
 is used
Message-ID: <20180225201151.GD19904@piout.net>
References: <20180209180534.28925-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180209180534.28925-1-bigeasy@linutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 09/02/2018 at 19:05:34 +0100, Sebastian Andrzej Siewior wrote:
> Without CONFIG_RTC_DRV_M41T80_WDT the compiler complains:
> 
> |drivers/rtc/rtc-m41t80.c:76 ‘m41t80_rtc_mutex’ defined but not used [-Wunused-variable]
> 
> Move the variable to the block where it is used.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/rtc/rtc-m41t80.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
