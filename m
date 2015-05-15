Return-Path: <rtc-linux+bncBCKMZDW5VIHBBV6226VAKGQEOQLJBWQ@googlegroups.com>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id ax9si182574igc.1.2015.05.15.05.57.59
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 05:57:59 -0700 (PDT)
Message-ID: <5555ED4F.5070003@roeck-us.net>
Date: Fri, 15 May 2015 05:57:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>,
 LINUXKERNEL <linux-kernel@vger.kernel.org>,
 LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
 Wim Van Sebroeck <wim@iguana.be>
CC: Alessandro Zummo <a.zummo@towertech.it>,
 DEVICETREE <devicetree@vger.kernel.org>,
 David Dajun Chen <david.chen@diasemi.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 LINUXINPUT <linux-input@vger.kernel.org>,
 Lee Jones <lee.jones@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>,
 Rob Herring <robh+dt@kernel.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
References: <cover.1431621833.git.stwiss.opensource@diasemi.com> <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com> <55555639.8090505@roeck-us.net> <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
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

Hi Steve,

On 05/15/2015 01:13 AM, Opensource [Steve Twiss] wrote:
> Hi Guenter,
>
> Thank you for your comments again,
> Here are my responses.
>
> Regards,
> Steve
>
> On 15 May 2015 03:13, Guenter Roeck
>> Subject: Re: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
>>
>
> [...]
>

[ ... ]

>>> +
>>> +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
>>> +	if (irq < 0) {
>>> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
>>> +		ret = irq;
>>> +		goto error;
>>
>> Just return; the label does not serve a useful purpose. Same for the other
>> goto statements below.
>
> Agreed. This is changed now.
>
>> Also, is the interrupt mandatory ? All it does is to display a message.
>> Looks very optional to me.
>
> It is a place holder for something more application specific.
> I could remove it, but I figured it would just get re-added when somebody takes the
> driver and modifies it for their needs.
>
> If this is a problem however, it can go.
> Please advise ..
>

Then this someone should add the code. For the time being, it just increases
kernel size and may cause the driver to fail for no good reason. Plus, given
the driver apparently works without interrupt, even then it should be optional,
and the driver does not have to fail loading if it is not supported on a
given platform.

Thanks,
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
