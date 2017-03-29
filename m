Return-Path: <rtc-linux+bncBDJIP47K7MERBW4Z5TDAKGQEQMQZN2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com. [209.85.218.68])
        by gmr-mx.google.com with ESMTPS id 191si629125itj.0.2017.03.28.18.24.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 18:24:43 -0700 (PDT)
Received: by mail-oi0-f68.google.com with SMTP id b187so125830oif.3
        for <rtc-linux@googlegroups.com>; Tue, 28 Mar 2017 18:24:42 -0700 (PDT)
Date: Tue, 28 Mar 2017 20:24:41 -0500
From: Rob Herring <robh@kernel.org>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 2/7] rtc: Add rtc-sh
Message-ID: <20170329012441.bxnkyqui24mymuvr@rob-hp-laptop>
References: <20170322142754.30888-1-chris.brandt@renesas.com>
 <20170322142754.30888-3-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170322142754.30888-3-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Mar 22, 2017 at 10:27:49AM -0400, Chris Brandt wrote:
> rtc-sh is an RTC for SuperH and RZ/A SoCs.

Please work on the subject. It's a bit brief. "dt-bindings: rtc: " is 
the preferred prefix.

> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2:
> * added interrupt-names and clock-names
> * clocks now include counting sources
> * changed 'is a RTC' to 'is an RTC' in commit message
> ---
>  Documentation/devicetree/bindings/rtc/rtc-sh.txt | 29 ++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-sh.txt b/Documentation/devicetree/bindings/rtc/rtc-sh.txt
> new file mode 100644
> index 0000000..adbb8af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-sh.txt
> @@ -0,0 +1,29 @@
> +* Real Time Clock for Renesas SH and ARM SoCs
> +
> +Required properties:
> +- compatible: Should be "renesas,r7s72100-rtc" and "renesas,sh-rtc" as a
> +  fallback.
> +- reg: physical base address and length of memory mapped region.
> +- interrupts: 3 interrupts for alarm, period, and carry.
> +- interrupt-names: The interrupts should be labeled as "alarm", "period", and
> +  "carry".
> +- clocks: The functional clock source for the RTC controller must be listed
> +  first (if exists). Additionally, potential clock counting sources are to be
> +  listed.
> +- clock-names: The functional clock must be labeled as "fck". Other clocks
> +  may be named in accordance to the SoC hardware manuals.
> +
> +
> +Example:
> +rtc: rtc@fcff1000 {
> +	compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
> +	reg = <0xfcff1000 0x2e>;
> +	interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
> +		      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
> +		      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
> +	interrupt-names = "alarm", "period", "carry";
> +	clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
> +		 <&rtc_x3_clk>, <&extal_clk>;
> +	clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
> +	power-domains = <&cpg_clocks>;

Not documented.

Rob

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
