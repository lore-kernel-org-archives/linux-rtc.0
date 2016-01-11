Return-Path: <rtc-linux+bncBDA7X7F2WUEBBNUEZW2AKGQECPD53YA@googlegroups.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id v7si204532wmg.3.2016.01.10.21.48.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 21:48:38 -0800 (PST)
Received: by mail-wm0-x233.google.com with SMTP id f206so199072236wmf.0
        for <rtc-linux@googlegroups.com>; Sun, 10 Jan 2016 21:48:38 -0800 (PST)
Date: Mon, 11 Jan 2016 05:48:35 +0000
From: Lee Jones <lee.jones@linaro.org>
To: kbuild test robot <lkp@intel.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, kbuild-all@01.org,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160111054835.GC3331@x1>
References: <1452177524-23192-3-git-send-email-ldewangan@nvidia.com>
 <201601072308.7XP0yi7D%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <201601072308.7XP0yi7D%fengguang.wu@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 07 Jan 2016, kbuild test robot wrote:

> Hi Laxman,
>=20
> [auto build test WARNING on pinctrl/for-next]
> [also build test WARNING on v4.4-rc8 next-20160107]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improving the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Laxman-Dewangan/Add-supp=
ort-for-MAXIM-MAX77620-MAX20024-PMIC/20160107-225450
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinc=
trl.git for-next
>=20
>=20
> coccinelle warnings: (new ones prefixed by >>)
>=20
> >> drivers/mfd/max77620.c:900:3-8: No need to set .owner here. The core w=
ill do it.

I can't accept this patch until this has been taken care of.

> Please review and possibly fold the followup patch.
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

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
