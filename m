Return-Path: <rtc-linux+bncBDJIP47K7MERBCWLS67AKGQEQ4WCOGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com. [209.85.218.68])
        by gmr-mx.google.com with ESMTPS id g4si1465103ith.2.2016.08.30.12.59.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 12:59:05 -0700 (PDT)
Received: by mail-oi0-f68.google.com with SMTP id b22so2743237oii.3
        for <rtc-linux@googlegroups.com>; Tue, 30 Aug 2016 12:59:05 -0700 (PDT)
Date: Tue, 30 Aug 2016 14:59:03 -0500
From: Rob Herring <robh@kernel.org>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>
Subject: [rtc-linux] Re: [PATCH v4] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160830195903.GA14471@rob-hp-laptop>
References: <20160825111912.23017-1-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160825111912.23017-1-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Aug 25, 2016 at 01:19:12PM +0200, Marcin Niestroj wrote:
> Support configuration of ext_wakeup sources. This patch makes it
> possible to enable ext_wakeup and set it's polarity, depending on board
> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> notify about power-button presses. Handling power-button presses enables
> to recover from RTC-only power states correctly.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Hi,
> 
> This is a total reimplementation, so it is not based on any of the previos
> patch versions. This patch adds support for ext_wakeup using generic pinconf
> device-tree bindings, with one added "ti,input-polarity" custom property.
> This approach has been suggested by Tony and Grygorii in [1].
> 
> Patch was developed on 4.6, rebased on 4.8-rc3, tested using chiliBoard.
> 
> [1] http://www.spinics.net/lists/devicetree/msg131516.html
> 
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  21 +++
>  drivers/rtc/Kconfig                                |   1 +
>  drivers/rtc/rtc-omap.c                             | 167 ++++++++++++++++++++-
>  3 files changed, 181 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index bf7d11a..5d18373 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -18,6 +18,18 @@ Optional properties:
>    through pmic_power_en
>  - clocks: Any internal or external clocks feeding in to rtc
>  - clock-names: Corresponding names of the clocks
> +- pinctrl-0: a phandle pointing to the pin settings for the device
> +- pinctrl-names: should be "default"
> +
> +Optional subnodes:
> +- generic pinctrl node
> +
> +Required pinctrl subnodes properties:
> +- pins - Names of ext_wakeup pins to configure
> +
> +Optional pinctrl subnodes properties:
> +- input-enable - Enables ext_wakeup
> +- ti,input-polarity - GPIO_ACTIVE_LOW or GPIO_ACTIVE_HIGH depending board

This is not a GPIO, so don't use GPIO defines. Just make this boolean 
with not present ideally being the more common case.

>  Example:
>  
> @@ -30,4 +42,13 @@ rtc@1c23000 {
>  	system-power-controller;
>  	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
>  	clock-names = "ext-clk", "int-clk";
> +
> +	pinctrl-0 = <&ext_wakeup>;
> +	pinctrl-names = "default";
> +
> +	ext_wakeup: ext_wakeup {

Use '-', not '_' in node names.

> +		pins = "ext_wakeup0";
> +		input-enable;
> +		ti,input-polarity = <GPIO_ACTIVE_LOW>;
> +	};
>  };

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
