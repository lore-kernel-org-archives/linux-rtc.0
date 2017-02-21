Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBM73WLCQKGQECJTAQ2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 14si1210435wmn.2.2017.02.21.14.22.43
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 14:22:43 -0800 (PST)
Date: Tue, 21 Feb 2017 23:22:42 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] Re: [PATCH v3 1/3] rtc: armada38x: Prepare driver to
 manage different versions
Message-ID: <20170221222242.n5pdpmrjk5wie5wq@piout.net>
References: <20170220173850.8640-1-gregory.clement@free-electrons.com>
 <20170220173850.8640-2-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170220173850.8640-2-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/02/2017 at 18:38:48 +0100, Gregory CLEMENT wrote:
> In order to prepare the introduction of the A7K/A8K version of the RTC,
> this commit introduces a new data structure. This structure allows to
> handle the differences between the integration of the RTC IP in the
> SoCs. It will be:
>  - MBUS bridge timing initialization
>  - IRQ configuration at SoC level
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/rtc/rtc-armada38x.c | 152 +++++++++++++++++++++++++++++---------------
>  1 file changed, 99 insertions(+), 53 deletions(-)
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
