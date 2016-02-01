Return-Path: <rtc-linux+bncBDA7X7F2WUEBBCV5XS2QKGQEP25DWKQ@googlegroups.com>
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com. [2a00:1450:400c:c09::236])
        by gmr-mx.google.com with ESMTPS id s132si268704wmd.1.2016.02.01.00.59.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 00:59:53 -0800 (PST)
Received: by mail-wm0-x236.google.com with SMTP id 128so59241300wmz.1
        for <rtc-linux@googlegroups.com>; Mon, 01 Feb 2016 00:59:53 -0800 (PST)
Date: Mon, 1 Feb 2016 08:59:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	k.kozlowski@samsung.com, Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V6 2/8] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160201085950.GA3368@x1>
References: <1453988274-28052-1-git-send-email-ldewangan@nvidia.com>
 <1453988274-28052-3-git-send-email-ldewangan@nvidia.com>
 <20160129090632.GS3368@x1>
 <56AB462A.8090307@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56AB462A.8090307@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 29 Jan 2016, Laxman Dewangan wrote:

> Thanks Lee for review.
> I will take care of most of stuff on next version of patch.
>=20
> However, I have some query form your comment.
> On Friday 29 January 2016 02:36 PM, Lee Jones wrote:
> >On Thu, 28 Jan 2016, Laxman Dewangan wrote:
> >
> >
> >>+	}
> >>+
> >>+#define MAX20024_SUB_MODULE_NO_RES(_name, _id)			\
> >>+	[_id] =3D {						\
> >>+		.name =3D "max20024-"#_name,			\
> >>+		.id =3D _id,					\
> >>+	}
> >I don't want people hand-rolling this stuff.  If it's useful to you,
> >it's useful to others, so great a generic implementation that lives in
> >the kernel headers directory.
>=20
> yaah, generic implementation possible. I can put the new defines in
> the mfd/core.h.
>=20
> This will be similar to
> +/* Define mfd cells with name and resource */
> +#define DEFINE_MFD_CELL_NAME_RESOURCE(_name, _res)             \
> +       {                                                       \
> +               .name =3D (_name),                                \
> +               .num_resources =3D ARRAY_SIZE((res)),             \
> +               .resources =3D (_res),                            \
> +       }
> +
> +/* Define mfd cells with name */
> +#define DEFINE_MFD_CELL_NAME(_name)                            \
> +       {                                                       \
> +               .name =3D (_name),                                \
> +       }
> +
>=20
> This will be separate patch and should be applied before this series.
> Does it look fine?

Hmm... Actually, I have my own ideas of how this should look.  How do
you feel about me submitting my own patch.  I'll keep you on Cc, so
you can review and make use of it in your set.

> >>+static const struct i2c_device_id max77620_id[] =3D {
> >>+	{"max77620", MAX77620},
> >>+	{"max20024", MAX20024},
> >>+	{},
> >>+};
> >>+MODULE_DEVICE_TABLE(i2c, max77620_id);
> >>+
> >>+static const struct of_device_id max77620_of_match[] =3D {
> >>+	{
> >>+		.compatible =3D "maxim,max77620",
> >>+		.data =3D &max77620_cells,
> >>+	}, {
> >>+		.compatible =3D "maxim,max20024",
> >>+		.data =3D &max20024_cells,
> >>+	}, {
> >>+	},
> >>+};
> >>+MODULE_DEVICE_TABLE(of, max77620_of_match);
> >This is not acceptable.  EITHER use DT OR MFD methods of registering
> >devices, do not mix the two.
>=20
> You mean I need to either provide the i2c_device_id table or the
> of_device_id table, not both?
> Do I need to protect it by CONFIG_OF?
>=20
> This only support the DT method of registration. So do I need to
> remove i2c_device_id?

No, I mean I don't want you providing platform data via an MFD cell
and passing it through the OF .data attribute.

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
