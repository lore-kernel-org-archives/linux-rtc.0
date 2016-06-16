Return-Path: <rtc-linux+bncBDSJBYGBRIMBBZF7RG5QKGQEFSZIOIY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x203si482929wme.0.2016.06.16.01.14.28
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Jun 2016 01:14:28 -0700 (PDT)
Date: Thu, 16 Jun 2016 10:14:27 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 09/10] ARM: dts: sun9i: a80-optimus: Order
 nodes by alphabetical order
Message-ID: <20160616081427.GG5144@lukather>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-10-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
In-Reply-To: <1465986467-14802-10-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jun 15, 2016 at 06:27:46PM +0800, Chen-Yu Tsai wrote:
> Move the mmc nodes above the ohci nodes for proper ordering by name.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXYl/jAAoJEBx+YmzsjxAgd1MP/idSUAw5syl9OYAtiKeJ7RNr
W9AUz+wc0pHjra9Ui7Y8TDXtRYOKnw15lSpw1KCIXCSfFUV+zfc/vZH0Ed8NPeAr
RSb2zR6D+YEMf+oOGJbD+AM/9GxzuaCqiHBh93rOeeWo0sa31ns2wIdD2DInJRU1
MasoUVWkgGDA2F/p5cbj70UPiIjjahRgk8Tk4VRKfgBFCeLEsZMkUKi48EjqCrCn
zibYKucH3v1qKgzI2Gd3557xzpewiO8Pdf2KHiwzDqmL9DTcfyXpoNG7bTUXJmRd
hWj5RqZEfngNPaIr+MtmsrYZf4JV4Nbq2joHIvpBwRxLBx2l/xZxl52VI9gD1Zt1
yap0Se+IDjVB5LQbeEFtbIEP5p1BGGkVOltHK6pj5iJu306gyNNrEueXfqXzlneT
L9njjQvD14V+VE9gyqeytdeVkwOjWlHShUtkng8GWYnC3wSh9OB1vZjLpZvsvTqx
O/WbxmBleUGgrvHUTJxBpXcHjZe/5UtD9ALKX9djNGCbYY4GlWZrtnR+e4nDJ9BD
fFj29BzO5l0UOtwbmkTYx8elSJNG28lYP6Tk5i6mWnqq37uQP5+LmfhxEo7SQXR/
z7lfEg8hCZCa0etJ2HOau7bHQ9ET32+o0oxr9unyglTUPQ0yWDx1FmFZYiSo0SlW
jH0YPQqhQJH0khuyje0d
=S8IS
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
