Return-Path: <rtc-linux+bncBDS7HNEFSALRBHFHWGWAKGQED4FXMEA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bc3si360367wib.2.2015.06.25.12.16.43
        for <rtc-linux@googlegroups.com>;
        Thu, 25 Jun 2015 12:16:43 -0700 (PDT)
Date: Thu, 25 Jun 2015 21:16:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.2
Message-ID: <20150625191642.GA16184@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC susbsystem for 4.2. This is my
first pull-request to you, don't hesitate to tell me if I need to adjust
something.

Conflicts:
   drivers/rtc/Makefile

Trivial add/add conflicts with the mfd tree, solved in linux-next
Resolution: take both sides.

The following changes since commit 0f57d86787d8b1076ea8f9cbdddda2a46d534a27=
:

  Linux 4.1-rc8 (2015-06-14 15:51:10 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-v4.2-1

for you to fetch changes up to 3783055ef4cf096910f670f9a1a32e32db08559b:

  rtc: remove useless I2C dependencies (2015-06-25 01:13:48 +0200)

----------------------------------------------------------------
RTC for 4.2

Core:
 - Coding style and whitespace fixes (interface, Makefile and Kconfig)
 - New rtc_tm_sub() helper
 - New CONFIG_RTC_SYSTOHC_DEVICE option
 - Removed rtc_set_mmss()

New drivers:
 - Mediatek MT6397
 - Cortina Gemini

Drivers:
 - Year 2106 fixes for isl1208, pcf8563 and sunxi
 - update author email for at32ap700x and efi
 - ds1307: alarm fix
 - efi: use correct EFI 'epoch'
 - hym8563: make irq optional
 - imxdi: cleanups and better handling of the security/tamper monitoring
 - snvs: fix wakealarm
 - Compilation fixes or warning removal for gemini, mt6397, palmas, pfc8563
 - Trivial cleanups for ab8500, ds1216, ds1286, ds1672, ep93xx,
hid-sensor-time, max6900, max8998, max77686, max77802, mc13xxx, mv, mxc, s3=
c,
spear, v3020
 - Kconfig fixes for stmp3xxx and xgene

----------------------------------------------------------------
Alexandre Belloni (8):
      rtc: mt6397: fix build on some 32bits platforms
      rtc: stmp3xxx select STMP_DEVICE
      rtc: mv: use BIT()
      rtc: mv: correct 24 hour error message
      MAINTAINERS: Add RTC subsystem repository
      rtc: Properly sort Makefile
      rtc: whitespace fixes
      rtc: remove useless I2C dependencies

Ard Biesheuvel (1):
      rtc: efi: use correct EFI 'epoch'

Arnd Bergmann (1):
      rtc: pfc8563: fix uninitialized variable warning

Axel Lin (1):
      rtc: ds1672, max6900, max8998: Add MODULE_DEVICE_TABLE

Eddie Huang (2):
      mfd: provide RTC resource in MT6397 MFD
      MAINTAINERS: add Mediatek RTC driver

H Hartley Sweeten (1):
      rtc: ep93xx: Use readl/writel for io

Hans Ulli Kroll (1):
      rtc: driver for Cortina Gemini

Hans-Christian Egtvedt (1):
      rtc: at32ap700x: update author email

Heiko St=C3=BCbner (1):
      rtc: hym8563: make the irq optional

Jan Kardell (1):
      rtc: pcf8563 fix: return -EINVAL if we read an invalid time.

Javier Martinez Canillas (2):
      rtc: max77686: Report platform modalias to fix module autoload
      rtc: max77802: Report platform modalias to fix module autoload

Jean Delvare (1):
      rtc: xgene: Set hardware dependency

Jingoo Han (1):
      rtc: rtc-v3020: use gpio_request_array()

Juergen Borleis (5):
      rtc: imxdi: avoid the __raw* register access functions
      rtc: imxdi: add some background info about the states the machine can=
 be in
      rtc: imxdi: add the unit recovery code
      rtc: imxdi: monitor a security violation at runtime
      rtc: imxdi: when locked, do not fail silently

Julia Lawall (1):
      rtc: simplify use of devm_ioremap_resource

Krzysztof Kozlowski (6):
      rtc: ab8500: Constify platform_device_id
      rtc: hid-sensor-time: Constify platform_device_id
      rtc: mxc: Constify platform_device_id
      rtc: interface: Fix coding style violations
      rtc: interface: Remove unused return value from rtc_timer_cancel()
      rtc: s3c: Integrate Exynos3250 into S3C6410

Laxman Dewangan (1):
      rtc: palmas: Initialise bb_charging flag before using it

Nishanth Menon (1):
      rtc: ds1307: Enable the mcp794xx alarm after programming time

Rasmus Villemoes (1):
      rtc: mc13xxx: fix obfuscated and wrong format string

Stefan Agner (1):
      rtc: snvs: fix wakealarm by call enable_irq_wake earlier

Tianping Fang (1):
      rtc: mediatek: Add MT6397 RTC driver

Xunlei Pang (7):
      rtc: pcf8563: Replace deprecated rtc_time_to_tm() and rtc_tm_to_time(=
)
      rtc: Introduce rtc_tm_sub() helper function
      rtc: isl1208: Replace deprecated rtc_tm_to_time()
      rtc: sunxi: Replace deprecated rtc_tm_to_time()
      rtc: NTP: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP synchronization
      sparc: time: Replace update_persistent_clock() with CONFIG_RTC_SYSTOH=
C
      rtc: interface: Remove rtc_set_mmss()

dann frazier (1):
      rtc: efi: Update author email address

kbuild test robot (1):
      rtc: gemini: fix cocci warnings

 .../devicetree/bindings/rtc/haoyu,hym8563.txt      |   2 +-
 MAINTAINERS                                        |   9 +
 arch/sparc/Kconfig                                 |   2 +-
 arch/sparc/kernel/time_32.c                        |  21 -
 arch/sparc/kernel/time_64.c                        |  14 -
 drivers/mfd/mt6397-core.c                          |  18 +
 drivers/rtc/Kconfig                                | 104 +++--
 drivers/rtc/Makefile                               |  42 +-
 drivers/rtc/interface.c                            |  49 +--
 drivers/rtc/rtc-ab8500.c                           |   2 +-
 drivers/rtc/rtc-at32ap700x.c                       |   2 +-
 drivers/rtc/rtc-ds1216.c                           |   4 +-
 drivers/rtc/rtc-ds1286.c                           |   4 +-
 drivers/rtc/rtc-ds1307.c                           |  12 +-
 drivers/rtc/rtc-ds1672.c                           |   1 +
 drivers/rtc/rtc-efi.c                              |  43 +-
 drivers/rtc/rtc-ep93xx.c                           |   6 +-
 drivers/rtc/rtc-gemini.c                           | 175 ++++++++
 drivers/rtc/rtc-hid-sensor-time.c                  |   2 +-
 drivers/rtc/rtc-hym8563.c                          |  18 +-
 drivers/rtc/rtc-imxdi.c                            | 438 +++++++++++++++++=
+---
 drivers/rtc/rtc-isl1208.c                          |   9 +-
 drivers/rtc/rtc-max6900.c                          |   1 +
 drivers/rtc/rtc-max77686.c                         |   1 +
 drivers/rtc/rtc-max77802.c                         |   1 +
 drivers/rtc/rtc-max8998.c                          |   1 +
 drivers/rtc/rtc-mc13xxx.c                          |   2 +-
 drivers/rtc/rtc-mt6397.c                           | 395 +++++++++++++++++=
++
 drivers/rtc/rtc-mv.c                               |  13 +-
 drivers/rtc/rtc-mxc.c                              |   2 +-
 drivers/rtc/rtc-palmas.c                           |   2 +-
 drivers/rtc/rtc-pcf8563.c                          |  21 +-
 drivers/rtc/rtc-s3c.c                              |  14 +-
 drivers/rtc/rtc-snvs.c                             |  30 +-
 drivers/rtc/rtc-spear.c                            |   7 +-
 drivers/rtc/rtc-sunxi.c                            |  32 +-
 drivers/rtc/rtc-v3020.c                            |  41 +-
 drivers/rtc/systohc.c                              |   2 +-
 include/linux/rtc.h                                |  20 +-
 39 files changed, 1196 insertions(+), 366 deletions(-)
 create mode 100644 drivers/rtc/rtc-gemini.c
 create mode 100644 drivers/rtc/rtc-mt6397.c

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

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVjFOaAAoJEKbNnwlvZCyzZa0P/3Cee7QSYDbsu3i8ga/o7cKN
YLxQ//KshJ5EeLhP8dC80GGLxDSQldA3AH2x5/1HhNHqjR1QME7CvSoneOj0BrHV
19gLpqkwQXumWz07o5p+iBNiyK9vg8NVVnZ8k1YLbc68b/zU3nmqC4Aa5mvHoWGs
Mto2LUuQoQduGQdaerk5YzWYj6+Yoswq9MN+j8nrXFieC1zjEicEQ8wqy9y1L7Eu
EX9FatDiXcnGzZxbSUrcMCT+FRmHwe1pQbPYDinUaZ8JapUdyCfTIWK1vuJOwhdg
ZLcjEZYVAiLXZU5nEahhQipVP2tUoOyZuADLBfKeOEjFISpbFgqprUBxn4d7ek+P
iEveto+65rEd+U+QQ0a4JemvPGa87q6mP4VkLDYJLxkQX6ZEf6t+JTbb3kL+1iWn
YYyYGYi9liAPoyX56XWoZZqbrnXh94+vydcVuWB+/Ww5IA+EKfF8U+WKevI1iE4X
5yZ38AGsqA7DqFdJ196G3CRESDyS0/d4EtEXeU1LzjVdrsDqn1kq/AYEx513dZzd
xUftHbWQy+yJzPpSS/xiuxeN7IRW5iwbKrj/VLZULt2F6WBzD893WJciWmScAPdQ
KsdADg6PbiWapXNjWerZxMhGy072BFImzxBVWNVpF7wBiKcQclL2gdfTk4LCyBBq
iBGW+0rcVaC4Nydux1z9
=Jd83
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
