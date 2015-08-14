Return-Path: <rtc-linux+bncBDS7HNEFSALRB4GNW2XAKGQENDDGBCI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si38290wib.2.2015.08.14.01.29.36
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Aug 2015 01:29:36 -0700 (PDT)
Date: Fri, 14 Aug 2015 10:29:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Walmsley <paul@pwsan.com>
Cc: Keerthy <a0393675@ti.com>, Keerthy <j-keerthy@ti.com>, tony@atomide.com,
	linux-omap@vger.kernel.org, pawel.moll@arm.com,
	galak@codeaurora.org, akpm@linux-foundation.org, johan@kernel.org,
	grygorii.strashko@ti.com, rtc-linux@googlegroups.com,
	bcousson@baylibre.com, nm@ti.com, devicetree@vger.kernel.org,
	t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Message-ID: <20150814082935.GF22269@piout.net>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
 <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com>
 <55CB99C2.7010007@ti.com>
 <20150812201636.GJ3411@piout.net>
 <alpine.DEB.2.02.1508131822510.1009@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <alpine.DEB.2.02.1508131822510.1009@utopia.booyaka.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/08/2015 at 20:17:23 +0000, Paul Walmsley wrote :
> > I'd say that I don't really care. I'd say the best would be to make a
> > decision based on clock-accuracy but maybe that is an information you
> > don't have yet. Anyway, this could be added at a later date.
> 
> Either the clock mux logic is glitchless, in which case the RTC is likely 
> to lose at least 31 microseconds per switch; or it's not glitchless, in 
> which case it's unsafe to switch the RTC clock source while the clock 
> isn't gated.  Keerthy, before submitting this patch for merging, I'd 
> suggest consulting your hardware folks to figure out which case it is.
> 

Don't take me wrong, your point is perfectly valid. I was just saying
that I didn't care what was done in the driver. Obviously, this has to
match what is best from a hardware point of view. But since we agreed on
the DT bindings, I'd say that we can still adjust the driver later.


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
