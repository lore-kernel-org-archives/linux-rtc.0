Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXU54W5AKGQEF6LZG4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id f142si920747wmf.3.2016.06.09.04.11.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 04:11:26 -0700 (PDT)
Received: by mail-wm0-x235.google.com with SMTP id k184so22126761wme.1
        for <rtc-linux@googlegroups.com>; Thu, 09 Jun 2016 04:11:26 -0700 (PDT)
Date: Thu, 9 Jun 2016 12:12:01 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com
Subject: [rtc-linux] Re: [RESEND PATCH v5 1/5] mfd: RK808: Add RK818 support
Message-ID: <20160609111201.GA1388@dell>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <20160608141735.GE14888@dell>
 <5759277D.7090101@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5759277D.7090101@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 09 Jun 2016, Wadim Egorov wrote:
> On 08.06.2016 16:17, Lee Jones wrote:
> > On Thu, 02 Jun 2016, Wadim Egorov wrote:
> >
> >> The RK818 chip is a power management IC for multimedia and handheld
> > "Power Management IC (PMIC)"
> >
> >> devices. It contains the following components:
> >>
> >> - Regulators
> >> - RTC
> >> - Clkout
> > Clocking
> >
> >> - battery support
> > Battery support
> >
> >> Both chips RK808 and RK818 are using a similar register map.
> > "Both RK808 ad RK818 chips"
> >
> >> So we can reuse the RTC and Clkout functionality.
> > Swap '.' for ','.
> >
> >> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> >> ---
> >>  drivers/mfd/Kconfig       |   4 +-
> >>  drivers/mfd/rk808.c       | 231 +++++++++++++++++++++++++++++++++++++=
+--------
> >>  include/linux/mfd/rk808.h | 162 ++++++++++++++++++++++++++++++--
> >>  3 files changed, 350 insertions(+), 47 deletions(-)

[...]

> >> -struct rk808_reg_data {
> >> -	int addr;
> >> -	int mask;
> >> -	int value;
> >> -};
> > Why are you moving this to the header?
>=20
> It is now part of the rk808 struct.

Why?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
