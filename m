Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXER5C2QKGQEYEUHKQA@googlegroups.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id e130si415112wme.2.2016.02.09.07.42.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 07:42:20 -0800 (PST)
Received: by mail-wm0-x22b.google.com with SMTP id g62so28820917wme.0
        for <rtc-linux@googlegroups.com>; Tue, 09 Feb 2016 07:42:20 -0800 (PST)
Date: Tue, 9 Feb 2016 15:42:15 +0000
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
Subject: [rtc-linux] Re: [PATCH V7 1/8] mfd: add device-tree binding doc for
 PMIC max77620/max20024
Message-ID: <20160209154215.GF24522@x1>
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com>
 <1454171931-27752-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1454171931-27752-2-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, 30 Jan 2016, Laxman Dewangan wrote:

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
> Change from V2:=20
> - added unit in period related dt property.
>=20
> Change from V3: None
> - Added Rob's ack.
>=20
> Changes from V4:=20
> - A- Provide more details in the dt binding doc.
> - Take care of fps nodes.
> - Split the submodule's DT binding doc on respective folder.
> - Drop the battery charger and low battery binding and related code as
>   it need to go on power driver.
>=20
> Change from V5:
> - None
>=20
> Change from V6:
> -start the patch title with mfd instead of DT: mfd:
>=20
>  Documentation/devicetree/bindings/mfd/max77620.txt | 118 +++++++++++++++=
++++++
>  include/dt-bindings/mfd/max77620.h                 |  35 ++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
>  create mode 100644 include/dt-bindings/mfd/max77620.h
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documen=
tation/devicetree/bindings/mfd/max77620.txt
> new file mode 100644
> index 0000000..f258ce4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -0,0 +1,118 @@
> +MAX77620 Power management IC from Maxim Semiconductor.
> +
> +Required properties:
> +-------------------
> +- compatible: Must be one of
> +		"maxim,max77620"
> +		"maxim,max20024".
> +- reg: I2C device address.
> +
> +Optional properties:
> +-------------------
> +- interrupts:		the interrupt on the parent the controller is
> +			connected to

Nit: Sometimes you use full-stops and sometimes you don't.

> +- interrupt-controller: Marks the device node as an interrupt controller=
.
> +- #interrupt-cells:	is <2> and their usage is compliant to the 2 cells
> +			variant of <../interrupt-controller/interrupts.txt>
> +			IRQ numbers for different interrupt source of MAX77620
> +			are defined at dt-bindings/mfd/max77620.h.
> +
> +Optional subnodes and their properties:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Flexible power sequence configurations:
> +--------------------------------------
> +The PMIC has multiple control mode:

s/mode/modes/

> +	Normal mode also called as active mode on which all step-down
> +		regulators, all linear regulators, GPIOs, and the 32kHz
> +		oscillator are in normal active mode.
> +	sleep mode: Regulators/GPIOs/clock can go on OFF state based on

"can go on OFF state"?

> +		their configurations.
> +	Global Low power mode (GLPM): In this mode, step-down regulators, linea=
r
> +		regulators, and the 32kHz oscillator are in low-power modes.

Again, please standardise your formatting.  Sometimes you use
uppercase characters, sometimes you don't.  Sometimes you use ':'
after the mode, sometimes you don't.  Etc.

I suggest the following format would read better:

Normal mode:		Also called as active mode on which all step-down
			regulators, all linear regulators, GPIOs, and the 32kHz
			oscillator are in normal active mode.
Sleep mode:		Regulators/GPIOs/clock can go on OFF state based on
			their configurations.
Global Low Power mode:	In GLPM, step-down regulators, linear
			regulators, and the 32kHz oscillator are in low-power modes.

> +	Different modes of regulators/clock/GPIOs are controlled by the their
> +FPS configurations. There is different configuration registers for each =
of
> +these resources. Typical configurations per resource are:
> +	FPS source: 	Attach the resource to required FPS source. When
> +			resources are attached to one of FPS source then
> +			resournce can be enable/disable when related FPS

Have you used spell check?  I suggest you do.

> +			source gets the control signal for ON and OFF.
> +	Power on slot: 	Slot number on which resource is ON once FPS source
> +			get ON signal.

Can you find another way of explaining this please?

> +	Power down slot Slot number on which resource is OFF once FPS source

Please read what you wrote to see if it makes sense before
submitting.

> +			get OFF signal.
> +
> +There is three FPS source for resources called FPS0, FPS1 and FPS2. All

s/is/are/
s/source/sources/

> +resources need to attached to one of these FPS. It can alsoi be set

Please spell check the entire document.

> +FPS source to NONE, and on this case, it is completely controlled by

s/on/in/

> +the register control rather than external input control to PMIC.
> +
> +The configuration parameters of FPS is provided through subnode "fps"
> +and their child for FPS specific.
> +The node name for FPS child are defined as "fps0", "fps1", and "fps2" fo=
r
> +the FPS0, FPS1 and FPS2 respectively.
> +
> +There is need for different FPS configuration parameters based on system
> +state like when system state changed from active to suspend or active to
> +power off (shutdown).
> +
> +Optinal properties:
> +-------------------
> +-maxim,fps-control:	u32, FPS control source like external control input
> +			to PMIC i.e. EN0, EN1 or software (SW). The macros
> +			are defined on dt-bindings/mfd/max77620.h for
> +			different control source.
> +				FPS_CONTROL_SRC_EN0 for PMIC external input EN0.
> +				FPS_CONTROL_SRC_EN1 for PMIC external input EN1.
> +				FPS_CONTROL_SRC_SW for software control.
> +
> +-maxim,shutdown-fps-time-period-us: u32, FPS time period in microseconds
> +				    when system enters to shutdown state.
> +-maxim,suspend-fps-time-period-us:  u32, FPS time period in microseconds
> +				    when system enters to suspend state.
> +
> +-maxim,enable-sleep: 		    Boolean, enable sleep state of PMIC

We already have bindings for sleeping.  Please use a generic one.

> +				    when the FPS control input become active.
> +-maxim,enable-global-lpm: 	    Boolean, enable Global Low Power Mode (GL=
PM)
> +				    of PMIC when the FPS control input become
> +				    active.
> +
> +Here supported time periods by device in microseconds are as follows:
> +MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microsecond=
s.
> +MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
> +
> +For different sub modules like GPIO, pincontrol, regulator, power, pleas=
e refer
> +respected device-tree binding document on respective directories.
> +
> +Example:
> +--------
> +#include <dt-bindings/mfd/max77620.h>
> +
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
> +	fps {
> +		fps0 {
> +			maxim,shutdown-fps-time-period-us =3D <1280>;
> +			maxim,fps-control =3D <FPS_CONTROL_SRC_EN1>;
> +		};
> +
> +		fps1 {
> +			maxim,shutdown-fps-time-period-us =3D <1280>;
> +			maxim,fps-control =3D <FPS_CONTROL_SRC_EN0>;
> +		};
> +
> +		fps2 {
> +			maxim,shutdown-fps-time-period-us =3D <1280>;
> +			maxim,fps-control =3D <FPS_CONTROL_SRC_SW>;
> +		};
> +	};
> +};
> diff --git a/include/dt-bindings/mfd/max77620.h b/include/dt-bindings/mfd=
/max77620.h
> new file mode 100644
> index 0000000..1b571d7
> --- /dev/null
> +++ b/include/dt-bindings/mfd/max77620.h
> @@ -0,0 +1,35 @@
> +/*
> + * This header provides macros for MAXIM MAX77620 device bindings.
> + *
> + * Copyright (c) 2016, NVIDIA Corporation.
> + * Author: Laxman Dewangan <ldewangan@nvidia.com>
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
> +
> +/* FPS control inputs */
> +#define FPS_CONTROL_SRC_EN0		0
> +#define FPS_CONTROL_SRC_EN1		1
> +#define FPS_CONTROL_SRC_SW		2
> +
> +/* FPS source */
> +#define FPS_SRC_0			0
> +#define FPS_SRC_1			1
> +#define FPS_SRC_2			2
> +#define FPS_SRC_NONE			3
> +#define FPS_SRC_DEF			4
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
