Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCGXRDDQKGQEYYBDZOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id a126si828182wmd.2.2017.04.03.04.01.27
        for <rtc-linux@googlegroups.com>;
        Mon, 03 Apr 2017 04:01:27 -0700 (PDT)
Date: Mon, 3 Apr 2017 13:01:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH]  driver: rtc: tps65910: Add parameter check
Message-ID: <20170403110127.asqdxbyny63bpr67@piout.net>
References: <1489575152-29931-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1489575152-29931-1-git-send-email-d.schultz@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 15/03/2017 at 11:52:32 +0100, Daniel Schultz wrote:
> If the tps65910 driver has no interrupt, the probe of tps65910-rtc will
> fail.
> 
> This patch adds a check in the probe of the rtc if an interrupt exist.
> The check is similar to the check in the function which creates the
> interrupt.
> 

Can you elaborate on what this is fixing? If the probe already fails I'm
not sure why your patch is also making it fail.

> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  drivers/rtc/rtc-tps65910.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
> index d0244d7..8c5ca11 100644
> --- a/drivers/rtc/rtc-tps65910.c
> +++ b/drivers/rtc/rtc-tps65910.c
> @@ -375,6 +375,11 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
>  
>  	tps65910 = dev_get_drvdata(pdev->dev.parent);
>  
> +	if (!tps65910->chip_irq) {
> +		dev_warn(&pdev->dev, "No interrupt support, not created\n");
> +		return -EINVAL;
> +	}
> +
>  	tps_rtc = devm_kzalloc(&pdev->dev, sizeof(struct tps65910_rtc),
>  			GFP_KERNEL);
>  	if (!tps_rtc)
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
