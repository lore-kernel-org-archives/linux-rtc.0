Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBDFP2XAQKGQE3GTZH6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 85si111389wmb.3.2016.11.23.00.47.07
        for <rtc-linux@googlegroups.com>;
        Wed, 23 Nov 2016 00:47:07 -0800 (PST)
Date: Wed, 23 Nov 2016 09:46:57 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: rtc-twl: kill static variables
Message-ID: <20161123084657.or53k7tlyjxcmrr2@piout.net>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-2-git-send-email-Nicolae_Rosia@mentor.com>
 <20161122223103.qd44b3z5aj4ahroi@piout.net>
 <CAKP5S=0vLb+7az4aaFyPjGSEE5cG+epM2qpGP=zpzhvt6x69qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAKP5S=0vLb+7az4aaFyPjGSEE5cG+epM2qpGP=zpzhvt6x69qA@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/11/2016 at 10:39:12 +0200, Nicolae Rosia wrote :
> Hi,
> Thanks for the review.
> 
> On Wed, Nov 23, 2016 at 12:31 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Hi,
> >
> > A few alignments are off but I can fix that provided you answer the
> > question below:
> >
> Ok, could you please indicate which lines so I can fix them instead of
> wasting your time?
> 

checkpatch.pl --strict will find them for you

> > On 12/11/2016 at 12:07:24 +0200, Nicolae Rosia wrote :
> >>       /* for twl6030/32 make sure BIT_RTC_CTRL_REG_GET_TIME_M is clear */
> >> -     if (twl_class_is_6030()) {
> >> +     if (!twl_rtc->is_4030) {
> >
> > This changes the meaning of it. What if at some point there is a new
> > part that is neither a 4030 nor an 6030?
> > That will probably mean going over ths part of code again but maybe the
> > odds are low and nobody cares.
> Since there are only two classes, 4030 and 6030, it will work.
> But you're right, it's better to retain the old logic so the changes
> are minimal.
> 
> Will send V2 in a bit.

Thanks

> 
> Thanks,
> Nicolae

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
