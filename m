Return-Path: <rtc-linux+bncBDJIP47K7MERBHXR2OZAKGQEQZ3VIVI@googlegroups.com>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com. [209.85.214.169])
        by gmr-mx.google.com with ESMTPS id mv7si42896igb.0.2015.11.24.15.54.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 15:54:05 -0800 (PST)
Received: by mail-ob0-f169.google.com with SMTP id bj7so26633286obb.1
        for <rtc-linux@googlegroups.com>; Tue, 24 Nov 2015 15:54:05 -0800 (PST)
Date: Tue, 24 Nov 2015 17:54:00 -0600
From: Rob Herring <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH 1/2] Documentation: devicetree: add epson
 rx6110 binding
Message-ID: <20151124235337.GA18195@rob-hp-laptop>
References: <1448361533-10728-1-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448361533-10728-1-git-send-email-s.trumtrar@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Nov 24, 2015 at 11:38:52AM +0100, Steffen Trumtrar wrote:
> Add the binding documentation for the Epson RX6110 RTC.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> I'm not sure what the current policy for such simple SPI bindings is.
> Are they necessary?

Yes. We do have trivial-devices.txt for i2c. We could do one for spi. 
Although, you need the mode configuration for each device, so spi is not 
so trivial.

> 
>  .../devicetree/bindings/rtc/epson,rtc-rx6110.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt
> new file mode 100644
> index 000000000000..7ce7ae761657
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt
> @@ -0,0 +1,25 @@
> +Epson RX6110 Real Time Clock
> +============================
> +
> +The Epson RX6110 can be used with SPI or I2C busses. The kind of
> +bus depends on the SPISEL pin and can not be configured via software.

Can you document I2C mode. It should just be the compatible and reg 
properties.

> +
> +SPI mode
> +--------
> +
> +Required properties:
> +- compatible: should be: "epson,rtc-rx6110"
> +- reg: chip select number
> +- spi-cs-high: RX6110 needs chipselect high
> +- spi-cpha: RX6110 works with SPI shifted clock phase
> +- spi-cpol: RX6110 works with SPI inverse clock polarity
> +
> +Example:
> +
> +	rtc: rtc@3 {
> +		compatible = "epson,rtc-rx6110"
> +		reg = <3>
> +		spi-cs-high;
> +		spi-cpba;
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
