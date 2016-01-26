Return-Path: <rtc-linux+bncBDA7X7F2WUEBBM4TT22QKGQE46ZELUQ@googlegroups.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id h123si95325wmd.0.2016.01.26.06.58.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 06:58:59 -0800 (PST)
Received: by mail-wm0-x22f.google.com with SMTP id 123so109101569wmz.0
        for <rtc-linux@googlegroups.com>; Tue, 26 Jan 2016 06:58:59 -0800 (PST)
Date: Tue, 26 Jan 2016 14:58:54 +0000
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
Message-ID: <20160126145854.GC3368@x1>
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com>
 <1453198783-28383-2-git-send-email-ldewangan@nvidia.com>
 <20160125115610.GC3368@x1>
 <56A63A85.6060609@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56A63A85.6060609@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 25 Jan 2016, Laxman Dewangan wrote:

>=20
> Thanks Lee for your review. I will take care of most of comment on
> my next patch.
>=20
> I have reply on some comment and seeking more details for few
> comments as follows.
>=20
> On Monday 25 January 2016 05:26 PM, Lee Jones wrote:
> >On Tue, 19 Jan 2016, Laxman Dewangan wrote:
> >
> >>+- interrupt-controller: MAX77620 has internal interrupt controller whi=
ch
> >>+  takes the interrupt request from internal sub-blocks like RTC,
> >>+  regulators, GPIOs as well as external input.
> >This is how interrupt-controllers usually work.  I don't think there
> >is any need to explain this.  I'd just link to
> >../interrupt-controller/interrupts.txt instead.
>=20
> Something similar to (just to confirm)
> - interrupt-controller: describes the 88pm860x as an interrupt
> controller (has its own domain)

IRQ domains are Linuxisums, which aren't allowed in DT.

I'd prefer something along the lines of:

  "Identifies the node as an interrupt controller."

> >>+- #interrupt-cells: Should be set to 2 for IRQ number and flags.
> >>+  The first cell is the IRQ number. IRQ numbers for different interrup=
t
> >>+  source of MAX77620 are defined at dt-bindings/mfd/max77620.h
> >>+  The second cell is the flags, encoded as the trigger masks from bind=
ing
> >>+  document interrupts.txt, using dt-bindings/irq.
> >This is a very lengthy read for such little information.  Please make
> >it more succinct.  Take a look at other files for examples.
> I started with as3722.txt and it seems I am carrying forward the
> complexity here. Originally, as3722 is posted by me only. Any good
> file example which I can refer?

Just grep for #interrupt-cells in Documentation.  There are plenty of
nice, short examples.

> >  Also,
> >tell use where interrupts.txt is
> >i.e. ../interrupt-controller/interrupts.txt.
> >
> >These are so much easier to read if you tab out from the property name
> >to the description.
> >
> >- reg:				I2C device address.
> >- interrupt-controller: 	MAX77620 has internal interrupt controller whic=
h
> >   				takes the interrupt request from internal
> >				sub-blocks like RTC, regulators, GPIOs as well
> >				as external input.
> >- #interrupt-cells:		Should be set to 2 for IRQ number and flags.
> >				The first cell is the IRQ number. IRQ numbers
> >				for different interrupt source of MAX77620 are
> >				defined at dt-bindings/mfd/max77620.h
> >   				The second cell is the flags, encoded as the
> >				trigger masks from binding document
> >				interrupts.txt, using dt-bindings/irq.
> >
> >... don't you think?
>=20
> Agree, I can make indenting. And will do whatever places it needs in
> this document.
>=20
> >
> >>+Optional properties:
> >>+-------------------
> >>+This device also supports the power OFF of system.
> >What is the "power OFF of system"?
>=20
> PMIC supplies the power. So once PMIC is in OFF state, it turns off
> all its rail and hence no SW execution on system. Still external
> supply will keep supply to PMIC.

"This device controls platform power" or something.

> >>+Following properties are used for this purpose:
> >>+- system-power-controller: Boolean, This device will be use as
> >You don't describe the type of each property, so why is this one
> >special?
> Hmm. I describe the boolean and tristate only. Do I need to define
> type for integer,string also?

I wouldn't describe any of them.  It's normally pretty obvious which
properties are boolean by the lack of required cell description.

> >>+power OFF slot and slot period of the device. Device has 3 FPS as FPS0=
,
> >>+FPS1 and FPS2. The details of FPS configuration is provided through
> >>+subnode "fps". The details of FPS0, FPS1, FPS2 are provided through th=
e
> >>+child node under this subnodes. The FPS number is provided via reg pro=
perty.
> >>+
> >>+The property for fps child nodes as:
> >>+Required properties:
> >>+	-reg: FPS number like 0, 1, 2 for FPS0, FPS1 and FPS2 respectively.
> >I'm surprised Rob Acked this.  We don't usually do device numbers in DT.
> What is best way to make the child node for FPS and differentiate FPS0,1,=
 2?
> What is your suggestion here?

There are lots of ways you can solve this and so many examples of
others doing so.  I suggest you have a look at some DTS files and
figure it out.  One possible solution is to use different compatible
strings.

> >>+	-maxim,active-fps-time-period-us: Active state FPS time period in
> >>+		microseconds.
> >>+	-maxim,suspend-fps-time-period-us: Suspend state FPS time period in
> >>+		microseconds.
> >>+	-maxim,fps-enable-input: FPS enable source like EN0, EN1 or SW. The
> >>+			macros are defined on dt-bindings/mfd/max77620.h for
> >>+			different enable source.
> >>+				FPS_EN_SRC_EN0 for EN0 enable source.
> >>+				FPS_EN_SRC_EN1 for En1 enable source.
> >>+				FPS_EN_SRC_SW for SW based control.
> >>+	-maxim,fps-sw-enable: Boolean, applicable if enable input is SW.
> >>+			If this property present then enable the FPS else
> >"property is present"
> >
> >If this enables/disables FPS, why does it matter if it's SW or not?
> >Why can't you just cal it maxim,fps-enable?  Also, is there a case
> >where you would supply this sub-node, have FPS enabled and this
> >property not present?  If not, can't you just remove the entire node?
> >Or am I missing something?
>=20
> Here, my need is to connect different FPS source inputs EN0, EN1 or
> SW. They can connected to any inputs. That's why fps-enable-input
> select the related digital input for given FPS.
> However, I can reduce the need of "fps-sw-enable" and make this
> always enable if fps-enable-input=3D <SW>.

This is exactly how you need to think.  Reducing the number of
properties you introduce (and this device adds a lot more than I would
normally expect by the way) needs to be top priority.

> Here is excerpt from datasheet:
> B3:B1: SRCFPSx[1:0]
>     Enable Source. Specifies the enable source for the sequencer.
>         0b00=3DEN0 hardware input
>         0b01=3DEN1 hardware input
>         0b10=3DENFPSx software bit
>         0b11=3Dreserved
> B0 ENFPSx
>     Software Enable
>     0=3DDisable FPSx
>     1=3DEnable FPSx
>     X=3DENFPSx is a don=E2=80=99t care if SRCFPSx[1:0] !=3D 0b10
>=20
>=20
> >
> >>+	-maxim,enable-global-lpm: Boolean, enable global LPM when the externa=
l
> >LPM?
> Low Power Mode (LPM). I will add details.
>=20
> >+Pinmux and GPIO:
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >I think this whole section needs moving to ../pinctrl and needs to be
> >reviewed by Linus W.
>=20
> Is this mean I need to create DT binding doc for the each subsystem
> differently?
> Actually during AS3722, I had different understanding to have single file=
.

Yes, that way you have each of the the subsystem experts review your
documentation.  You can then link to them from this document.

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
