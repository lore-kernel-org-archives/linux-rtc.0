Return-Path: <rtc-linux+bncBDQ2L75W5QGBBWMDYO4AKGQEOIFV6AY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id tu5si4521911pab.2.2016.04.15.03.26.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 03:26:33 -0700 (PDT)
Date: Fri, 15 Apr 2016 11:26:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, mturquette@baylibre.com,
	sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	dianders@chromium.org, zyw@rock-chips.com, arnd@arndb.de,
	k.kozlowski@samsung.com, javier@osg.samsung.com, kgene@kernel.org,
	olof@lixom.net, geert+renesas@glider.be,
	sjoerd.simons@collabora.co.uk, treding@nvidia.com,
	public_timo.s@silentcreek.de
Message-ID: <20160415102602.GE3217@sirena.org.uk>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
 <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
In-Reply-To: <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
Subject: [rtc-linux] Re: [PATCH 3/6] regulator: rk808: Make rk808 generic,
 rename rk808-regulator.c
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Apr 15, 2016 at 11:16:27AM +0200, Wadim Egorov wrote:

> This patch just renames the rk808 driver so we can reuse this driver
> to add more regulator devices from the RK8XX PMIC family later.

We normally manage to cope fine without renaming things - it's quite
common to have drivers that were initially named after one part
supporting multiple parts, avoiding the rename makes things like
backports easier and avoids needing git log --follow and so on.

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXEMG4AAoJECTWi3JdVIfQcD4H/iNZDAZnA5uupiKQzJ3ydnUr
7WBWd+7jXep5mtHEPPJ1a3fhWpxKVC5FfUig6yx/7egaqZp7ZIcMrpC1Zd0adKcn
/sw4E6f2rsvJnWlcKgfyj00VwyEXLLUwUfnnijjTjtwYABONf7Pwlytg9f10IitR
kylwLCrgwxbBXtiGxEZPvYiIEEpxlG1BXWH2lKGbIIc35Z/zX3Sk2efoAQghz4Xa
agnA7tW63zfav6pePH/i6WwcZGdSXgdq0mHWr6HmVu/EleU9vqOzvLbtS4f/WlY5
Ly4XJCXU0cqEsBxKgSq6g616lRV2V6VZB9asr8OCEJ9VFS/AygHhfvRueYbO7G4=
=PHsG
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
