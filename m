Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Johan Hovold <jhovold@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v8 09/10] rtc: at91sam9: add DT bindings documentation
Date: Tue, 23 Sep 2014 14:56:37 +0200
Message-ID: <3728270.N2tTcyeJmL@wuerfel>
In-Reply-To: <1411471444-2764-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com> <1411471444-2764-10-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <rtc-linux.googlegroups.com>

On Tuesday 23 September 2014 13:24:03 Boris BREZILLON wrote:
> Add RTT bindings documentation.

Two minor comments here:

> +Atmel AT91SAM9260 Real Time Timer
> +
> +Required properties:
> +- compatible: should be: "atmel,at91sam9260-rtt"
> +- reg: should encode the memory region of the RTT controller
> +- interrupts: rtt alarm/event interrupt
> +- clocks: should contain one clock pointing to the slow clk

This should document what the clock is used for, not where it's
connected.

> +
> +rtt@fffffe00 {
> +       compatible = "atmel,at91sam9260-rtt";
> +       reg = <0xfffffd20 0x10>;
> +       interrupts = <1 4 7>;
> +       clocks = <&clk32k>;
> +       atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> 

The register address fffffd20 does not match the name fffffe00

	Arnd
