Return-Path: <rtc-linux+bncBDS7HNEFSALRBLW7USVAKGQEA5FQNEI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k2si36195wif.0.2015.05.05.14.01.33
        for <rtc-linux@googlegroups.com>;
        Tue, 05 May 2015 14:01:33 -0700 (PDT)
Date: Tue, 5 May 2015 23:01:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>,
	Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomasz Figa <tfiga@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
	srv_heupstream@mediatek.com, Samuel Ortiz <sameo@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [rtc-linux] [PATCH v3 2/3] rtc: mediatek: Add MT6397 RTC driver
Message-ID: <20150505210131.GR4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
 <20150505200010.GP4276@piout.net>
 <1430858661.9365.20.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430858661.9365.20.camel@perches.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 05/05/2015 at 13:44:21 -0700, Joe Perches wrote :
> I suggest moving the time_after() test into the loop,
> use break; and remove the exit label too.
> 
> Maybe something like:
> 
> 	while (1) {
> 		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> 				  &data);
> 		if (ret < 0)
> 			break;
> 		if (!(data & RTC_BBPU_CBUSY))
> 			break;
> 		if (time_after(jiffies, timeout)) {
> 			ret = -ETIMEDOUT;
> 			break;
> 		}
> 		cpu_relax();
> 	}
> 
> 	return ret;

That certainly looks more readable.

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
