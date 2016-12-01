Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBF677XAQKGQELASZEBQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id s81si1016368wmf.3.2016.11.30.16.32.23
        for <rtc-linux@googlegroups.com>;
        Wed, 30 Nov 2016 16:32:23 -0800 (PST)
Date: Thu, 1 Dec 2016 01:32:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Meng Yi <meng.yi@nxp.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [RFC PATCH] rtc/nxp: add FTM alarm driver as the
 wakeup source
Message-ID: <20161201003222.ih3lxuyfv7xyaget@piout.net>
References: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
 <DB6PR0401MB263163BD3E6AF420934DC6FAECA00@DB6PR0401MB2631.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <DB6PR0401MB263163BD3E6AF420934DC6FAECA00@DB6PR0401MB2631.eurprd04.prod.outlook.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/11/2016 at 08:23:32 +0000, Meng Yi wrote :
> > +
> > +static int ftm_alarm_irq_enable(struct device *dev, unsigned int
> > +enabled) {
> > +	if (enabled)
> > +		ftm_irq_enable(true);
> > +	else
> > +		ftm_irq_enable(false);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nxp_ftm_rtc_read_time(struct device *dev, struct rtc_time
> > +*tm) {
> > +	struct timeval time;
> > +	unsigned long local_time;
> > +
> > +	do_gettimeofday(&time);
> > +	local_time = (u32)(time.tv_sec - (sys_tz.tz_minuteswest * 60));
> > +	rtc_time_to_tm(local_time, tm);
> > +
> > +	return 0;
> > +}
> > +
> 
> This is not really getting time from the RTC since FTM is not a RTC device,
> But we need to get the time to setup alarm, so we are using system time for now.
> Anybody have better idea?
> 

No, that seems fine to me. I'll review the rest of the driver.


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
