Return-Path: <rtc-linux+bncBDS7HNEFSALRBKWTV2XAKGQE4PM5AKQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ek3si698321wid.1.2015.08.12.13.16.42
        for <rtc-linux@googlegroups.com>;
        Wed, 12 Aug 2015 13:16:42 -0700 (PDT)
Date: Wed, 12 Aug 2015 22:16:36 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <a0393675@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Keerthy <j-keerthy@ti.com>,
	tony@atomide.com, linux-omap@vger.kernel.org, pawel.moll@arm.com,
	galak@codeaurora.org, akpm@linux-foundation.org, johan@kernel.org,
	grygorii.strashko@ti.com, rtc-linux@googlegroups.com,
	bcousson@baylibre.com, nm@ti.com, devicetree@vger.kernel.org,
	t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Message-ID: <20150812201636.GJ3411@piout.net>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
 <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com>
 <55CB99C2.7010007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55CB99C2.7010007@ti.com>
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

On 13/08/2015 at 00:38:50 +0530, Keerthy wrote :
> The intent here is to switch to a higher precision clock which is the
> internal clock when available.
> 
> Alexandre,
> 
> Is dynamic switching preferred over sticking  to external clock always if
> present?
> 

I'd say that I don't really care. I'd say the best would be to make a
decision based on clock-accuracy but maybe that is an information you
don't have yet. Anyway, this could be added at a later date.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
