Return-Path: <rtc-linux+bncBDHPTCWTXEHRBQUKQO4QKGQELM4SQUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id u137si583339wmd.1.2016.04.27.06.57.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 06:57:21 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Mark Brown <broonie@kernel.org>
Cc: Wadim Egorov <w.egorov@phytec.de>, linux-rockchip@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, a.zummo@towertech.it, pawel.moll@arm.com, rtc-linux@googlegroups.com, ijc+devicetree@hellion.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, alexandre.belloni@free-electrons.com, dianders@chromium.org, galak@codeaurora.org, zyw@rock-chips.com, lee.jones@linaro.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: Applied "regulator: rk808: remove linear range
 definitions with a single range" to the regulator tree
Date: Wed, 27 Apr 2016 15:56:56 +0200
Message-ID: <13413437.Ipf2eOczfj@diego>
In-Reply-To: <20160427135048.GQ3217@sirena.org.uk>
References: <E1aukkg-0007km-6s@debutante> <57205DC2.7070506@phytec.de> <20160427135048.GQ3217@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Am Mittwoch, 27. April 2016, 14:50:48 schrieb Mark Brown:
> On Wed, Apr 27, 2016 at 08:35:46AM +0200, Wadim Egorov wrote:
> > On 26.04.2016 21:33, Heiko St=C3=BCbner wrote:
> > > with this patch applied, 4.6.0-rc5-next-20160426 fails to boot on
> > > rk3288-veyron devices with the bug below. Reverting this one patch
> >=20
> > > results in the system booting again:
> > This is because I missed to add the correct ops for LDO_REG3 in this
> > patch.
>=20
> Any ETA on a fix or should I revert?

I guess
	[PATCH v4 1/7] regulator: rk808: Add rk808_reg_ops_ranges for LDO3
from yesterday [0] might be the fix? At least it fits Wadim's description a=
bove=20
but I haven't had time to test it yet.




[0] https://patchwork.kernel.org/patch/8939741/

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
