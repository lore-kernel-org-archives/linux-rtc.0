Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36594 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdI0NZY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 09:25:24 -0400
Date: Wed, 27 Sep 2017 15:25:23 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rtc: sun6i: fix memory leak
Message-ID: <20170927132523.u6miojeax67idtsj@piout.net>
References: <1505652190-4942-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505652190-4942-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 17/09/2017 at 13:43:10 +0100, Sudip Mukherjee wrote:
> If 'clk_data' is not allocated we returned but we failed to free 'rtc'.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 3d2216c..5bc28ee 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -201,8 +201,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>  
>  	clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
>  			   GFP_KERNEL);
> -	if (!clk_data)
> +	if (!clk_data) {
> +		kfree(rtc);
>  		return;
> +	}

Please also fix the other occurrence of the issue in the same function.

>  
>  	spin_lock_init(&rtc->lock);
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
