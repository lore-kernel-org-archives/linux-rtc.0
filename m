Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45480 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeGKPVL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Jul 2018 11:21:11 -0400
Date: Wed, 11 Jul 2018 09:16:21 -0600
From: Rob Herring <robh@kernel.org>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] rtc: isl1219: add device tree docu
Message-ID: <20180711151621.GA4084@rob-hp-laptop>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
 <20180710090710.9066-6-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180710090710.9066-6-Denis.Osterland@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Jul 10, 2018 at 09:44:15AM +0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example. It is not a trivial
> device, because it supports two interrupt souces.

s/souces/sources/

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

Just list 'interrupts' and how many there are. interrupt-parent is 
implied and may be in a parent node. interrupts-extended is also 
implicitly allowed as needed.

> + - "isil,ev-evienb": if present bit can be set to disable event input pull-up
> +
> +
> +Example isl1219 node with #IRQ pin connected to SoC gpio1 pin12
> + and #EVDET pin connected to SoC gpio2 pin 24:
> +
> +	isl1219: rtc@68 {
> +		compatible = "isil,isl1219";
> +		reg = <0x68>;
> +		interrupt-names = "irq", "evdet";
> +		interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
> +			<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> --
> 2.18.0
> 
> 
> 
> Diehl Connectivity Solutions GmbH
> Geschäftsführung: Horst Leonberger
> Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
> Nürnberg: HRB 32315
> ___________________________________________________________________________________________________
> 
> Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
> Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
> Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
> mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
