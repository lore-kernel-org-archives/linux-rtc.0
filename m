Return-Path: <rtc-linux+bncBCJP7WOE5UIBBSG3RGZQKGQEKAH5CXA@googlegroups.com>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com. [2607:f8b0:4002:c07::22b])
        by gmr-mx.google.com with ESMTPS id m7si1396389ywe.1.2015.12.04.20.53.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 20:53:28 -0800 (PST)
Received: by mail-yk0-x22b.google.com with SMTP id s79so146139790ykf.1
        for <rtc-linux@googlegroups.com>; Fri, 04 Dec 2015 20:53:28 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAD=FV=Ur0+qmQ1mnvV3Er1RjfMU8DY7yk9PPf04wAJ7Xrt+7vw@mail.gmail.com>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
	<CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
	<CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
	<CAODwPW939ZrmGsspk42BU=U+hca4hyT4W0ceOZCVWtu057i58A@mail.gmail.com>
	<CAD=FV=Ur0+qmQ1mnvV3Er1RjfMU8DY7yk9PPf04wAJ7Xrt+7vw@mail.gmail.com>
Date: Fri, 4 Dec 2015 20:53:27 -0800
Message-ID: <CAD=FV=X_1yUONf53AXGBZps=3VFnGFDq5u2-57SoBGtvBFiWHg@mail.gmail.com>
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

Hi,

On Fri, Dec 4, 2015 at 8:02 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Fri, Dec 4, 2015 at 5:54 PM, Julius Werner <jwerner@chromium.org> wrote:
>>> How would such a hook work?  If userspace sees the system suspend on
>>> Nov 30th and sees the system wake up on Dec 1st, how does it know
>>> whether it should adjust?  If it's truly Dec 1st then the kernel will
>>> have adjusted the date from Nov 31st to Dec 1st.  If it's truly Dec
>>> 2nd then the kernel will not have adjusted the date and the RTC will
>>> have ticked past Nov 31 and onto Dec 1st.  Userspace can't tell.
>>> Userspace could try to parse "dmesg" and look to see if the kernel
>>> adjusted, but that's ugly.
>>
>> Good point, I didn't think that through far enough. I guess parsing
>> dmesg would be an option, but a pretty ugly one and it wouldn't be
>> guaranteed to work if you got an early boot kernel crash after the
>> correction. So, really, it seems like there's no reliable way to fix
>> this for S5 (unless we start doing crazy things like writing to disk
>> from kernel code).
>
> Hmmm, this made me think.  We _do_ have some storage we could use,
> depending on how hacky^H^H^H^H^H^H clever we wanted to be.  We've got
> the alarm registers in the RTC.  If we set the alarm to something but
> then turn the alarm off then we can use that to store information that
> will persist in S5 (as long as the RTC is ticking).  What do you
> think?  I'd have to think of a scheme, but we could certainly use
> alarms that are several years in the future (or the past) as a
> sentinel, then use the day/month of the last time the kernel saw the
> time....

Actually, it wouldn't even be that terribly hacky  Whenever the alarm
isn't in use then set it to the next Nov 31st.  At boot time, if the
alarm is set to Nov 31st and the current date is >= the alarm time
then you adjust.  At shutdown time always disable the alarm (and set
to Nov 31st).  To handle resume time you might as well just keep the
state somewhere in RAM (see below for why).

Whenever you set the alarm for real then presumably you'll need to
adjust for Nov 31st and presumably you'll wake up and deal with the
alarm, then turn it off.  So if you set the alarm for July 4th then
(presumably) you'll wake up way before Nov 31st.  If you set the alarm
for Dec 25th and it's currently Oct 31st then you'll have to adjust in
the alarm code and you'll really set it for Dec 24th.  As per above,
we're in S3 (presumably) or have some persistent kernel state so we
know to adjust everything when we wake up (even if we wake up for a
non-alarm reason).

You'll still get a failure if you set the alarm and then forcibly go
into S5 without software knowledge, then stay in S5 long enough to
cross over Nov 31st without seeing it (but somehow keep the RTC
state).  ...but come on, that seems so incredibly rare!  :-P


Of course, all this hinges on being able to tell whether we've got the
bug or not so we know whether to adjust.  Assuming that there is no ID
register, we could get someone from Rockchip to agree to change
_something_ in a way that it's visible to us if they ever fix the
bug...


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
