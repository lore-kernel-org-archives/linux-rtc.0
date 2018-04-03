Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50697 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeDCO6f (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 3 Apr 2018 10:58:35 -0400
Date: Tue, 3 Apr 2018 16:58:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: isl12022: use true and false for boolean values
Message-ID: <20180403145821.GC6444@piout.net>
References: <20180322195328.GA25733@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322195328.GA25733@embeddedgus>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 22/03/2018 14:53:28-0500, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-isl12022.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
