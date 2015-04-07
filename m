Return-Path: <rtc-linux+bncBAABBEMER2UQKGQEWC2DCKA@googlegroups.com>
Received: from compulab.co.il (softlayer.compulab.co.il. [50.23.254.55])
        by gmr-mx.google.com with ESMTPS id d4si611809igl.1.2015.04.07.00.06.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Apr 2015 00:06:56 -0700 (PDT)
Message-ID: <5523820C.2010709@compulab.co.il>
Date: Tue, 07 Apr 2015 10:06:52 +0300
From: Igor Grinberg <grinberg@compulab.co.il>
MIME-Version: 1.0
To: Keerthy <a0393675@ti.com>, Andrew Morton <akpm@linux-foundation.org>,
 rtc-linux@googlegroups.com
CC: Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com> <20150324155916.cfd1b7ab442271466160283f@linux-foundation.org> <55234F25.5060708@ti.com>
In-Reply-To: <55234F25.5060708@ti.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 04/07/15 06:29, Keerthy wrote:
> Hi Andrew,
> 
> Apologies for replying late.
> 
> On Wednesday 25 March 2015 04:29 AM, Andrew Morton wrote:
>> On Tue, 3 Mar 2015 15:12:02 +0530 Keerthy <j-keerthy@ti.com> wrote:
>>
>>> Add external 32k clock feature. The internal clock will be gated during suspend.
>>> Hence make use of the external 32k clock so that rtc is functional accross
>>> suspend/resume.
>>>
>>> ...
>>>
>>> @@ -446,6 +449,7 @@ static const struct omap_rtc_device_type omap_rtc_default_type = {
>>>
>>>   static const struct omap_rtc_device_type omap_rtc_am3352_type = {
>>>       .has_32kclk_en    = true,
>>> +    .has_osc_ext_32k = true,
>>>       .has_kicker    = true,
>>>       .has_irqwakeen    = true,
>>>       .has_pmic_mode    = true,
>>> @@ -543,7 +547,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>>>       if (rtc->type->has_32kclk_en) {
>>>           reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
>>>           rtc_writel(rtc, OMAP_RTC_OSC_REG,
>>> -                reg | OMAP_RTC_OSC_32KCLK_EN);
>>> +               reg | OMAP_RTC_OSC_32KCLK_EN);
>>> +    }
>>> +
>>> +    /* Enable External clock as the source */
>>> +
>>> +    if (rtc->type->has_osc_ext_32k) {
>>> +        rtc_writel(rtc, OMAP_RTC_OSC_REG,
>>> +               (OMAP_RTC_OSC_EXT_32K |
>>> +               rtc_read(rtc, OMAP_RTC_OSC_REG)) &
>>> +               (~OMAP_RTC_OSC_OSC32K_GZ));
>>>       }
>>
>> How do we know that all systems have this external clock and that it
>> works OK?
>>
> 
> AM335 and AM43X have the external clock feature which we choose using
> RTC_OSC_REG. I verified it works OK by seeing the RTC seconds ticking
> even after switching the source to the external 32k Clock.

AFAIU, this is related to the external (outside of SoC) oscillator, right?
If so, there is a possibility to not assemble it on the board (at least
on AM335) and use the internal clock source instead.
There are dozens of boards out there that do not have the external
oscillator assembled.

Am I missing something?

-- 
Regards,
Igor.

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
