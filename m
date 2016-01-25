Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXU2TC2QKGQEWFBGZ3Q@googlegroups.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com. [2a00:1450:400c:c09::229])
        by gmr-mx.google.com with ESMTPS id s132si385458wmd.1.2016.01.25.03.56.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:56:13 -0800 (PST)
Received: by mail-wm0-x229.google.com with SMTP id u188so62458326wmu.1
        for <rtc-linux@googlegroups.com>; Mon, 25 Jan 2016 03:56:13 -0800 (PST)
Date: Mon, 25 Jan 2016 11:56:10 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	k.kozlowski@samsung.com, vreddytalla@nvidia.com
Subject: [rtc-linux] Re: [PATCH V4 1/5] DT: mfd: add device-tree binding doc
 fro PMIC max77620/max20024
Message-ID: <20160125115610.GC3368@x1>
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com>
 <1453198783-28383-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1453198783-28383-2-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 19 Jan 2016, Laxman Dewangan wrote:

> The MAXIM PMIC MAX77620 and MAX20024 are power management IC
> which supports RTC, GPIO, DCDC/LDO regulators, interrupt,
> watchdog etc.
>=20
> Add DT binding document for the different functionality of
> this device.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes from V1:=20
> - Added units in some of properties.
> - Change the boolean property to tristate type and detail some of
>   properties.
>=20
> Change from V2:
> - added unit in period related dt property.
>=20
> Change from V3: None
> Added Rob's ack.
>=20
>=20
>  Documentation/devicetree/bindings/mfd/max77620.txt | 397 +++++++++++++++=
++++++
>  include/dt-bindings/mfd/max77620.h                 |  38 ++
>  2 files changed, 435 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
>  create mode 100644 include/dt-bindings/mfd/max77620.h
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documen=
tation/devicetree/bindings/mfd/max77620.txt
> new file mode 100644
> index 0000000..46f6aac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -0,0 +1,397 @@
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

This is how interrupt-controllers usually work.  I don't think there
is any need to explain this.  I'd just link to
../interrupt-controller/interrupts.txt instead.

> +- #interrupt-cells: Should be set to 2 for IRQ number and flags.
> +  The first cell is the IRQ number. IRQ numbers for different interrupt
> +  source of MAX77620 are defined at dt-bindings/mfd/max77620.h
> +  The second cell is the flags, encoded as the trigger masks from bindin=
g
> +  document interrupts.txt, using dt-bindings/irq.

This is a very lengthy read for such little information.  Please make
it more succinct.  Take a look at other files for examples.  Also,
tell use where interrupts.txt is
i.e. ../interrupt-controller/interrupts.txt.

These are so much easier to read if you tab out from the property name
to the description.

- reg:				I2C device address.
- interrupt-controller: 	MAX77620 has internal interrupt controller which
  				takes the interrupt request from internal
				sub-blocks like RTC, regulators, GPIOs as well
				as external input.
- #interrupt-cells:		Should be set to 2 for IRQ number and flags.
				The first cell is the IRQ number. IRQ numbers
				for different interrupt source of MAX77620 are=20
				defined at dt-bindings/mfd/max77620.h
  				The second cell is the flags, encoded as the
				trigger masks from binding document
				interrupts.txt, using dt-bindings/irq.

... don't you think?

> +Optional properties:
> +-------------------
> +This device also supports the power OFF of system.

What is the "power OFF of system"?

> +Following properties are used for this purpose:
> +- system-power-controller: Boolean, This device will be use as

You don't describe the type of each property, so why is this one
special?

s/use/used/

> +	system power controller and used for power OFF of system.

Again, what is the "power OFF of system".  Find another example of
other people describing this well and copy/paste.

> +	Host issue necessary command to PMIC.

s/issue/issues/

> +Optional submodule and their properties:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

s/submodule/sub-modules/ ... or sub-modes even.

> +Flexible power sequence configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This sub-node configures the Flexible Power Sequnece(FPS) for power ON s=
lot,

s/Sequnece(FPS)/Sequnece (FPS)/

> +power OFF slot and slot period of the device. Device has 3 FPS as FPS0,
> +FPS1 and FPS2. The details of FPS configuration is provided through
> +subnode "fps". The details of FPS0, FPS1, FPS2 are provided through the
> +child node under this subnodes. The FPS number is provided via reg prope=
rty.
> +
> +The property for fps child nodes as:
> +Required properties:
> +	-reg: FPS number like 0, 1, 2 for FPS0, FPS1 and FPS2 respectively.

I'm surprised Rob Acked this.  We don't usually do device numbers in DT.

> +Optinal properties:

Spelling.

> +	-maxim,active-fps-time-period-us: Active state FPS time period in
> +		microseconds.
> +	-maxim,suspend-fps-time-period-us: Suspend state FPS time period in
> +		microseconds.
> +	-maxim,fps-enable-input: FPS enable source like EN0, EN1 or SW. The
> +			macros are defined on dt-bindings/mfd/max77620.h for
> +			different enable source.
> +				FPS_EN_SRC_EN0 for EN0 enable source.
> +				FPS_EN_SRC_EN1 for En1 enable source.
> +				FPS_EN_SRC_SW for SW based control.
> +	-maxim,fps-sw-enable: Boolean, applicable if enable input is SW.
> +			If this property present then enable the FPS else

"property is present"

If this enables/disables FPS, why does it matter if it's SW or not?
Why can't you just cal it maxim,fps-enable?  Also, is there a case
where you would supply this sub-node, have FPS enabled and this
property not present?  If not, can't you just remove the entire node?
Or am I missing something?

> +			disable FPS.
> +	-maxim,enable-sleep: Boolean, enable sleep when the external control
> +			goes from HIGH to LOW.
> +	-maxim,enable-global-lpm: Boolean, enable global LPM when the external

LPM?

> +			control goes from HIGH to LOW.

Please format these as I suggested above.

> +Here supported time periods by device in microseconds are as follows:
> +MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microsecond=
s.
> +MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
> +
> +Pinmux and GPIO:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think this whole section needs moving to ../pinctrl and needs to be
reviewed by Linus W.

> +Device has 8 GPIO pins which can be configured as GPIO as well as the
> +special IO functions.
> +
> +Please refer to pinctrl-bindings.txt for details of the common pinctrl
> +bindings used by client devices, including the meaning of the phrase
> +"pin configuration node".
> +
> +Following are properties which is needed if GPIO and pinmux functionalit=
y
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think this whole section needs moving to ../regulator and needs to be
reviewed by Mark B.

> +Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The node "regulator=
s"
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I think this whole section needs moving to ../power and needs to be
reviewed by Sebastian R.

> +This sub-node configure charging backup battery of the device. Device
> +has support of charging the backup battery. The subnode name is
> +"backup-battery".
> +
> +The property for backup-battery child nodes as:
> +Presense of this child node will enable the backup battery charging.
> +
> +Optinal properties:
> +	-maxim,bb-charging-current-microamp: Charging current
> +			setting.
> +			The device supports 50/100/200/400/600/800uA.
> +			If this property is unavailable then it will
> +			charge with 50uA.
> +	-maxim,bb-charging-voltage-microvolt: Charging Voltage Limit Setting.
> +			Device supports 2500000/3000000/3300000/350000uV.
> +			Default will be set to 2500mV. The voltage will be roundoff
> +			to nearest lower side if other than above is configured.
> +	-maxim,bb-output-resister-ohm: Output resistor on Ohm.
> +			Device supports 100/1000/3000/6000 Ohms.
> +
> +Low-Battery Monitor:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As above.

> +This sub-node configure low battery monitor configuration registers.
> +Device has support for low-battery monitor configuration through
> +child DT node "low-battery-monitor".
> +
> +Optinal properties:
> +	- maxim,low-battery-dac: Tristate, enable/disable low battery DAC.
> +			0 for disable,
> +			1 for enable,
> +			absence will left configuration to default.
> +	- maxim,low-battery-shutdown: Tristate, enable/disable low battery
> +		shutdown.
> +			0 for disable,
> +			1 for enable,
> +			absence will left configuration to default.
> +	- maxim,low-battery-reset: Tristate, enable/disable low battery reset.
> +			0 for disable,
> +			1 for enable,
> +			absence will left configuration to default.
> +
> +Example:
> +--------
> +#include <dt-bindings/mfd/max77620.h>
> +...
> +max77620@3c {
> +	compatible =3D "maxim,max77620";
> +	reg =3D <0x3c>;
> +
> +	interrupt-parent =3D <&intc>;
> +	interrupts =3D <0 86 IRQ_TYPE_NONE>;
> +
> +
> +Example:
> +--------
> +#include <dt-bindings/mfd/max77620.h>
> +...
> +max77620@3c {
> +	compatible =3D "maxim,max77620";
> +	reg =3D <0x3c>;
> +
> +	interrupt-parent =3D <&intc>;
> +	interrupts =3D <0 86 IRQ_TYPE_NONE>;
> +
> +	interrupt-controller;
> +	#interrupt-cells =3D <2>;
> +
> +	gpio-controller;
> +	#gpio-cells =3D <2>;
> +
> +	backup-battery {
> +		maxim,bb-charging-current-microamp =3D <100>;
> +		maxim,bb-charging-voltage-microvolt =3D <3000000>;
> +		maxim,bb-output-resister-ohm =3D <100>;
> +	};
> +
> +	fps {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		fps@0 {
> +			reg =3D <0>;
> +			maxim,fps-time-period-us =3D <1280>;
> +			maxim,fps-enable-input =3D <FPS_EN_SRC_EN0>;
> +		};
> +
> +		fps@1 {
> +			reg =3D <1>;
> +			maxim,fps-time-period-us =3D <2560>;
> +			maxim,fps-enable-input =3D <FPS_EN_SRC_EN1>;
> +		};
> +
> +		fps@2 {
> +			reg =3D <2>;
> +			maxim,fps-time-period-us =3D <640>;
> +			maxim,fps-enable-input =3D <FPS_EN_SRC_SW>;
> +		};
> +	};
> +
> +	regulators {
> +		in-ldo0-1-supply =3D <&max77620_sd2>;
> +		in-ldo7-8-supply =3D <&max77620_sd2>;
> +
> +		max77620_sd0: sd0 {
> +			regulator-name =3D "vdd-core";
> +			regulator-min-microvolt =3D <600000>;
> +			regulator-max-microvolt =3D <1400000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +			maxim,fps-source =3D <FPS_SRC_1>;
> +			regulator-init-mode =3D <REGULATOR_MODE_NORMAL>;
> +		};
> +
> +		max77620_sd1: sd1 {
> +			regulator-name =3D "vddio-ddr";
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-init-mode =3D <REGULATOR_MODE_NORMAL>;
> +			maxim,fps-source =3D <FPS_SRC_0>;
> +		};
> +
> +		max77620_sd2: sd2 {
> +			regulator-name =3D "vdd-pre-reg";
> +			regulator-min-microvolt =3D <1350000>;
> +			regulator-max-microvolt =3D <1350000>;
> +			maxim,fps-source =3D <FPS_SRC_1>;
> +		};
> +
> +		max77620_sd3: sd3 {
> +			regulator-name =3D "vdd-1v8";
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			maxim,fps-source =3D <FPS_SRC_0>;
> +			regulator-init-mode =3D <REGULATOR_MODE_NORMAL>;
> +		};
> +
> +		max77620_ldo0: ldo0 {
> +			regulator-name =3D "avdd-sys";
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +
> +		max77620_ldo1: ldo1 {
> +			regulator-name =3D "vdd-pex";
> +			regulator-min-microvolt =3D <1050000>;
> +			regulator-max-microvolt =3D <1050000>;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +
> +		max77620_ldo2: ldo2 {
> +			regulator-name =3D "vddio-sdmmc3";
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <3300000>;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +
> +		max77620_ldo3: ldo3 {
> +			regulator-name =3D "vdd-cam-hv";
> +			regulator-min-microvolt =3D <2800000>;
> +			regulator-max-microvolt =3D <2800000>;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +
> +		max77620_ldo4: ldo4 {
> +			regulator-name =3D "vdd-rtc";
> +			regulator-min-microvolt =3D <1250000>;
> +			regulator-max-microvolt =3D <1250000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			maxim,fps-source =3D <FPS_SRC_0>;
> +		};
> +
> +		max77620_ldo5: ldo5 {
> +			regulator-name =3D "avdd-ts-hv";
> +			regulator-min-microvolt =3D <3000000>;
> +			regulator-max-microvolt =3D <3000000>;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +
> +		max77620_ldo6: ldo6 {
> +			regulator-name =3D "vdd-ts";
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +
> +		max77620_ldo7: ldo7 {
> +			regulator-name =3D "vdd-gen-pll-edp";
> +			regulator-min-microvolt =3D <1050000>;
> +			regulator-max-microvolt =3D <1050000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			maxim,fps-source =3D <FPS_SRC_1>;
> +		};
> +
> +		max77620_ldo8: ldo8 {
> +			regulator-name =3D "vdd-hdmi-dp";
> +			regulator-min-microvolt =3D <1050000>;
> +			regulator-max-microvolt =3D <1050000>;
> +			maxim,fps-source =3D <FPS_SRC_NONE>;
> +		};
> +	};
> +};
> diff --git a/include/dt-bindings/mfd/max77620.h b/include/dt-bindings/mfd=
/max77620.h
> new file mode 100644
> index 0000000..8423d1d
> --- /dev/null
> +++ b/include/dt-bindings/mfd/max77620.h
> @@ -0,0 +1,38 @@
> +/*
> + * This header provides macros for MAXIM MAX77620 device bindings.
> + *
> + * Copyright (c) 2016, NVIDIA Corporation.
> + *
> + * Author: Laxman Dewangan <ldewangan@nvidia.com>
> + *

Remove this line.

> + */
> +
> +#ifndef _DT_BINDINGS_MFD_MAX77620_H
> +#define _DT_BINDINGS_MFD_MAX77620_H
> +
> +/* MAX77620 interrupts */
> +#define MAX77620_IRQ_TOP_GLBL		0 /* Low-Battery */
> +#define MAX77620_IRQ_TOP_SD		1 /* SD power fail */
> +#define MAX77620_IRQ_TOP_LDO		2 /* LDO power fail */
> +#define MAX77620_IRQ_TOP_GPIO		3 /* GPIO internal int to MAX77620 */
> +#define MAX77620_IRQ_TOP_RTC		4 /* RTC */
> +#define MAX77620_IRQ_TOP_32K		5 /* 32kHz oscillator */
> +#define MAX77620_IRQ_TOP_ONOFF		6 /* ON/OFF oscillator */
> +#define MAX77620_IRQ_LBT_MBATLOW	7 /* Thermal alarm status, > 120C */
> +#define MAX77620_IRQ_LBT_TJALRM1	8 /* Thermal alarm status, > 120C */
> +#define MAX77620_IRQ_LBT_TJALRM2	9 /* Thermal alarm status, > 140C */

> +/* FPS enable -inputs */
> +#define FPS_EN_SRC_EN0	0
> +#define FPS_EN_SRC_EN1	1
> +#define FPS_EN_SRC_SW	2
> +#define FPS_EN_SRC_RSVD	3
> +
> +/* FPS source */
> +#define FPS_SRC_0	0
> +#define FPS_SRC_1	1
> +#define FPS_SRC_2	2
> +#define FPS_SRC_NONE	3
> +#define FPS_SRC_DEF	4
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
