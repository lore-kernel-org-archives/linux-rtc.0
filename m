Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45754 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbdLFI6h (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Dec 2017 03:58:37 -0500
Date: Wed, 6 Dec 2017 09:58:25 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel-dev@beckhoff.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        Patrick Bruenn <p.bruenn@beckhoff.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Juergen Borleis <jbe@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
Message-ID: <20171206085825.GM21780@piout.net>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
 <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 06/12/2017 at 09:36:18 +0100, Sascha Hauer wrote:
> > +/*
> > + * This function updates the RTC alarm registers and then clears all the
> > + * interrupt status bits.
> > + * The caller should hold the pdata->lock
> > + *
> > + * @param  alrm         the new alarm value to be updated in the RTC
> > + *
> > + * @return  0 if successful; non-zero otherwise.
> > + */
> > +static int mxc_rtc_write_alarm_locked(struct mxc_rtc_data *const pdata,
> > +				      struct rtc_time *alarm_tm)
> > +{
> > +	void __iomem *const ioaddr = pdata->ioaddr;
> > +	unsigned long time;
> > +
> > +	rtc_tm_to_time(alarm_tm, &time);
> > +
> > +	if (time > U32_MAX) {
> > +		pr_err("Hopefully I am out of service by then :-(\n");
> > +		return -EINVAL;
> > +	}
> 
> This will never happen as on your target hardware unsigned long is a
> 32bit type. Not sure what is best to do here. Maybe you should test
> the return value of rtc_tm_to_time. ATM it returns 0 unconditionally,
> but rtc_tm_to_time could detect when the input time doesn't fit into
> its return type and return an error in this case.
> Also I just realized that it's unsigned and only overflows in the year
> 2106. I'm most likely dead then so I don't care that much ;)
> 

One solution is to use the 64bit version instead so it doesn't overflow.
This makes the time > U32_MAX work.
Also, I'll send (hopefully soon) a series adding proper range checking
for the whole RTC subsystem. And yes, it not urgent as I don't think I
will care so much in 2106 too ;)

> > +/*
> > + * This function reads the current RTC time into tm in Gregorian date.
> > + *
> > + * @param  tm           contains the RTC time value upon return
> > + *
> > + * @return  0 if successful; non-zero otherwise.
> > + */
> > +static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> > +	time_t now;
> > +	int ret = mxc_rtc_lock(pdata);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	now = readl(pdata->ioaddr + SRTC_LPSCMR);
> > +	rtc_time_to_tm(now, tm);
> > +	ret = rtc_valid_tm(tm);

This check is useless for two reasons: you know that rtc_time_to_tm will
generate a valid tm and the core always checks the tm anyway.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
