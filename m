Return-Path: <rtc-linux+bncBAABB5WGS7CQKGQEL4QQH6A@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id q4si54235wma.3.2017.02.16.09.37.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 09:37:57 -0800 (PST)
Date: Thu, 16 Feb 2017 17:37:48 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
	Andrew Lunn <andrew@lunn.ch>, Haim Boot <hayim@marvell.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/3] Extend rtc-armada38x support for Armada 7K/8K
Message-ID: <20170216173748.GU27312@n2100.armlinux.org.uk>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
 <20170216173348.GT27312@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170216173348.GT27312@n2100.armlinux.org.uk>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Feb 16, 2017 at 05:33:48PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2017 at 04:31:33PM +0100, Gregory CLEMENT wrote:
> > The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> > the SOC integration differs in 2 points:
> >      - MBUS bridge timing initialization
> >      - IRQ configuration at SoC level
> > 
> > This patch set extends the driver support to these SoCs family.
> 
> I've just tried merging this into my kernel, and...
> 
> root@mcbin:~# date
> Thu Feb 16 17:33:00 GMT 2017
> root@mcbin:~# hwclock -uw
> root@mcbin:~# hwclock
> Sun 07 Feb 2106 01:49:51 GMT  -10.010475 seconds
> root@mcbin:~# hwclock
> Sun 07 Feb 2106 01:49:51 GMT  -10.010458 seconds
> 
> I guess it needs the same hack that Armada38x needs - "date reset" twice
> in uboot?

Hmm, even with that sorted:

root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:50 GMT  -0.786571 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:51 GMT  -1.347541 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:52 GMT  -1.889295 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:53 GMT  -1.787338 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:54 GMT  -1.444397 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:55 GMT  -1.419772 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:35:58 GMT  -2.555282 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:36:09 GMT  -0.515289 seconds
root@mcbin:~# hwclock
Thu 16 Feb 2017 17:36:11 GMT  -1.773030 seconds
root@mcbin:~#

I think this RTC is a random number generator.  It's certainly not
a reliable indication of time.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
