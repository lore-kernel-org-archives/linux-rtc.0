Return-Path: <rtc-linux+bncBDJIP47K7MERB7FPQGZQKGQE5SQNZGI@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id pe1si1029383pac.2.2015.12.03.06.55.56
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Dec 2015 06:55:56 -0800 (PST)
Date: Thu, 3 Dec 2015 08:55:52 -0600
From: Rob Herring <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v2 1/2] Documentation: devicetree: add epson
 rx6110 binding
Message-ID: <20151203145552.GA3635@rob-hp-laptop>
References: <1448977700-10924-1-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448977700-10924-1-git-send-email-s.trumtrar@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Dec 01, 2015 at 02:48:19PM +0100, Steffen Trumtrar wrote:
> Add the binding documentation for the Epson RX6110 RTC.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Changes since v1:
> 	- added i2c binding
> 	- compatible: "epson,rtc-rx6110" -> "epson,rx6110"
> 	- fixed typo
> 
>  .../devicetree/bindings/rtc/epson,rx6110.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> new file mode 100644
> index 000000000000..8c3d06f117e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> @@ -0,0 +1,39 @@
> +Epson RX6110 Real Time Clock
> +============================
> +
> +The Epson RX6110 can be used with SPI or I2C busses. The kind of
> +bus depends on the SPISEL pin and can not be configured via software.
> +
> +I2C mode
> +--------
> +
> +Required properties:
> +  - compatible: should be: "epson,rx6110"
> +  - reg : offset and length of the register set for the device

For i2c, there is no size cell. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +
> +Example:
> +
> +	rtc: rtc@32 {
> +		compatible = "epson,rx6110"
> +		reg = <0x32 0x32>;
> +	};
> +
> +SPI mode
> +--------
> +
> +Required properties:
> +  - compatible: should be: "epson,rx6110"
> +  - reg: chip select number
> +  - spi-cs-high: RX6110 needs chipselect high
> +  - spi-cpha: RX6110 works with SPI shifted clock phase
> +  - spi-cpol: RX6110 works with SPI inverse clock polarity
> +
> +Example:
> +
> +	rtc: rtc@3 {
> +		compatible = "epson,rx6110"
> +		reg = <3>
> +		spi-cs-high;
> +		spi-cpha;
> +		spi-cpol;
> +	};
> -- 
> 2.6.2
> 

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
