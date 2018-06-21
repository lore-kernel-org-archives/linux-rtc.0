Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59773 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbeFUR7l (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 21 Jun 2018 13:59:41 -0400
Date: Thu, 21 Jun 2018 19:59:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jon Nettleton <jon@solid-run.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] rtc: armada38x: drop redundant initialization
Message-ID: <20180621175939.GL7737@piout.net>
References: <00ffe926e6878724d8289dd0e289a1f16df55ef7.1529602823.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00ffe926e6878724d8289dd0e289a1f16df55ef7.1529602823.git.baruch@tkos.co.il>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 21/06/2018 20:40:22+0300, Baruch Siach wrote:
> The 'ret' variable in these functions is set unconditionally below.
> 

Hum, what is the actual benefit of this patch?

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/rtc-armada38x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 1e4978c96ffd..4d62a54fd5d6 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -229,7 +229,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> -	int ret = 0;
> +	int ret;
>  	unsigned long time, flags;
>  
>  	ret = rtc_tm_to_time(tm, &time);
> @@ -272,7 +272,7 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	u32 reg = ALARM_REG(RTC_ALARM1, rtc->data->alarm);
>  	u32 reg_irq = ALARM_REG(RTC_IRQ1_CONF, rtc->data->alarm);
>  	unsigned long time, flags;
> -	int ret = 0;
> +	int ret;
>  
>  	ret = rtc_tm_to_time(&alrm->time, &time);
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
