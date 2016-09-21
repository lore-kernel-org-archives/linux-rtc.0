Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB2PBRO7QKGQEHEYJK4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p199si3213327wmd.1.2016.09.21.13.43.20
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Sep 2016 13:43:20 -0700 (PDT)
Date: Wed, 21 Sep 2016 22:43:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Martin Fuzzey <mfuzzey@parkeon.com>, Rob Herring <robh+dt@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/3] dt-binding: rtc Add DT binding for NXP
 85263 RTC
Message-ID: <20160921204320.zueirn3cs42yhifd@piout.net>
References: <20160801155029.32232.56063.stgit@localhost>
 <20160801155032.32232.68432.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160801155032.32232.68432.stgit@localhost>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Rob, can you review those bindings?


On 01/08/2016 at 17:50:32 +0200, Martin Fuzzey wrote :

Please always include a commit message.

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf85263.txt       |   41 ++++++++++++++++++++
>  include/dt-bindings/rtc/nxp,pcf85263.h             |   14 +++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt
>  create mode 100644 include/dt-bindings/rtc/nxp,pcf85263.h
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt
> new file mode 100644
> index 0000000..03b9505
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85263.txt
> @@ -0,0 +1,41 @@
> +NXP PCF85263 I2C Real Time Clock
> +
> +Required properties:
> +- compatible: must be: "nxp,rtc-pcf85263"
> +- reg: must be the I2C address
> +
> +Optional properties:
> +- interrupt-names: Which interrupt signal is used must be "INTA" or "INTB"
> +    Defaults to "INTA"
> +
> +- quartz-load-capacitance: The internal capacitor to select for the quartz:
> +	PCF85263_QUARTZCAP_7pF		[0]
> +	PCF85263_QUARTZCAP_6pF		[1]
> +	PCF85263_QUARTZCAP_12p5pF	[2] DEFAULT
> +
> +- quartz-drive-strength: Drive strength for the quartz:
> +	PCF85263_QUARTZDRIVE_NORMAL	[0] DEFAULT
> +	PCF85263_QUARTZDRIVE_LOW	[1]
> +	PCF85263_QUARTZDRIVE_HIGH	[2]
> +
> +- quartz-low-jitter: Boolean property, if present enables low jitter mode which
> +    reduces jitter at the cost of increased power consumption.
> +

Maybe that one should be handled using sysfs instead of DT as it is more
policy than HW related.

> +- wakeup-source: mark the chip as a wakeup source, independently of
> +    the availability of an IRQ line connected to the SoC.
> +    This is useful if the IRQ line is connected to a PMIC or other circuit
> +    that can power up the device rather than to a normal SOC interrupt.
> +
> +Example:
> +
> +rtc@51 {
> +	compatible = "nxp,pcf85263";
> +	reg = <0x51>;
> +
> +	interrupt-parent = <&gpio4>;
> +	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "INTB";
> +
> +	quartz-load-capacitance = <PCF85263_QUARTZCAP_12p5pF>;
> +	quartz-drive-strength = <PCF85263_QUARTZDRIVE_LOW>;
> +};
> diff --git a/include/dt-bindings/rtc/nxp,pcf85263.h b/include/dt-bindings/rtc/nxp,pcf85263.h
> new file mode 100644
> index 0000000..ea87ae4
> --- /dev/null
> +++ b/include/dt-bindings/rtc/nxp,pcf85263.h
> @@ -0,0 +1,14 @@
> +#ifndef _DT_BINDINGS_RTC_NXP_PCF85263_H
> +#define _DT_BINDINGS_RTC_NXP_PCF85263_H
> +
> +/* Quartz capacitance */
> +#define PCF85263_QUARTZCAP_7pF		0
> +#define PCF85263_QUARTZCAP_6pF		1
> +#define PCF85263_QUARTZCAP_12p5pF	2
> +
> +/* Quartz drive strength */
> +#define PCF85263_QUARTZDRIVE_NORMAL	0
> +#define PCF85263_QUARTZDRIVE_LOW	1
> +#define PCF85263_QUARTZDRIVE_HIGH	2
> +
> +#endif /* _DT_BINDINGS_RTC_NXP_PCF85263_H */
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
