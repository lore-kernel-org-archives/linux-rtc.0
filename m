Return-Path: <rtc-linux+bncBAABB7VXQPBAKGQE5ZNJNJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0057.outbound.protection.outlook.com. [104.47.2.57])
        by gmr-mx.google.com with ESMTPS id c68si127553ith.1.2016.12.01.18.27.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 18:27:09 -0800 (PST)
From: Meng Yi <meng.yi@nxp.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] RE: [RFC PATCH] rtc/nxp: add FTM alarm driver as the
 wakeup source
Date: Fri, 2 Dec 2016 02:27:06 +0000
Message-ID: <DB6PR0401MB26316D0BABB3652FB008D931EC8E0@DB6PR0401MB2631.eurprd04.prod.outlook.com>
References: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
 <DB6PR0401MB263163BD3E6AF420934DC6FAECA00@DB6PR0401MB2631.eurprd04.prod.outlook.com>
 <20161201003222.ih3lxuyfv7xyaget@piout.net>
In-Reply-To: <20161201003222.ih3lxuyfv7xyaget@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

> > > +
> > > +static int nxp_ftm_rtc_read_time(struct device *dev, struct
> > > +rtc_time
> > > +*tm) {
> > > +	struct timeval time;
> > > +	unsigned long local_time;
> > > +
> > > +	do_gettimeofday(&time);
> > > +	local_time = (u32)(time.tv_sec - (sys_tz.tz_minuteswest * 60));
> > > +	rtc_time_to_tm(local_time, tm);
> > > +
> > > +	return 0;
> > > +}
> > > +
> >
> > This is not really getting time from the RTC since FTM is not a RTC
> > device, But we need to get the time to setup alarm, so we are using system
> time for now.
> > Anybody have better idea?
> >
> 
> No, that seems fine to me. I'll review the rest of the driver.

Thanks for your review, any feedback is welcomed!

> 
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Meng

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
