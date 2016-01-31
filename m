Return-Path: <rtc-linux+bncBDS7HNEFSALRBEXMW62QKGQEL7H2LRA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h123si178951wmd.0.2016.01.31.03.54.58
        for <rtc-linux@googlegroups.com>;
        Sun, 31 Jan 2016 03:54:58 -0800 (PST)
Date: Sun, 31 Jan 2016 12:54:57 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v4 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20160131115457.GL20165@piout.net>
References: <1451927075-8656-1-git-send-email-s.trumtrar@pengutronix.de>
 <1451927075-8656-2-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1451927075-8656-2-git-send-email-s.trumtrar@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/01/2016 at 18:04:35 +0100, Steffen Trumtrar wrote :
> The RX6110 comes in two different variants: SPI and I2C.
> This driver only supports the SPI variant.
> 
> If the need ever arises to also support the I2C variant, this driver
> could easily be refactored to support both cases.
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> 
> Changes since v3:
>     - remove old copyright infos
>     - use the BIT() macro
>     - replace rx6110_get_week_day() with ffs()
>     - replace hardcoded offsets with enum
>     - use regmap_bulk_write in set_time
>     - use regmap_register_patch in init function
>     - return -EINVAL instead of "fixing" time in the rtc
> 
>  drivers/rtc/Kconfig      |   9 ++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-rx6110.c | 402 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 412 insertions(+)
>  create mode 100644 drivers/rtc/rtc-rx6110.c
> 
Applied, after realigning some lines in rx6110_probe().

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
