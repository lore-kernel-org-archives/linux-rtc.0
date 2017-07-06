Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35332 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdGFUiM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 16:38:12 -0400
Date: Thu, 6 Jul 2017 22:38:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] rtc: ds1307: fix compile warning if
 RTC_DRV_DS1307_CENTURY isn't defined
Message-ID: <20170706203810.3qmnld6ptpta42rr@piout.net>
References: <022ecfbf-c999-b76e-f8cf-1d02fb20237e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <022ecfbf-c999-b76e-f8cf-1d02fb20237e@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/07/2017 at 22:03:12 +0200, Heiner Kallweit wrote:
> Fix the following warning if RTC_DRV_DS1307_CENTURY isn't defined.
> 
> drivers/rtc/rtc-ds1307.c: In function 'ds1307_get_time':
> drivers/rtc/rtc-ds1307.c:342:26: warning: unused variable 'chip' [-Wunused-variable]
>   const struct chip_desc *chip = &chips[ds1307->type];
>                           ^
> Fixes: 436c93db60a4 ("rtc: ds1307: factor out century bit handling")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

I've squashed it in the original commit, thanks.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
