Return-Path: <rtc-linux+bncBD66BCOYSQBBBZN3S6XQKGQE5VYBG5I@googlegroups.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com. [192.94.94.40])
        by gmr-mx.google.com with ESMTPS id d20si114781igo.3.2015.09.01.10.18.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 10:18:28 -0700 (PDT)
Message-ID: <55E5DDD8.6060400@ti.com>
Date: Tue, 1 Sep 2015 22:48:16 +0530
From: Keerthy <a0393675@ti.com>
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
CC: Keerthy <j-keerthy@ti.com>, <bcousson@baylibre.com>, <johan@kernel.org>,
        <linux-omap@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <grygorii.strashko@ti.com>
Subject: [rtc-linux] Re: [PATCH v5 0/3] ARM: AM437X: Add rtc clock handling
References: <1439890876-19024-1-git-send-email-j-keerthy@ti.com> <20150821211812.GI3769@piout.net> <55DDEE88.3020407@ti.com> <20150826180126.GS4215@atomide.com> <20150826215350.GS13155@piout.net> <20150901152740.GH4215@atomide.com>
In-Reply-To: <20150901152740.GH4215@atomide.com>
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



On Tuesday 01 September 2015 08:57 PM, Tony Lindgren wrote:
> * Alexandre Belloni <alexandre.belloni@free-electrons.com> [150826 14:57]:
>> On 26/08/2015 at 11:01:27 -0700, Tony Lindgren wrote :
>>> * Keerthy <a0393675@ti.com> [150826 09:54]:
>>>> Tony,
>>>>
>>>> On Saturday 22 August 2015 02:48 AM, Alexandre Belloni wrote:
>>>>> Tony,
>>>>>
>>>>> On 18/08/2015 at 15:11:13 +0530, Keerthy wrote :
>>>>>> The series is applicable for all am437x series of processors.
>>>>>> It adds clock handling support. Boot tested on am437x-gp-evm.
>>>>>>
>>>>>> Keerthy (3):
>>>>>>    ARM: dts: AM437x: Add the internal and external clock nodes for rtc
>>>>>>    rtc: omap: Add internal clock enabling support
>>>>>>    rtc: omap: Add external clock enabling support
>>>>>>
>>>>>
>>>>> I'm wondering how you want to get those patches merged. I can let you
>>>>> take 2 and 3 through arm-soc but you will miss 4.3. Or I can take 2 and
>>>>> 3 for 4.3 but the documentation will be missing.
>>>>
>>>> A gentle ping on this series.
>>>
>>> Alexandre, it's probably best that you take them all. The dts changes
>>> apply against Linux next with fuzz so there should not be any merge
>>> conflict. Feel free to add:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>
>> So, I've rebased 1/3 on rtc-next to avoid depending on arm-soc. I've
>> pushed everything and hopefully there won't be any issues in linux-next.
>> We are quite close to the merge window so I would be much more confident
>> sending them to Linus if you could test linux-next once the patches land
>> there.
>
> Keerthy, I presume you have now tested these with Linux next?

Yes. When i had posted v5. I tested them.

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
