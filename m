Return-Path: <rtc-linux+bncBDA7X7F2WUEBBHWUY64QKGQEHMQJUYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id a124si120348wme.0.2016.05.10.07.03.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:03:10 -0700 (PDT)
Received: by mail-wm0-x231.google.com with SMTP id g17so29814376wme.1
        for <rtc-linux@googlegroups.com>; Tue, 10 May 2016 07:03:10 -0700 (PDT)
Date: Tue, 10 May 2016 15:03:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org,
	lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com
Subject: [rtc-linux] Re: [PATCH v5 3/6] regulator: rk808: Add regulator driver
 for RK818
Message-ID: <20160510140320.GO19473@dell>
References: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
 <1462886340-7893-4-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462886340-7893-4-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 10 May 2016, Wadim Egorov wrote:

> Add support for the rk818 regulator. The regulator module consists
> of 4 DCDCs, 9 LDOs, 1 switch and 1 BOOST converter which is used to
> power OTG and HDMI5V.
>=20
> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  drivers/regulator/Kconfig           |   4 +-
>  drivers/regulator/rk808-regulator.c | 143 ++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 138 insertions(+), 9 deletions(-)

Needs an Ack before I can take the set.

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
