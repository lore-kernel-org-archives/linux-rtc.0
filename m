Return-Path: <rtc-linux+bncBDJIP47K7MERBLGF3CZQKGQEITY5GWY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id p88si2212937pfi.0.2015.12.19.19.38.20
        for <rtc-linux@googlegroups.com>;
        Sat, 19 Dec 2015 19:38:20 -0800 (PST)
Date: Sat, 19 Dec 2015 21:38:15 -0600
From: Rob Herring <robh@kernel.org>
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH v5] rtc: support DS1302 RTC on ICP DAS LP-8x4x
Message-ID: <20151220033815.GD9883@rob-hp-laptop>
References: <397668667-27328-3-git-send-email-ynvich@gmail.com>
 <1450201525-9137-1-git-send-email-ynvich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1450201525-9137-1-git-send-email-ynvich@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Dec 15, 2015 at 08:45:23PM +0300, Sergei Ianovich wrote:

Nothing in this is specific to ICP, so the subject should be updated.

> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>    v4..v5
>    * drop THIS_MODULE from struct platform driver
>    * use "dallas" for vendor name per vendor-prefixes.txt
> 
>    v3..v4
>    * move DTS bindings to a different patch
> 
>    v2..v3
>    * use usleep_range instead of custom nsleep
>    * number change (07/16 -> 09/21)
> 
>    v0..v2
>    * use device tree
>    * use devm helpers where possible
> 
>  .../devicetree/bindings/rtc/rtc-ds1302.txt         |  14 +++
>  drivers/rtc/Kconfig                                |   2 +-
>  drivers/rtc/rtc-ds1302.c                           | 100 ++++++++++++++++++++-
>  3 files changed, 113 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
> new file mode 100644
> index 0000000..810613b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
> @@ -0,0 +1,14 @@
> +* Dallas Semiconductor DS-1302 RTC
> +
> +Simple device which could be used to store date/time between reboots.
> +
> +Required properties:
> +- compatible : Should be "dallas,rtc-ds1302"
> +- reg : Should be address and size of IO memory region

This device is a SPI (or SPI like?) interface. So you have some sort of 
of FPGA logic in between the cpu and ds1302. The DT should have a node 
for the controller and then the ds1302 as a child of it. A full blown 
SPI driver may be overkill here, but that's a separate discussion from 
the DT binding.

Rob

> +
> +Examples:
> +
> +rtc@40900000 {
> +	compatible = "dallas,rtc-ds1302";
> +	reg = <0x1700901c 0x1>;
> +};

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
