Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:34407 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbeHaNYb (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 31 Aug 2018 09:24:31 -0400
Date: Fri, 31 Aug 2018 11:17:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] rtc: mrst: remove set but not used variable 'valid'
Message-ID: <20180831091757.GN16561@piout.net>
References: <1535681739-156599-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535681739-156599-1-git-send-email-yuehaibing@huawei.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 31/08/2018 02:15:39+0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/rtc/rtc-mrst.c: In function 'mrst_procfs':
> drivers/rtc/rtc-mrst.c:264:29: warning:
>  variable 'valid' set but not used [-Wunused-but-set-variable]
>   unsigned char rtc_control, valid;
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/rtc/rtc-mrst.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
