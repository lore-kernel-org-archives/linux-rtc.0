Return-Path: <rtc-linux+bncBCJP7WOE5UIBBUPNRCZQKGQEXF33YLI@googlegroups.com>
Received: from mail-qg0-x22e.google.com (mail-qg0-x22e.google.com. [2607:f8b0:400d:c04::22e])
        by gmr-mx.google.com with ESMTPS id m7si1346366ywe.1.2015.12.04.16.58.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 16:58:57 -0800 (PST)
Received: by mail-qg0-x22e.google.com with SMTP id c40so102629454qge.2
        for <rtc-linux@googlegroups.com>; Fri, 04 Dec 2015 16:58:57 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
	<CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
Date: Fri, 4 Dec 2015 16:58:57 -0800
Message-ID: <CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Doug Anderson <dianders@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Julius,

On Fri, Dec 4, 2015 at 4:25 PM, Julius Werner <jwerner@chromium.org> wrote:
>> If a device is in S3 for the whole day that the glitch occurs and then
>> we wake up then we'll end up thinking it's Dec 1st instead of Dec 2nd,
>> right?  That case _could_ be handled by knowing that the last time we
>> read the clock it was before 12/1 and that this time it is after
>> 11/30.  Then we add the extra day.  In order to do this, we'd have to
>> know that we're on hardware with the glitch, which I guess could
>> either be done with a device tree property or by spending 1 second
>> probing the device at bootup (that would be a bit of a pain...).
>>
>> Obviously the trick above wouldn't handle if the clock ticked when the
>> device was in S5, but I'd imagine that most systems treat the RTC as
>> slightly questionable on an initial bootup anyway (though I'd imagine
>> that they rely on it working across S3).
>
> True, we could do that. I don't think it makes much sense to
> differentiate between S3 and S5 like that, though... the problem can
> happen just the same after both, and I don't think there's a practical
> difference in how systems treat that (if userspace has ways to
> double-check the system time, such as syncing to a network time
> source, it should really be doing that after both resume and reboot).
> Of course, building a work-around like that for S5 will become more
> complicated and requires persistent storage.

Right, the need for persistent storage is what makes S5 hard...


> For Chromium OS, we're already planning to improve tlsdated such that
> I don't think this will be an issue anymore (making it schedule a
> resync after resume, not just after reboot, which is a probably a good
> idea in general). For other systems that don't have any kind of
> network time sync, I think the best solution would be to handle this
> completely with a small userspace hook on boot and resume (because you
> probably need to access the file system to keep track of the last seen
> time anyway, you can do the device identification through
> /proc/device-tree just as well, and this avoids putting too much hacky
> workaround logic into the kernel).

How would such a hook work?  If userspace sees the system suspend on
Nov 30th and sees the system wake up on Dec 1st, how does it know
whether it should adjust?  If it's truly Dec 1st then the kernel will
have adjusted the date from Nov 31st to Dec 1st.  If it's truly Dec
2nd then the kernel will not have adjusted the date and the RTC will
have ticked past Nov 31 and onto Dec 1st.  Userspace can't tell.
Userspace could try to parse "dmesg" and look to see if the kernel
adjusted, but that's ugly.  We could add a sysfs entry, but it seems
pretty hard to imagine that all Linux distros using rk808 will add
this type of hook...


> The other thing that would worry me about this approach is that it
> requires perfect identification of the problem, and Rockchip will
> hopefully eventually be able to fix this either in RK808 or a
> successor chip that might use the same RTC interface (and thus
> driver). Detecting it at boot is probably a bad idea because a
> crash/brownout at the wrong moment will permanently leave you with a
> bad time. I really think fixing this as best as we easily can and
> leaving the hard edge-cases to userspace is the best approach here.

Yes, you're right.  Detecting is a bit scary.

Chris: any chance there's an RK808 revision hiding somewhere in the
i2c register banks that we could rely on?

Adding a device tree hook doesn't seem insane, but you're right that
Rockchip could start producing new revisions of rk808 with this fixed
and all of sudden we'd be adjusting the wrong way.  ...so you're
probably right that this is a bad idea...


So I guess my #1 choice would be to find a revision somewhere in the
rk808 i2c register space.  If that's not there, then I guess you're
patch is probably better than trying to adjust and maybe being wrong
when newer rk808 revisions fix this...

-Doug

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
