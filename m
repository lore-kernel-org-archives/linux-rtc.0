Return-Path: <rtc-linux+bncBDA7X7F2WUEBBREF3WWQKGQEJ4Y2P4I@googlegroups.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com. [209.85.212.176])
        by gmr-mx.google.com with ESMTPS id bk2si458564wib.1.2015.07.28.01.52.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 01:52:20 -0700 (PDT)
Received: by wibxm9 with SMTP id xm9so150205136wib.1
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 01:52:20 -0700 (PDT)
Date: Tue, 28 Jul 2015 09:52:16 +0100
From: Lee Jones <lee.jones@linaro.org>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V3 0/3]  da9062: Add DA9062 OnKey support
 using the existing DA9063 OnKey driver
Message-ID: <20150728085216.GP14943@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> From: S Twiss <stwiss.opensource@diasemi.com>

Steve,

Can you sort out your git configuration please.  Your name should be
represented in full.  No abbreviations or synonyms please.

I would expect to see: 'Steve Twiss <stwiss.opensource@diasemi.com>'

The mailer is less important, but I suggest 'Steve Twiss' would be
more professional than either 'S Twiss' or 'Opensource [Steve Twiss]'.

I appreciate it might be company policy, but is there any chance of
reversing that to read 'Steve Twiss [Opensource]' instead?

> This patch set adds OnKey support for the Dialog DA9062 Power Management =
IC.
> Changes are made to the existing DA9063 OnKey component so that functiona=
lity
> in this device driver can be re-used to support the DA9062 OnKey.
>=20
> This following patch set re-uses the existing kernel OnKey driver for chi=
ps
> whose OnKey blocks are functionally similar to the DA9063 OnKey.
>=20
> The main points for the MFD core and device tree changes are as follows.
>=20
> - Alteration of the DA9063 OnKey Kconfig needs to be updated to depend on
>   both MFD_DA9063 "or" MFD_DA9062. There is no explicit DA9062 OnKey Kcon=
fig.
> - The DA9062 MFD core should add a new OnKey resource as usual and an ent=
ry
>   in the mfd_cell to support a component name and of_compatible for
>   "da9062-onkey" and "dlg,da9062-onkey".
> - The device tree binding support should include a compatible string for
>   "dlg,da9062-onkey"
>=20
> The main points for the OnKey changes are as follows:
>=20
> A generic structure is used (called da906x_chip_config) to hold all gener=
ic
> registers and bitmasks for use with this type of OnKey component.
>=20
> Functions in the DA9063 OnKey will be refactored to use this compatibilit=
y
> struct and all accesses to generic registers/masks will be made through
> this table look-up instead of using defines from the register header file=
s
> directly
>=20
> Linkage between the DA9062 MFD and the DA9063 OnKey driver is created thr=
ough
> the use of an of_match_table entry in the platform_driver structure.
> A re-work of da9063_onkey_probe() is necessary to use the of_match_node()=
 and
> dev_get_regmap() functions: this will provide initialisation of the gener=
ic
> registers and masks and allow access to the regmap according to the corre=
ct
> device tree specification.
>=20
> The addition of a of_device_id table for DA9063 and DA9062 default data
> is created.=20
>=20
> In this patch set the following is provided:
>  - [PATCH V3 1/3]: MFD changes in DA9062 to support OnKey
>  - [PATCH V3 2/3]: Update existing DA9063 OnKey to add DA9062 support
>  - [PATCH V3 3/3]: Device tree bindings for DA9062 OnKey component
>=20
> This patch applies against linux-next and next-20150708=20
>=20
> Thank you,
> Steve Twiss, Dialog Semiconductor Ltd.
>=20
> S Twiss (3):
>   mfd: da9062: Support for the DA9063 OnKey in the DA9062 core
>   onkey: da9063: Add DA9062 OnKey capability to DA9063 OnKey driver
>   devicetree: da9062: Add device tree bindings for DA9062 OnKey
>=20
>  .../devicetree/bindings/input/da9062-onkey.txt     |  36 ++++++
>  Documentation/devicetree/bindings/mfd/da9062.txt   |   3 +
>  drivers/input/misc/Kconfig                         |   8 +-
>  drivers/input/misc/da9063_onkey.c                  | 129 +++++++++++++++=
++----
>  drivers/mfd/da9062-core.c                          |  11 ++
>  5 files changed, 158 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.=
txt
>=20

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
