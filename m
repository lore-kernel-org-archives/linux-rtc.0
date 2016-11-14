Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBKGAVDAQKGQEGFW5PSY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l19si22754wmg.0.2016.11.14.12.35.51
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Nov 2016 12:35:51 -0800 (PST)
Date: Mon, 14 Nov 2016 21:35:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC fixes for 4.9
Message-ID: <20161114203541.3uthgnzexr3fla7b@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5b4bgsdzy4hjnjdj"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--5b4bgsdzy4hjnjdj
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are a few driver fixes for 4.9. It has been calm for a while so I
don't expect more for this cycle.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc=
:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.9-2

for you to fetch changes up to efce21fc43e00a76aee7b0a1eda73730ed2d5d3a:

  rtc: omap: prevent disabling of clock/module during suspend (2016-11-04 2=
3:11:39 +0100)

----------------------------------------------------------------
RTC for 4.9 #2

Drivers:
 - asm9260: fix module autoload
 - cmos: fix crashes
 - omap: fix clock handling

----------------------------------------------------------------
Javier Martinez Canillas (1):
      rtc: asm9260: fix module autoload

LABBE Corentin (1):
      rtc: cmos: remove all __exit_p annotations

Lokesh Vutla (1):
      rtc: omap: Fix selecting external osc

Tero Kristo (1):
      rtc: omap: prevent disabling of clock/module during suspend

Ville Syrj=C3=A4l=C3=A4 (1):
      rtc: cmos: Don't enable interrupts in the middle of the interrupt han=
dler

 drivers/rtc/rtc-asm9260.c |  1 +
 drivers/rtc/rtc-cmos.c    | 15 ++++++++-------
 drivers/rtc/rtc-omap.c    | 38 ++++++++++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 15 deletions(-)

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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

--5b4bgsdzy4hjnjdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYKiAaAAoJENiigzvaE+LCzhcP/RUNEWQS0BEim+IbvLePeAzW
WxonvAU0xSX5YaEsoKHIF+5+J2sqEtUly3e6GG+otIGwAD/DSYL80hXJC4EzmhVR
9MxST6lHjCoAXYliW/RuvRXlLcXxHGE3LJSwPmqqMjxLg6E8586w6oEH0g/TKmSQ
MXDqAeItKjUsdn+vv7HjDMPFit0UJH2vYdn/1qlGrgZr1zXvN/IAbxbGjehsxHlc
h+GBWbKsulydlroYIzE8FuqG3i5W0rc1EdxrbNEd8lrsRBMAfgiBLrB461UCbwLj
2uwbjLI4/J6PoRlAzRjqUpzOHu0RCzg/reSQ5RdlNlNiANELih34a3dDS6JCi6N9
84eTcBgz/8L/qzcyoHFMv+qmx3asGnzaW5Ih+5CCMY2Shofq9mMdOB6hPZzLcbpm
+Essu/AW3kVGRpqI2T5cX4szEar+Gd4Nhm+5FW7E4xAKKMLJq8+hkExbF518pgMf
fJRuxtJqlskdaRFwwwEMvppKCBuPiDiKRNQmQeU1yjUbURqnqj0UQvLJmpoMvGbV
Ya3C82Z8iUCVJQV7PjtZDervnCpxtG3RxraM0TsTeqq7S2ajwfqBeklawQKS6QSR
bqCQorQGDnWjv8DwTqlcMya4K27ABJ6/z5xi3FLKbs/1756Up+/aEBG6gML9DGZi
HWeBRUIc0iVviVjr2hvY
=jvo0
-----END PGP SIGNATURE-----

--5b4bgsdzy4hjnjdj--
