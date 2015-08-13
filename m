Return-Path: <rtc-linux+bncBDA2TOHIQEARBWXWWCXAKGQEPHLAP5A@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id j6si138477igx.0.2015.08.12.23.38.17
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 23:38:17 -0700 (PDT)
Message-ID: <55CC3B8E.2090802@ti.com>
Date: Thu, 13 Aug 2015 09:39:10 +0300
From: Tero Kristo <t-kristo@ti.com>
MIME-Version: 1.0
To: Paul Walmsley <paul@pwsan.com>, Keerthy <j-keerthy@ti.com>
CC: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>,
        <galak@codeaurora.org>, <alexandre.belloni@free-electrons.com>,
        <akpm@linux-foundation.org>, <johan@kernel.org>,
        <grygorii.strashko@ti.com>, <rtc-linux@googlegroups.com>,
        <bcousson@baylibre.com>, <nm@ti.com>, <devicetree@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 5/6] ARM: AM43XX: HWMOD: Add rtc hwmod
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-6-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1508121434190.7154@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.02.1508121434190.7154@utopia.booyaka.com>
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

On 08/12/2015 05:39 PM, Paul Walmsley wrote:
> On Mon, 10 Aug 2015, Keerthy wrote:
>
>> The patch adds rtc hwmod. This is present on gp and sk evm and not on
>> epos evm. Hence adding it selectively using a seprate list.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> So just to confirm, the RTC IP block has been physically removed or
> permanently disabled on these new AM438x chips?  So the registers are no
> longer accessible by the MPU?
>
> Is there a TRM available for these chips?

No public TRM available, as the SoC mostly contains secure environment 
support on them.

The RTC module is physically present on the SoC, but it is permanently 
disabled. A secure RTC is used instead on these devices, where needed.

-Tero

>
>
> - Paul
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
