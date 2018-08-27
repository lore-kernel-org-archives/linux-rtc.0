Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:52437 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeH1Asx (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 27 Aug 2018 20:48:53 -0400
Date: Mon, 27 Aug 2018 23:00:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, od@zcrc.me,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20180827210035.GF24549@piout.net>
References: <20180820180716.1853-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820180716.1853-1-paul@crapouillou.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 20/08/2018 20:07:16+0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
