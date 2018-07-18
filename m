Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:38950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeGRIPe (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 18 Jul 2018 04:15:34 -0400
Date: Wed, 18 Jul 2018 09:38:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Message-ID: <20180718073850.GH3211@piout.net>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
 <20180710090710.9066-6-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180710090710.9066-6-Denis.Osterland@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 10/07/2018 09:44:15+0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example. It is not a trivial
> device, because it supports two interrupt souces.
> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl1219.txt  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> new file mode 100644
> index 000000000000..f26f1e9d4bde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> @@ -0,0 +1,29 @@
> +Intersil ISL1219 I2C RTC/Alarm chip with event in
> +
> +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be "isil,isl1219"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - "interrupt-names": list which may contains "irq" and "evdet"
> + - "interrupt-parent", "interrupts", "interrupts-extended":
> +   for passing the interrupt line of the SoC connected to #IRQ pin
> +   and #EVDET pin of the RTC chip.
> + - "isil,ev-evienb": if present bit can be set to disable event input pull-up

I would use a clearer name for that property like isil,ev-pull-up-enabled.

Also make it an int so 0 is disabling the pull-up (EVIENB set to 1) 1 is
enabling the pull-up (EVIENB set to 0) and do nothing when the property
is not present.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
