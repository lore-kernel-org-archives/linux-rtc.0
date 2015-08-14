Return-Path: <rtc-linux+bncBD66BCOYSQBBBQHJWWXAKGQEX6R3NNA@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id g7si100679igr.0.2015.08.13.21.55.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Aug 2015 21:55:28 -0700 (PDT)
Message-ID: <55CD74AF.4020803@ti.com>
Date: Fri, 14 Aug 2015 10:25:11 +0530
From: Keerthy <a0393675@ti.com>
MIME-Version: 1.0
To: Paul Walmsley <paul@pwsan.com>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Keerthy <j-keerthy@ti.com>
CC: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>,
        <galak@codeaurora.org>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>
Subject: [rtc-linux] Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-3-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com> <55CB99C2.7010007@ti.com> <20150812201636.GJ3411@piout.net> <alpine.DEB.2.02.1508131822510.1009@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.02.1508131822510.1009@utopia.booyaka.com>
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



On Friday 14 August 2015 01:47 AM, Paul Walmsley wrote:
> Hi guys
>
> On Wed, 12 Aug 2015, Alexandre Belloni wrote:
>
>> On 13/08/2015 at 00:38:50 +0530, Keerthy wrote :
>>> The intent here is to switch to a higher precision clock which is the
>>> internal clock when available.
>>>
>>> Alexandre,
>>>
>>> Is dynamic switching preferred over sticking  to external clock always if
>>> present?
>>
>> I'd say that I don't really care. I'd say the best would be to make a
>> decision based on clock-accuracy but maybe that is an information you
>> don't have yet. Anyway, this could be added at a later date.
>
> Either the clock mux logic is glitchless, in which case the RTC is likely
> to lose at least 31 microseconds per switch; or it's not glitchless, in
> which case it's unsafe to switch the RTC clock source while the clock
> isn't gated.  Keerthy, before submitting this patch for merging, I'd
> suggest consulting your hardware folks to figure out which case it is.

Paul,

Thanks. Yes so i am doing the static way first. Keeping external clock 
always if available. Switching dynamically can be done later with more 
clarifications.

Thanks,
Keerthy

>
>
> - Paul
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
