Return-Path: <rtc-linux+bncBD2536XZRAKBBRFWZOXAKGQEUB2VVHQ@googlegroups.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com. [2a00:1450:4010:c03::22d])
        by gmr-mx.google.com with ESMTPS id qc10si587026lbb.1.2015.08.18.00.14.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2015 00:14:11 -0700 (PDT)
Received: by mail-la0-x22d.google.com with SMTP id i9so93096749lah.2
        for <rtc-linux@googlegroups.com>; Tue, 18 Aug 2015 00:14:11 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
Date: Tue, 18 Aug 2015 09:14:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: alexandre.belloni@free-electrons.com, tony@atomide.com,
	johan@kernel.org, linux-omap@vger.kernel.org,
	rtc-linux@googlegroups.com, grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH v3 3/3] rtc: omap: Add external clock enabling support
Message-ID: <20150818071410.GA8151@localhost>
References: <1439878724-5828-1-git-send-email-j-keerthy@ti.com>
 <1439878724-5828-4-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439878724-5828-4-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Aug 18, 2015 at 11:48:44AM +0530, Keerthy wrote:
> Configure the clock source to external clock if available.
> External clock is preferred as it can be ticking during suspend.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index f31c012..255f7b7 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
 
> @@ -555,11 +557,19 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (rtc->irq_alarm <= 0)
>  		return -ENOENT;
>  
> -	rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
> -
> -	if (!IS_ERR(rtc->clk))
> +	rtc->clk = devm_clk_get(&pdev->dev, "ext-clk");
> +	if (!IS_ERR(rtc->clk)) {
> +		rtc->has_ext_clk = true;
>  		clk_prepare_enable(rtc->clk);
> +	} else {
> +		rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
> +		if (IS_ERR(rtc->clk))
> +			goto no_clk;
> +	}
>
> +	clk_prepare_enable(rtc->clk);

Just always check for errors before enabling here, and get rid of the
double enable and goto above.

> +
> +no_clk:

Johan

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
