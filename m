Return-Path: <rtc-linux+bncBDA7X7F2WUEBBM7P462QKGQE2X57YRA@googlegroups.com>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com. [2a00:1450:400c:c09::234])
        by gmr-mx.google.com with ESMTPS id h73si411906wme.0.2016.02.09.06.29.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 06:29:07 -0800 (PST)
Received: by mail-wm0-x234.google.com with SMTP id p63so25430057wmp.1
        for <rtc-linux@googlegroups.com>; Tue, 09 Feb 2016 06:29:07 -0800 (PST)
Date: Tue, 9 Feb 2016 14:29:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	vreddytalla@nvidia.com, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [rtc-linux] [PATCH V7 5/8] gpio: add DT binding doc for gpio of
 PMIC max77620/max20024
Message-ID: <20160209142903.GE24522@x1>
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com>
 <1454171931-27752-6-git-send-email-ldewangan@nvidia.com>
 <CACRpkdYNBHvefR_qdjZ7hWr=cFzhv1gEgb5jBCrqHdWzNWgV6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CACRpkdYNBHvefR_qdjZ7hWr=cFzhv1gEgb5jBCrqHdWzNWgV6w@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 05 Feb 2016, Linus Walleij wrote:

> On Sat, Jan 30, 2016 at 5:38 PM, Laxman Dewangan <ldewangan@nvidia.com> w=
rote:
>=20
> > Maxim Semiconductor's PMIC MAX77620/MAX20024 has 8 GPIO pins
> > which act as GPIO as well as special function mode.
> >
> > Add DT binding document to support these pins in GPIO
> > mode via GPIO framework.
> >
> > Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> > Acked-by: Rob Herring <robh@kernel.org>
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Lee can merge this too.

Ths set needs a re-work anyway.

Laxman, just apply your collected Acks and re-submit when you're
ready.

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
