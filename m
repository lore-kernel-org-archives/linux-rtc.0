Return-Path: <rtc-linux+bncBDS7HNEFSALRBEF2SOVAKGQE3GCZPGY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si78933wia.1.2015.05.02.07.20.00
        for <rtc-linux@googlegroups.com>;
        Sat, 02 May 2015 07:20:00 -0700 (PDT)
Date: Sat, 2 May 2015 16:19:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Donggeun Kim <dg77.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: a.zummo@towertech.it, ben-linux@fluff.org, rtc-linux@googlegroups.com,
	myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [rtc-linux] Re: rtc: rtc-s3c: Set year, month, day value for setting alarm
Message-ID: <20150502141957.GM12076@piout.net>
References: <1307694592-20949-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1307694592-20949-1-git-send-email-dg77.kim@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 10/06/2011 at 17:29:52 +0900, Donggeun Kim wrote :
> This patch sets year, month, day value for set_alarm function.
> The current driver omits to set the values.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.kim@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>

This patch never made it to the mainlined but seems useful enough. Do
you want to respin it?

> ---
>  drivers/rtc/rtc-s3c.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 16512ec..18e648b 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -251,6 +251,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	struct rtc_time *tm = &alrm->time;
>  	void __iomem *base = s3c_rtc_base;
>  	unsigned int alrm_en;
> +	int year = tm->tm_year - 100;
>  
>  	pr_debug("s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
>  		 alrm->enabled,
> @@ -276,6 +277,21 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		writeb(bin2bcd(tm->tm_hour), base + S3C2410_ALMHOUR);
>  	}
>  
> +	if (year < 100 && year >= 0) {
> +		alrm_en |= S3C2410_RTCALM_YEAREN;
> +		writeb(bin2bcd(year), base + S3C2410_ALMYEAR);
> +	}
> +
> +	if (tm->tm_mon < 12 && tm->tm_mon >= 0) {
> +		alrm_en |= S3C2410_RTCALM_MONEN;
> +		writeb(bin2bcd(tm->tm_mon + 1), base + S3C2410_ALMMON);
> +	}
> +
> +	if (tm->tm_mday <= 31 && tm->tm_mday >= 1) {
> +		alrm_en |= S3C2410_RTCALM_DAYEN;
> +		writeb(bin2bcd(tm->tm_mday), base + S3C2410_ALMDATE);
> +	}
> +
>  	pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
>  
>  	writeb(alrm_en, base + S3C2410_RTCALM);

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
