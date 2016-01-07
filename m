Return-Path: <rtc-linux+bncBDJIP47K7MERB57BXO2AKGQEXBY5QHY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id h86si11295pfd.0.2016.01.07.15.12.55
        for <rtc-linux@googlegroups.com>;
        Thu, 07 Jan 2016 15:12:55 -0800 (PST)
Date: Thu, 7 Jan 2016 17:12:49 -0600
From: Rob Herring <robh@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com
Subject: [rtc-linux] Re: [PATCH 1/6] DT: mfd: add device-tree binding doc fro
 PMIC max77620/max20024
Message-ID: <20160107231249.GA17514@rob-hp-laptop>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1452177524-23192-2-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jan 07, 2016 at 08:08:39PM +0530, Laxman Dewangan wrote:
> The MAXIM PMIC MAX77620 and MAX20024 are power management IC
> which supports RTC, GPIO, DCDC/LDO regulators, interrupt,
> watchdog etc.
> 
> Add DT binding document for the different functionality of
> this device.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77620.txt | 383 +++++++++++++++++++++
>  include/dt-bindings/mfd/max77620.h                 |  38 ++
>  2 files changed, 421 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
>  create mode 100644 include/dt-bindings/mfd/max77620.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> new file mode 100644
> index 0000000..09cff4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -0,0 +1,383 @@
> +* MAX77620 Power management IC from Maxim Semiconductor.
> +
> +Required properties:
> +-------------------
> +- compatible: Must be one of
> +		"maxim,max77620" or
> +		"maxim,max20024".
> +- reg: I2C device address.
> +- interrupt-controller: MAX77620 has internal interrupt controller which
> +  takes the interrupt request from internal sub-blocks like RTC,
> +  regulators, GPIOs as well as external input.
> +- #interrupt-cells: Should be set to 2 for IRQ number and flags.
> +  The first cell is the IRQ number. IRQ numbers for different interrupt
> +  source of MAX77620 are defined at dt-bindings/mfd/max77620.h
> +  The second cell is the flags, encoded as the trigger masks from binding
> +  document interrupts.txt, using dt-bindings/irq.
> +
> +Optional properties:
> +-------------------
> +This device also supports the power OFF of system.
> +Following properties are used for this purpose:
> +- system-power-controller: Boolean, This device will be use as
> +	system power controller and used for power OFF of system.
> +	Host issue necessary command to PMIC.
> +
> +
> +Optional submodule and their properties:
> +=======================================
> +
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
> +	-reg: FPS number like 0, 1, 2 for FPS0, FPS1 and FPS2 respectively.
> +Optinal properties:
> +	-maxim,active-fps-time-period: Active state FPS time period.
> +	-maxim,suspend-fps-time-period: Suspend state FPS time period.

What are the units?

> +	-maxim,fps-enable-input: FPS enable source like EN0, EN1 or SW. The
> +			macros are defined on dt-bindings/mfd/max77620.h for
> +			different enable source.
> +				FPS_EN_SRC_EN0 for EN0 enable source.
> +				FPS_EN_SRC_EN1 for En1 enable source.
> +				FPS_EN_SRC_SW for SW based control.
> +	-maxim,fps-sw-enable: Boolean, applicable if enable input is SW.
> +			If this property present then enable the FPS else
> +			disable FPS.
> +	-maxim,enable-sleep: Enable sleep when the external control goes from
> +			HIGH to LOW.

Boolean?

> +	-maxim,enable-global-lpm: Enable global LPM when the external control
> +			goes from HIGH to LOW.

Boolean?

> +
> +Pinmux and GPIO:
> +===============
> +Device has 8 GPIO pins which can be configured as GPIO as well as the
> +special IO functions.
> +
> +Please refer to pinctrl-bindings.txt for details of the common pinctrl
> +bindings used by client devices, including the meaning of the phrase
> +"pin configuration node".
> +
> +Following are properties which is needed if GPIO and pinmux functionality
> +is required:
> +    Required properties:
> +    -------------------
> +	- gpio-controller: Marks the device node as a GPIO controller.
> +	- #gpio-cells: Number of GPIO cells. Refer to binding document
> +			gpio/gpio.txt
> +
> +    Optional properties:
> +    --------------------
> +	Following properties are require if pin control setting is required
> +	at boot.
> +	- pinctrl-names: A pinctrl state named "default" be defined, using
> +		the bindings in pinctrl/pinctrl-binding.txt.
> +	- pinctrl[0...n]: Properties to contain the phandle that refer to
> +		different nodes of pin control settings. These nodes
> +		represents the pin control setting of state 0 to state n.
> +		Each of these nodes contains different subnodes to
> +		represents some desired configuration for a list of pins.
> +		This configuration can include the mux function to select
> +		on those pin(s), and various pin configuration parameters,
> +		such as pull-up, open drain.
> +
> +		Each subnode have following properties:
> +		Required properties:
> +		    - pins: List of pins. Valid values of pins properties
> +				are: gpio0, gpio1, gpio2, gpio3, gpio4,
> +				gpio5, gpio6, gpio7
> +
> +		Optional properties:
> +			function, drive-push-pull, drive-open-drain,
> +			bias-pull-up, bias-pull-down.
> +				Definitions are in the pinmux dt binding
> +			devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +			Absence of properties will leave the configuration
> +			on default.
> +
> +			Valid values for function properties are:
> +				gpio, lpm-control-in, fps-out, 32k-out,
> +				sd0-dvs-in, sd1-dvs-in, reference-out
> +			Theres is also customised property for the GPIO1,
> +				GPIO2 and GPIO3.
> +			- maxim,active-fps-source: FPS source for the gpios in
> +				active state of the GPIO. Valid values are
> +				FPS_SRC_0, FPS_SRC_1, FPS_SRC_2 and
> +				FPS_SRC_NONE. Absence of this property will
> +				leave the pin on default.
> +			- maxim,active-fps-power-up-slot: Power up slot on
> +				given FPS for acive state.Valid values are 0
> +				to 7.
> +			- maxim,active-fps-power-down-slot: Power down slot
> +				on given FPS for active state. Valid values
> +				are 0 t  7.
> +			- maxim,suspend-fps-source: Suspend state FPS source.
> +			- maxim,suspend-fps-power-down-slot: Suspend state
> +				power down slot.
> +			- maxim,suspend-fps-power-up-slot: Suspend state power
> +				up slot.
> +
> +Regulators:
> +===========
> +Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The node "regulators"
> +is require if regulator functionality is needed.
> +
> +Following are properties of regulator subnode.
> +
> +    Optional properties:
> +    -------------------
> +	The input supply of regulators are the optional properties on the
> +	regulator node. The input supply of these regulators are provided
> +	through following properties:
> +		in-sd0-supply: Input supply for SD0, INA-SD0 or INB-SD0 pins.
> +		in-sd1-supply: Input supply for SD1.
> +		in-sd2-supply: Input supply for SD2.
> +		in-sd3-supply: Input supply for SD3.
> +		in-ldo0-1-supply: Input supply for LDO0 and LDO1.
> +		in-ldo2-supply: Input supply for LDO2.
> +		in-ldo3-5-supply: Input supply for LDO3 and LDO5
> +		in-ldo4-6-supply: Input supply for LDO4 and LDO6.
> +		in-ldo7-8-supply: Input supply for LDO7 and LDO8.
> +
> +
> +    Optional sub nodes for regulators:
> +    ---------------------------------
> +	The subnodes name is the name of regulator and it must be one of:
> +	sd[0-3], ldo[0-8]
> +
> +	Each sub-node should contain the constraints and initialization
> +	information for that regulator. See regulator.txt for a description
> +	of standard properties for these sub-nodes.
> +	Additional optional custom properties  are listed below.
> +		maxim,active-fps-source: FPS source. The macros are defined at
> +			dt-bindings/mfd/max77620.h
> +		maxim,shutdown-fps-source: Same as maxim,fps-source, but it
> +			will apply during shutdown of system.
> +		maxim,active-fps-power-up-slot: Active state Power up slot for
> +			rail on given FPS.
> +		maxim,active-fps-power-down-slot: Active state Power down slot
> +			for rail on given FPS.
> +		maxim,suspend-fps-source: Suspend state FPS source of rail.
> +		maxim,suspend-fps-power-up-slot: Suspend state FPS power
> +			up slot.
> +		maxim,suspend-fps-power-down-slot: Suspend state FPS power
> +			down slot.
> +		maxim,enable-group-low-power: Enable Group low power mode.
> +		maxim,enable-sd0-en2-control: Enable EN2 pincontrol for SD0.
> +			This property is only applicable for SD0.
> +		maxim,disable-remote-sense-on-suspend: Boolean, disable
> +			remote sense on suspend and re-enable on resume.
> +			If this property is not there then no change on
> +			configuration.
> +
> +Backup Battery:
> +==============
> +This sub-node configure charging backup battery of the device. Device
> +has support of charging the backup battery. The subnode name is
> +"backup-battery".
> +
> +The property for backup-battery child nodes as:
> +Presense of this child node will enable the backup battery charging.
> +
> +Optinal properties:
> +	-maxim,backup-battery-charging-current: Charging current setting.
> +			The device supports 50/100/200/400/600/800uA.
> +			If this property is unavailable then it will
> +			charge with 50uA.

Add units suffix (-microamp).

> +	-maxim,backup-battery-charging-voltage: Charging Voltage Limit Setting.
> +			Device supports 2500000/3000000/3300000/350000uV.
> +			Default will be set to 2500mV. The voltage will be roundoff
> +			to nearest lower side if other than above is configured.

Add units suffix (-microvolt).

> +	-maxim,backup-battery-output-resister: Output resistor on Ohm.
> +			Device supports 100/1000/3000/6000 Ohms.

Add units suffix.

> +
> +Low-Battery Monitor:
> +==================
> +This sub-node configure low battery monitor configuration registers.
> +Device has support for low-battery monitor configuration through
> +child DT node "low-battery-monitor".
> +
> +Optinal properties:
> +	- maxim,low-battery-dac-enable: Enable low battery DAC.
> +	- maxim,low-battery-dac-disable: Disable low battery DAC.
> +	- maxim,low-battery-shutdown-enable: Enable low battery shutdown.
> +	- maxim,low-battery-shutdown-disable: Disable low battery shutdown.
> +	- maxim,low-battery-reset-enable: Enable low battery reset.
> +	- maxim,low-battery-reset-disable: Disable low battery reset.

Why not boolean? Not present means keep default value? I'd prefer 
boolean or tristate of not present, 0 to disable, or 1 to enable.

Rob

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
