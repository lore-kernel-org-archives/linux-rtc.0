Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50098 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdIMQxJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Sep 2017 12:53:09 -0400
Date: Wed, 13 Sep 2017 18:53:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 4.14
Message-ID: <20170913165305.iapztosbftghxotj@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.14.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.14

for you to fetch changes up to b4be271cebb6f8b475f8bf2199091be8fe4c4278:

  rtc: ds1307: use octal permissions (2017-09-05 09:55:05 +0200)

----------------------------------------------------------------
RTC for 4.14

Subsystem:
 - Remove .open() and .release() RTC ops
 - constify i2c_device_id

New driver:
 - Realtek RTD1295
 - Android emulator (goldfish) RTC

Drivers:
 - ds1307: Beginning of a huge cleanup
 - s35390a: handle invalid RTC time
 - sun6i: external oscillator gate support

----------------------------------------------------------------
Aleksandar Markovic (1):
      dt-bindings: Add device tree binding for Goldfish RTC driver

Alexandre Belloni (16):
      rtc: puv3: switch to devm_rtc_allocate_device()/rtc_register_device()
      rtc: puv3: make alarms useful
      rtc: m41t80: remove debug sysfs attribute
      rtc: pxa: fix possible race condition
      rtc: sa1100: fix unbalanced clk_prepare_enable/clk_disable_unprepare
      rtc: sa1100: make alarms useful
      rtc: vr41xx: make alarms useful
      rtc: mxc: avoid disabling interrupts on device close
      rtc: remove .open() and .release()
      rtc: ds1307: remove regs member
      rtc: ds1307: use sizeof
      rtc: ds1307: use u32
      rtc: ds1307: use BIT
      rtc: ds1307: fix alignments and blank lines
      rtc: ds1307: fix braces
      rtc: ds1307: use octal permissions

Alexey Klimov (1):
      rtc: sun6i: Remove double init of spinlock in sun6i_rtc_clk_init()

Andreas Färber (2):
      dt-bindings: rtc: Add Realtek RTD1295
      rtc: Add Realtek RTD1295

Arvind Yadav (1):
      rtc: constify i2c_device_id

Colin Ian King (2):
      rtc: sun6i: ensure clk_data is kfree'd on error
      rtc: max8925: remove redundant check on ret

Elaine Zhang (1):
      rtc: rk808: Name RK805 in Kconfig for RTC_DRV_RK808

Eric Cooper (1):
      rtc: m41t80: enable wakealarm when "wakeup-source" is specified

Fabien Lahoudere (2):
      rtc: s35390a: handle invalid RTC time
      rtc: s35390a: implement ioctls

Heiner Kallweit (10):
      rtc: ds1307: remove legacy check for "isil, irq2-can-wakeup-machine" property
      rtc: ds1307: remove member irq from struct ds1307
      rtc: ds1307: factor out bbsqi bit to struct chip_desc
      rtc: ds1307: improve trickle charger initialization
      rtc: ds1307: constify struct chip_desc variables
      rtc: ds1307: improve irq setup
      rtc: ds1307: factor out irq_handler to struct chip_desc
      rtc: ds1307: factor out rtc_ops to struct chip_desc
      rtc: ds1307: factor out offset to struct chip_desc
      rtc: ds1307: remove member nvram_offset from struct ds1307

Maxime Ripard (1):
      rtc: sun6i: Add support for the external oscillator gate

Miodrag Dinic (1):
      rtc: goldfish: Add RTC driver for Android emulator

Nikita Yushchenko (1):
      rtc: ds1307: add basic support for ds1341 chip

 .../devicetree/bindings/power/wakeup-source.txt    |   9 +-
 .../bindings/rtc/google,goldfish-rtc.txt           |  17 +
 .../devicetree/bindings/rtc/isil,isl12057.txt      |   1 -
 .../devicetree/bindings/rtc/realtek,rtd119x.txt    |  16 +
 .../devicetree/bindings/rtc/sun6i-rtc.txt          |   4 +-
 MAINTAINERS                                        |   6 +
 drivers/rtc/Kconfig                                |  30 +-
 drivers/rtc/Makefile                               |   2 +
 drivers/rtc/rtc-dev.c                              |  20 +-
 drivers/rtc/rtc-ds1307.c                           | 457 +++++++++++----------
 drivers/rtc/rtc-ds1672.c                           |   2 +-
 drivers/rtc/rtc-em3027.c                           |   2 +-
 drivers/rtc/rtc-goldfish.c                         | 237 +++++++++++
 drivers/rtc/rtc-m41t80.c                           |  67 +--
 drivers/rtc/rtc-max6900.c                          |   2 +-
 drivers/rtc/rtc-max8925.c                          |   2 -
 drivers/rtc/rtc-mxc.c                              |  21 -
 drivers/rtc/rtc-puv3.c                             |  72 +---
 drivers/rtc/rtc-pxa.c                              |   4 +-
 drivers/rtc/rtc-rtd119x.c                          | 242 +++++++++++
 drivers/rtc/rtc-rv3029c2.c                         |   2 +-
 drivers/rtc/rtc-s35390a.c                          | 104 +++--
 drivers/rtc/rtc-sa1100.c                           |  65 +--
 drivers/rtc/rtc-sun6i.c                            |  34 +-
 drivers/rtc/rtc-vr41xx.c                           |  18 -
 include/linux/rtc.h                                |   2 -
 26 files changed, 953 insertions(+), 485 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
 create mode 100644 drivers/rtc/rtc-goldfish.c
 create mode 100644 drivers/rtc/rtc-rtd119x.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
