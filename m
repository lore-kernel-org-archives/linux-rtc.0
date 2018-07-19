Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeGSNa1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Jul 2018 09:30:27 -0400
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
To: Johan Hovold <johan@kernel.org>
CC: <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <t-kristo@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
 <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
 <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
 <20180719123617.GV10204@localhost>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <e3841afa-fe18-84c0-e5b6-520365c5e4a1@ti.com>
Date: Thu, 19 Jul 2018 18:16:56 +0530
MIME-Version: 1.0
In-Reply-To: <20180719123617.GV10204@localhost>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On Thursday 19 July 2018 06:06 PM, Johan Hovold wrote:
> On Thu, Jul 19, 2018 at 05:52:17PM +0530, Keerthy wrote:
>> On Thursday 19 July 2018 05:23 PM, Keerthy wrote:
>>> On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
>>>> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
> 
>>>>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
>>>>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>>>>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>>>>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> 
>>>>> +	/* Our calculations started right before the rollover, try again */
> 
>>>>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>>>>> +		goto again;
>>>>
>>>> Here the alarm may have gone off as part of the roll over, in which case
>>>> you shouldn't retry.
>>>
>>> Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.
>>>
>>> In the event of Roll over before setting the
>>> OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
>>> not miss the ALARM2 event? Then poweroff would fail right?
> 
> Right, that would fail.
> 
>>> Hence the attempt to retry the next second. This sequence would begin
>>> right at the beginning of a new second and we expect the full sequence
>>> to get over without having to retry again.
>>>
>>> Hope i am clear.
> 
> Yes, sure, but my point is that could end up retrying also after the
> alarm has fired correctly (e.g. due to latencies in turning of the
> power)>
> It may be enough to check OMAP_RTC_STATUS_REG before retrying.

Ah okay. Yes this makes sense. I will use the status to retry.

> 
>> I tried to program the interrupt for the same second on the hardware and
>> it does not fire. So to take care of roll over corner case one attempt
>> to retry is needed.
> 
> Yes, that's expected.
> 
> Thanks,
> Johan
> 
