Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29950 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdKHHIK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 02:08:10 -0500
Subject: Re: [PATCH] rtc: omap: Support scratch registers
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux OMAP List <linux-omap@vger.kernel.org>
References: <20171031162731.27019-1-alexandre.belloni@free-electrons.com>
 <600fd106-9f79-0f5a-a2fd-e6b067785c17@ti.com>
 <4741d4c7-d6f7-ecdb-1eed-1293175f38d9@ti.com>
 <9a383f74-e049-885b-4705-93968f4c75d4@ti.com>
 <20171108062738.cml7qaek324rvc4e@piout.net>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <775d3cfc-95ca-1dff-d146-64efbdd71e1f@ti.com>
Date: Wed, 8 Nov 2017 12:38:05 +0530
MIME-Version: 1.0
In-Reply-To: <20171108062738.cml7qaek324rvc4e@piout.net>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On Wednesday 08 November 2017 11:57 AM, Alexandre Belloni wrote:
> Hi,
> 
> On 08/11/2017 at 11:30:45 +0530, Keerthy wrote:
>>>>> +static int omap_rtc_scratch_read(void *priv, unsigned int offset, void *_val,
>>>>> +				 size_t bytes)
>>>>> +{
>>>>> +	struct omap_rtc	*rtc = priv;
>>>>> +	u32 *val = _val;
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < bytes / 4; i++)
>>>>> +		val[i] = rtc_readl(rtc,
>>>>> +				   OMAP_RTC_SCRATCH0_REG + offset + (i * 4));
>>
>> Can the offset be the Scratch register number instead of bytes offset?
>> More intuitive to me.
>>
>> So that one can request using offset as 0, 1, 2 instead of 0, 4, 8?
>>
> 
> Well, the offset is coming from the nvmem core, itself getting it from
> the Linux file API (and it is in bytes). However, you have the guarantee
> that it will be aligned on a word, see:
> http://elixir.free-electrons.com/linux/latest/source/drivers/nvmem/core.c#L88

Okay Alexandre. Thanks for clarifying. Looks good to me.
I have tested on AM437X-GP-EVM.

Regards,
Keerthy

> 
>> The above can be:
>> rtc_readl(rtc, OMAP_RTC_SCRATCH0_REG + (offset + i) * 4), val[i]);
>>
>>
> 
