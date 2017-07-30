Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60187 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3Ola (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 30 Jul 2017 10:41:30 -0400
Date: Sun, 30 Jul 2017 16:41:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, robh@kernel.org
Subject: Re: [PATCH 3/3] rtc: sun6i: Remove unneeded initalization of ret in
 sun6i_rtc_setalarm()
Message-ID: <20170730144128.2lvg6vxohsbmxw63@piout.net>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
 <1499857190-30849-3-git-send-email-alexey.klimov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499857190-30849-3-git-send-email-alexey.klimov@arm.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 12/07/2017 at 11:59:50 +0100, Alexey Klimov wrote:
> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 77bc4d3..1886b85 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -362,7 +362,7 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
>  	unsigned long time_now = 0;
>  	unsigned long time_set = 0;
>  	unsigned long time_gap = 0;
> -	int ret = 0;
> +	int ret;
>  

I don't see any reason that would justify that change.

>  	ret = sun6i_rtc_gettime(dev, &tm_now);
>  	if (ret < 0) {
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
