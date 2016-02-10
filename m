Return-Path: <rtc-linux+bncBDA7X7F2WUEBBWPT5S2QKGQECDE2KMA@googlegroups.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com. [2a00:1450:400c:c09::229])
        by gmr-mx.google.com with ESMTPS id e130si544443wme.2.2016.02.10.05.23.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 05:23:36 -0800 (PST)
Received: by mail-wm0-x229.google.com with SMTP id p63so25995029wmp.1
        for <rtc-linux@googlegroups.com>; Wed, 10 Feb 2016 05:23:36 -0800 (PST)
Date: Wed, 10 Feb 2016 13:23:33 +0000
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
Subject: [rtc-linux] Re: [PATCH V7 1/8] mfd: add device-tree binding doc for
 PMIC max77620/max20024
Message-ID: <20160210132333.GG24522@x1>
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com>
 <1454171931-27752-2-git-send-email-ldewangan@nvidia.com>
 <20160209154215.GF24522@x1>
 <56BA2859.2040605@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56BA2859.2040605@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 09 Feb 2016, Laxman Dewangan wrote:

>=20
> On Tuesday 09 February 2016 09:12 PM, Lee Jones wrote:
> >On Sat, 30 Jan 2016, Laxman Dewangan wrote:
> >
> >+	Normal mode also called as active mode on which all step-down
> >+		regulators, all linear regulators, GPIOs, and the 32kHz
> >+		oscillator are in normal active mode.
> >+	sleep mode: Regulators/GPIOs/clock can go on OFF state based on
> >"can go on OFF state"?
>=20
> Regulator/GPIO has two states, enable and disable. If sleep mode is
> configured for these resource and external signal triggers to sleep
> then this get disabled.

It's the English that I'm unhappy with.

"can go on OFF state" doesn't sound right.

> >>+			source gets the control signal for ON and OFF.
> >>+	Power on slot: 	Slot number on which resource is ON once FPS source
> >>+			get ON signal.
> >Can you find another way of explaining this please?
>=20
> Hmm..
> Does it look fine:
> There is 8 slots for each FPS on which resource can get enabled.
> This property provides the slot number on which resource gets
> enabled after FPS sequence started.

It's a bit better, yes.  Although it's still a little difficult to
read.  In fact, I can't even recommend a suitable alternative, since I
still do not understand exactly what it is you're trying to say.

> >+
> >+-maxim,enable-sleep: 		    Boolean, enable sleep state of PMIC
> >We already have bindings for sleeping.  Please use a generic one.
>=20
> Which property? Saw sleep property with vendor prefix.

I guess there are too many '.*sleep.*' properties now, each with
slightly different syntax and meaning.  The situation is exacerbated
by one of the key examples is using the property with cells expected
i.e. non-bool.

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
