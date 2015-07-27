Return-Path: <rtc-linux+bncBCWZNOXQ7EDBBFXI3CWQKGQEBU5FFVQ@googlegroups.com>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com. [209.85.213.178])
        by gmr-mx.google.com with ESMTPS id rs3si735186igb.2.2015.07.27.06.37.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 06:37:26 -0700 (PDT)
Received: by mail-ig0-f178.google.com with SMTP id ij6so71736973igb.1
        for <rtc-linux@googlegroups.com>; Mon, 27 Jul 2015 06:37:26 -0700 (PDT)
Date: Mon, 27 Jul 2015 09:37:20 -0400
From: Matt Porter <mporter@konsulko.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com, joshc@ni.com
Subject: [rtc-linux] Re: [PATCH v3 2/2] doc: dt: add documentation for nxp,lpc1788-rtc
Message-ID: <20150727133720.GA15004@beef>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
 <1436635730-15617-3-git-send-email-manabian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436635730-15617-3-git-send-email-manabian@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, Jul 11, 2015 at 07:28:50PM +0200, Joachim Eastwood wrote:
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt     | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
> new file mode 100644
> index 000000000000..ad41a040432c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
> @@ -0,0 +1,21 @@
> +NXP LPC1788 real-time clock
> +
> +The LPC1788 RTC provides calendar and clock functionality
> +together with periodic tick and alarm interrupt support.
> +
> +Required properties:
> +- compatible	: must contain "nxp,lpc1788-rtc"
> +- reg		: Specifies base physical address and size of the registers.
> +- interrupts	: A single interrupt specifier.
> +- clocks	: Must contain entries for rtc and register clock

"Must contain clock specifiers for rtc and register clock" ?

-Matt

> +- clock-names	: Must contain "rtc" and "reg"
> +  See ../clocks/clock-bindings.txt for details.
> +
> +Example:
> +rtc: rtc@40046000 {
> +	compatible = "nxp,lpc1788-rtc";
> +	reg = <0x40046000 0x1000>;
> +	interrupts = <47>;
> +	clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
> +	clock-names = "rtc", "reg";
> +};

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
