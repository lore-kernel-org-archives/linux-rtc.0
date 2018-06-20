Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:48876 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeFTKqX (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 20 Jun 2018 06:46:23 -0400
Date: Wed, 20 Jun 2018 12:46:12 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-bq4802: add error handling for devm_ioremap
Message-ID: <20180620104612.GC7737@piout.net>
References: <1528778404-41456-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528778404-41456-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 12/06/2018 12:40:03+0800, Zhouyang Jia wrote:
> When devm_ioremap fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling devm_ioremap.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/rtc/rtc-bq4802.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
