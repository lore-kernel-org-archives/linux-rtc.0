Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:40532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732143AbeG0Quo (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 27 Jul 2018 12:50:44 -0400
Date: Fri, 27 Jul 2018 17:28:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sh: remove unused variable rtc_dev
Message-ID: <20180727152818.GE7701@piout.net>
References: <20180727151015.3930-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180727151015.3930-1-anders.roxell@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 27/07/2018 17:10:15+0200, Anders Roxell wrote:
> When building rtc-sh, rtc_dev isn't used in function __sh_rtc_periodic.
> drivers/rtc/rtc-sh.c: In function ‘__sh_rtc_periodic’:
> drivers/rtc/rtc-sh.c:146:21: warning: unused variable ‘rtc_dev’ [-Wunused-variable]
>   struct rtc_device *rtc_dev = rtc->rtc_dev;
>                      ^~~~~~~
> Remove the declaration of rtc_dev to dispose the warning.
> 
> Fixes: ec623ff014c4 ("rtc: sh: remove dead code")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/rtc/rtc-sh.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thanks.

It is weird that kbuild didn't complain about it though.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
