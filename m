Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBEWLZXCQKGQE77ELBMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id y19si672628wmd.0.2017.02.26.15.32.34
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Feb 2017 15:32:34 -0800 (PST)
Date: Mon, 27 Feb 2017 00:32:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.11
Message-ID: <20170226233223.hhvwuxke7dtnilul@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vghyfjuwrg55x3ld"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--vghyfjuwrg55x3ld
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.11.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77=
:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.11

for you to fetch changes up to d4f6c6f15a1f57e10374cf1a457f4eab5933bd0c:

  rtc: ds3232: Call device_init_wakeup before device_register (2017-02-24 1=
1:14:53 +0100)

----------------------------------------------------------------
RTC for 4.11

Subsystem:
 - constify rtc_class_ops structures

New driver:
 - STM32

Drivers:
 - armada38x: fix errata, Armada 7K/8K support
 - ds3232: fix wakeup support
 - gemini: DT support
 - m48t86: huge cleanup and platform_data removal
 - mcp795: alarm support
 - sun6i: proper oscillator handling
 - tegra: proper clock handling
 - tps65910: calibration support

----------------------------------------------------------------
Akinobu Mita (1):
      bindings: rtc: correct wrong reference in required properties

Alexandre Belloni (1):
      rtc: sun6i: extend test coverage

Amelie Delaunay (4):
      dt-bindings: document the STM32 RTC bindings
      rtc: add STM32 RTC driver
      rtc: stm32: use 0 instead of ~PWR_CR_DBP in regmap_update_bits
      rtc: stm32: fix comparison warnings

Arnd Bergmann (2):
      rtc: stm32: remove __exit annotation on remove callback
      rtc: stm32: fix building without CONFIG_OF

Bhumika Goyal (1):
      rtc: constify rtc_class_ops structures

Chen-Yu Tsai (1):
      rtc: sun6i: Fix compatibility with old DT binding

Emil Bartczak (2):
      rtc: mcp795: Add support for weekday.
      rtc: mcp795: add alarm support.

Enric Balletbo i Serra (1):
      rtc: bq32000: add support to enable disable the trickle charge FET by=
pass

Fabien Lahoudere (1):
      rtc: rx8010: change lock mechanism

Gregory CLEMENT (3):
      rtc: armada38x: Follow the new recommendation for errata implementati=
on
      rtc: armada38x: Prepare driver to manage different versions
      rtc: armada38x: Add support for Armada 7K/8K

Guy Shapiro (1):
      rtc: snvs: add a missing write sync

H Hartley Sweeten (8):
      rtc: m48t86: shorten register name defines
      rtc: m48t86: allow driver to manage its resources
      rtc: m48t86: add NVRAM support
      rtc: m48t86: verify that the RTC is actually present
      ARM: ep93xx: ts72xx: allow rtc-m48t86 to manage its own resources
      ARM: Orion5x: ts78xx: remove RTC detection
      ARM: Orion5x: ts78xx: allow rtc-m48t86 to manage it's own resources
      rtc: m48t86: remove unused platform_data

Linus Walleij (1):
      rtc: gemini: Add device tree probing

Martin Kaiser (2):
      rtc: imxdi: use the security violation interrupt
      Documentation: dt: rtc-imxdi: security violation interrupt

Maxime Ripard (5):
      rtc: sun6i: Disable the build as a module
      rtc: sun6i: Add some locking
      rtc: sun6i: Switch to the external oscillator
      rtc: sun6i: Expose the 32kHz oscillator
      rtc: sun6i: Switch to devm_rtc_device_register

Phil Reid (3):
      rtc: ds3232: Cleanup whitespace around register and bit definitions.
      rtc: ds3232: Add regmap max_register definition.
      rtc: ds3232: Call device_init_wakeup before device_register

Russell King (1):
      rtc: armada38x: make struct rtc_class_ops const

Sean Nyekjaer (1):
      rtc: pcf2127: bulk read only date and time registers.

Thierry Reding (2):
      rtc: tegra: Sort includes alphabetically
      rtc: tegra: Implement clock handling

Vesa J=C3=A4=C3=A4skel=C3=A4inen (2):
      rtc: tps65910: Add RTC calibration support
      rtc: tps65910: use 'unsigned int' instead of 'unsigned' in arguments

Wei Yongjun (1):
      rtc: sun6i: Fix return value check in sun6i_rtc_clk_init()

 .../ABI/testing/sysfs-bus-i2c-devices-bq32k        |   7 +
 .../devicetree/bindings/rtc/armada-380-rtc.txt     |   8 +-
 .../devicetree/bindings/rtc/cortina,gemini.txt     |  14 +
 .../devicetree/bindings/rtc/imxdi-rtc.txt          |   5 +-
 .../devicetree/bindings/rtc/maxim,ds3231.txt       |   3 +-
 Documentation/devicetree/bindings/rtc/pcf8563.txt  |   3 +-
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +
 .../devicetree/bindings/rtc/sun6i-rtc.txt          |  10 +
 arch/arm/mach-ep93xx/ts72xx.c                      |  40 +-
 arch/arm/mach-ep93xx/ts72xx.h                      |  11 -
 arch/arm/mach-orion5x/ts78xx-setup.c               |  80 +--
 drivers/rtc/Kconfig                                |  18 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-armada38x.c                        | 318 +++++++--
 drivers/rtc/rtc-au1xxx.c                           |   2 +-
 drivers/rtc/rtc-bfin.c                             |   2 +-
 drivers/rtc/rtc-bq32k.c                            |  76 +++
 drivers/rtc/rtc-dm355evm.c                         |   2 +-
 drivers/rtc/rtc-ds3232.c                           |  53 +-
 drivers/rtc/rtc-gemini.c                           |   7 +
 drivers/rtc/rtc-imxdi.c                            |  33 +-
 drivers/rtc/rtc-ls1x.c                             |   2 +-
 drivers/rtc/rtc-m48t86.c                           | 272 +++++---
 drivers/rtc/rtc-mcp795.c                           | 183 +++++-
 drivers/rtc/rtc-mxc.c                              |   2 +-
 drivers/rtc/rtc-pcf2127.c                          |  15 +-
 drivers/rtc/rtc-rx8010.c                           |  24 +-
 drivers/rtc/rtc-sh.c                               |   2 +-
 drivers/rtc/rtc-snvs.c                             |   1 +
 drivers/rtc/rtc-stm32.c                            | 725 +++++++++++++++++=
++++
 drivers/rtc/rtc-sun6i.c                            | 182 +++++-
 drivers/rtc/rtc-tegra.c                            |  41 +-
 drivers/rtc/rtc-tps65910.c                         | 146 ++++-
 include/linux/mfd/tps65910.h                       |   1 +
 include/linux/platform_data/rtc-m48t86.h           |  16 -
 35 files changed, 1956 insertions(+), 376 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-bq32k
 create mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.tx=
t
 create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
 create mode 100644 drivers/rtc/rtc-stm32.c
 delete mode 100644 include/linux/platform_data/rtc-m48t86.h

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

--vghyfjuwrg55x3ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEl0I5XWmUIrwBfFMm2KKDO9oT4sIFAlizZYUACgkQ2KKDO9oT
4sJavg//VxnKICCXghCK1nKWIRs4kZrAvjWdGR65su0tIigomXuCOQdXHfmVLt2V
9TAnl91xVsN503ksOKmTPGulz1BolbSQLToK0GYOrAA6UA4fjt4fZjs1DSrAILYu
WgpwNHY/Kfr7q1uR5XiDfUXfJTi/arCHl8h4d8oec3bLGvpm559bid6e+ytn25SP
hmRVL6d2Trxogx5Ou6odykGq+CD/vPHmUdrjMoK9U1uyIEB9uAlBhtep7vA4adSD
r0Y2YQ7DK+LJ57cSVM9jUNC0+k7/ya4g4WaiIMT+DMmcjN7WwVgjxlB/ScXr1Lr7
voK9afINnwRxxMnD06fWho8MSwLUv/OKrxX1VMMFkcxJRTZbcIFVSc9UMpmJjzkl
Tc1OCbhom7XX77YDRcM31AhEEjliq82B25VDAthcbZ32ketBze9QR/fFuxP239V+
7+zo+JcOZTERDD9tJP9pDA7yVOHK63ZC8RmM4byXQKbQbTXNfia8FiO61PpbvSIG
RIVNE64vOttBVPyNXL9Z1JkNBTTl89fWWrEYyVKVut7HVgixEAxe1UZk53mmeWvR
tXg6kpr6Td/OqhPYawlgf6WiJwByBW00htk1xL8uLondAfVv8FS0p6inr2dyRzcL
y4YpsOcLkZVpQb6KUCaPYAwxDLvBNh3rth4QOo9uw2/BcwDcVQI=
=ZLcP
-----END PGP SIGNATURE-----

--vghyfjuwrg55x3ld--
