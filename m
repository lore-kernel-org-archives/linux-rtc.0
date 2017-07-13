Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51256 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdGMJCD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 13 Jul 2017 05:02:03 -0400
Date: Thu, 13 Jul 2017 11:01:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.13
Message-ID: <20170713090151.47rrpc62dxcqwvtz@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="obf3wtmmxzglmzdo"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--obf3wtmmxzglmzdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.13.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.13

for you to fetch changes up to 40bf6a35483ee25271ce2a90d8976cf1409a033a:

  rtc: Remove wrong deprecation comment (2017-07-12 23:11:23 +0200)

----------------------------------------------------------------
RTC for 4.13

Subsystem:
 - expose non volatile RAM using nvmem instead of open coding in many
 drivers. Unfortunately, this option has to be enabled by default to not
 break existing users.
 - rtctest can now test for cutoff dates, showing when an RTC will start
 failing to properly save time and date.
 - new RTC registration functions to remove race conditions in drivers

Newly supported RTCs:
 - Broadcom STB wake-timer
 - Epson RX8130CE
 - Maxim IC DS1308
 - STMicroelectronics STM32H7

Drivers:
 - ds1307: use regmap, use nvmem, more cleanups
 - ds3232: temperature reading support
 - gemini: renamed to ftrtc010
 - m41t80: use CCF to expose the clock
 - rv8803: use nvmem
 - s3c: many cleanups
 - st-lpc: fix y2106 bug

----------------------------------------------------------------
Alexandre Belloni (17):
      rtc: sysfs: make name uniform
      rtc: dev: remove rtc->name from debug message
      rtc: pcf8563: avoid using rtc->name
      rtc: ds1307: avoid using rtc-name
      rtc: remove rtc_device.name
      rtc: class separate device allocation from registration
      rtc: class separate id allocation from registration
      rtc: introduce new registration method
      rtc: at91rm9200: remove race condition
      rtc: add generic nvmem support
      rtc: rv8803: switch to rtc_register_device
      rtc: rv8803: use generic nvmem support
      rtc: rv8803: remove rv8803_remove
      rtc: ds1307: switch to rtc_register_device
      rtc: ds1307: use generic nvmem
      rtc: ds1307: remove ds1307_remove
      rtc: Remove wrong deprecation comment

Amelie Delaunay (2):
      dt-bindings: rtc: stm32: add support for STM32H7
      rtc: stm32: add STM32H7 RTC support

Arnd Bergmann (1):
      nvmem: include linux/err.h from header

Benjamin Gaignard (3):
      tools: timer: add rtctest_setdate
      rtc: rtctest: add check for problematic dates
      rtc: st-lpc: make it robust against y2038/2106 bug

Brian Norris (1):
      rtc: brcmstb-waketimer: Add Broadcom STB wake-timer

Dan Carpenter (1):
      rtc: rtc-nuc900: fix loop timeout test

David Lowe (1):
      rtc: rtc-ds1307: enable support for mcp794xx as a wakeup source witho=
ut IRQ

Diaz de Grenu, Jose (1):
      rtc: mxc: remove unused variable

Florian Fainelli (1):
      dt-bindings: Document the Broadcom STB wake-up timer node

Gary Bisson (4):
      rtc: m41t80: fix SQWE override when setting an alarm
      rtc: m41t80: fix SQW dividers override when setting a date
      rtc: m41t80: remove sqw sysfs entry
      rtc: m41t80: add clock provider support

Heiner Kallweit (3):
      rtc: ds1307: convert driver to regmap
      rtc: ds1307: use regmap_update_bits where applicable
      rtc: ds1307: factor out century bit handling

Kirill Esipov (1):
      rtc: ds3232: add temperature support

Krzysztof Kozlowski (6):
      rtc: s3c: Jump to central exit point on getting src clock error
      rtc: s3c: Minor white-space cleanups
      rtc: s3c: Drop unneeded cast to void pointer
      rtc: s3c: Do not remove const from rodata memory
      rtc: s3c: Handle clock prepare failures in probe
      rtc: s3c: Handle clock enable failures

Linus Walleij (3):
      rtc: gemini: Add optional clock handling
      rtc: gemini: Augment DT bindings for Faraday
      rtc: gemini/ftrtc010: rename driver and symbols

Marek Vasut (1):
      rtc: ds1307: Add support for Epson RX8130CE

Mauro Carvalho Chehab (1):
      rtc.txt: standardize document format

Sean Nyekjaer (1):
      rtc: ds1307: add ds1308 variant

Vaibhav Jain (3):
      rtc: opal: Handle disabled TPO in opal_get_tpo_time()
      rtc: interface: Validate alarm-time before handling rollover
      rtc: opal: Implement rtc_class_ops.alarm_irq_enable callback

 .../bindings/rtc/brcm,brcmstb-waketimer.txt        |  22 +
 .../devicetree/bindings/rtc/cortina,gemini.txt     |  14 -
 .../devicetree/bindings/rtc/faraday,ftrtc010.txt   |  28 +
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  32 +-
 Documentation/rtc.txt                              |  46 +-
 MAINTAINERS                                        |   2 +-
 drivers/rtc/Kconfig                                |  37 +-
 drivers/rtc/Makefile                               |   4 +-
 drivers/rtc/class.c                                | 202 +++--
 drivers/rtc/interface.c                            |   9 +-
 drivers/rtc/nvmem.c                                | 113 +++
 drivers/rtc/rtc-at91rm9200.c                       |  14 +-
 drivers/rtc/rtc-brcmstb-waketimer.c                | 330 +++++++
 drivers/rtc/rtc-core.h                             |   8 +
 drivers/rtc/rtc-dev.c                              |   2 +-
 drivers/rtc/rtc-ds1307.c                           | 957 ++++++++++-------=
----
 drivers/rtc/rtc-ds3232.c                           | 119 +++
 drivers/rtc/{rtc-gemini.c =3D> rtc-ftrtc010.c}       | 119 ++-
 drivers/rtc/rtc-m41t80.c                           | 251 ++++--
 drivers/rtc/rtc-mxc.c                              |  11 -
 drivers/rtc/rtc-nuc900.c                           |   2 +-
 drivers/rtc/rtc-opal.c                             |  32 +-
 drivers/rtc/rtc-pcf8563.c                          |   2 +-
 drivers/rtc/rtc-rv8803.c                           |  72 +-
 drivers/rtc/rtc-s3c.c                              | 147 ++--
 drivers/rtc/rtc-st-lpc.c                           |  19 +-
 drivers/rtc/rtc-stm32.c                            |  82 +-
 drivers/rtc/rtc-sysfs.c                            |   3 +-
 include/linux/nvmem-provider.h                     |   3 +
 include/linux/rtc.h                                |  21 +-
 tools/testing/selftests/timers/Makefile            |   2 +-
 tools/testing/selftests/timers/rtctest.c           | 128 ++-
 tools/testing/selftests/timers/rtctest_setdate.c   |  86 ++
 33 files changed, 2027 insertions(+), 892 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-wake=
timer.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.=
txt
 create mode 100644 drivers/rtc/nvmem.c
 create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c
 rename drivers/rtc/{rtc-gemini.c =3D> rtc-ftrtc010.c} (50%)
 create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--obf3wtmmxzglmzdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAllnNv4ACgkQAyWl4gNJ
NJLkSA//cpRFOhnSbmQRxsC/3ueHr2NTKoVYCDGBJltO+3awpmAgeNDhZcrYIBzs
QSV2aE4+K1p2QNHD+5fRhKhpJkXAb/KWSmBJwIJwbiBtz1IokfAwt3L8BZRJuHZj
ACMZl8HdHz4FAtMtC5uIot8jxJIPsYjZdluk0gcWWFbJb6WiKKt8ED7U7iZ1x9S9
5YrDRoPREvKizaESYHLRIVZNrveY4OI+1t1odfMtzHbAiUEz7bRM/PCpvtohZ9bs
GetpcOWWfz2MWDOzhGBi89168Y74nmcfuGi1FgoH8ZCu5mVmV9hnsKXuKQtQwu8J
WepWZQF1pJLixyoriki+6mp+mnMsY3bAhgWDncJXU38N+Eh2MrbiHvYUh/LwJzRb
jStDpA7Loi9o+h1jBn0/y5qgr8MZQJ0ffBgAF/S6UbfnbsKQscEmbQTwq+2Piobm
/ag+184gR37yU209oWcGwzZVnB1S7BbClmtOftzPqN4SdbV8Slk9yJPnjSeD74rc
Ztoxa17eI8LwYHCdKzfnvLTNlL5vT/hDZ/W+4g8GhUwQtUxe1k674qk33USBLWmP
inXjiEIJ4pNRHM36T5HECqDX/6Ny1V3j4IQf5otTkLR2tim08rEoBZRZTop+lT3z
e62UTolRa8Guyrb1DYzqRiuPb0uZ03Ab5nQWQEd9oaF6OAVU2jA=
=gm9j
-----END PGP SIGNATURE-----

--obf3wtmmxzglmzdo--
