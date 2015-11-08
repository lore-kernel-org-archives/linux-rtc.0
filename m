Return-Path: <rtc-linux+bncBDS7HNEFSALRBZ4W7WYQKGQEKC7WTCQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t18si303438wme.0.2015.11.08.05.17.27
        for <rtc-linux@googlegroups.com>;
        Sun, 08 Nov 2015 05:17:27 -0800 (PST)
Date: Sun, 8 Nov 2015 14:17:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.4
Message-ID: <20151108131726.GA16866@piout.net>
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

Here is the pull-request for the RTC susbsystem for 4.4. This cycle was act=
ually quite calm.


The following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861=
:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-v4.4

for you to fetch changes up to 1e3929ef0e1c4c7127b785ce7a236965b3739406:

  rtc: Add a driver for Micro Crystal RV8803 (2015-11-08 14:12:32 +0100)

----------------------------------------------------------------
RTC for 4.4

Core:
 - Fix rtctest error path

New drivers:
 - Microcrystal RV8803

Subsystem wide cleanups:
 - remove misuse of IRQF_NO_SUSPEND flag

Drivers:
 - at91rm9200: clear RTC alarm status flag prior to suspending
 - davinci: remove incorrect reference to probe function
 - ds1307: Fix alarm programming for mcp794xx
 - ds1390: trickle charger support, fix ds1390_get_reg
 - isl1208: Pass the IRQF_ONESHOT flag
 - opal: fix type of token
 - pcf2127: fix RTC_READ_VL, remove useless driver version
 - pcf85063: return an error when date is invalid
 - pcf8563: add CLKOUT to common clock framework
 - rx8025: remove unnecessary braces
 - s3c: Set year, month, day value for setting alarm
 - stmp3xxx: unify register access macros
 - License fixes: pcf2127, da9063
 - wakeup-source support for isl12057 and opal

----------------------------------------------------------------
Alexandre Belloni (3):
      rtc: rx8025: remove unnecessary braces
      rtc: pcf85063: return an error when date is invalid
      rtc: Add a driver for Micro Crystal RV8803

Andrzej Hajda (1):
      rtc: opal: fix type of token

Arnd Bergmann (1):
      rtc: davinci: remove incorrect reference to probe function

Fabio Estevam (1):
      rtc: isl1208: Pass the IRQF_ONESHOT flag

Harald Geyer (1):
      rtc: stmp3xxx: unify register access macros

Heiko Schocher (1):
      rtc: pcf8563: add CLKOUT to common clock framework

Ivan Grimaldi (2):
      rtc: ds1390: fix ds1390_get_reg return value
      rtc: ds1390: Add trickle charger device tree binding

Krzysztof Kozlowski (1):
      rtc: s3c: Set year, month, day value for setting alarm

Steve Twiss (1):
      rtc: da9063: GPL copyright inconsistency fix

Sudeep Holla (5):
      rtc: pl031: remove misuse of IRQF_NO_SUSPEND flag
      rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag
      rtc: ds1343: remove misuse of IRQF_NO_SUSPEND flag
      rtc: opal: enable support for the stardard "wakeup-source" property
      rtc: isl12057: enable support for the standard "wakeup-source" proper=
ty

Tero Kristo (1):
      rtc: ds1307: Fix alarm programming for mcp794xx

Uwe Kleine-K=C3=B6nig (4):
      rtc: pcf2127: make module license match the file header
      rtc: rtctest: enabling UIE for a chip that doesn't support it returns=
 EINVAL
      rtc: pcf2127: fix reading uninitialized value on RTC_READ_VL ioctl
      rtc: pcf2127: remove useless driver version

Wenyou Yang (1):
      rtc: at91rm9200: clear RTC alarm status flag prior to suspending

 .../devicetree/bindings/rtc/dallas,ds1390.txt      |  18 +
 Documentation/devicetree/bindings/rtc/pcf8563.txt  |  25 +
 drivers/rtc/Kconfig                                |  13 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-ab8500.c                           |   6 +-
 drivers/rtc/rtc-at91rm9200.c                       |   2 +
 drivers/rtc/rtc-da9063.c                           |  18 +-
 drivers/rtc/rtc-davinci.c                          |   1 -
 drivers/rtc/rtc-ds1307.c                           |   4 +-
 drivers/rtc/rtc-ds1343.c                           |   9 +-
 drivers/rtc/rtc-ds1390.c                           |  65 ++-
 drivers/rtc/rtc-isl12057.c                         |  10 +-
 drivers/rtc/rtc-isl1208.c                          |   2 +-
 drivers/rtc/rtc-opal.c                             |   9 +-
 drivers/rtc/rtc-pcf2127.c                          |  47 +-
 drivers/rtc/rtc-pcf85063.c                         |   8 +-
 drivers/rtc/rtc-pcf8563.c                          | 170 ++++++-
 drivers/rtc/rtc-pl031.c                            |  13 +-
 drivers/rtc/rtc-rv8803.c                           | 521 +++++++++++++++++=
++++
 drivers/rtc/rtc-rx8025.c                           |   4 +-
 drivers/rtc/rtc-s3c.c                              |  16 +
 drivers/rtc/rtc-stmp3xxx.c                         |  27 +-
 tools/testing/selftests/timers/rtctest.c           |   2 +-
 23 files changed, 908 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt
 create mode 100644 drivers/rtc/rtc-rv8803.c

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
