Return-Path: <rtc-linux+bncBDJIP47K7MERBQFOVW3AKGQELR3Q5GY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id ui7si3318104pab.0.2016.02.22.10.45.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 10:45:19 -0800 (PST)
Date: Mon, 22 Feb 2016 12:45:14 -0600
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
	"open list:REAL TIME CLOCK SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH v6] rtc: rewrite DS1302 using SPI
Message-ID: <20160222184514.GA26099@rob-hp-laptop>
References: <397668667-27328-3-git-send-email-ynvich@gmail.com>
 <1456105286-28598-1-git-send-email-ynvich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456105286-28598-1-git-send-email-ynvich@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 22, 2016 at 04:41:22AM +0300, Sergei Ianovich wrote:
> DS1302 is half-duplex SPI device. The driver respects this fact now.
> 
> Pin configurations should be implemented using SPI subsystem.
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Rob Herring <robh@kernel.org>
> ---
>    v5..v6
>    * rewrite the driver as an SPI slave device
>    * use "maxim" for vendor name per Kconfig
>    * stop touching device RAM in device presence test
>    * only return time from device if valid
>    * use burst mode for reading/writing time
>    * droppped charging control. I cannot test it, and it looks broken
> 
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
>  .../devicetree/bindings/rtc/rtc-ds1302.txt         |  46 +++
>  drivers/rtc/Kconfig                                |  15 +-
>  drivers/rtc/rtc-ds1302.c                           | 348 ++++++++++-----------
>  3 files changed, 212 insertions(+), 197 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
> new file mode 100644
> index 0000000..b6c0973
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
> @@ -0,0 +1,46 @@
> +* Maxim/Dallas Semiconductor DS-1302 RTC
> +
> +Simple device which could be used to store date/time between reboots.
> +
> +The device uses the standard MicroWire half-duplex transfer timing.
> +Master output is set on low clock and sensed by the RTC on the rising
> +edge. Master input is set by the RTC on the trailing edge and is sensed
> +by the master on low clock.
> +
> +Required properties:
> +
> +- compatible : Should be "maxim,rtc-ds1302"

Just maxim,ds1032. RTC is implied by the part number and inline with 
existing dallas,ds1307.

> +
> +Required SPI properties:
> +
> +- reg : Should be address of the device chip select within
> +  the controller.
> +
> +- spi-max-frequency : DS-1302 has 500 kHz if powered at 2.2V,
> +  and 2MHz if powered at 5V.
> +
> +- spi-3wire : The device has a shared signal IN/OUT line.
> +
> +- spi-lsb-first : DS-1302 requires least significant bit first
> +  transfers.
> +
> +- spi-cs-high: DS-1302 has active high chip select line. This is
> +  required unless inverted in hardware.
> +
> +Example:
> +
> +spi0@901c {

spi@...

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "icpdas,spi-lp8841-rtc";

And this will need updating...

> +	reg = <0x901c 0x1>;
> +
> +	rtc@0 {
> +		compatible = "maxim,rtc-ds1302";
> +		reg = <0>;
> +		spi-max-frequency = <500000>;
> +		spi-3wire;
> +		spi-lsb-first;
> +		spi-cs-high;
> +	};
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
