Return-Path: <rtc-linux+bncBDT2ZUWD7IKRBV7QSOZQKGQEEUREKSA@googlegroups.com>
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.137])
        by gmr-mx.google.com with ESMTPS id pe1si2961797pac.2.2015.12.06.19.09.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 06 Dec 2015 19:09:11 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
To: Doug Anderson <dianders@chromium.org>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
 <CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
 <CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
 <CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
 <CAODwPW939ZrmGsspk42BU=U+hca4hyT4W0ceOZCVWtu057i58A@mail.gmail.com>
 <CAD=FV=Ur0+qmQ1mnvV3Er1RjfMU8DY7yk9PPf04wAJ7Xrt+7vw@mail.gmail.com>
 <CAD=FV=X_1yUONf53AXGBZps=3VFnGFDq5u2-57SoBGtvBFiWHg@mail.gmail.com>
 <CAODwPW-UAVRHVwsA=ZBgL=ZRrW0+WJSmPDcF5jv=bwnePsTe5w@mail.gmail.com>
 <CAD=FV=USMU1eQ8-kA0ysyciXzU-EW6Zy-xZnmtEHsC39xOYrZw@mail.gmail.com>
 <5664E1CF.8030406@rock-chips.com>
 <CAD=FV=V6x94vFCcCwRa=YH+NFCRKCGkNVyE8NTAnXVxX9Bac2Q@mail.gmail.com>
 <CAD=FV=VJKHK2Eu75UJPf+3i7Gaxa09g+Hwfy7nwWYrgMvocarg@mail.gmail.com>
Cc: Julius Werner <jwerner@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alessandro Zummo <a.zummo@towertech.it>, Sonny Rao <sonnyrao@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rtc-linux@googlegroups.com
From: Chris Zhong <zyw@rock-chips.com>
Message-ID: <5664F837.607@rock-chips.com>
Date: Mon, 7 Dec 2015 11:08:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VJKHK2Eu75UJPf+3i7Gaxa09g+Hwfy7nwWYrgMvocarg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



On 12/07/2015 10:52 AM, Doug Anderson wrote:
> Hi,
>
> On Sun, Dec 6, 2015 at 6:50 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Chris,
>>
>> On Sun, Dec 6, 2015 at 5:33 PM, Chris Zhong <zyw@rock-chips.com> wrote:
>>> Hi Doug
>>>
>>> RK808 has a shadowed register for saving a "frozen" RTC time.
>>> When we setting "GET_TIME" to 1, the time will save in this shadowed
>>> register. So if we do not set the "GET_TIME", we always get the last time.
>>>
>>> read the old time before "get_time", and then read the time again for new
>>> time. If the old time earlier than 12.1 && new time later than 12.1, we
>>> should
>>> +1 day for the correct rtc time.
>>>
>>> On the other hand, we should set the "GET_TIME" after rk808_rtc_set_time,
>>> for restore the time before suspend/shut_down.
>> Ah, good idea using the shadow registers.  The whole point of the
>> shadow registers is to enable atomic read of time, right?  So if the
>> clock ticks as you are reading 23:59:59 you don't end up reading
>> 23:59:00 or 24:59:59 (you'll get either 23:59:59 or 24:00:00).  So
>> right, time read will now be:
>>
>> 1. Read GET_TIME.  Confirm it's 1.
>> 2. Read the time.
>> 3. Set GET_TIME to 0.
>> 4. Set GET_TIME to 1.
>> 5. Read the time.
>>
>> If time from #2 < 11/31 and time from #5 >= 11/31 then we do the
>> adjust.  If GET_TIME wasn't 1 in step #1 then we won't do any
>> adjusting unless the time is actually 11/31.
>>
>> Between steps #4 and #5 we'll need to add a small delay since old code
>> used to use the setting to 0 as a delay (as commented).
>>
>> We should presumably always leave GET_TIME as 1 unless we're actively
>> reading the time for the most reliability.  Also, if we've already
>> read the time this bootup, we can certainly optimize the above by
>> skipping #1 and #2.
GET_TIME: Rising transition of this register transfers dynamic registers 
into
static shadowed registers.
So only the rising of GET_TIME would update the "static shadowed registers".
We only need ensure that the rising occurs on condition that we want to the
really time.
> Oh, but also we still need to know whether to adjust the alarm.  I
> think you said that all existing rk808 chips have this bug and that
> you'll set a bit (to be determined later) if/when this bug is fixed.
> So we still need to assume that all rk808 chips have this bug...
I think so, all rk808 chips have this bug. And we can read the version 
register
to differentiate the PMICs, once this bug is fixed.
>
> -Doug
>
>
>


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
