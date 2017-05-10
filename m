Date: Wed, 10 May 2017 23:27:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.12
Message-ID: <20170510212702.m2hl3ijmojrcwy36@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <rtc-linux.googlegroups.com>

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.12.

I had to generate a new GPG subkey so you may have to refresh my key
before verifying the signature

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.12

for you to fetch changes up to 332e0d13d3c7d1e4394a513585a3d3b15a0030b8:

  rtc: gemini: add return value validation (2017-05-05 00:43:52 +0200)

----------------------------------------------------------------
RTC for 4.12

Subsystem:
 - Add OF device ID table for i2c drivers

New driver:
 - Motorola CPCAP PMIC RTC

Drivers:
 - cmos: fix IRQ selection
 - ds1307: Add ST m41t0 support
 - ds1374: fix watchdog configuration
 - sh: Add rza series support

----------------------------------------------------------------
Alexandre Belloni (2):
      rtc: ds1307: Add m41t0 to OF device ID table
      rtc: m41t80: Add proper compatible for rv4162

Arnd Bergmann (1):
      rtc: sh: mark PM functions as unused

Chris Brandt (2):
      rtc: sh: add support for rza series
      dt-bindings: rtc: document the rtc-sh bindings

Dan Carpenter (2):
      rtc: cpcap: kfreeing devm allocated memory
      rtc: hid-sensor-time: remove some dead code

Dmitry Torokhov (2):
      rtc: omap: remove incorrect __exit markups
      rtc: omap: mark PM methods as __maybe_unused

Hans de Goede (2):
      x86: i8259: export legacy_pic symbol
      rtc: cmos: Do not assume irq 8 for rtc when there are no legacy irqs

Javier Martinez Canillas (13):
      rtc: rv8803: Add OF device ID table
      rtc: rv3029: Add OF device ID table
      rtc: bq32k: Add OF device ID table
      rtc: ds1307: Add OF device ID table
      rtc: rx8010: Add OF device ID table
      rtc: ds3232: Add OF device ID table
      rtc: rtc-ds1672: Add OF device ID table
      rtc: ds1374: Set .of_match_table to OF device ID table
      rtc: isl1208: Add OF device ID table
      rtc: s35390a: Add OF device ID table
      rtc: rx8581: Add OF device ID table
      rtc: m41t80: Add OF device ID table
      rtc: rs5c372: Add OF device ID table

Moritz Fischer (2):
      rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt tic=
ks
      rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL

Nobuhiro Iwamatsu (1):
      rtc: wm8350: Remove unused to_wm8350_from_rtc_dev

Pan Bian (2):
      rtc: snvs: fix an incorrect check of return value
      rtc: gemini: add return value validation

Sebastian Reichel (2):
      dt-bindings: Add vendor prefix for Motorola
      rtc: cpcap: new rtc driver

Stefan Agner (1):
      rtc: ds1307: support m41t0 variant

Tony Lindgren (1):
      rtc: cpcap: fix improper use of IRQ_NONE for request_threaded_irq

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/rtc/cpcap-rtc.txt          |  18 ++
 Documentation/devicetree/bindings/rtc/rtc-sh.txt   |  28 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/x86/kernel/i8259.c                            |   1 +
 drivers/rtc/Kconfig                                |  11 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bq32k.c                            |   7 +
 drivers/rtc/rtc-cmos.c                             |  17 +-
 drivers/rtc/rtc-cpcap.c                            | 330 +++++++++++++++++=
++++
 drivers/rtc/rtc-ds1307.c                           |  85 +++++-
 drivers/rtc/rtc-ds1374.c                           |  11 +-
 drivers/rtc/rtc-ds1672.c                           |   9 +-
 drivers/rtc/rtc-ds3232.c                           |   7 +
 drivers/rtc/rtc-gemini.c                           |   2 +
 drivers/rtc/rtc-hid-sensor-time.c                  |   4 +-
 drivers/rtc/rtc-isl1208.c                          |  12 +-
 drivers/rtc/rtc-m41t80.c                           |  68 ++++-
 drivers/rtc/rtc-omap.c                             |  22 +-
 drivers/rtc/rtc-rs5c372.c                          |  37 ++-
 drivers/rtc/rtc-rv3029c2.c                         |   9 +
 drivers/rtc/rtc-rv8803.c                           |  21 +-
 drivers/rtc/rtc-rx8010.c                           |   7 +
 drivers/rtc/rtc-rx8581.c                           |   7 +
 drivers/rtc/rtc-s35390a.c                          |   8 +
 drivers/rtc/rtc-sh.c                               |  39 ++-
 drivers/rtc/rtc-snvs.c                             |   2 +-
 drivers/rtc/rtc-wm8350.c                           |   2 -
 28 files changed, 721 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt
 create mode 100644 drivers/rtc/rtc-cpcap.c

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
