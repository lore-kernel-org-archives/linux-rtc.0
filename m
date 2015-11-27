Return-Path: <rtc-linux+bncBDS7HNEFSALRB2X24GZAKGQEPBJXFSA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g21si298392wmd.3.2015.11.27.07.57.30
        for <rtc-linux@googlegroups.com>;
        Fri, 27 Nov 2015 07:57:30 -0800 (PST)
Date: Fri, 27 Nov 2015 16:57:29 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
	Steve Twiss <stwiss.opensource@diasemi.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Support Opensource <support.opensource@diasemi.com>
Subject: Re: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data
 to rtc
Message-ID: <20151127155729.GB22136@piout.net>
References: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20151127150158.GC4268@piout.net>
 <ly1tbbea3m.fsf@ensc-virt.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <ly1tbbea3m.fsf@ensc-virt.intern.sigma-chemnitz.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27/11/2015 at 16:27:25 +0100, Enrico Scholz wrote :
> > Unfortunately, the datasheets are behind a register wall and I can't
> > check. Is there any meaningful bits mixed in the date/time registers?
> 
> We can set "RTC_EN and CRYSTAL writing disabled" (COUNT_Y[6]) randomly;
> this bit has a different meaning for read ("RTC clock okay") and write
> ("disable writing"; not clearable).
> 
> ALARM_MO[4] "Period of the Tick (0: every second, 1: every minute)" or
> ALARM_Y[7+6] (enable tick/alarm) should not be set randomly either.
> 
> 
> I think, it is always a bad idea to write random data from stack to a
> device.
> 

I agree.

> 
> > I think this was intended to keep those bits to their previous value but
> > this is not yet implemented.
> 
> Datasheet does not say how to deal with "reserved" bits; but it would be
> imo overkill to apply a regmap_update_bits() like access to the RTC
> registers.
> 

It depends on how much you care about those bits across reboots.

I'll take your patch anyway, unless Steve has another opinion on that.


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
