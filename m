Return-Path: <rtc-linux+bncBDS7HNEFSALRBOVY6S2AKGQEMXAT5XY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 5si456184wmm.2.2016.01.18.09.09.13
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Jan 2016 09:09:13 -0800 (PST)
Date: Mon, 18 Jan 2016 18:09:13 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.5
Message-ID: <20160118170913.GA18375@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC susbsystem for 4.5. It depends on a
few patches that you already pulled through the MFD tree.

The following changes since commit c60faa3afad0e926e63a39894489b64e9a8165df=
:

  Merge tag 'ib-mfd-regulator-rtc-v4.5' into rtc-next (2016-01-11 20:19:40 =
+0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.5

for you to fetch changes up to 079062b28fb4c58e30d024fdf974e00de53158fd:

  rtc: cmos: prevent kernel warning on IRQ flags mismatch (2016-01-11 20:38=
:50 +0100)

----------------------------------------------------------------
RTC for 4.5

Core:
 - fix module reference count in rtc-proc
 - Replace simple_strtoul by kstrtoul

New driver:
 - Epson RX8010SJ

Subsystem wide cleanups:
 - use %ph for short hex dumps
 - constify *_chip_ops structures

Drivers:
 - abx80x: Microcrystal rv1805 support, alarm support
 - cmos: prevent kernel warning on IRQ flags mismatch
 - s5m: various cleanups
 - rv8803: rx8900 compatibility, small error path fix
 - sunxi: various cleanups
 - lpc32xx: remove irq > NR_IRQS check from probe()
 - imxdi: fix spelling mistake in warning message
 - ds1685: don't try to micromanage sysfs output size
 - da9063: avoid writing undefined data to rtc
 - gemini: Remove unnecessary platform_set_drvdata()
 - efi: add efi_procfs in efi_rtc_ops
 - pcf8523: refuse to write dates later than 2099

----------------------------------------------------------------
Akshay Bhat (1):
      rtc: Add Epson RX8010SJ RTC driver

Alexandre Belloni (2):
      rtc: abx80x: Add Microcrystal rv1805 support
      rtc: abx80x: add alarm support

Andrzej Hajda (1):
      rtc: rv8803: fix handling return value of i2c_smbus_read_byte_data

Andy Shevchenko (1):
      rtc: cmos: prevent kernel warning on IRQ flags mismatch

Colin Ian King (1):
      rtc: imxdi: fix spelling mistake in warning message

Enrico Scholz (1):
      rtc: da9063: avoid writing undefined data to rtc

Geliang Tang (2):
      rtc: fix module reference count in rtc-proc
      rtc: efi: add efi_procfs in efi_rtc_ops

Gregory CLEMENT (1):
      rtc: rv8803: Extend compatibility with the rx8900

Julia Lawall (2):
      rtc: v3020: constify v3020_chip_ops structures
      rtc: rtc-ds2404: constify ds2404_chip_ops structures

Krzysztof Kozlowski (3):
      rtc: s5m: Cleanup by removing useless 'rtc' prefix from fields
      rtc: s5m: Add separate field for storing auto-cleared mask in registe=
r config
      rtc: s5m: Make register configuration per S2MPS device to remove exce=
ptions

LABBE Corentin (4):
      rtc: sunxi: fix signedness issues
      rtc: sunxi: constify the data_year_param structure
      rtc: sunxi: use of_device_get_match_data
      rtc: Replace simple_strtoul by kstrtoul

Nizam Haider (1):
      rtc: gemini: Remove unnecessary platform_set_drvdata()

Rasmus Villemoes (2):
      rtc: use %ph for short hex dumps
      rtc: ds1685: don't try to micromanage sysfs output size

Uwe Kleine-K=C3=B6nig (1):
      rtc: pcf8523: refuse to write dates later than 2099

Vladimir Zapolskiy (1):
      rtc: lpc32xx: remove irq > NR_IRQS check from probe()

 drivers/rtc/Kconfig             |  10 +
 drivers/rtc/Makefile            |   1 +
 drivers/rtc/rtc-abx80x.c        | 146 ++++++++++-
 drivers/rtc/rtc-cmos.c          |   2 +-
 drivers/rtc/rtc-da9063.c        |  23 +-
 drivers/rtc/rtc-ds1305.c        |   8 +-
 drivers/rtc/rtc-ds1307.c        |  17 +-
 drivers/rtc/rtc-ds1685.c        |  22 +-
 drivers/rtc/rtc-ds2404.c        |   4 +-
 drivers/rtc/rtc-efi.c           |  66 ++++-
 drivers/rtc/rtc-gemini.c        |   1 -
 drivers/rtc/rtc-imxdi.c         |   2 +-
 drivers/rtc/rtc-lpc32xx.c       |   2 +-
 drivers/rtc/rtc-pcf8523.c       |  11 +
 drivers/rtc/rtc-proc.c          |   8 +-
 drivers/rtc/rtc-rv8803.c        |   3 +-
 drivers/rtc/rtc-rx8010.c        | 523 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/rtc/rtc-s5m.c           | 138 +++++++----
 drivers/rtc/rtc-sunxi.c         |  18 +-
 drivers/rtc/rtc-sysfs.c         |  11 +-
 drivers/rtc/rtc-v3020.c         |   6 +-
 include/linux/mfd/samsung/rtc.h |   2 +
 22 files changed, 894 insertions(+), 130 deletions(-)
 create mode 100644 drivers/rtc/rtc-rx8010.c

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJWnRw4AAoJEKbNnwlvZCyzcnYP/jWvlzIyGAfJjNhjE0/Vjj+e
x7peg4R0D4Om2xwrCRQFtCVWEAASd6eJjJE9nvEonjlLDgRAu7zz1ZMNXViqzCNG
FmB/rZn7GBnj+1o8y39l9tLCQwIdhc5oDIqk7/9Y6lnWwSszavozcMjzUgFzkg7J
tbE/a6PLVYcaa7NcCSK/1eISaiNFfhOTMAIFV5sIfSYtLgX+Z7wBZz+cHtcSyFXc
dTiM/kPI3sSVb55mTEIdsUErviPywjELN/XqQ/9+JoOtmfjUavEgGqjFgk0Ohjr8
UF3Hph1PXEElKL8CH3hEGCFJG11qNl0vTF2S/nRyHfUXohB9EMdm4Hq8XMd5nJym
iRbbHld+4ojPrJ+xr2aKH9iVwCkpBQwh0IKG/i6jcDTXJ/OwyDoI6iopMadH29qM
yIUOWKg43QP4wYqny4CbYov3BJf4GHUlqs7alarmlPbpf1+Auq/FdkxWTKDcA927
pZ4z14JgEvtCuG+LJ2wYjr49dYuL5iGBVLFODvo+wbecfYNKqFBKMriEcAJVXQNj
ZeuxlRzqJ5ytagFE5wMle58fbQl6jGQU5Te9GwAOr1Dx4A1bBJFzeamc1cp3yk69
7FTfA4pDW4vCUSKSQEP8aPCh34t0L6LJHK2UoS4UcGDCpkFW0Iu11aDB5TjwsTzZ
ue1hXZzBvEcnw7XQwNkX
=I8iZ
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
