Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBW4TRG6QKGQEB6TCY6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y7si24106wmd.0.2016.08.03.12.45.31
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Aug 2016 12:45:31 -0700 (PDT)
Date: Wed, 3 Aug 2016 21:45:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.8
Message-ID: <20160803194520.GA3931@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.8.

There will be a small conflict in arch/x86/platform/efi/efi_64.c that
is easy to solve and was properly solved in linux-next.

The following changes since commit 1a695a905c18548062509178b98bc91e67510864=
:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.8

for you to fetch changes up to 6f367788d6333a41fefd013975b0b160d5c0a1c8:

  rtc: rv8803: Clear V1F when setting the time (2016-07-28 09:59:43 +0200)

----------------------------------------------------------------
RTC for 4.8

Cleanups:
 - huge cleanup of rtc-generic and char/genrtc this allowed to cleanup rtc-=
cmos,
  rtc-sh, rtc-m68k, rtc-powerpc and rtc-parisc
 - move mn10300 to rtc-cmos

Subsystem:
 - fix wakealarms after hibernate
 - multiples fixes for rctest
 - simplify implementations of .read_alarm

New drivers:
 - Maxim MAX6916

Drivers:
 - ds1307: fix weekday
 - m41t80: add wakeup support
 - pcf85063: add support for PCF85063A variant
 - rv8803: extend i2c fix and other fixes
 - s35390a: fix alarm reading, this fixes instant reboot after shutdown for=
 QNAP
   TS-41x
 - s3c: clock fixes

----------------------------------------------------------------
Alexander Graf (1):
      rtc: efi: Fail probing if RTC reads don't work

Alexandre Belloni (8):
      rtc: rv8803: broaden workaround
      rtc: ds17287: remove unused header
      rtc: ds2404: move rtc-ds2404.h to platform_data
      rtc: m48t86: move m48t86.h to platform_data
      rtc: adjust MAINTAINERS entry
      rtc: ds1286: move header to linux/rtc
      rtc: v3020: move rtc-v3020.h to platform_data
      rtc: pcf85063: fix year range

Alim Akhtar (2):
      rtc: s3c: Remove unnecessary call to disable already disabled clock
      rtc: s3c: Add s3c_rtc_{enable/disable}_clk in s3c_rtc_setfreq()

Andrey Smirnov (3):
      rtc: rtctest: Change alarm IRQ support detection
      rtc: rtctest: Change no IRQ detection for RTC_IRQP_READ
      rtc: rtctest: Change no IRQ detection for RTC_IRQP_SET

Arnd Bergmann (20):
      rtc: cmos: remove empty asm/mc146818rtc.h files
      rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h
      char/genrtc: x86: remove remnants of asm/rtc.h
      rtc: sh: provide rtc_class_ops directly
      char/genrtc: remove alpha support
      char/genrtc: remove mn10300 support
      rtc: parisc: provide rtc_class_ops directly
      char/genrtc: remove parisc support
      rtc: m68k: provide rtc_class_ops directly
      rtc: m68k: provide ioctl for q40
      char/genrtc: remove m68k support
      rtc: powerpc: provide rtc_class_ops directly
      char/genrtc: remove powerpc support
      rtc: generic: remove get_rtc_time/set_rtc_time wrappers
      char/genrtc: remove asm-generic/rtc.h from mips
      char/genrtc: remove the rest of the driver
      sparc32: remove stale RTC_PORT definition
      x86: include linux/ratelimit.h in nmi.c
      mn10300: use RTC_DRV_CMOS instead of CONFIG_RTC
      rtc: move mc146818 helper functions out-of-line

Beno=C3=AEt Th=C3=A9baudeau (6):
      rtc: rv8803: Kconfig: Indicate rx8900 support
      rtc: rv8803: Remove the check for valid time
      rtc: rv8803: Fix read day of week
      rtc: rv8803: Always apply the I=C2=B2C workaround
      rtc: rv8803: Stop the clock while setting the time
      rtc: rv8803: Clear V1F when setting the time

Chris DeBruin (1):
      rtc: pcf85063: Add support for the PCF85063A device

Colin Ian King (1):
      rtc: interface: ignore expired timers when enqueuing new timers

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for rtc device tree bindings

Heinrich Schuchardt (1):
      rtc: ds1685: correct day of month checking

Keerthy (1):
      rtc: ds1307: Fix relying on reset value for weekday

Martin Kepplinger (1):
      rtc: pcf2123: use sign_extend32() for sign extension

Stefan Christ (2):
      rtc: m41t80: make it a real error message
      rtc: m41t80: add suspend handlers for alarm IRQ

Sudip Mukherjee (2):
      rtc: m41t80: use devm_add_action_or_reset()
      rtc: abx80x: use devm_add_action_or_reset()

Uwe Kleine-K=C3=B6nig (12):
      rtc: initialize output parameter for read alarm to "uninitialized"
      rtc: simplify implementations of read_alarm
      rtc: isl12057: let the rtc core interpret the partial alarm
      rtc: sh: drop bogus assignment of tm_year in .read_alarm
      rtc: sh: don't validate alarm time provided to .set_alarm
      rtc: s35390a: fix reading out alarm
      rtc: s35390a: implement reset routine as suggested by the reference
      rtc: s35390a: improve irq handling
      rtc: s35390a: improve two comments in .set_alarm
      rtc: fix a typo and reduce three empty lines to one
      rtc: explicitly set tm_sec =3D 0 for drivers with minute accurancy
      rtc: hym8563: in .read_alarm set .tm_sec to 0 to signal minute accura=
cy

Venkat Prashanth B U (1):
      rtc: add support for Maxim max6916

Wei Yongjun (2):
      rtc: at91sam9: Fix missing spin_lock_init()
      rtc: asm9260: remove .owner field for driver

 MAINTAINERS                                        |   4 +
 arch/alpha/include/asm/rtc.h                       |   1 -
 arch/alpha/kernel/core_marvel.c                    |   1 -
 arch/alpha/kernel/rtc.c                            |   6 +-
 arch/arm/mach-ep93xx/ts72xx.c                      |   2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c               |   2 +-
 arch/arm/mach-pxa/cm-x270.c                        |   2 +-
 arch/arm/mach-pxa/cm-x300.c                        |   2 +-
 arch/arm/mach-pxa/em-x270.c                        |   2 +-
 arch/frv/include/asm/mc146818rtc.h                 |  16 -
 arch/h8300/include/asm/mc146818rtc.h               |   9 -
 arch/ia64/include/asm/mc146818rtc.h                |  10 -
 arch/m68k/amiga/config.c                           |   1 -
 arch/m68k/apollo/config.c                          |   1 -
 arch/m68k/bvme6000/config.c                        |   1 -
 arch/m68k/hp300/config.c                           |   2 +-
 arch/m68k/include/asm/rtc.h                        |  79 ---
 arch/m68k/kernel/time.c                            |  48 +-
 arch/m68k/mac/config.c                             |   3 +-
 arch/m68k/mac/misc.c                               |   1 -
 arch/m68k/mvme147/config.c                         |   1 -
 arch/m68k/mvme16x/config.c                         |   1 -
 arch/m68k/q40/config.c                             |   2 +-
 arch/m68k/sun3/config.c                            |   1 -
 arch/m68k/sun3/intersil.c                          |   2 +-
 arch/m68k/sun3x/time.c                             |   2 +-
 arch/mips/sgi-ip22/ip22-reset.c                    |   2 +-
 arch/mips/sni/time.c                               |   1 -
 arch/mn10300/Kconfig                               |   4 +-
 arch/mn10300/include/asm/rtc-regs.h                |   4 +-
 arch/mn10300/include/asm/rtc.h                     |   2 -
 arch/mn10300/kernel/rtc.c                          | 104 +---
 arch/mn10300/proc-mn103e010/proc-init.c            |   3 +
 arch/mn10300/proc-mn2ws0050/proc-init.c            |   1 +
 arch/parisc/include/asm/mc146818rtc.h              |   9 -
 arch/parisc/include/asm/rtc.h                      | 131 -----
 arch/parisc/kernel/time.c                          |  36 +-
 arch/powerpc/include/asm/rtc.h                     |  78 ---
 arch/powerpc/kernel/time.c                         |  29 +-
 arch/powerpc/platforms/Kconfig                     |  11 +
 arch/powerpc/platforms/ps3/time.c                  |   2 +-
 arch/sh/include/asm/mc146818rtc.h                  |   7 -
 arch/sh/include/asm/rtc.h                          |  11 -
 arch/sh/kernel/time.c                              |  33 +-
 arch/sparc/include/asm/io_32.h                     |  10 -
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/mc146818rtc.h                 |   1 -
 arch/x86/include/asm/rtc.h                         |   1 -
 arch/x86/kernel/hpet.c                             |   3 +-
 arch/x86/kernel/nmi.c                              |   1 +
 arch/x86/kernel/rtc.c                              |   3 +-
 arch/x86/platform/efi/efi.c                        |   1 -
 arch/x86/platform/efi/efi_64.c                     |   1 +
 arch/x86/platform/intel-mid/intel_mid_vrtc.c       |   1 +
 drivers/acpi/acpi_cmos_rtc.c                       |   2 +-
 drivers/base/power/trace.c                         |   6 +-
 drivers/char/Kconfig                               |  28 +-
 drivers/char/Makefile                              |   1 -
 drivers/char/genrtc.c                              | 539 -----------------=
----
 drivers/rtc/Kconfig                                |  26 +-
 drivers/rtc/Makefile                               |   2 +
 drivers/rtc/interface.c                            |  32 +-
 drivers/rtc/rtc-abx80x.c                           |  12 +-
 drivers/rtc/rtc-asm9260.c                          |   1 -
 drivers/rtc/rtc-at91sam9.c                         |   1 +
 drivers/rtc/rtc-cmos.c                             |  17 +-
 drivers/rtc/rtc-da9052.c                           |   1 +
 drivers/rtc/rtc-da9055.c                           |   1 +
 drivers/rtc/rtc-davinci.c                          |   2 +
 drivers/rtc/rtc-ds1286.c                           |   2 +-
 drivers/rtc/rtc-ds1305.c                           |   7 -
 drivers/rtc/rtc-ds1307.c                           |  33 +-
 drivers/rtc/rtc-ds1343.c                           |   6 -
 drivers/rtc/rtc-ds1685.c                           |  53 +-
 drivers/rtc/rtc-ds2404.c                           |   2 +-
 drivers/rtc/rtc-ds3232.c                           |   6 -
 drivers/rtc/rtc-efi.c                              |   6 +
 drivers/rtc/rtc-generic.c                          |  36 +-
 drivers/rtc/rtc-hym8563.c                          |   5 +-
 drivers/rtc/rtc-isl12057.c                         |  33 +-
 drivers/rtc/rtc-m41t80.c                           |  34 +-
 drivers/rtc/rtc-m48t86.c                           |   2 +-
 drivers/rtc/rtc-max6916.c                          | 164 +++++++
 .../rtc.h =3D> drivers/rtc/rtc-mc146818-lib.c        |  69 +--
 drivers/rtc/rtc-mrst.c                             |  10 +-
 drivers/rtc/rtc-pcf2123.c                          |   4 +-
 drivers/rtc/rtc-pcf85063.c                         |  59 ++-
 drivers/rtc/rtc-pcf8563.c                          |   5 +-
 drivers/rtc/rtc-rc5t583.c                          |   1 +
 drivers/rtc/rtc-rs5c372.c                          |   6 -
 drivers/rtc/rtc-rv8803.c                           | 205 +++++---
 drivers/rtc/rtc-rx8010.c                           |   8 +-
 drivers/rtc/rtc-rx8025.c                           |   5 -
 drivers/rtc/rtc-s35390a.c                          | 157 ++++--
 drivers/rtc/rtc-s3c.c                              |  16 +-
 drivers/rtc/rtc-sh.c                               |  42 +-
 drivers/rtc/rtc-tegra.c                            |   6 -
 drivers/rtc/rtc-v3020.c                            |   2 +-
 include/linux/ds17287rtc.h                         |  66 ---
 include/linux/mc146818rtc.h                        |   5 +
 include/linux/{ =3D> platform_data}/rtc-ds2404.h     |   0
 .../linux/{m48t86.h =3D> platform_data/rtc-m48t86.h} |   0
 include/linux/{ =3D> platform_data}/rtc-v3020.h      |   0
 include/linux/{ =3D> rtc}/ds1286.h                   |   0
 tools/testing/selftests/timers/rtctest.c           |  13 +-
 105 files changed, 850 insertions(+), 1582 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rtc.h
 delete mode 100644 arch/frv/include/asm/mc146818rtc.h
 delete mode 100644 arch/h8300/include/asm/mc146818rtc.h
 delete mode 100644 arch/ia64/include/asm/mc146818rtc.h
 delete mode 100644 arch/m68k/include/asm/rtc.h
 delete mode 100644 arch/parisc/include/asm/mc146818rtc.h
 delete mode 100644 arch/parisc/include/asm/rtc.h
 delete mode 100644 arch/powerpc/include/asm/rtc.h
 delete mode 100644 arch/sh/include/asm/mc146818rtc.h
 delete mode 100644 arch/x86/include/asm/rtc.h
 delete mode 100644 drivers/char/genrtc.c
 create mode 100644 drivers/rtc/rtc-max6916.c
 rename include/asm-generic/rtc.h =3D> drivers/rtc/rtc-mc146818-lib.c (76%)
 delete mode 100644 include/linux/ds17287rtc.h
 rename include/linux/{ =3D> platform_data}/rtc-ds2404.h (100%)
 rename include/linux/{m48t86.h =3D> platform_data/rtc-m48t86.h} (100%)
 rename include/linux/{ =3D> platform_data}/rtc-v3020.h (100%)
 rename include/linux/{ =3D> rtc}/ds1286.h (100%)

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

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXoknNAAoJENiigzvaE+LCGsoP+gNVvGB5jZNfgNlr3tfpYIxo
aJiIYHbIZwBavRtUrYxpWQ3RyNJ2yUKQ69BEz6rwqrcb9Af1fanOfgPFZObjGw/w
zSewHEAsGJarxWr186EcNcInqQHWtJu09Bf83ucmptsy+RrD+K4s004gJu/K0lIg
r1gJa4JebEmy7GBqzumXKdIjJTcdJ/BsgQDIe/t7LVI8bl2Sn5mIlqJX0fT42yrP
4pnnPtL1ysI9+jUBSdoozoQ0NcpsXec1ffm7A9lbAzzU6dZcXrasv+9lKiaQoFTR
koEMKHdE7FBh57Itc0QUS5LtdO6O3M6aVJUFRgiu/sMUrYly9lIKv0ubQEVGp9QR
qIseBrH84/HX1XEwLH+UXOIaA+u+MZFtiWbMEa6z9fT/fy7fBWRUD1Dpi4OTvbSe
h3kyZp+Tu1pEIk8pA1bydJjt+4EOn3pNpNxFeCqU4i5TUDK0nz3q6l8qWqz+p+P7
LUFzj9SjoXR8gpCSPjoabhWcMxwJ0X0VI6UBZ9PLINcOkXSVaa8IVm/AISoOgT5I
sRGreHMJGejZ3G0C9K/CQYKEeGeUM662dizl3t2l/yjYK0czUCC/twdNACq9vlT9
qRiYLYo53b2xoVhdG6cWzeU8+w+ZcrQcMxQ1+LM0pp++cEnXhvWHobV2wYLq/9dW
JyhYBgoezSPwuSRxXwUK
=VTxf
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
