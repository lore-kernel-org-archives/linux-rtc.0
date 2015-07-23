Return-Path: <rtc-linux+bncBDA7X7F2WUEBBI4GYSWQKGQE53ESV3A@googlegroups.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com. [209.85.212.173])
        by gmr-mx.google.com with ESMTPS id bk2si266245wib.1.2015.07.23.08.07.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 08:07:14 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id ud3so28702870wib.1
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 08:07:14 -0700 (PDT)
Date: Thu, 23 Jul 2015 16:07:11 +0100
From: Lee Jones <lee.jones@linaro.org>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V2 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
Message-ID: <20150723150711.GI3436@x1>
References: <cover.1437399438.git.stwiss.opensource@diasemi.com>
 <f3630d64fd819832dc2d0925b49c1dca9b11644b.1437399438.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f3630d64fd819832dc2d0925b49c1dca9b11644b.1437399438.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 20 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add device tree bindings for the DA9062 OnKey driver component
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  da9062.txt                total: 0 errors, 0 warnings, 97 lines checked
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documenta=
tion/devicetree/bindings/mfd/da9062.txt
> index 5765ed9..7752093 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-device=
s:
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
>  da9062-regulator        :               : LDOs & BUCKs
> +da9062-onkey            :               : On Key
>  da9062-watchdog         :               : Watchdog Timer
> =20
>  =3D=3D=3D=3D=3D=3D
> @@ -41,6 +42,18 @@ Sub-nodes:
>    Documentation/devicetree/bindings/regulator/regulator.txt
> =20
> =20
> +- onkey : This node defines the OnKey settings for controlling the key
> +  functionality of the device. The node should contain the compatible pr=
operty
> +  with the value "dlg,da9063-onkey".
> +
> +  Optional onkey properties:
> +
> +  - dlg,disable-key-power : Disable power-down using a long key-press. I=
f this
> +    entry exists the OnKey driver will remove support for the KEY_POWER =
key
> +    press. If this entry does not exist then by default the key-press
> +    triggered power down is enabled and the OnKey will support both KEY_=
POWER
> +    and KEY_SLEEP.

Child driver specifics should be separated out into other SS'
documents, in this case ../input.

>  - watchdog: This node defines the settings for the watchdog driver assoc=
iated
>    with the DA9062 PMIC. The compatible =3D "dlg,da9062-watchdog" should =
be added
>    if a node is created.
> @@ -59,6 +72,11 @@ Example:
>  			compatible =3D "dlg,da9062-watchdog";
>  		};
> =20
> +		onkey {
> +			compatible =3D "dlg,da9063-onkey";
> +			dlg,disable-key-power;
> +		};
> +
>  		regulators {
>  			DA9062_BUCK1: buck1 {
>  				regulator-name =3D "BUCK1";

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
