Return-Path: <rtc-linux+bncBDA7X7F2WUEBB2UPYSWQKGQESYKMKEA@googlegroups.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com. [209.85.212.173])
        by gmr-mx.google.com with ESMTPS id q10si289771wiz.0.2015.07.23.08.27.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 08:27:38 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id ud3so224584958wib.0
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 08:27:38 -0700 (PDT)
Date: Thu, 23 Jul 2015 16:27:34 +0100
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
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V3 2/3] devicetree: da9062: Add device tree
 bindings for DA9062 RTC
Message-ID: <20150723152734.GO3436@x1>
References: <cover.1437474547.git.stwiss.opensource@diasemi.com>
 <f899992aaa9b5ea54cb2e27c1cabf626d5969c07.1437474547.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f899992aaa9b5ea54cb2e27c1cabf626d5969c07.1437474547.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 21 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add device tree bindings for the DA9062 RTC driver component
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  da9062.txt                total: 0 errors, 0 warnings, 88 lines checked
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documenta=
tion/devicetree/bindings/mfd/da9062.txt
> index 5765ed9..38802b5 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-device=
s:
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
>  da9062-regulator        :               : LDOs & BUCKs
> +da9062-rtc              :               : Real-Time Clock
>  da9062-watchdog         :               : Watchdog Timer
> =20
>  =3D=3D=3D=3D=3D=3D
> @@ -41,6 +42,10 @@ Sub-nodes:
>    Documentation/devicetree/bindings/regulator/regulator.txt
> =20
> =20
> +- rtc : This node defines settings required for the Real-Time Clock asso=
ciated
> +  with the DA9062. There are currently no entries in this binding, howev=
er
> +  compatible =3D "dlg,da9062-rtc" should be added if a node is created.
> +
>  - watchdog: This node defines the settings for the watchdog driver assoc=
iated
>    with the DA9062 PMIC. The compatible =3D "dlg,da9062-watchdog" should =
be added
>    if a node is created.
> @@ -55,6 +60,10 @@ Example:
>  		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-controller;
> =20
> +		rtc {
> +			compatible =3D "dlg,da9062-rtc";
> +		};
> +
>  		watchdog {
>  			compatible =3D "dlg,da9062-watchdog";
>  		};

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
