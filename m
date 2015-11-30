Return-Path: <rtc-linux+bncBAABBYPR52ZAKGQEU7TC22A@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.151])
        by gmr-mx.google.com with ESMTPS id 204si703720wmx.1.2015.11.29.18.48.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2015 18:48:01 -0800 (PST)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Enrico Scholz
	<enrico.scholz@sigma-chemnitz.de>, "Opensource [Steve Twiss]"
	<stwiss.opensource@diasemi.com>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "Alessandro
 Zummo" <a.zummo@towertech.it>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data
 to rtc
Date: Mon, 30 Nov 2015 02:47:59 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70173D273EF@SW-EX-MBX02.diasemi.com>
References: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20151127150158.GC4268@piout.net>
 <ly1tbbea3m.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <20151127155729.GB22136@piout.net>
In-Reply-To: <20151127155729.GB22136@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27 November 2015 15:57 Alexandre Belloni wrote:

> To: Enrico Scholz; Opensource [Steve Twiss]
> Cc: rtc-linux@googlegroups.com; Alessandro Zummo; Support Opensource
> Subject: Re: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data
> to rtc
> 
> On 27/11/2015 at 16:27:25 +0100, Enrico Scholz wrote :
> > > Unfortunately, the datasheets are behind a register wall and I can't
> > > check. Is there any meaningful bits mixed in the date/time registers?
> >
> > We can set "RTC_EN and CRYSTAL writing disabled" (COUNT_Y[6]) randomly;
> > this bit has a different meaning for read ("RTC clock okay") and write
> > ("disable writing"; not clearable).
> >
> > ALARM_MO[4] "Period of the Tick (0: every second, 1: every minute)" or
> > ALARM_Y[7+6] (enable tick/alarm) should not be set randomly either.
> >
> > I think, it is always a bad idea to write random data from stack to a
> > device.
> 
> I agree.
> 
> > > I think this was intended to keep those bits to their previous value but
> > > this is not yet implemented.
> >
> > Datasheet does not say how to deal with "reserved" bits; but it would be
> > imo overkill to apply a regmap_update_bits() like access to the RTC
> > registers.
> >
> 
> It depends on how much you care about those bits across reboots.
> 
> I'll take your patch anyway, unless Steve has another opinion on that.
> 

 I'll take a look at this later today.

Regards,
Steve

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
