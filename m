Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB3XO2XBQKGQEIAJ6NRQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d207si1148930wmd.1.2017.01.10.16.08.14
        for <rtc-linux@googlegroups.com>;
        Tue, 10 Jan 2017 16:08:14 -0800 (PST)
Date: Wed, 11 Jan 2017 01:08:03 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Russell King <linux@armlinux.org.uk>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [rtc-linux] Re: [PATCHv3 3/8] rtc: add STM32 RTC driver
Message-ID: <20170111000803.mlie6kizcsj2o7lh@piout.net>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Looks good to me, however...


On 05/01/2017 at 14:43:24 +0100, Amelie Delaunay wrote :
> +struct stm32_rtc {
> +	struct rtc_device *rtc_dev;
> +	void __iomem *base;
> +	struct clk *ck_rtc;
> +	spinlock_t lock; /* Protects registers accesses */

This spinlock seems to be useless, the rtc ops_lock is already
protecting everywhere it is taken.

> +	int irq_alarm;
> +};
> +

[...]

> +static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct stm32_rtc *rtc = dev_get_drvdata(dev);
> +	struct rtc_time *tm = &alrm->time;
> +	unsigned long irqflags;
> +	unsigned int cr, isr, alrmar;
> +	int ret = 0;
> +
> +	if (rtc_valid_tm(tm)) {
> +		dev_err(dev, "Alarm time not valid.\n");
> +		return -EINVAL;

This will never happen, tm is already checked multiple times (up to
three) in the core before this function can be called.

> +	}
> +

You don't need to resend the whole series, just this patch. I'll take
2/8 and 3/8, the other ones can go through the stm32 tree.

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
