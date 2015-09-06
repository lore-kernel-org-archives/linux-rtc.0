Return-Path: <rtc-linux+bncBDS7HNEFSALRBS4TWCXQKGQEPO5NLTA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k7si60192wif.1.2015.09.06.02.39.23
        for <rtc-linux@googlegroups.com>;
        Sun, 06 Sep 2015 02:39:23 -0700 (PDT)
Date: Sun, 6 Sep 2015 11:39:21 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.3
Message-ID: <20150906093921.GA17978@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Linus,

Here is the pull-request for the RTC susbsystem for 4.3. I rebased on
your tree yesterday to be able to take a patch fixing a warning that
appeared following a patch that went through GKH's tree. Tell me if this
wasn't the proper course of action.

The main drawback is that this hides a simple add/add conflict in
arch/arm/boot/dts/am437x-gp-evm.dts


The following changes since commit f377ea88b862bf7151be96d276f4cb740f8e1c41:

  Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2015-09-04 15:49:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-v4.3

for you to fetch changes up to 5f1b2f77646fc0ef2f36fc554f5722a1381d0892:

  rtc: abx80x: fix RTC write bit (2015-09-05 19:37:31 +0200)

----------------------------------------------------------------
RTC for 4.3

Core:
 - use is_visible() to control sysfs attributes
 - switch wakealarm attribute to DEVICE_ATTR_RW
 - make rtc_does_wakealarm() return boolean
 - properly manage lifetime of dev and cdev in rtc device
 - remove unnecessary device_get() in rtc_device_unregister
 - fix double free in rtc_register_device() error path

New drivers:
 - NXP LPC24xx
 - Xilinx Zynq MP
 - Dialog DA9062

Subsystem wide cleanups:
 - fix drivers that consider 0 as a valid IRQ in client->irq
 - Drop (un)likely before IS_ERR(_OR_NULL)
 - drop the remaining owner assignment for i2c_driver and platform_driver
 - module autoload fixes

Drivers:
 - 88pm80x: add device tree support
 - abx80x: fix RTC write bit
 - ab8500: Add a sentinel to ab85xx_rtc_ids[]
 - armada38x: Align RTC set time procedure with the official errata
 - as3722: correct month value
 - at91sam9: cleanups
 - at91rm9200: get and use slow clock and cleanups
 - bq32k: remove redundant check
 - cmos: century support, proper fix for the spurious wakeup
 - ds1307: cleanups and wakeup irq support
 - ds1374: Remove unused variable
 - ds1685: Use module_platform_driver
 - ds3232: fix WARNING trace in resume function
 - gemini: fix ptr_ret.cocci warnings
 - mt6397: implement suspend/resume
 - omap: support internal and external clock enabling
 - opal: Enable alarms only when opal supports tpo
 - pcf2127: use OFS flag to detect unreliable date and warn the user
 - pl031: fix typo for author email
 - rx8025: huge cleanup and fixes
 - sa1100/pxa: share common code
 - s5m: fix to update ctrl register
 - s3c: fix clocks and wakeup, cleanup
 - sirfsoc: use regmap
 - nvram_read()/nvram_write() functions for cmos, ds1305, ds1307, ds1343,
 ds1511, ds1553, ds1742, m48t59, rp5c01, stk17ta8, tx4939
 - use rtc_valid_tm() error code when reading date/time instead of 0 for
 isl12022, pcf2123, pcf2127

----------------------------------------------------------------
Adrian Huang (2):
      rtc: cmos: Cancel alarm timer if alarm time is equal to now+1 seconds
      rtc: cmos: Revert "rtc-cmos: Add an alarm disable quirk"

Alexandre Belloni (23):
      rtc: at91sam9: properly handle error case
      rtc: at91sam9: remove useless check
      rtc: at91sam9: sort headers alphabetically
      rtc: at91sam9: get sclk rate after enabling it
      rtc: at91rm9200: sort headers alphabetically
      rtc: at91rm9200: get and use slow clock
      rtc: rx8025: remove useless headers and reorder them
      rtc: rx8025: Convert to threaded IRQ
      rtc: rx8025: switch to managed irq allocation
      rtc: rx8025: remove useless probe error message
      rtc: rx8025: use BIT()
      rtc: rx8025: only handle dates between 2000 and 2099
      rtc: rx8025: fix transfer mode
      rtc: rx8025: don't reset the time
      rtc: rx8025: cleanup accessors
      rtc: rx8025: continue without alarm when irq request fails
      rtc: rx8025: fix rx8025_init_client()
      rtc: rx8025: reset validity when setting time
      rtc: rx8025: remove useless initialization
      rtc: rx8025: fix RX8025_BIT_CTRL2_CTFG initialization
      rtc: rx8025: check time validity when necessary
      rtc: at91sam9: include linux/of.h
      rtc: at91sam9: remove useless include

Andrea Scian (2):
      rtc: use rtc_valid_tm() error code when reading date/time
      rtc: pcf2127: use OFS flag to detect unreliable date and warn the user

Bibek Basu (1):
      rtc: as3722: correct month value

Dmitry Torokhov (6):
      rtc: class: fix double free in rtc_register_device() error path
      rtc: class: remove unnecessary device_get() in rtc_device_unregister
      rtc: dev: properly manage lifetime of dev and cdev in rtc device
      rtc: make rtc_does_wakealarm() return boolean
      rtc: switch wakealarm attribute to DEVICE_ATTR_RW
      rtc: switch to using is_visible() to control sysfs attributes

Fabio Estevam (2):
      rtc: ds1374: Remove unused variable
      rtc: ab8500: Add a sentinel to ab85xx_rtc_ids[]

Felipe Balbi (1):
      rtc: ds1307: Convert to threaded IRQ

Guo Zeng (1):
      rtc: sirfsoc: move to regmap APIs from platform-specific APIs

Henri Roosen (1):
      rtc: rx8025: remove obsolete local_irq_disable() and local_irq_enable() for rtc_update_irq()

Henry Chen (1):
      rtc: mt6397: implement suspend/resume function in rtc-mt6397 driver

Javier Martinez Canillas (3):
      rtc: Export OF module alias information in missing drivers
      rtc: Fix module autoload for rtc-{ab8500,max8997,s5m} drivers
      rtc: Fix module autoload for OF platform drivers

Joachim Eastwood (2):
      doc: dt: add documentation for nxp,lpc1788-rtc
      rtc: add rtc-lpc24xx driver

Joonyoung Shim (4):
      rtc: s3c: fix disabled clocks for alarm
      rtc: s3c: add missing clk control
      rtc: s3c: remove unnecessary NULL assignment
      rtc: s5m: fix to update ctrl register

Keerthy (3):
      ARM: dts: AM437x: Add the internal and external clock nodes for rtc
      rtc: omap: Add internal clock enabling support
      rtc: omap: Add external clock enabling support

Krzysztof Kozlowski (2):
      rtc: Drop owner assignment from i2c_driver
      rtc: Drop owner assignment from platform_driver

Leo Yan (1):
      rtc: pl031: fix typo for author email

Maninder Singh (1):
      rtc: bq32k: remove redundant check

Mitja Spes (1):
      rtc: abx80x: fix RTC write bit

Nadav Haklai (1):
      rtc: armada38x: Align RTC set time procedure with the official errata

Nishanth Menon (3):
      rtc: ds1307: Switch to managed irq allocation
      rtc: ds1307: Sort the headers
      rtc: ds1307: Support optional wakeup interrupt source

Octavian Purdila (1):
      rtc: fix drivers that consider 0 as a valid IRQ in client->irq

Rob Herring (7):
      rtc: sa1100: prepare to share sa1100_rtc_ops
      rtc: pxa: convert to use shared sa1100 functions
      ARM: pxa: add memory resource to SA1100 RTC device
      rtc: sa1100/pxa: convert to run-time register mapping
      ARM: sa1100: remove unused RTC register definitions
      ARM: mmp: remove unused RTC register definitions
      ARM: config: Switch PXA27x platforms to use PXA RTC driver

S Twiss (1):
      rtc: da9063: Add DA9062 RTC capability to DA9063 RTC driver

Suneel Garapati (2):
      devicetree: bindings: rtc: add bindings for xilinx zynqmp rtc
      rtc: add xilinx zynqmp rtc driver

Sylvain Chouleur (1):
      rtc: cmos: century support

Vaibhav Hiremath (1):
      rtc: 88pm80x: add device tree support

Vaibhav Jain (1):
      rtc: opal: Enable alarms only when opal supports tpo

Vaishali Thakkar (1):
      rtc: ds1685: Use module_platform_driver

Vladimir Zapolskiy (11):
      rtc: cmos: clean up cmos_nvram_read()/cmos_nvram_write()
      rtc: ds1305: clean up ds1305_nvram_read()/ds1305_nvram_write()
      rtc: ds1307: clean up ds1307_nvram_read()/ds1307_nvram_write()
      rtc: ds1343: clean up ds1343_nvram_read()/ds1343_nvram_write()
      rtc: ds1511: clean up ds1511_nvram_read()/ds1511_nvram_write()
      rtc: ds1553: clean up ds1553_nvram_read()/ds1553_nvram_write()
      rtc: ds1742: clean up ds1742_nvram_read()/ds1742_nvram_write()
      rtc: m48t59: clean up m48t59_nvram_read()/m48t59_nvram_write()
      rtc: rp5c01: clean up rp5c01_nvram_read()/rp5c01_nvram_write()
      rtc: stk17ta8: clean up stk17ta8_nvram_read()/stk17ta8_nvram_write()
      rtc: tx4939: clean up tx4939_rtc_nvram_read()/tx4939_rtc_nvram_write()

Wang Dongsheng (1):
      rtc: ds3232: fix WARNING trace in resume function

kbuild test robot (1):
      rtc: gemini: fix ptr_ret.cocci warnings

viresh kumar (1):
      rtc: Drop (un)likely before IS_ERR(_OR_NULL)

 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    |  21 ++
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |   4 +
 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt |  25 ++
 arch/arm/boot/dts/am4372.dtsi                      |   2 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |  13 +
 arch/arm/boot/dts/am437x-idk-evm.dts               |   9 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |   9 +
 arch/arm/configs/cm_x2xx_defconfig                 |   2 +-
 arch/arm/configs/em_x270_defconfig                 |   2 +-
 arch/arm/configs/magician_defconfig                |   2 +-
 arch/arm/configs/palmz72_defconfig                 |   2 +-
 arch/arm/configs/pcm027_defconfig                  |   2 +-
 arch/arm/configs/trizeps4_defconfig                |   2 +-
 arch/arm/mach-mmp/include/mach/regs-rtc.h          |  23 --
 arch/arm/mach-pxa/devices.c                        |  18 +-
 arch/arm/mach-pxa/pxa27x.c                         |   1 -
 arch/arm/mach-pxa/pxa3xx.c                         |   1 -
 arch/arm/mach-sa1100/include/mach/SA-1100.h        |  34 --
 drivers/rtc/Kconfig                                |  37 +-
 drivers/rtc/Makefile                               |   2 +
 drivers/rtc/class.c                                |  33 +-
 drivers/rtc/interface.c                            |   2 +-
 drivers/rtc/rtc-88pm80x.c                          |  28 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                       |   2 +-
 drivers/rtc/rtc-ab8500.c                           |   2 +
 drivers/rtc/rtc-abx80x.c                           |   2 +-
 drivers/rtc/rtc-armada38x.c                        |  33 +-
 drivers/rtc/rtc-as3722.c                           |   4 +-
 drivers/rtc/rtc-at91rm9200.c                       |  43 ++-
 drivers/rtc/rtc-at91sam9.c                         |  45 ++-
 drivers/rtc/rtc-bfin.c                             |   2 +-
 drivers/rtc/rtc-bq32k.c                            |   3 +-
 drivers/rtc/rtc-cmos.c                             | 125 ++++---
 drivers/rtc/rtc-coh901331.c                        |   1 +
 drivers/rtc/rtc-core.h                             |  19 +-
 drivers/rtc/rtc-da9063.c                           | 392 +++++++++++++++------
 drivers/rtc/rtc-dev.c                              |   1 +
 drivers/rtc/rtc-ds1305.c                           |  18 -
 drivers/rtc/rtc-ds1307.c                           | 120 +++----
 drivers/rtc/rtc-ds1343.c                           |  12 -
 drivers/rtc/rtc-ds1374.c                           |   7 +-
 drivers/rtc/rtc-ds1511.c                           |  42 +--
 drivers/rtc/rtc-ds1553.c                           |   4 +-
 drivers/rtc/rtc-ds1685.c                           |  22 +-
 drivers/rtc/rtc-ds1742.c                           |   4 +-
 drivers/rtc/rtc-ds3232.c                           |   8 +-
 drivers/rtc/rtc-fm3130.c                           |   1 -
 drivers/rtc/rtc-gemini.c                           |   5 +-
 drivers/rtc/rtc-hym8563.c                          |   1 -
 drivers/rtc/rtc-isl12022.c                         |   8 +-
 drivers/rtc/rtc-isl12057.c                         |   2 +-
 drivers/rtc/rtc-lpc24xx.c                          | 310 ++++++++++++++++
 drivers/rtc/rtc-m48t59.c                           |  18 +-
 drivers/rtc/rtc-max8997.c                          |   1 +
 drivers/rtc/rtc-moxart.c                           |   1 +
 drivers/rtc/rtc-mpc5121.c                          |   1 +
 drivers/rtc/rtc-mt6397.c                           |  27 ++
 drivers/rtc/rtc-mv.c                               |   1 +
 drivers/rtc/rtc-omap.c                             |  33 ++
 drivers/rtc/rtc-opal.c                             |  10 +-
 drivers/rtc/rtc-pcf2123.c                          |   8 +-
 drivers/rtc/rtc-pcf2127.c                          |  35 +-
 drivers/rtc/rtc-pcf85063.c                         |   1 -
 drivers/rtc/rtc-pcf8523.c                          |   1 -
 drivers/rtc/rtc-pcf8563.c                          |   1 -
 drivers/rtc/rtc-pcf8583.c                          |   1 -
 drivers/rtc/rtc-pl031.c                            |   2 +-
 drivers/rtc/rtc-pxa.c                              |  55 +--
 drivers/rtc/rtc-rp5c01.c                           |   4 +-
 drivers/rtc/rtc-rx8025.c                           | 277 ++++++---------
 drivers/rtc/rtc-rx8581.c                           |   1 -
 drivers/rtc/rtc-s3c.c                              |  28 +-
 drivers/rtc/rtc-s5m.c                              |  11 +
 drivers/rtc/rtc-sa1100.c                           | 139 +++++---
 drivers/rtc/rtc-sa1100.h                           |  23 ++
 drivers/rtc/rtc-sirfsoc.c                          | 107 +++---
 drivers/rtc/rtc-stk17ta8.c                         |   4 +-
 drivers/rtc/rtc-sysfs.c                            |  72 ++--
 drivers/rtc/rtc-tx4939.c                           |   6 +-
 drivers/rtc/rtc-vt8500.c                           |   1 +
 drivers/rtc/rtc-zynqmp.c                           | 279 +++++++++++++++
 include/asm-generic/rtc.h                          |  29 ++
 82 files changed, 1756 insertions(+), 933 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h
 create mode 100644 drivers/rtc/rtc-lpc24xx.c
 create mode 100644 drivers/rtc/rtc-sa1100.h
 create mode 100644 drivers/rtc/rtc-zynqmp.c

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
