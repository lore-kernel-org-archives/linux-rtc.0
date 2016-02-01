Return-Path: <rtc-linux+bncBDA7X7F2WUEBBM56XS2QKGQEJVH4JWQ@googlegroups.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id w129si223755wme.1.2016.02.01.01.02.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 01:02:42 -0800 (PST)
Received: by mail-wm0-x22b.google.com with SMTP id l66so58944007wml.0
        for <rtc-linux@googlegroups.com>; Mon, 01 Feb 2016 01:02:42 -0800 (PST)
Date: Mon, 1 Feb 2016 09:02:39 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	k.kozlowski@samsung.com, vreddytalla@nvidia.com,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V7 2/8] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160201090239.GB3368@x1>
References: <201601310157.sKXyINX7%fengguang.wu@intel.com>
 <56ACEEE1.1050800@nvidia.com>
 <20160201082553.GW3368@x1>
 <56AF17D6.2090106@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56AF17D6.2090106@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 01 Feb 2016, Laxman Dewangan wrote:

>=20
> On Monday 01 February 2016 01:55 PM, Lee Jones wrote:
> >On Sat, 30 Jan 2016, Laxman Dewangan wrote:
> >
> >>This depends on patch
> >>[PATCH V2] mfd: core: add macro for adding mfd cells
> >>
> >>and due to absence of this patch, it reports the error.
> >If you have dependencies, why aren't they in this set?
> >
>=20
> This change is not related to the series as such and so independent.
> I just thought that mentioning on commit log will be fine here. May
> be I missed some points here.

If you have patches which use/depend on it, then it's not so
independent, right?

> Let me know if I need to add this to back on series.
=20
In order to avoid any mishaps, that would be preferable, yes.

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
