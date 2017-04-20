Return-Path: <rtc-linux+bncBDJIP47K7MERBNFU4PDQKGQESKH3WRQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com. [209.85.218.67])
        by gmr-mx.google.com with ESMTPS id q9si2117716itc.1.2017.04.20.08.56.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 08:56:36 -0700 (PDT)
Received: by mail-oi0-f67.google.com with SMTP id y11so8807546oie.1
        for <rtc-linux@googlegroups.com>; Thu, 20 Apr 2017 08:56:36 -0700 (PDT)
Date: Thu, 20 Apr 2017 10:56:34 -0500
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	mark.rutland@arm.com
Subject: [rtc-linux] Re: [PATCH] rtc: ds1374: Add trickle charger device tree binding
Message-ID: <20170420155634.gs7qkufw7j4mfqpx@rob-hp-laptop>
References: <1492468810-17224-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1492468810-17224-1-git-send-email-mdf@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Apr 17, 2017 at 03:40:10PM -0700, Moritz Fischer wrote:
> Introduce a device tree binding for specifying the trickle charger
> configuration for ds1374. This is based on the code for ds13390.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  .../devicetree/bindings/rtc/dallas,ds1374.txt      | 18 ++++++++
>  drivers/rtc/rtc-ds1374.c                           | 54 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> new file mode 100644
> index 0000000..4cf5bd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> @@ -0,0 +1,18 @@
> +* Dallas DS1374		I2C Real-Time Clock / WDT

Please remove from trivial-devices.txt, too. (which is moving in 4.12 
BTW)

> +
> +Required properties:
> +- compatible: Should contain "dallas,ds1374".
> +- reg: I2C address for chip
> +
> +Optional properties:
> +- trickle-resistor-ohms : Selected resistor for trickle charger
> +	Values usable for ds1374 are 250, 2000, 4000
> +	Should be given if trickle charger should be enabled
> +- trickle-diode-disable : Do not use internal trickle charger diode
> +	Should be given if internal trickle charger diode should be disabled

These should have vendor prefix unless you think they are common.

> +Example:
> +	ds1374: rtc@0 {
> +		compatible = "dallas,ds1374";
> +		trickle-resistor-ohms = <250>;
> +		reg = <0>;
> +	};

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
