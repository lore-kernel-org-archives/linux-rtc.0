Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:39915 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeGLSo2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 12 Jul 2018 14:44:28 -0400
Date: Thu, 12 Jul 2018 20:33:42 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/4] rtc: omap: fixes and clean ups
Message-ID: <20180712183342.GH16084@piout.net>
References: <20180704090558.16647-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 04/07/2018 11:05:54+0200, Johan Hovold wrote:
> Here are a couple of fixes for issues discovered through inspection
> along with some clean ups.
> 
> Johan
> 
> 
> Johan Hovold (4):
>   rtc: omap: fix potential crash on power off
>   rtc: omap: fix resource leak in registration error path
>   rtc: omap: add missing register lock in error path
>   rtc: omap: drop unnecessary register unlock around reads
> 
>  drivers/rtc/rtc-omap.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 

All applied, thanks

> -- 
> 2.18.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
