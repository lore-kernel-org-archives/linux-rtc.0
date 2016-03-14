Return-Path: <rtc-linux+bncBDS7HNEFSALRBP6VTO3QKGQEZKY6NEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si649620wml.0.2016.03.14.09.45.51
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 09:45:51 -0700 (PDT)
Date: Mon, 14 Mar 2016 17:45:49 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.6
Message-ID: <20160314164549.GA20174@piout.net>
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

Here is the pull-request for the RTC susbsystem for 4.6. It is based on
v4.5-rc1 as arm-soc, through samsung-soc, depends on an immutable tag:
rtc-max77686-4.6

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.6

for you to fetch changes up to cee2cc21550648679d222cbe2637fcc6d0f730ef:

  rtc: pcf2127: add pcf2129 device id (2016-03-14 17:08:41 +0100)

----------------------------------------------------------------
RTC for 4.6

Core:
 - New sysfs interface to set and read clock offset
 - Drivers can now be both I2C and SPI (see pcf2127 and ds3232)

New drivers:
 - Alphascale ASM9260
 - Epson RX6110SA
 - Maxim max20024 and max77620 (in max77686)
 - Microchip PIC32
 - NXP pcf2129 (in pcf2127)

Subsystem wide cleanups:
 - remove IRQF_EARLY_RESUME when unecessary

Drivers:
 - ds1307: clock output, temperature sensor and wakeup-source support
 - ds1685: actually spin forever in poweroff error path
 - ds3232: many cleanups
 - ds3234: merged in ds3232
 - hym8563: fix invalid year calculation
 - max77686: many cleanups
 - max77802 merged in max77686
 - pcf2123: cleanups and offset support
 - pcf85063: cleanups
 - pcf8523: propely handle oscillator stop bit
 - rv3029: many cleanups, trickle charger and temperature sensor support
 - rv8803: convert spin_lock to mutex_lock
 - rx8025: many fixes
 - vr41xx: restore alarm_irq_enable

----------------------------------------------------------------
Akinobu Mita (16):
      rtc: ds1307: add temperature sensor support for ds3231
      rtc: ds1307: add clock provider support for DS3231
      rtc: rx8025: fix irq handler registration
      rtc: rx8025: protect ctrl1 register update by rtc->ops_lock
      rtc: rx8025: round up to nearest minute for a minute accuracy alarm
      rtc: rx8025: unsupport UIE mode
      rtc: ds3232: convert to use regmap
      rtc: merge ds3232 and ds3234
      rtc: ds3232: fix read on /dev/rtc after RTC_AIE_ON
      rtc: ds3232: add register access error checks
      rtc: ds3232: remove unused UIE code
      rtc: ds3232: fix issue when irq is shared several devices
      rtc: ds3232: use rtc->ops_lock to protect alarm operations
      rtc: pcf2127: convert to use regmap
      rtc: pcf2127: add support for spi interface
      rtc: pcf2127: add pcf2129 device id

Alexander Kochetkov (1):
      rtc: hym8563: fix invalid year calculation

Alexandre Belloni (9):
      rtc: rx8025: remove rv8803 id
      rtc: rv3029: reword Kconfig option
      rtc: pcf85063: remove useless century handling
      rtc: always show I2C
      rtc: pcf85063: remove useless DRV_VERSION
      rtc: pcf85063: remove struct pcf85063
      rtc: pcf8523: properly handle oscillator stop bit
      rtc: enable COMPILE_TEST
      rtc: pxa: fix Kconfig indentation

Andre Przywara (1):
      rtc: allow compilation of sun6i RTC for all sunxi SoCs

Arnd Bergmann (2):
      rtc: mt6397: add IRQ domain dependency
      rtc: generic: allow building on all architectures

Dan Carpenter (1):
      rtc: ds1685: passing bogus values to irq_restore

Geert Uytterhoeven (1):
      rtc: vr41xx: Wire up alarm_irq_enable

Geliang Tang (1):
      rtc: ds1305: use to_spi_device and kobj_to_dev

Grygorii Strashko (5):
      rtc: palmas: Drop IRQF_EARLY_RESUME flag
      rtc: tps6586x: Drop IRQF_EARLY_RESUME flag
      rtc: tps65910: Drop IRQF_EARLY_RESUME flag
      rtc: tps80031: Drop IRQF_EARLY_RESUME flag
      rtc: as3722: Drop IRQF_EARLY_RESUME flag

Javier Martinez Canillas (9):
      rtc: max77686: Fix max77686_rtc_read_alarm() return value
      rtc: max77686: Use ARRAY_SIZE() instead of current array length
      rtc: max77686: Use usleep_range() instead of msleep()
      rtc: max77686: Use a driver data struct instead hard-coded values
      rtc: max77686: Add an indirection level to access RTC registers
      rtc: max77686: Add max77802 support
      rtc: max77686: Fix unsupported year message
      rtc: Remove Maxim 77802 driver
      rtc: mt6397: Remove plaform module alias

Josh Poimboeuf (1):
      rtc: ds1685: actually spin forever in poweroff error path

Joshua Clayton (8):
      rtc: pcf2123: define registers and bit macros
      rtc: pcf2123: clean up reads from the chip
      rtc: pcf2123: clean up writes to the rtc chip
      rtc: pcf2123: refactor chip reset into a function
      rtc: pcf2123: avoid resetting the clock if possible
      rtc: Add functions to set and read rtc offset
      rtc: implement a sysfs interface for clock offset
      rtc: pcf2123: implement read_offset and set_offset

Joshua Henderson (2):
      dt/bindings: Add bindings for the PIC32 real time clock
      rtc: pic32: Add PIC32 real time clock driver

Juergen Borleis (3):
      rtc: pcf85063: simplify code to read the current time
      rtc: pcf85063: fix time/date reading
      rtc: pcf85063: fix time/date setting

Krzysztof Kozlowski (3):
      rtc: max77686: Properly handle regmap_irq_get_virq() error code
      rtc: max77686: Cleanup and reduce dmesg output
      rtc: s5m: De-inline large functions to save space

Laxman Dewangan (7):
      rtc: max77686: fix checkpatch error
      rtc: max77686: use rtc regmap to access RTC registers
      rtc: max77686: avoid reference of parent device info multiple places
      mfd: max77686: do not set i2c client data for rtc i2c client
      rtc: max77686: move initialisation of rtc regmap, irq chip locally
      rtc: max77686: Add support for MAX20024/MAX77620 RTC IP
      rtc: max77686: Use REGMAP_IRQ_REG for regmap-rtc-irqs initialisation

Michael Buesch (8):
      rtc: rv3029: Remove all 'C2' suffixes from identifiers
      rtc: rv3029: Add "rv3029" I2C device id
      rtc: rv3029: Add missing register definitions
      rtc: rv3029: Add i2c register update-bits helper
      rtc: rv3029: Add functions for EEPROM access
      rtc: rv3029: Add device tree property for trickle charger
      rtc: rv3029: Add update_bits helper for eeprom access
      rtc: rv3029: Add thermometer hwmon support

Michael Lange (1):
      rtc: ds1307: add support for the DT property 'wakeup-source'

Oleksij Rempel (3):
      rtc: add Alphascale asm9260 driver
      doc: dt: add documentation for alphascale,asm9260-rtc
      rtc: rv8803: convert spin_lock to mutex_lock

Paul Gortmaker (1):
      rtc: make class.c explicitly non-modular

Soren Brinkmann (1):
      rtc: Group Kconfig entries by vendor

Steffen Trumtrar (2):
      Documentation: devicetree: add epson rx6110 binding
      rtc: add driver for RX6110SA real time clock

 .../bindings/rtc/alphascale,asm9260-rtc.txt        |  19 +
 .../devicetree/bindings/rtc/epson,rx6110.txt       |  39 ++
 .../devicetree/bindings/rtc/maxim,ds3231.txt       |  37 ++
 .../bindings/rtc/microchip,pic32-rtc.txt           |  21 +
 Documentation/rtc.txt                              |   6 +
 drivers/mfd/max77686.c                             |  86 +--
 drivers/rtc/Kconfig                                | 252 ++++---
 drivers/rtc/Makefile                               |   5 +-
 drivers/rtc/class.c                                |  13 -
 drivers/rtc/interface.c                            |  54 ++
 drivers/rtc/rtc-as3722.c                           |   2 +-
 drivers/rtc/rtc-asm9260.c                          | 355 ++++++++++
 drivers/rtc/rtc-ds1305.c                           |   4 +-
 drivers/rtc/rtc-ds1307.c                           | 411 +++++++++++-
 drivers/rtc/rtc-ds1685.c                           |   9 +-
 drivers/rtc/rtc-ds3232.c                           | 476 ++++++++------
 drivers/rtc/rtc-ds3234.c                           | 171 -----
 drivers/rtc/rtc-generic.c                          |  12 +-
 drivers/rtc/rtc-hym8563.c                          |   2 +-
 drivers/rtc/rtc-max77686.c                         | 565 ++++++++++++----
 drivers/rtc/rtc-max77802.c                         | 502 --------------
 drivers/rtc/rtc-mt6397.c                           |   1 -
 drivers/rtc/rtc-palmas.c                           |   3 +-
 drivers/rtc/rtc-pcf2123.c                          | 271 +++++---
 drivers/rtc/rtc-pcf2127.c                          | 335 ++++++++--
 drivers/rtc/rtc-pcf85063.c                         | 162 ++---
 drivers/rtc/rtc-pcf8523.c                          |  25 +-
 drivers/rtc/rtc-pic32.c                            | 411 ++++++++++++
 drivers/rtc/rtc-rv3029c2.c                         | 723 ++++++++++++++++-----
 drivers/rtc/rtc-rv8803.c                           |  39 +-
 drivers/rtc/rtc-rx6110.c                           | 402 ++++++++++++
 drivers/rtc/rtc-rx8025.c                           |  25 +-
 drivers/rtc/rtc-s5m.c                              |   8 +-
 drivers/rtc/rtc-sysfs.c                            |  35 +-
 drivers/rtc/rtc-tps6586x.c                         |   2 +-
 drivers/rtc/rtc-tps65910.c                         |   2 +-
 drivers/rtc/rtc-tps80031.c                         |   2 +-
 drivers/rtc/rtc-vr41xx.c                           |  13 +-
 include/linux/mfd/max77686-private.h               |   3 -
 include/linux/rtc.h                                |   4 +
 40 files changed, 3854 insertions(+), 1653 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
 create mode 100644 drivers/rtc/rtc-asm9260.c
 delete mode 100644 drivers/rtc/rtc-ds3234.c
 delete mode 100644 drivers/rtc/rtc-max77802.c
 create mode 100644 drivers/rtc/rtc-pic32.c
 create mode 100644 drivers/rtc/rtc-rx6110.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
