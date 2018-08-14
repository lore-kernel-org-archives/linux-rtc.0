Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36941 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNMOZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 14 Aug 2018 08:14:25 -0400
Date: Tue, 14 Aug 2018 11:27:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, t-kristo@ti.com,
        linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan@kernel.org
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180814092755.GB30344@localhost>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
 <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
 <20180725093018.GA3539@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725093018.GA3539@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jul 25, 2018 at 11:30:18AM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 25/07/2018 11:21:22+0530, Keerthy wrote:
> > Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> > over try again.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>

> >  static void omap_rtc_power_off(void)
> > @@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
> >  	struct rtc_time tm;
> >  	unsigned long now;
> >  	u32 val;
> > +	int seconds;
> >  
> >  	rtc->type->unlock(rtc);
> >  	/* enable pmic_power_en control */
> >  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
> >  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
> >  
> > -	/* set alarm two seconds from now */
> > +again:
> > +	/* set alarm one second from now */
> >  	omap_rtc_read_time_raw(rtc, &tm);
> > +	seconds = tm.tm_sec;
> >  	bcd2tm(&tm);
> >  	rtc_tm_to_time(&tm, &now);
> > -	rtc_time_to_tm(now + 2, &tm);
> > +	rtc_time_to_tm(now + 1, &tm);
> >  
> >  	if (tm2bcd(&tm) < 0) {
> >  		dev_err(&rtc->rtc->dev, "power off failed\n");
> > @@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
> >  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> >  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> >  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> > +
> > +	/*
> > +	 * first check if ALARM2 has fired, if not then check if
> > +	 * our calculations started right before the rollover, try again
> > +	 * in case of rollover
> > +	 */
> > +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
> > +						 OMAP_RTC_STATUS_REG)) &&
> > +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> > +		goto again;
> > +
> 
> Can you use a while loop instead of goto?

I think a goto is warranted here as it allows for more readable code
with less indentation. And the exception case it is used for is truly an
exception that a single retry would take care of.

Johan
