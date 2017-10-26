Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFUZZHHQKGQECIDUU6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id o2si12344wmf.1.2017.10.26.13.59.01
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Oct 2017 13:59:01 -0700 (PDT)
Date: Thu, 26 Oct 2017 22:59:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Bastian Stender <bst@pengutronix.de>
Cc: rtc-linux@googlegroups.com, Marek Vasut <marex@denx.de>,
	Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>,
	Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
	kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: add OF and ACPI entries for
 Epson RX8130
Message-ID: <20171026205901.k3ym3uejsslddne3@piout.net>
References: <20171017124607.17461-1-bst@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20171017124607.17461-1-bst@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Note that this has not been sent to the correct mailing list (please use
a more recent kernel ;))

On 17/10/2017 at 14:46:07 +0200, Bastian Stender wrote:
> Make Epson RX8130 device tree and ACPI aware.
> 
> Fixes: ee0981be7704 ("rtc: ds1307: Add support for Epson RX8130CE")
> Signed-off-by: Bastian Stender <bst@pengutronix.de>
> ---
>  drivers/rtc/rtc-ds1307.c | 5 +++++
>  1 file changed, 5 insertions(+)
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
