Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39645 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeA2Xls (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 29 Jan 2018 18:41:48 -0500
Date: Mon, 29 Jan 2018 17:41:46 -0600
From: Rob Herring <robh@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        kernel@pengutronix.de, Denis.Osterland@diehl.com
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Message-ID: <20180129234146.73hvclxohhme5i2w@rob-hp-laptop>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123121801.4214-5-m.grzeschik@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Jan 23, 2018 at 01:18:01PM +0100, Michael Grzeschik wrote:
> We add support for the ISL1219 chip that got an integrated tamper
> detection function. This patch implements the feature by using an hwmon
> interface.
> 
> The ISL1219 can also describe the timestamp of the intrusion
> event. For this we add the documentation of the new interface
> intrusion[0-*]_timestamp.
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  .../rtc/{intersil,isl1208.txt => isil,isl1208.txt} |  18 +-
>  Documentation/hwmon/sysfs-interface                |   7 +
>  drivers/rtc/rtc-isl1208.c                          | 190 +++++++++++++++++++--
>  3 files changed, 201 insertions(+), 14 deletions(-)
>  rename Documentation/devicetree/bindings/rtc/{intersil,isl1208.txt => isil,isl1208.txt} (57%)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> similarity index 57%
> rename from Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> rename to Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> index a54e99feae1ca..d549699e1cfc4 100644
> --- a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> @@ -1,14 +1,21 @@
> -Intersil ISL1208, ISL1218 I2C RTC/Alarm chip
> +Intersil ISL1208, ISL1218, ISL1219 I2C RTC/Alarm chip
>  
>  ISL1208 is a trivial I2C device (it has simple device tree bindings,
>  consisting of a compatible field, an address and possibly an interrupt
>  line).
>  
> +ISL1219 supports tamper detection user space representation through
> +case intrusion hwmon sensor.

User space and hwmon are Linux details not relevant to the binding. Just 
describe the h/w.

> +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
> +I2C devices support only one irq. #IRQ and #EVDET are open-drain active low,
> +so it is possible layout them to one SoC pin with pull-up.
> +
>  Required properties supported by the device:
>  
>   - "compatible": must be one of
>  	"isil,isl1208"
>  	"isil,isl1218"
> +	"isil,isl1219"
>   - "reg": I2C bus address of the device
>  
>  Optional properties:
> @@ -33,3 +40,12 @@ Example isl1208 node with #IRQ pin connected to SoC gpio1 pin 12:
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>  	};
> +
> +Example isl1219 node with #IRQ pin and #EVDET pin connected to SoC gpio1 pin 12:
> +
> +	isl1219: isl1219@68 {
> +		compatible = "intersil,isl1219";
> +		reg = <0x68>;
> +		interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>;

With 2 interrupts, you should have 2 values. If they are connected 
together, just repeat the connection. Otherwise, you can't tell if EVDET 
is a no connect.

There's not much point in having an example for every compatible. This 
binding is simple enough, one should be enough.

> +	};
> +
