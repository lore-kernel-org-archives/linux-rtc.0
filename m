Return-Path: <rtc-linux+bncBDA7X7F2WUEBB6NFYOYQKGQEHSOWJEQ@googlegroups.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id cm6si1033993wib.1.2015.10.28.06.51.53
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 06:51:53 -0700 (PDT)
Received: by mail-wi0-x22e.google.com with SMTP id fv8so13446394wic.0
        for <rtc-linux@googlegroups.com>; Wed, 28 Oct 2015 06:51:53 -0700 (PDT)
Date: Wed, 28 Oct 2015 13:51:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: k.kozlowski.k@gmail.com, Alim Akhtar <alim.akhtar@samsung.com>,
	broonie@kernel.org, mturquette@baylibre.com,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Thomas Abraham <thomas.ab@samsung.com>
Subject: [rtc-linux] Re: [PATCH v3 2/5] mfd: sec: Add support for S2MPS15 PMIC
Message-ID: <20151028135149.GF4058@x1>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-3-git-send-email-alim.akhtar@samsung.com>
 <20151026143411.GL597@x1>
 <563021AF.6030100@samsung.com>
 <20151028084609.GG5828@x1>
 <5630D12C.2030008@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5630D12C.2030008@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:

> W dniu 28.10.2015 o 17:46, Lee Jones pisze:
> > On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:
> >=20
> >> On 26.10.2015 23:34, Lee Jones wrote:
> >>> On Mon, 26 Oct 2015, Alim Akhtar wrote:
> >>>
> >>>> From: Thomas Abraham <thomas.ab@samsung.com>
> >>>>
> >>>> Add support for S2MPS15 PMIC which is similar to S2MPS11 PMIC. The S=
2MPS15
> >>>> PMIC supports 27 LDO regulators, 10 buck regulators, RTC, three 32.7=
68KHz
> >>>> clock outputs and battery charger. This patch adds initial support f=
or
> >>>> LDO and buck regulators of S2MPS15 device.
> >>>>
> >>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> >>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> >>>> [Alim: Added s2mps15_devs like rtc and clk and related changes]
> >>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>>> ---
> >>>>  drivers/mfd/sec-core.c              |   31 +++++++
> >>>>  drivers/mfd/sec-irq.c               |    8 ++
> >>>>  include/linux/mfd/samsung/core.h    |    1 +
> >>>>  include/linux/mfd/samsung/s2mps15.h |  158 ++++++++++++++++++++++++=
+++++++++++
> >>>>  4 files changed, 198 insertions(+)
> >>>>  create mode 100644 include/linux/mfd/samsung/s2mps15.h
> >>>
> >>> I replied to the previous set and won't be reviewing this one until
> >>> all of the open points are solved.
> >>
> >> The naming and compatibles used by the driver are confusing but how it
> >> was at beginning. Beside the confusion, the names are correct:
> >>
> >> 1. Main mfd driver:
> >>  - compatible: samsung,s2mps1*-pmic
> >>  - driver name: sec_pmic
> >>
> >> 2. Regulator driver:
> >>  - no compatible (because it always searches for "regulators" subnode =
of
> >> its parent... that is the convention/legacy behaviour)
> >>  - driver name: s2mps1*-pmic
> >>
> >> I hope that explains your concerns.
> >=20
> > It explains *why*, but doesn't ease my concerns in any way.
> >=20
> > Unfortunately I've only just realised the disparity we have between
> > MFD and the Regulator subsystem, which is annoying because it's now
> > almost impossible to rectify. =20
> >=20
> > We should have taken one of two views.  Either a) The MFD is the PMIC
> > device which encompasses regulator control.  In which case the MFD
> > and it's corresponding compatible string would be named *-pmic and the
> > regulator driver would be called *-regulator. Or b) The MFD could be
> > considered a normal MFD and be named after the model number, then the
> > regulator 'could' be named *-pmic.
> >=20
> > However, with reference to b), how much other Power Management does
> > the regulator driver do besides control regulators?  I suspect not
> > much.  Therefore my preference would be for a).  My second choice
> > would be a mixuture of the two where nothing gets named *-pmic.  The
> > last option on my list would be the current situation where we seem to
> > be calling both the MFD (PMIC) itself and the Regulator driver
> > *-pmic, which is not good.
>=20
> Starting from the description of device-family. This is called "Power
> Management IC" but it is rather a "Power Deliver/Distribute IC". There
> isn't any logic inside except enable/disable/configure/set low power
> mode for regulators.
>=20
> However in the same time the IC comes (always) with:
>  - 32kHz clocks,
>  - RTC,
>  - backup battery charger (no driver for it),
>  - reset for SoC,
>  - shutdown on thermal alert (also no driver for this control).
>=20
> The solution a) seems fine to me. Make sense and it looks entirely
> backward compatible - only driver names will be modified.

Perfect solution from my PoV.

Thanks Krzysztof.

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
