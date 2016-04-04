Return-Path: <rtc-linux+bncBCQPVKWLVAIRB5G2RO4AKGQEZ2Q6HYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id r4si4428589pfr.1.2016.04.04.15.40.51
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Apr 2016 15:40:51 -0700 (PDT)
Date: Mon, 4 Apr 2016 15:40:47 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160404224046.GA17042@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

* Marcin Niestroj <m.niestroj@grinn-global.com> [160404 08:57]:
> Support configuration of ext_wakeup sources. This patch makes it
> possible to enable ext_wakeup and set it's polarity, depending on board
> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> notify about power-button presses. Handling power-button presses enables
> to recover from RTC-only power states correctly.

I suggest you just set this pin up as a minimal gpiochip. That way
we can use the standard binding :) And if we get lucky, this pin can
also trigger during runtime.

Regards,

Tony

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
