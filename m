Return-Path: <rtc-linux+bncBDS7HNEFSALRBTGCUSVAKGQEPCNTH7Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si162257wiz.0.2015.05.05.13.00.11
        for <rtc-linux@googlegroups.com>;
        Tue, 05 May 2015 13:00:11 -0700 (PDT)
Date: Tue, 5 May 2015 22:00:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomasz Figa <tfiga@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
	srv_heupstream@mediatek.com, Samuel Ortiz <sameo@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [rtc-linux] [PATCH v3 2/3] rtc: mediatek: Add MT6397 RTC driver
Message-ID: <20150505200010.GP4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
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

This looks mostly good. Could you align the wrapped function parameters
to the open parenthesis (use checkpatch --strict)?

On 28/04/2015 at 15:35:55 +0800, Eddie Huang wrote :
> +static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> +{
> +	unsigned long timeout = jiffies + HZ;
> +	int ret;
> +	u32 data;
> +
> +	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	do {
> +		cpu_relax();
> +		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> +				&data);
> +		if (ret < 0)
> +			goto exit;
> +	} while ((data & RTC_BBPU_CBUSY) && time_after(timeout, jiffies));
> +

Shouldn't you return -ETIMEDOUT if the loop breaks because of time_after?

Thanks,

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
