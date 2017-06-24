Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBAFHXPFAKGQEBNR2V4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 68si1582758wmg.2.2017.06.24.14.02.56
        for <rtc-linux@googlegroups.com>;
        Sat, 24 Jun 2017 14:02:56 -0700 (PDT)
Date: Sat, 24 Jun 2017 23:02:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Marek Vasut <marex@denx.de>
Cc: rtc-linux@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
	Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [rtc-linux] Re: [PATCH V2] rtc: ds1307: Add support for Epson RX8130CE
Message-ID: <20170624210255.evnmwoec5xukla5c@piout.net>
References: <20170618205528.10088-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170618205528.10088-1-marex@denx.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 18/06/2017 at 22:55:28 +0200, Marek Vasut wrote:
> Add support for yet another RTC chip, Epson RX8130CE. This time around,
> the chip has slightly permutated registers and also the register starts
> at 0x10 instead of 0x0 .
> 
> So far, we only support the RTC and NVRAM parts of the chip, Alarm and
> Timer is not supported.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> V2: Convert to regmap
> ---
>  drivers/rtc/rtc-ds1307.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
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
