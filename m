Return-Path: <rtc-linux+bncBDS7HNEFSALRB7U2UGUQKGQEBXSLLCY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bz6si43169wib.3.2015.04.10.15.23.57
        for <rtc-linux@googlegroups.com>;
        Fri, 10 Apr 2015 15:23:57 -0700 (PDT)
Date: Sat, 11 Apr 2015 00:23:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Keerthy <a0393675@ti.com>, Igor Grinberg <grinberg@compulab.co.il>,
	Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
Message-ID: <20150410222355.GE20669@piout.net>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
 <20150324155916.cfd1b7ab442271466160283f@linux-foundation.org>
 <55234F25.5060708@ti.com>
 <5523820C.2010709@compulab.co.il>
 <5527894E.9000807@ti.com>
 <20150410133730.8f84b2894efcf1bde075048f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150410133730.8f84b2894efcf1bde075048f@linux-foundation.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 10/04/2015 at 13:37:30 -0700, Andrew Morton wrote :
> Is there any way in which we can get all systems working properly?  If
> there's no way of auto-detecting an external oscillator then perhaps a
> module parameter is needed.  If so, it would be better if the driver
> were to default to internal oscillator (ie: current behaviour), and the
> module parameter selects the external oscillator.  This way, existing
> systems are unaffected by the kernel upgrade.
> 

Actually, I would use the common clock framework, allowing to chose
between the internal and an external clock source by using the "clocks"
property. This would also allow to have the correct reference count on
that 32k internal clock. It may not matter now but for example, not
doing so became a problem on at91.

As a fallback, if no clocks property is available, I would use the
internal 32k to keep DT ABI backward compatibility.

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
