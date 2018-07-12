Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:40013 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbeGLSrJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 12 Jul 2018 14:47:09 -0400
Date: Thu, 12 Jul 2018 20:36:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jon Nettleton <jon@solid-run.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] rtc: armada38x: reset after rtc power loss
Message-ID: <20180712183622.GI16084@piout.net>
References: <00ffe926e6878724d8289dd0e289a1f16df55ef7.1529602823.git.baruch@tkos.co.il>
 <2a509f094a7ae584f657fb02791e5edea29ea149.1529602823.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2a509f094a7ae584f657fb02791e5edea29ea149.1529602823.git.baruch@tkos.co.il>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 21/06/2018 20:40:23+0300, Baruch Siach wrote:
> When the RTC block looses power it needs a reset sequence to make it
> usable again. Otherwise, writes to the time register have no effect.
> 
> This reset sequence combines information from the mvebu_rtc driver in
> the Marvell provided U-Boot, and the SolidRun provided U-Boot repo.
> 
> Tested on the Armada 388 based SolidRun Clearfog Base.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/rtc-armada38x.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
