Return-Path: <rtc-linux+bncBDSJBYGBRIMBB4V7RG5QKGQEDJJP3GA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f10si219412wmg.2.2016.06.16.01.14.42
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Jun 2016 01:14:42 -0700 (PDT)
Date: Thu, 16 Jun 2016 10:14:41 +0200
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
Subject: [rtc-linux] Re: [PATCH v2 08/10] ARM: dts: sun9i: cubieboard4: Order
 nodes by alphabetical order
Message-ID: <20160616081441.GH5144@lukather>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-9-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
In-Reply-To: <1465986467-14802-9-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jun 15, 2016 at 06:27:45PM +0800, Chen-Yu Tsai wrote:
> Move the &pio node below the mmc nodes for proper ordering by name.
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

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXYl/xAAoJEBx+YmzsjxAg+rIQAIJic/Ica37/xWQ52n0hfxdm
NCMUa0uLNknxve8+zrFkLymH8HgebpWC7VJHM9uuycXXcyNOboVjAUzsrO1IHZxq
SXxROc6fYuEUXVFY0ZO58vDwaK/m5Oo1D3oe+6HRgMbB5c4DVmMy99sxRh5/m93U
gWWfyHSsLrHuAJBuUgW0y0p26kPcsnstOSO+njZSBOCbzZtty1gSogh5kbVmcGNi
IburNSZ5k9J7VSFb6hMbQV3L9hwBv+n1jyEWQf/F/cPfZsBAVwlxbMLnI6snrjVm
si8xwfuqsF7gm7l39qME6P9gtGDGI0a+ffKOT1SQ9ks0qblPGq4+QIJFp8DEJwLp
oPBa+LkuiOFcJrZdB7fufE/TFQsewpfST5E/G76R6yDM53PBINgfb+zM+J5hs3pa
StcMjiQ4A6Xy1GJyLr6miqwt/69Re3Ba6ubZnVcWGxeMSkw8cMWbmb2o+Ok1PDmv
njDqNhBn5zjR1X+Eq9WIVY25eDtX8tL8rTK20kQwoa0Y+7gh3XccjCG0dzUOy6UP
pOiYDk1CNuFGWjTJtosFxKONUDlQ+6xdyiCVdSy/uMSxZ9czQDKvImXZ19CmyPMb
2jYHQzb3+prcVHmazcz3iksoqwEqKqepB7F3McjFVXKmmPtHx1W2fIkEqv0hOCHW
baGgBDXIkZNeyyNfdM6G
=fciQ
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--
