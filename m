Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7625 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeBTVoG (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:06 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/21] lib, rtc: Print rtc_time via %ptR[dt][rv]
Date: Tue, 20 Feb 2018 23:43:39 +0200
Message-Id: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

At some point I have noticed too many users of struct rtc_time that
printing its content field by field.

In this series I introduce %ptR[dt][rv] specifier to make life a bit
easier.

There are still users of detailed output of the struct rtc_time, but we
can introduce an additional extension for them in the future if needed,
otherwise they might be converted to the proposed output format.

Some of the changes slightly modify the output. In those cases we are on
the safe side since they are pure debug. Nevertheless I tried to leave
numbers to be the same or quite close: in some cases year is printed +
1900, though month is left in the range [0,11] instead of [1,12].

I didn't compile everything there, though I did a basic smoke test on
some x86 hardware. So, I rely on kbuild test robot as well :-)

Most of the users currently are RTC drivers, thus the patch series is
assumed to go via RTC tree.

The patch series depends on earlier send clean up of lib/vsprintf [1].

[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1612716.html

Changelog v2:
- split out lib/vsprintf changes to separate series
- build it optionally depending on introduced PRINTK_PEXT_TIMEDATE
- for now support only struct rtc_time
- make an additional letter for different time representations
- make above letter capital to reduce confusion on %ptr vs. %ptR
- drop kdb patch since it's a candidate for time64_t support

Andy Shevchenko (21):
  lib/vsprintf: Print time and date in human readable format via %pt
  rtc: Switch to use %ptR
  rtc: at91rm9200: Switch to use %ptR
  rtc: at91sam9: Switch to use %ptR
  rtc: m41t80: Switch to use %ptR
  rtc: m48t59: Switch to use %ptR
  rtc: mcp795: Switch to use %ptR
  rtc: pcf50633: Switch to use %ptR
  rtc: pic32: Switch to use %ptR
  rtc: pm8xxx: Switch to use %ptR
  rtc: puv3: Switch to use %ptR
  rtc: rk808: Switch to use %ptR
  rtc: rx6110: Switch to use %ptR
  rtc: rx8025: Switch to use %ptR
  rtc: s3c: Switch to use %ptR
  rtc: s5m: Switch to use %ptR
  rtc: tegra: Switch to use %ptR
  ds1302: Switch to use %ptR
  Input: hp_sdc_rtc - Switch to use %ptR
  mk68/mac: Switch to use %ptR
  PM: Switch to use %ptR

 Documentation/core-api/printk-formats.rst |  31 +++++++
 arch/m68k/Kconfig.machine                 |   1 +
 arch/m68k/mac/misc.c                      |   8 +-
 drivers/base/power/trace.c                |   4 +-
 drivers/char/Kconfig                      |   2 +
 drivers/char/ds1302.c                     |  39 +++-----
 drivers/char/rtc.c                        |   7 +-
 drivers/input/misc/Kconfig                |   1 +
 drivers/input/misc/hp_sdc_rtc.c           |   8 +-
 drivers/rtc/Kconfig                       |   1 +
 drivers/rtc/hctosys.c                     |   8 +-
 drivers/rtc/interface.c                   |   8 +-
 drivers/rtc/rtc-at91rm9200.c              |  15 +---
 drivers/rtc/rtc-at91sam9.c                |  16 +---
 drivers/rtc/rtc-m41t80.c                  |   6 +-
 drivers/rtc/rtc-m48t59.c                  |   8 +-
 drivers/rtc/rtc-mcp795.c                  |  18 ++--
 drivers/rtc/rtc-pcf50633.c                |   8 +-
 drivers/rtc/rtc-pic32.c                   |  18 +---
 drivers/rtc/rtc-pm8xxx.c                  |  16 ++--
 drivers/rtc/rtc-proc.c                    |  36 ++------
 drivers/rtc/rtc-puv3.c                    |  18 +---
 drivers/rtc/rtc-rk808.c                   |  20 ++---
 drivers/rtc/rtc-rx6110.c                  |  12 +--
 drivers/rtc/rtc-rx8025.c                  |  19 +---
 drivers/rtc/rtc-s3c.c                     |  21 ++---
 drivers/rtc/rtc-s5m.c                     |  27 ++----
 drivers/rtc/rtc-sysfs.c                   |  12 +--
 drivers/rtc/rtc-tegra.c                   |  30 +------
 kernel/power/Kconfig                      |   1 +
 lib/Kconfig                               |   8 ++
 lib/test_printf.c                         |   6 ++
 lib/vsprintf.c                            | 145 ++++++++++++++++++++++++++++++
 33 files changed, 287 insertions(+), 291 deletions(-)

-- 
2.15.1
