Return-Path: <rtc-linux+bncBAABBCWFS7CQKGQEROQ6T5Q@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id q4si53223wma.3.2017.02.16.09.34.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 09:34:01 -0800 (PST)
Date: Thu, 16 Feb 2017 17:33:48 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
	Haim Boot <hayim@marvell.com>, linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/3] Extend rtc-armada38x support for Armada 7K/8K
Message-ID: <20170216173348.GT27312@n2100.armlinux.org.uk>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170216153136.27009-1-gregory.clement@free-electrons.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Feb 16, 2017 at 04:31:33PM +0100, Gregory CLEMENT wrote:
> The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> the SOC integration differs in 2 points:
>      - MBUS bridge timing initialization
>      - IRQ configuration at SoC level
> 
> This patch set extends the driver support to these SoCs family.

I've just tried merging this into my kernel, and...

root@mcbin:~# date
Thu Feb 16 17:33:00 GMT 2017
root@mcbin:~# hwclock -uw
root@mcbin:~# hwclock
Sun 07 Feb 2106 01:49:51 GMT  -10.010475 seconds
root@mcbin:~# hwclock
Sun 07 Feb 2106 01:49:51 GMT  -10.010458 seconds

I guess it needs the same hack that Armada38x needs - "date reset" twice
in uboot?

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
