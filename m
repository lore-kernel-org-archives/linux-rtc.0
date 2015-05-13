Return-Path: <rtc-linux+bncBCKMZDW5VIHBB6EXZWVAKGQEANGO3UQ@googlegroups.com>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id qr9si478914igb.0.2015.05.13.06.04.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 06:04:56 -0700 (PDT)
Message-ID: <55534BEF.7020409@roeck-us.net>
Date: Wed, 13 May 2015 06:04:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
 LINUXKERNEL <linux-kernel@vger.kernel.org>,
 RTCLINUX <rtc-linux@googlegroups.com>,
 DEVICETREE <devicetree@vger.kernel.org>,
 David Dajun Chen <david.chen@diasemi.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 LINUXINPUT <linux-input@vger.kernel.org>,
 LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
 Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Support Opensource <Support.Opensource@diasemi.com>,
 Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
References: <cover.1429280614.git.stwiss.opensource@diasemi.com> <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com> <20150510095838.GF3338@piout.net> <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com> <20150513125858.GX3338@piout.net>
In-Reply-To: <20150513125858.GX3338@piout.net>
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

On 05/13/2015 05:58 AM, Alexandre Belloni wrote:
> Hi,
>
> On 13/05/2015 at 12:31:36 +0000, Opensource [Steve Twiss] wrote :
>> Something similar is being discussed for the OnKey component of the DA9062.
>> https://lkml.org/lkml/2015/4/24/304
>>
>> It is only the OnKey and RTC components that are similar to the DA9063 chip
>> and I was hoping to keep the 62 RTC separate in this case ... however it should
>> definitely be possible to re-use the DA9063 RTC driver if this is your requirement.
>> If this will block my submission of the DA9062 then I will drop the RTC from my
>> next patch set and try to re-work the existing 63 RTC driver accordingly.
>>
>> I think this sort of thing has been done before:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-pm8xxx.c
>>   ... at first glance -- it seems to support that sort of thing.
>>
>
> Isn't that exactly the point of using the MFD infrastructure? It allows
> to reuse existing drivers even when the IP is part of a different chip.
> The RTC inside the da9062 and the da9063 are obviously the same so there
> is no point in duplicating the driver.
>
> I'm guessing using da9063-rtc instead of da9062-rtc is just working
> fine.
>
>> I guess it would be possible to rename the da9063-rtc to something more sensible like
>> da9xxx-rtc.c if this goes ahead?
>>
>
> Sure, that can be done but this means that the module name will change.
> if you feel that your current users can cope with that, I'm fine with it.
>
Don't know how this is handled for rtc drivers, but in other subsystems
we just live with the original name. I don't see a need to rename a driver
just because it starts supporting more hardware, and xxx is weird anyway
since it suggests everything from 000 to 999, which is much worse than
just sticking with 9063.

Guenter

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
