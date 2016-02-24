Return-Path: <rtc-linux+bncBDS7HNEFSALRB5G3XC3AKGQEQXJQ5EA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si11217wmd.0.2016.02.24.14.25.56
        for <rtc-linux@googlegroups.com>;
        Wed, 24 Feb 2016 14:25:56 -0800 (PST)
Date: Wed, 24 Feb 2016 23:25:55 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Henderson <joshua.henderson@microchip.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: rtc-pic32: Add PIC32 real time
 clock driver
Message-ID: <20160224222555.GA12073@piout.net>
References: <1455905390-3491-2-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455905390-3491-2-git-send-email-joshua.henderson@microchip.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 19/02/2016 at 11:09:45 -0700, Joshua Henderson wrote :
> +static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
> +{
> +	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
> +	void __iomem *base = pdata->reg_base;
> +	unsigned int tries = 0;
> +
> +	clk_enable(pdata->clk);
> +
> +	do {
> +		rtc_tm->tm_hour = readb(base + PIC32_RTCHOUR);
> +		rtc_tm->tm_min = readb(base + PIC32_RTCMIN);
> +		rtc_tm->tm_mon  = readb(base + PIC32_RTCMON);
> +		rtc_tm->tm_mday = readb(base + PIC32_RTCDAY);
> +		rtc_tm->tm_year = readb(base + PIC32_RTCYEAR);
> +		rtc_tm->tm_sec  = readb(base + PIC32_RTCSEC);
> +
> +		/*
> +		 * The only way to work out whether the system was mid-update
> +		 * when we read it is to check the second counter, and if it
> +		 * is zero, then we re-try the entire read.
> +		 */
> +		tries = 1;
> +	} while (rtc_tm->tm_sec == 0 && tries < 2);
> +

This doesn't seem right. It will wait up to a second as tries will
always be less than 2, this is probably not what you want.

> +	rtc_tm->tm_sec = bcd2bin(rtc_tm->tm_sec);
> +	rtc_tm->tm_min = bcd2bin(rtc_tm->tm_min);
> +	rtc_tm->tm_hour = bcd2bin(rtc_tm->tm_hour);
> +	rtc_tm->tm_mday = bcd2bin(rtc_tm->tm_mday);
> +	rtc_tm->tm_mon = bcd2bin(rtc_tm->tm_mon) - 1;
> +	rtc_tm->tm_year = bcd2bin(rtc_tm->tm_year);
> +
> +	rtc_tm->tm_year += 100;
> +
> +	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
> +		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
> +		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
> +
> +	clk_disable(pdata->clk);
> +	return rtc_valid_tm(rtc_tm);
> +}
> +

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
