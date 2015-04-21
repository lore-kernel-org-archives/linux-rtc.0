Return-Path: <rtc-linux+bncBDS7HNEFSALRBD533OUQKGQEAP5LW5Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g5si216597wix.1.2015.04.21.16.30.23
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Apr 2015 16:30:23 -0700 (PDT)
Date: Wed, 22 Apr 2015 01:30:22 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	kernel@pengutronix.de, Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org,
	Robert Schwebel <rsc@pengutronix.de>
Subject: Re: [rtc-linux] [PATCH 4/5] RTC/i.MX/DryIce: when locked, do not fail silently
Message-ID: <20150421233022.GE8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <1429002716-19821-5-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1429002716-19821-5-git-send-email-jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Please always include a commit message.

On 14/04/2015 at 11:11:55 +0200, Juergen Borleis wrote :
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
> [rsc: got NDA clearance from Freescale]
> ---
>  drivers/rtc/rtc-imxdi.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> index b04c64f..de1a2e4 100644
> --- a/drivers/rtc/rtc-imxdi.c
> +++ b/drivers/rtc/rtc-imxdi.c
> @@ -581,14 +581,36 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int dryice_rtc_set_mmss(struct device *dev, unsigned long secs)
>  {
>  	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
> +	u32 dcr, dsr;
>  	int rc;
>  
> +	dcr = __raw_readl(imxdi->ioaddr + DCR);
> +	dsr = __raw_readl(imxdi->ioaddr + DSR);
> +
> +	if (!(dcr & DCR_TCE) || (dsr & DSR_SVF)) {
> +		if (dcr & DCR_TCHL) {
> +			/* we are even more out of luck */
> +			di_what_is_to_be_done(imxdi, "battery");
> +			return -EPERM;
> +		}
> +		if ((dcr & DCR_TCSL) || (dsr & DSR_SVF)) {
> +			/* we are out of luck for now */
> +			di_what_is_to_be_done(imxdi, "main");
> +			return -EPERM;
> +		}
> +	}
> +
>  	/* zero the fractional part first */
>  	rc = di_write_wait(imxdi, 0, DTCLR);
> -	if (rc == 0)
> -		rc = di_write_wait(imxdi, secs, DTCMR);
> +	if (rc != 0)
> +		return rc;
>  
> -	return rc;
> +	rc = di_write_wait(imxdi, secs, DTCMR);
> +	if (rc != 0)
> +		return rc;
> +
> +	return di_write_wait(imxdi, __raw_readl(imxdi->ioaddr + DCR) |
> +								DCR_TCE, DCR);
>  }
>  
>  static int dryice_rtc_alarm_irq_enable(struct device *dev,
> -- 
> 2.1.4
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
