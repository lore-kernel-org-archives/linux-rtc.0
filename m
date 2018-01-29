Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44853 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeA2XeM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 29 Jan 2018 18:34:12 -0500
Date: Mon, 29 Jan 2018 17:34:10 -0600
From: Rob Herring <robh@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        kernel@pengutronix.de, Denis.Osterland@diehl.com
Subject: Re: [PATCH 2/4] rtc: isl1208: Add device tree binding documentation
Message-ID: <20180129233410.y2g27rawmoh5phvr@rob-hp-laptop>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-3-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123121801.4214-3-m.grzeschik@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Jan 23, 2018 at 01:17:59PM +0100, Michael Grzeschik wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> Wrote documentation for ISL1208, ISL1218 device tree
> binding with short examples.
> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  .../devicetree/bindings/rtc/intersil,isl1208.txt   | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl1208.txt

A couple of nits, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt b/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> new file mode 100644
> index 0000000000000..a54e99feae1ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> @@ -0,0 +1,35 @@
> +Intersil ISL1208, ISL1218 I2C RTC/Alarm chip
> +
> +ISL1208 is a trivial I2C device (it has simple device tree bindings,
> +consisting of a compatible field, an address and possibly an interrupt
> +line).
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be one of
> +	"isil,isl1208"
> +	"isil,isl1218"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - "interrupt-parent", "interrupts", "interrupts-extended":
> +   for passing the interrupt line of the SoC connected to #IRQ pin
> +   of the RTC chip.
> +
> +
> +Example isl1208 node without #IRQ pin connected:
> +
> +	isl1208: isl1208@68 {

rtc@68

> +		compatible = "isil,isl1208";
> +		reg = <0x68>;
> +	};
> +
> +Example isl1208 node with #IRQ pin connected to SoC gpio1 pin 12:
> +
> +	isl1208: isl1208@68 {

rtc@68

> +		compatible = "isil,isl1208";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> +	};
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
