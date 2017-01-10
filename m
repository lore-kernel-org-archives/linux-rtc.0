Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBH622DBQKGQE4DECOZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id a19si778171wme.0.2017.01.09.16.38.54
        for <rtc-linux@googlegroups.com>;
        Mon, 09 Jan 2017 16:38:54 -0800 (PST)
Date: Tue, 10 Jan 2017 01:38:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] Re: [PATCH v3] rtc: armada38x: Follow the new
 recommendation for errata implementation
Message-ID: <20170110003854.67n6x2chjkwazfvs@piout.net>
References: <20161221102816.6939-1-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161221102816.6939-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/12/2016 at 11:28:16 +0100, Gregory CLEMENT wrote :
> According to RES-3124064:
> 
> The device supports CPU write and read access to the RTC time register.
> However, due to this restriction, read and write from/to internal RTC
> register may fail.
> 
> Workaround:
> General setup:
> 1. Configure the RTC Mbus Bridge Timing Control register (offset 0x184A0)
>    to value 0xFD4D4FFF
>    Write RTC WRCLK Period to its maximum value (0x3FF)
>    Write RTC WRCLK setup to 0x29
>    Write RTC WRCLK High Time to 0x53 (default value)
>    Write RTC Read Output Delay to its maximum value (0x1F)
>    Mbus - Read All Byte Enable to 0x1 (default value)
> 2. Configure the RTC Test Configuration Register (offset 0xA381C) bit3
>    to '1' (Reserved, Marvell internal)
> 
> For any RTC register read operation:
> 1. Read the requested register 100 times.
> 2. Find the result that appears most frequently and use this result
>    as the correct value.
> 
> For any RTC register write operation:
> 1. Issue two dummy writes of 0x0 to the RTC Status register (offset
>    0xA3800).
> 2. Write the time to the RTC Time register (offset 0xA380C).
> 
> This patch is based on the work of Shaker Daibes
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> this patch followed the patch series sent here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473232.html
> 
> For now I kept the patch 2 converting to time64_t apart after Russell
> King feedback.
> 
> Changelog:
> 
> v2 -> v3:
> - Removed unrelated change
> - Remove Unnecessary blank line
> - Used u32 instead of uint32_t
> - use the new errata name: RES-3124064 instead of FE-3124064
> 
> v1 -> v2:
> - merged the patch 1 and 3
> - substantially modified the 1st patch with I think a better
> implementation:
>   - First I do not put anymore more a big array onto the stack as
>     suggested by Andrew Lunn.
>   - Then I optimize the way to find the correct value.
> 
> Gregory
> 
>  drivers/rtc/rtc-armada38x.c | 118 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 95 insertions(+), 23 deletions(-)
> 
Applied, thanks.

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
