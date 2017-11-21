Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58379 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUP2Z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 21 Nov 2017 10:28:25 -0500
Date: Tue, 21 Nov 2017 16:28:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.15
Message-ID: <20171121152823.payahwcvnnjervgf@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mrqnoansep66ekt"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--7mrqnoansep66ekt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.14.

The last minute change is only a documentation update to avoid further
bug reports. (And also a small commit message reword).

There is nothing scary this cycle, mostly driver fixes and updates. The
core fix has been in for a while and has been tested on multiple kernel
revisions by multiple teams.

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.15

for you to fetch changes up to 87c9fd81825363237ac5560822e2261535800597:

  dt-bindings: rtc: imxdi: Improve the bindings text (2017-11-20 22:48:20 +=
0100)

----------------------------------------------------------------
RTC for 4.15

Subsystem:
 - Fix setting the alarm to the next expiring timer

New driver:
 - Mediatek MT7622 RTC
 - NXP PCF85363
 - Spreadtrum SC27xx PMIC RTC

Drivers:
 - Use generic nvmem to expose the Non volatile ram for ds1305, ds1511,
 m48t86 and omap
 - abx80x: solve possible race condition at probe
 - armada38x: support trimming the RTC oscillator
 - at91rm9200: fix reading the alarm value at boot
 - ds1511: allow waking platform
 - m41t80: rework square wave output
 - pcf8523: support trimming the RTC oscillator
 - pcf8563: fix clock output rate
 - pl031: make interrupt optional
 - xgene: fix suspend/resume

----------------------------------------------------------------
Akshay Bhat (3):
      rtc: rx8010: Remove duplicate define
      rtc: rx8010: Specify correct address for RX8010_RESV31
      rtc: rx8010: Fix for incorrect return value

Alexandre Belloni (18):
      rtc: rv3029: fix vendor string
      rtc: set the alarm to the next expiring timer
      rtc: ds1305: switch to rtc_register_device
      rtc: ds1305: use generic nvmem
      rtc: m48t86: switch to rtc_register_device
      rtc: m48t86: use generic nvmem
      rtc: abx80x: switch to rtc_register_device
      rtc: abx80x: solve race condition
      rtc: ds1511: switch to rtc_register_device
      rtc: ds1511: allow waking platform
      rtc: ds1511: use generic nvmem
      rtc: ds1390: Add OF device ID table
      rtc: omap: fix error path when pinctrl_register fails
      rtc: omap: switch to rtc_register_device
      rtc: omap: Support scratch registers
      rtc: pcf8563: don't alway enable the alarm
      rtc: at91rm9200: stop calculating yday in at91_rtc_readalarm
      rtc: at91rm9200: fix reading alarm value

Arnd Bergmann (1):
      rtc: xgene: mark PM functions as __maybe_unused

Baolin Wang (3):
      rtc: sysfs: Use time64_t variables to set time/alarm
      dt-bindings: rtc: Add Spreadtrum SC27xx RTC documentation
      rtc: sc27xx: Add Spreadtrum SC27xx PMIC RTC driver

Bastian Stender (1):
      rtc: ds1307: add OF and ACPI entries for Epson RX8130

Dan Carpenter (1):
      rtc: rv3029: Clean up error handling in rv3029_eeprom_write()

Eric Nelson (1):
      rtc: add support for NXP PCF85363 real-time clock

Fabio Estevam (1):
      dt-bindings: rtc: imxdi: Improve the bindings text

Heiner Kallweit (1):
      rtc: ds1307: improve weekday handling

Loc Ho (1):
      rtc: xgene: Fix suspend/resume

Mathieu Malaterre (2):
      rtc: jz4740: remove duplicate 'write' in message
      rtc: jz4740: fix loading of rtc driver

Philipp Zabel (1):
      rtc: pcf8563: fix output clock rate

Russell King (7):
      rtc: pl031: constify amba_ids
      rtc: pl031: use devm_* for allocating memory and mapping resource
      rtc: pl031: avoid exposing alarm if no interrupt
      rtc: pl031: make interrupt optional
      rtc: clarify the RTC offset correction
      rtc: armada38x: add support for trimming the RTC
      rtc: pcf8523: add support for trimming the RTC oscillator

Sean Wang (4):
      dt-bindings: rtc: mediatek: add bindings for MediaTek SoC based RTC
      rtc: mediatek: add driver for RTC on MT7622 SoC
      rtc: mediatek: enhance the description for MediaTek PMIC based RTC
      rtc: mediatek: update MAINTAINERS entry with MediaTek RTC driver

Troy Kisky (5):
      rtc: m41t80: m41t80_sqw_set_rate should return 0 on success
      rtc: m41t80: fix m41t80_sqw_round_rate return value
      rtc: m41t80: avoid i2c read in m41t80_sqw_recalc_rate
      rtc: m41t80: avoid i2c read in m41t80_sqw_is_prepared
      rtc: m41t80: remove unneeded checks from m41t80_sqw_set_rate

 .../devicetree/bindings/rtc/imxdi-rtc.txt          |  14 +-
 Documentation/devicetree/bindings/rtc/pcf85363.txt |  17 +
 .../devicetree/bindings/rtc/rtc-mt7622.txt         |  21 +
 .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |  27 +
 .../devicetree/bindings/trivial-devices.txt        |   2 +-
 MAINTAINERS                                        |   3 +
 drivers/rtc/Kconfig                                |  42 +-
 drivers/rtc/Makefile                               |   3 +
 drivers/rtc/interface.c                            |   6 +-
 drivers/rtc/rtc-abx80x.c                           |  12 +-
 drivers/rtc/rtc-armada38x.c                        | 101 ++++
 drivers/rtc/rtc-at91rm9200.c                       |  19 +-
 drivers/rtc/rtc-ds1305.c                           |  70 +--
 drivers/rtc/rtc-ds1307.c                           |  57 +-
 drivers/rtc/rtc-ds1390.c                           |   7 +
 drivers/rtc/rtc-ds1511.c                           |  75 +--
 drivers/rtc/rtc-jz4740.c                           |   6 +-
 drivers/rtc/rtc-m41t80.c                           |  84 ++-
 drivers/rtc/rtc-m48t86.c                           |  58 +-
 drivers/rtc/rtc-mt7622.c                           | 422 +++++++++++++
 drivers/rtc/rtc-omap.c                             |  57 +-
 drivers/rtc/rtc-pcf8523.c                          |  40 ++
 drivers/rtc/rtc-pcf85363.c                         | 220 +++++++
 drivers/rtc/rtc-pcf8563.c                          |   4 +-
 drivers/rtc/rtc-pl031.c                            |  48 +-
 drivers/rtc/rtc-rv3029c2.c                         |  18 +-
 drivers/rtc/rtc-rx8010.c                           |   7 +-
 drivers/rtc/rtc-sc27xx.c                           | 662 +++++++++++++++++=
++++
 drivers/rtc/rtc-sysfs.c                            |  25 +-
 drivers/rtc/rtc-xgene.c                            |  47 +-
 30 files changed, 1891 insertions(+), 283 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/sprd,sc27xx-rtc.t=
xt
 create mode 100644 drivers/rtc/rtc-mt7622.c
 create mode 100644 drivers/rtc/rtc-pcf85363.c
 create mode 100644 drivers/rtc/rtc-sc27xx.c

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--7mrqnoansep66ekt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAloURhAACgkQAyWl4gNJ
NJLCgQ/+Kj2Ib/W7rcgYObYX3xoPPQ3Eg9JsaNLeYu33jg+qBFAzbJk44qxOdgd4
407F7z6XhCMntumy4wtjKFi4Hq7e1wHOHMNANbN91Qr8UHoDqKOktfD1H2PzIGOk
DhUJh405fj+AkxUcVD8JaamLSGzwBmW6RHn5WMDJT8uSfXBNwqt7CTor/TQRMs1W
ZiLRwQa2lwo57ql5xpriZyUP74z9X80By/XR/THpW3ZeW6jd2yBj3sFXO6StOpTG
Y2fuA9NYfrBNPBc0KercToxv0qpnCF/jNYXRpxszWldOeewtK2RAvUryuXA6deGH
FWZeO9aOTTAsUxiDcTjVnBrzHu9jOflR4lbENpczA68ZJY/XwmTu7ZLAq9tQjLq+
+2fM4NMqlTArSdsxAZuDWABJdtLvn2pmOVrgXHOd4YD/3aUw3NHrFfljdXf/LUED
kOmRTpvYFKg3+q4uYbrJ4i+aKnKBwuyUH1ppoMVXwWW/ShRNvnHSHIudt+uWxSPa
SHtUPnap+KVrPoFb+sgguHcHt1o/MKyhHNKAKlsjrLKPGCkT+xOyeJNfsEdDfTT4
ES4rehsGPS2kU3pupmwC+yKLFqLspSR6EO3TSTo16q/WYw7S5GVPVVzJsOrS4wFG
gx64aQOd30HU3vB1/xWvW+bOdrfvw5HMOM9TN+uqFcXCKc3GMaY=
=YYVI
-----END PGP SIGNATURE-----

--7mrqnoansep66ekt--
