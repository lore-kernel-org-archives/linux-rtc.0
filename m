Return-Path: <rtc-linux+bncBD66BCOYSQBBBVNTV2XAKGQEKPCI6CI@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id 4si1294027igl.1.2015.08.12.12.09.09
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:09:09 -0700 (PDT)
Message-ID: <55CB99C2.7010007@ti.com>
Date: Thu, 13 Aug 2015 00:38:50 +0530
From: Keerthy <a0393675@ti.com>
MIME-Version: 1.0
To: Paul Walmsley <paul@pwsan.com>, Keerthy <j-keerthy@ti.com>,
        <alexandre.belloni@free-electrons.com>
CC: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>,
        <galak@codeaurora.org>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>
Subject: [rtc-linux] Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-3-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com>
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



On Wednesday 12 August 2015 07:57 PM, Paul Walmsley wrote:
> On Mon, 10 Aug 2015, Keerthy wrote:
>
>> Switch to external clock source during suspend and switch back
>> to internal source on resume. This helps rtc ticking across suspend.
>
> Doesn't this type of dynamic switching make it likely that ticks will be
> lost?
>
> If the external, optional source is present, isn't it best just to use the
> external source 100% of the time?


Paul,

The intent here is to switch to a higher precision clock which is the 
internal clock when available.

Alexandre,

Is dynamic switching preferred over sticking  to external clock always 
if present?

Regards,
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
