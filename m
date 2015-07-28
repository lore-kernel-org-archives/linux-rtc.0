Return-Path: <rtc-linux+bncBDA7X7F2WUEBBZEA3WWQKGQE3Q236LY@googlegroups.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com. [209.85.212.179])
        by gmr-mx.google.com with ESMTPS id ec7si498456wib.3.2015.07.28.01.42.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 01:42:11 -0700 (PDT)
Received: by wibud3 with SMTP id ud3so148708150wib.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 01:42:11 -0700 (PDT)
Date: Tue, 28 Jul 2015 09:42:07 +0100
From: Lee Jones <lee.jones@linaro.org>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V3 1/3] mfd: da9062: Support for the DA9063
 OnKey in the DA9062 core
Message-ID: <20150728084207.GO14943@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <983c3fe61ca732985f70c7d77bdb146860daf467.1437668261.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <983c3fe61ca732985f70c7d77bdb146860daf467.1437668261.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 23 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add MFD core driver support for a OnKey component
>=20
> - MFD core adds the resource da9062_onkey_resources[] for the OnKey
> - An appropriate value has been added into mfd_cell da9062_devs[] to
>   support component .name =3D "da9062-onkey" and
>   .of_compatible  =3D "dlg,da9062-onkey"
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> ---
> Changes in V3:
>  - Added Ack from Lee Jones
> Changes in V2:
>  - No change
>=20
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  drivers/mfd/da9062-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

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
