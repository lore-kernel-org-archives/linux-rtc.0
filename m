Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPX3WLCQKGQEGNTXUTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si1393641wma.3.2017.02.21.14.22.54
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 14:22:54 -0800 (PST)
Date: Tue, 21 Feb 2017 23:22:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] Re: [PATCH v3 2/3] rtc: armada38x: Add support for Armada 7K/8K
Message-ID: <20170221222253.jdcwvcjhey7f4cyv@piout.net>
References: <20170220173850.8640-1-gregory.clement@free-electrons.com>
 <20170220173850.8640-3-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170220173850.8640-3-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/02/2017 at 18:38:49 +0100, Gregory CLEMENT wrote:
> The Armada 7K/8K use the same RTC IP than the Armada 38x. However the SOC
> integration differs in 2 points:
>  - MBUS bridge timing initialization
>  - IRQ configuration at SoC level
> 
> Moreover the Armada 7K/8K have an issue preventing to get the interrupt
> from alarm 1. This commit allows to use alarm 2 for these A7K/8K but to
> still use alarm 1 for the Armada 38x.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     |  8 ++-
>  drivers/rtc/rtc-armada38x.c                        | 65 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 3 deletions(-)
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
