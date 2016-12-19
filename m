Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZOJ3TBAKGQEL62FPGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p138si1108853wme.1.2016.12.18.16.08.05
        for <rtc-linux@googlegroups.com>;
        Sun, 18 Dec 2016 16:08:05 -0800 (PST)
Date: Mon, 19 Dec 2016 01:08:04 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.10
Message-ID: <20161219000804.t73k4ixuhkxzucor@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klukze5oqbtygohr"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--klukze5oqbtygohr
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.10.
Unfortunately, I had to rewrite a commit before sending because
patchwork changed the author's name unexpectedly.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.10

for you to fetch changes up to d3e5925902dc0f639efc3641e07fca2bd7af5441:

  rtc: mcp795: Fix whitespace and indentation. (2016-12-19 00:59:25 +0100)

----------------------------------------------------------------
RTC for 4.10

Subsystem:
 - non-modular drivers are now explicitly non-modular

New driver:
 - Epson Toyocom rtc-7301sf/dg

Drivers:
 - cmos: reject unsupported alarm values wrt the RTC capabilities
 - ds1307: ACPI support
 - jz4740: DT support, jz4780 handling, can now be used as a system power
 controller
 - mcp795: many fixes, in particular proper month handling
 - twl: driver is now DT only

----------------------------------------------------------------
Akinobu Mita (1):
      rtc: add support for EPSON TOYOCOM RTC-7301SF/DG

Alexandre Belloni (3):
      rtc: jz4740: remove unused EXPORT_SYMBOL
      rtc: jz4740: make the driver builtin only
      rtc: fix typos in Kconfig

Christoph Hellwig (1):
      rtc: cmos: don't refer to asm-generic/rtc.h

Emil Bartczak (6):
      rtc: mcp795: use bcd2bin/bin2bcd.
      rtc: mcp795: fix bitmask value for leap year (LP).
      rtc: mcp795: fix time range difference between linux and RTC chip.
      rtc: mcp795: fix month write resetting date to 1.
      rtc: mcp795: Prefer using the BIT() macro.
      rtc: mcp795: Fix whitespace and indentation.

Gabriele Mazzotta (1):
      rtc: cmos: Reject unsupported alarm values

Krzysztof Kozlowski (1):
      rtc: Enable compile testing for Maxim and Samsung drivers

Martin Kaiser (1):
      rtc: imxdi: (trivial) fix a typo

Mauro Carvalho Chehab (1):
      ABI: rtc-ab8500: fix rtc_calibration documentation

Mirza Krak (1):
      rtc: pcf85063: do not register a RTC device if chip is not present

Nicolae Rosia (3):
      Documentation: bindings: fix twl-rtc documentation
      rtc: twl: kill static variables
      rtc: twl: make driver DT only

Paul Cercueil (7):
      rtc: jz4740: Add support for the RTC in the jz4780 SoC
      Documentation: dt: Add binding info for jz4740-rtc driver
      rtc: jz4740: Add support for devicetree
      rtc: jz4740: Add support for acting as the system power controller
      MIPS: jz4740: DTS: Probe the jz4740-rtc driver from devicetree
      MIPS: qi_lb60: Probe RTC driver from DT and use it as power controller
      MIPS: jz4740: Remove obsolete code

Paul Gortmaker (3):
      rtc: make rtc-lib explicitly non-modular
      rtc: sparc: make starfire explicitly non-modular
      rtc: sparc: make sun4v explicitly non-modular

Srikant Ritolia (1):
      rtc: ds1374: Merge conditional + WARN_ON()

Tin Huynh (1):
      rtc: ds1307: Add ACPI support

 .../sysfs-class-rtc-rtc0-device-rtc_calibration    |   5 +-
 .../devicetree/bindings/rtc/epson,rtc7301.txt      |  16 +
 .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt |  37 ++
 Documentation/devicetree/bindings/rtc/twl-rtc.txt  |  19 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |  11 +
 arch/mips/boot/dts/ingenic/qi_lb60.dts             |   4 +
 arch/mips/include/asm/mach-jz4740/platform.h       |   1 -
 arch/mips/jz4740/board-qi_lb60.c                   |   1 -
 arch/mips/jz4740/platform.c                        |  21 -
 arch/mips/jz4740/reset.c                           |  63 ---
 drivers/rtc/Kconfig                                |  38 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cmos.c                             |  75 +++-
 drivers/rtc/rtc-ds1307.c                           |  52 ++-
 drivers/rtc/rtc-ds1374.c                           |   4 +-
 drivers/rtc/rtc-imxdi.c                            |   2 +-
 drivers/rtc/rtc-jz4740.c                           | 154 ++++++-
 drivers/rtc/rtc-lib.c                              |   4 +-
 drivers/rtc/rtc-mcp795.c                           | 122 +++++-
 drivers/rtc/rtc-pcf85063.c                         |   7 +
 drivers/rtc/rtc-r7301.c                            | 453 +++++++++++++++++++++
 drivers/rtc/rtc-starfire.c                         |  10 +-
 drivers/rtc/rtc-sun4v.c                            |  10 +-
 drivers/rtc/rtc-twl.c                              | 202 +++++----
 24 files changed, 1055 insertions(+), 257 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rtc7301.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
 create mode 100644 drivers/rtc/rtc-r7301.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--klukze5oqbtygohr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEl0I5XWmUIrwBfFMm2KKDO9oT4sIFAlhXJOEACgkQ2KKDO9oT
4sKjRQ//b6MBki1ohdEPFBcPLWCzet2CIElY4Oj78ew1V13Ln6zj4/Ruw7thiii6
97edUFRXDmFVEY9TuhFBrs5oVoHdHaX2MH3NyAnRNHjrYlEB1uDX24Hak73faOmM
kTTnpgRDyp+3lP8vcUzZ6qqzUllTwsswe2GDo7eixgzxmzAWoagDnOYh9sJ7lPYy
c+DwTyKEDTK/DNLS9ye27IWQPTlTv6u2R5Fpu/YPM/CA9BxmwOkaOZP/NuW1vDEy
oVxFCSCRmtm9LCJB1N+4FezVYL2Wr8HCzIblRoAafH/A54aWzgk8TNp3efXKU2gI
m86LP/JLrBXoDCwmhyhNjk+ysUb27xHCqF/5+o64ZCLRJpxQ7LonEa9DoS42Rk59
fykEq+sW2uug4IEHlyDyfog9iiFoaLFWYHHoXZJ9hrFs4B2ChWN8jF2OyhdZOX9l
7qBxUr70I1pV5YKkQ+56Mv5FUnjzpUjt0zKEasAdLDdlG30WlXGSt/w4LNIh2CNi
T0Ou8xaunrkwUvEvJKrQcOrGkp2vOBCYPkjM7TpYAawNU8T4uLLn+sF54W1jCAPw
It4IyCSg0d18Y6+RGHH3N5/cT0RKGkNmdl3BoHuwnsbzGX7O2lvvEwwgOxu1NDWt
37VgsIcMHN174ZWLafW7bGUyxjrDx8HCDTx8bf28wyROJ5J8dyo=
=v/Xh
-----END PGP SIGNATURE-----

--klukze5oqbtygohr--
