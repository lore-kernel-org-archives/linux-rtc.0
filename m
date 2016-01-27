Return-Path: <rtc-linux+bncBDE6RCFOWIARBCFCUK2QKGQEYHIR2XI@googlegroups.com>
Received: from mail-oi0-x234.google.com (mail-oi0-x234.google.com. [2607:f8b0:4003:c06::234])
        by gmr-mx.google.com with ESMTPS id a1si374179igx.2.2016.01.27.01.42.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2016 01:42:31 -0800 (PST)
Received: by mail-oi0-x234.google.com with SMTP id r14so1975125oie.0
        for <rtc-linux@googlegroups.com>; Wed, 27 Jan 2016 01:42:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1452771166-13694-2-git-send-email-ldewangan@nvidia.com>
References: <1452771166-13694-1-git-send-email-ldewangan@nvidia.com>
	<1452771166-13694-2-git-send-email-ldewangan@nvidia.com>
Date: Wed, 27 Jan 2016 10:42:31 +0100
Message-ID: <CACRpkdbwnTRHUmHx+o238phQP6LrZr6kV-OjF2kcxd8rguT+4Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH V3 1/5] DT: mfd: add device-tree binding doc
 fro PMIC max77620/max20024
From: Linus Walleij <linus.walleij@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>, Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jan 14, 2016 at 12:32 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> +Flexible power sequence configuration
> +====================================
> +This sub-node configures the Flexible Power Sequnece(FPS) for power ON slot,
> +power OFF slot and slot period of the device. Device has 3 FPS as FPS0,
> +FPS1 and FPS2. The details of FPS configuration is provided through
> +subnode "fps". The details of FPS0, FPS1, FPS2 are provided through the
> +child node under this subnodes. The FPS number is provided via reg property.
> +
> +The property for fps child nodes as:
> +Required properties:
> +       -reg: FPS number like 0, 1, 2 for FPS0, FPS1 and FPS2 respectively.

This is ambitiously custom. Isn't power sequencing a generic problem?
The MMC subsystem has some power sequencing for example.

> +Optinal properties:
> +       -maxim,active-fps-time-period-us: Active state FPS time period in
> +               microseconds.
> +       -maxim,suspend-fps-time-period-us: Suspend state FPS time period in
> +               microseconds.

Define the "active state" and "suspend state" in the initial paragraph
under FPS so we can understand what these things are.

> +       -maxim,fps-enable-input: FPS enable source like EN0, EN1 or SW. The
> +                       macros are defined on dt-bindings/mfd/max77620.h for
> +                       different enable source.
> +                               FPS_EN_SRC_EN0 for EN0 enable source.
> +                               FPS_EN_SRC_EN1 for En1 enable source.
> +                               FPS_EN_SRC_SW for SW based control.

Is SW software? And EN0 and EN1 two different lines into the PMIC?
In that case describe that somewhere.

> +       -maxim,fps-sw-enable: Boolean, applicable if enable input is SW.
> +                       If this property present then enable the FPS else
> +                       disable FPS.
> +       -maxim,enable-sleep: Boolean, enable sleep when the external control
> +                       goes from HIGH to LOW.
> +       -maxim,enable-global-lpm: Boolean, enable global LPM when the external
> +                       control goes from HIGH to LOW.

First *what* is it that will sleep? The PMIC? The whole system? Or
does this simply mean that this will start the state machine? Elaborate.

This is confusing since for example there is a generic "wakeup-enable;"
property you can set on any device, therfore these things must be very
precisely defined.

What is "external control"? Is that a line into the PMIC?

> +    Optional properties:
> +    --------------------
> +       Following properties are require if pin control setting is required
> +       at boot.
> +       - pinctrl-names: A pinctrl state named "default" be defined, using
> +               the bindings in pinctrl/pinctrl-binding.txt.
> +       - pinctrl[0...n]: Properties to contain the phandle that refer to
> +               different nodes of pin control settings. These nodes
> +               represents the pin control setting of state 0 to state n.
> +               Each of these nodes contains different subnodes to
> +               represents some desired configuration for a list of pins.
> +               This configuration can include the mux function to select
> +               on those pin(s), and various pin configuration parameters,
> +               such as pull-up, open drain.
> +
> +               Each subnode have following properties:
> +               Required properties:
> +                   - pins: List of pins. Valid values of pins properties
> +                               are: gpio0, gpio1, gpio2, gpio3, gpio4,
> +                               gpio5, gpio6, gpio7
> +
> +               Optional properties:

Optional properties under optional properties?
This is getting confusing.

Write "Optional pin configurations"

> +                       function, drive-push-pull, drive-open-drain,
> +                       bias-pull-up, bias-pull-down.
> +                               Definitions are in the pinmux dt binding
> +                       devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +                       Absence of properties will leave the configuration
> +                       on default.

Thanks for using standardized bindings.

> +                       Valid values for function properties are:
> +                               gpio, lpm-control-in, fps-out, 32k-out,
> +                               sd0-dvs-in, sd1-dvs-in, reference-out
> +                       Theres is also customised property for the GPIO1,
> +                               GPIO2 and GPIO3.
> +                       - maxim,active-fps-source: FPS source for the gpios in
> +                               active state of the GPIO. Valid values are
> +                               FPS_SRC_0, FPS_SRC_1, FPS_SRC_2 and
> +                               FPS_SRC_NONE. Absence of this property will
> +                               leave the pin on default.


Define closer what an FPS source is. What is the effect on the pin?

> +                       - maxim,active-fps-power-up-slot: Power up slot on
> +                               given FPS for acive state.Valid values are 0
> +                               to 7.
> +                       - maxim,active-fps-power-down-slot: Power down slot
> +                               on given FPS for active state. Valid values
> +                               are 0 t  7.
> +                       - maxim,suspend-fps-source: Suspend state FPS source.
> +                       - maxim,suspend-fps-power-down-slot: Suspend state
> +                               power down slot.
> +                       - maxim,suspend-fps-power-up-slot: Suspend state power
> +                               up slot.


These two also have to be explained and connected back under the FPS
heading and explained. I guess it is impossible to understand this
without an accurate understanding of the FPS state machine, so provide
such a description in the document.

> +Low-Battery Monitor:
> +==================
> +This sub-node configure low battery monitor configuration registers.
> +Device has support for low-battery monitor configuration through
> +child DT node "low-battery-monitor".
> +
> +Optinal properties:
> +       - maxim,low-battery-dac: Tristate, enable/disable low battery DAC.
> +                       0 for disable,
> +                       1 for enable,
> +                       absence will left configuration to default.
> +       - maxim,low-battery-shutdown: Tristate, enable/disable low battery
> +               shutdown.
> +                       0 for disable,
> +                       1 for enable,
> +                       absence will left configuration to default.
> +       - maxim,low-battery-reset: Tristate, enable/disable low battery reset.
> +                       0 for disable,
> +                       1 for enable,
> +                       absence will left configuration to default.

I guess this should be reviewed by the drivers/power maintainers?
Added on the To: line.

Yours,
Linus Walleij

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
