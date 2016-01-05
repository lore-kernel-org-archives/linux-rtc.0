Return-Path: <rtc-linux+bncBDS7HNEFSALRBAUPVS2AKGQEFNJH4UI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f18si28804wme.1.2016.01.04.16.00.01
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Jan 2016 16:00:02 -0800 (PST)
Date: Tue, 5 Jan 2016 01:00:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: rtc-palmas: correct for bcd year
Message-ID: <20160105000000.GE32724@piout.net>
References: <1451508726-31769-1-git-send-email-salyzyn@android.com>
 <20160104161853.GC32724@piout.net>
 <568AA1C2.2070407@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <568AA1C2.2070407@android.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/01/2016 at 08:45:54 -0800, Mark Salyzyn wrote :
> On 01/04/2016 08:18 AM, Alexandre Belloni wrote:
> >Hi,
> >
> >On 30/12/2015 at 12:51:45 -0800, Mark Salyzyn wrote :
> >>Replace bcd2bin and bin2bcd with one that maps years 1970 to 2129
> >>in a pattern that works with the underlying hardware.
> >>
> >>The only transition that does not work correctly for this rtc clock
> >>is the transition from 2099 to 2100, it proceeds to 2000. The rtc
> >>clock retains and transitions the year correctly in all other
> >>circumstances.
> >>
> >If that transition doesn't work, it is not useful to try to support
> >dates after 2099. Also, I'm concerned about the leap year handling in
> >the other case. What is done right now is probably the best however, I
> >couldn't find the datasheet to confirm.
> >
> 
> As it stands today, if I set the date to 1970, it returns 2066, so this is a
> leap(sic) forward for this one rtc clock.
> 

I don't think we should care about dates in the past. However, it is
probably useful to return -EINVAL when trying to set a date outside of
its range.

> The advantages of supporting 2099+ for being able to set those years and not
> return garbage like in the 1970 case. The failure to roll over from
> 2099-2100 is but a millisecond of failure for an additional 1/3 of century
> of well being, and support code is minor, albeit flawed. Without these
> additional four lines, if something sets the year to 2100, they will get a
> garbage back in return, a small price to pay IMHO.
> 

If it doesn't go properly from 2099 to 2100 then userspace has no way of
knowing that this happened. Also, what happens between the 28th of
February the first of March when setting 0xA0? My guess is that you
actually have two month of failure.


> There are dozens and dozens of other bcd-based rtc clocks that could gain
> from this example (and may not have this issue with 2099 rollover), so maybe
> this year code should be in the library?

All the ones I know about will fail in 2100. Either because they will not
rollover to 2100 or because they will think 2100 is a leap year.

> 
> I will remove 2099+ support if you continue to consider this rollover issue
> egregious given my rationalization.
> 

I'd say that the proper course of action is to refuse to set dates
before 2000 and after 2100. See
http://patchwork.ozlabs.org/patch/541037/


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
