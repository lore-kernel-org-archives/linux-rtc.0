Return-Path: <rtc-linux+bncBDJIP47K7MERBRP3US5QKGQEP5ICOAQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-ob0-f195.google.com (mail-ob0-f195.google.com. [209.85.214.195])
        by gmr-mx.google.com with ESMTPS id o125si164263ith.3.2016.06.21.06.14.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 06:14:45 -0700 (PDT)
Received: by mail-ob0-f195.google.com with SMTP id f10so2678178obr.0
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 06:14:45 -0700 (PDT)
Date: Tue, 21 Jun 2016 08:14:43 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 2/8] mfd: ac100: Add device tree bindings
 for X-Powers AC100 codec/RTC combo IC
Message-ID: <20160621131443.GA29350@rob-hp-laptop>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-3-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466391138-12862-3-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jun 20, 2016 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v2:
> 
>   - Fix interrupt line for ac100_codec in provided example.
> 
> ---
>  Documentation/devicetree/bindings/mfd/ac100.txt | 42 +++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
> new file mode 100644
> index 000000000000..a793954bb952
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
> @@ -0,0 +1,42 @@
> +X-Powers AC100 Codec/RTC IC device tree bindings
> +
> +AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
> +separated, including power supplies and interrupt lines, but share
> +a common register address space and host interface.
> +
> +Required properties:
> +- compatible: "x-powers,ac100"
> +- reg: The I2C slave address or RSB hardware address for the chip
> +- sub-nodes:
> +  - codec
> +    - compatible: "x-powers,ac100-codec"
> +    - interrupt-parent: The parent interrupt controller
> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO pin
> +  - rtc
> +    - compatible: "x-powers,ac100-rtc"
> +    - interrupt-parent: The parent interrupt controller
> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
> +    - #clock-cells: shall be 1
> +    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
> +    - see clock/clock-bindings.txt for common clock bindings
> +
> +Example:
> +
> +ac100: codec@e89 {
> +	compatible = "x-powers,ac100";
> +	reg = <0xe89>;
> +
> +	ac100_codec {

Use generic node names and no underscores:

codec {

> +		compatible = "x-powers,ac100-codec";
> +		interrupt-parent = <&r_pio>;
> +		interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
> +	};
> +
> +	ac100_rtc {

rtc {

> +		compatible = "x-powers,ac100-rtc";
> +		interrupt-parent = <&nmi_intc>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
> +	};
> +};
> -- 
> 2.8.1
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
