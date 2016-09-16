Return-Path: <rtc-linux+bncBCQPVKWLVAIRBRVI6C7AKGQE47HENOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id 7si2863616pfw.1.2016.09.16.08.48.22
        for <rtc-linux@googlegroups.com>;
        Fri, 16 Sep 2016 08:48:22 -0700 (PDT)
Date: Fri, 16 Sep 2016 08:48:18 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v6] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160916154817.m67rh4wpu2ov53zf@atomide.com>
References: <20160916092628.1049-1-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160916092628.1049-1-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Marcin Niestroj <m.niestroj@grinn-global.com> [160916 02:27]:
> Support configuration of ext_wakeup sources. This patch makes it
> possible to enable ext_wakeup and set it's polarity, depending on board
> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> notify about power-button presses. Handling power-button presses enables
> to recover from RTC-only power states correctly.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Acked-by: Tony Lindgren <tony@atomide.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
