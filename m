Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBM465K7AKGQE7ETHZVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a126si164892wmd.1.2016.09.15.05.08.19
        for <rtc-linux@googlegroups.com>;
        Thu, 15 Sep 2016 05:08:19 -0700 (PDT)
Date: Thu, 15 Sep 2016 14:08:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Keerthy <j-keerthy@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160915120819.3733dhvy5r7n3n4j@piout.net>
References: <201609082240.a4dMqCnB%fengguang.wu@intel.com>
 <4512fa0b-890b-0f10-00dd-188fcc98fb5c@grinn-global.com>
 <20160913215837.xstx4c6d4pr42hgh@piout.net>
 <eb67e85b-4651-33e0-abb7-339d83f36463@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <eb67e85b-4651-33e0-abb7-339d83f36463@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/09/2016 at 11:21:48 +0200, Marcin Niestroj wrote :
> On 13.09.2016 23:58, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 12/09/2016 at 11:01:05 +0200, Marcin Niestroj wrote :
> > > I guess we are missing PINCTRL in Kconfig. I didn't add that before,
> > > because I thought that there is a dependency chain GENERIC_PINCONF ->
> > > PINCONF -> PINCTRL.
> > > 
> > > So to resolve this issue:
> > > 1) Should we add "select" or "depends on" for PINCTRL?
> > > 2) Should this option be somehow related to COMPILE_TEST?
> > > 
> > 
> > Adding a "depends on PINCTRL" line should be enough to solve that issue.
> > 
> 
> Ok, will add that together with "depends on OF", as I noticed it is
> also needed.
> 
> 
> But right now we will not be able to compile this driver with
> COMPILE_TEST, unless we select some architecture that selects PINCTRL.
> 

That is find, Arnd was pointing out that the main use case is x86
allmodconfig and that enables PINCTRL.

> So maybe it is a good idea to change "config PINCTRL" option from
> 'bool' to 'bool "Support PINCTRL" if COMPILE_TEST', so we can enable it
> manually?
> 

This can be done too Mark Brown was suggesting it is a good idea. This
can be submitted as a separate, unrelated patch.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
