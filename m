Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB3GGQTAAKGQENL7U3UY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f1si60517wmf.2.2016.10.14.11.26.52
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Oct 2016 11:26:52 -0700 (PDT)
Date: Fri, 14 Oct 2016 20:26:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.9
Message-ID: <20161014182651.brmhfqtomm4hdjoq@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.9.
Because of dependencies, it is based on ib-mfd-rtc-4.9 that you already
pulled in your tree.

The following changes since commit 04940631b8d2b2e57a13b6d4ca50dfe5994b514f=
:

  rtc: ac100: Add clk output support (2016-08-08 12:54:05 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.9

for you to fetch changes up to 1cd713762e4cd5378a488fd6eaa7507bf030a832:

  rtc: rv8803: set VDETOFF and SWOFF via device tree (2016-10-12 13:24:39 +=
0200)

----------------------------------------------------------------
RTC for 4.9

Subsystem:
 - delete owner assignment in multiple drivers
 - constify rtc_class_ops structures

Drivers:
 - ac100: support clock-output-names
 - cmos: properly handle ACPI alarms and quirky BIOSes and other fixes
 - ds1307: fix century bit support while staying comaptible with previous
   behaviour by default
 - ds1347: switch to regmap
 - isl12057 is now handled by ds1307
 - omap: support external wakeup
 - rv8803: allow to disable voltage drop detection

----------------------------------------------------------------
Alexandre Belloni (7):
      rtc: ds1307: fix century bit support
      rtc: ds1307: add Intersil ISL12057 support
      rtc: isl12057: remove driver
      Documentation: dt: Intersil isl12057 is not a trivial device
      rtc: rx6110: remove owner assignment
      rtc: asm9260: allow COMPILE_TEST
      rtc: asm9260: rework locking

Arnd Bergmann (1):
      rtc: cmos: avoid unused function warning

Axel Lin (1):
      rtc: ac100: Add NULL checking for devm_kzalloc call

Chen-Yu Tsai (1):
      rtc: ac100: support clock-output-names in device tree binding

Christophe JAILLET (1):
      rtc: pcf2123: Add missing error code assignment before test

Fabio Estevam (1):
      rtc: ds1390: Fix the SPI chip select number

Gabriele Mazzotta (2):
      rtc: cmos: Clear ACPI-driven alarms upon resume
      rtc: cmos: Restore alarm after resume

Jan =C3=96stlund (2):
      rtc: bq32k: Use correct mask name for 'minutes' register.
      rtc: bq32k: Fix handling of oscillator failure flag

Julia Lawall (1):
      rtc: constify rtc_class_ops structures

LABBE Corentin (1):
      rtc: sysfs: fix a cast removing the const attribute

Marcin Niestroj (1):
      rtc: omap: Support ext_wakeup configuration

Markus Elfring (1):
      rtc: pic32: Delete owner assignment

Oleksij Rempel (3):
      devicetree: Add Micro Crystal AG vendor id
      dt/bindings: Add bindings for Micro Crystal rv8803
      rtc: rv8803: set VDETOFF and SWOFF via device tree

Pratyush Anand (1):
      rtc: cmos: Initialize hpet timer before irq is registered

Raghavendra Ganiga (1):
      rtc: ds1347: changed raw spi calls to register map calls

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 -
 .../devicetree/bindings/rtc/dallas,ds1390.txt      |   2 +-
 .../devicetree/bindings/rtc/epson,rx8900.txt       |  22 +
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  21 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/rtc/Kconfig                                |  38 +-
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/rtc-ac100.c                            |   5 +
 drivers/rtc/rtc-asm9260.c                          |  20 +-
 drivers/rtc/rtc-at32ap700x.c                       |   2 +-
 drivers/rtc/rtc-bq32k.c                            |  16 +-
 drivers/rtc/rtc-cmos.c                             |  93 ++-
 drivers/rtc/rtc-coh901331.c                        |   2 +-
 drivers/rtc/rtc-davinci.c                          |   2 +-
 drivers/rtc/rtc-digicolor.c                        |   2 +-
 drivers/rtc/rtc-ds1302.c                           |   2 +-
 drivers/rtc/rtc-ds1307.c                           |  54 +-
 drivers/rtc/rtc-ds1347.c                           |  96 +--
 drivers/rtc/rtc-gemini.c                           |   2 +-
 drivers/rtc/rtc-isl12057.c                         | 643 -----------------=
----
 drivers/rtc/rtc-jz4740.c                           |   2 +-
 drivers/rtc/rtc-mcp795.c                           |   2 +-
 drivers/rtc/rtc-mt6397.c                           |   2 +-
 drivers/rtc/rtc-nuc900.c                           |   2 +-
 drivers/rtc/rtc-omap.c                             | 170 +++++-
 drivers/rtc/rtc-palmas.c                           |   2 +-
 drivers/rtc/rtc-pcf2123.c                          |   5 +-
 drivers/rtc/rtc-pcf50633.c                         |   2 +-
 drivers/rtc/rtc-pic32.c                            |   1 -
 drivers/rtc/rtc-rv8803.c                           |  50 +-
 drivers/rtc/rtc-rx6110.c                           |   3 +-
 drivers/rtc/rtc-rx8025.c                           |   2 +-
 drivers/rtc/rtc-spear.c                            |   2 +-
 drivers/rtc/rtc-stmp3xxx.c                         |   2 +-
 drivers/rtc/rtc-sysfs.c                            |   4 +-
 drivers/rtc/rtc-tegra.c                            |   2 +-
 drivers/rtc/rtc-twl.c                              |   2 +-
 37 files changed, 498 insertions(+), 782 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt
 delete mode 100644 drivers/rtc/rtc-isl12057.c

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
