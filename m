Return-Path: <rtc-linux+bncBAABBHOOVTCQKGQEJGLBTAA@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id y19si774913wmd.0.2017.02.20.09.27.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 09:27:56 -0800 (PST)
Date: Mon, 20 Feb 2017 17:27:39 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
	rtc-linux@googlegroups.com, Haim Boot <hayim@marvell.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/3] Extend rtc-armada38x support for
 Armada 7K/8K
Message-ID: <20170220172739.GN21222@n2100.armlinux.org.uk>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87tw7oaj24.fsf@free-electrons.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 20, 2017 at 06:06:11PM +0100, Gregory CLEMENT wrote:
> I saw on IRC than Russell managed to have a more coherent date with this
> series on his 8040 based board. For the record, as the U-Boot on this
> board didn't provide a "date reset" command for the RTC located on CP
> slave, then Russell needed to do the following:
> 
> devmem2 0xf428401c w 0
> devmem2 0xf4284018 w 0x2000
> followed by:
> date 021612342017; ntpdate ...; hwclock -uw
> 
> But this issue was related to the bootloader not to the kernel. The
> other potential issue seen by Russell was about the GIC mapping for the
> interrupt, but here again this mapping was done by the 1st stage
> bootloader.
> 
> Given this information would it be OK to applied this series?

No it is not.  As I already pointed out, the interrupt for the 8040 is
GIC_SPI 71 _not_ GIC_SPI 77 as you have it in this series.

Both CP110's on Armada 8040 have a default mapping of ICU 77 to GIC 71.

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
