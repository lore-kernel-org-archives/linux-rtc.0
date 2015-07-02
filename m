Return-Path: <rtc-linux+bncBDS7HNEFSALRBAP722WAKGQEJVLI22Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si364843wib.3.2015.07.02.15.47.29
        for <rtc-linux@googlegroups.com>;
        Thu, 02 Jul 2015 15:47:29 -0700 (PDT)
Date: Fri, 3 Jul 2015 00:47:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, balbi@ti.com,
	grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH V2 0/5] drivers/rtc/rtc-ds1307.c: Basic
 cleanups and support for wakeupirq
Message-ID: <20150702224728.GF3467@piout.net>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
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

On 23/06/2015 at 11:15:09 -0500, Nishanth Menon wrote :
> NOTE1: I have only tested in mcp79410 device, and not on other
> ds1307-rtc driver compatbile devices as I dont have any other.
> additional testing might be nice to have.

Patchwork picked up V3 of 4/5 correctly so I have applied the series and
pushed it in rtc-next. It will land in linux-next tomorrow so hopefully,
this will see more testing.

> NOTE2: there are additional fixes that linux-next seems to need but
> those are in omap-rtc, cpufreq etc, but those are not related by the
> ds-1307.
> 
> V1: https://patchwork.kernel.org/patch/4759171/
> 
> NOTE: Patch 5/5 of the series is meant to indicate the usage, and will
> be reposted along with other wakeup sources to be enabled once the
> driver changes are accepted.
> 

I've left that one out so you can send it to the omap maintainers when
ready.

Thanks!

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
