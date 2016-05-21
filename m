Return-Path: <rtc-linux+bncBDS7HNEFSALRBE7XQG5AKGQEM6MB2AA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s140si134546wme.1.2016.05.21.08.15.30
        for <rtc-linux@googlegroups.com>;
        Sat, 21 May 2016 08:15:30 -0700 (PDT)
Date: Sat, 21 May 2016 17:15:30 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.7
Message-ID: <20160521151530.GA24382@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.7.

Note that you may have to refresh my key to verify the tag signature as
I'm now using a subkey to sign tags and emails.


The following changes since commit 2dcd0af568b0cf583645c8a317dd12e344b1c72a=
:

  Linux 4.6 (2016-05-15 15:43:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.7

for you to fetch changes up to b9ba1eb0336877b9b83556fd30d2becda110fd8c:

  rtc: tps6586x: rename so module can be autoloaded (2016-05-21 17:07:17 +0=
200)

----------------------------------------------------------------
RTC for 4.7

Subsystem wide cleanups:
 - Use IS_ENABLED() instead of checking for built-in or module
 - remove useless DRV_VERSION
 - remove CLK_IS_ROOT
 - remove UIE signaling

Drivers:
 - ds1302: rewritten to be a proper SPI device driver
 - m41t80: huge cleanup, alarm, wakelarm ans oscialltor failure detection
 support
 - rv3029: switch to regmap to handle rv3049, alarm support, fixes
 - zynqmp: enable switching to battery power, fixes
 - small fixes for at91sam9, da9053, ds1307, ds1685, ds3232, r2025, sa1100,
 snvs, stmp3xxx, tps6586x

----------------------------------------------------------------
Akinobu Mita (2):
      rtc: ds1302: fix error check in set_time
      rtc: ds1302: fix write value for day of week register

Alexandre Belloni (1):
      rtc: remove useless DRV_VERSION

Anurag Kumar Vulisha (3):
      rtc: zynqmp: Enable RTC switching to battery power when VCC_PSAUX is =
N/A
      rtc: zynqmp: Write Calibration value before setting time
      rtc: zynqmp: Update seconds time programming logic

Arnd Bergmann (1):
      rtc: rv3029: hide unused i2c device table

Colin Ian King (1):
      rtc: at91sam9: remove duplicate assignment of variable mr

Geert Uytterhoeven (1):
      rtc: sa1100: DT spelling s/interrupt-name/interrupt-names/

Javier Martinez Canillas (1):
      rtc: Use IS_ENABLED() instead of checking for built-in or module

Josh Poimboeuf (1):
      rtc: ds1685: actually spin forever in poweroff path

Myl=C3=A8ne Josserand (15):
      rtc: m41t80: update sysfs entries export
      rtc: m41t80: remove proc macro
      rtc: m41t80: replace i2c functions for smbus ones
      rtc: m41t80: add the use of 'BIT' macro
      rtc: m41t80: remove warnings and replace obsolete function
      rtc: m41t80: add alarm functionality
      rtc: m41t80: add wakealarm functionality
      rtc: m41t80: handle oscillator failure bit
      rtc: rv3029: remove 'i2c' in functions names
      rtc: rv3029: convert to use regmap
      rtc: rv3029: Add support of RV3049
      rtc: rv3029: Remove some checks and warnings
      rtc: rv3029: fix alarm support
      rtc: rv3029: fix set_time function
      rtc: rv3029: add alarm IRQ

Nicolas Boullis (2):
      rtc: ds1307: fix ds1307_native_smbus_read_block_data function
      rtc: ds1307: ensure that any pending alarm is cleared before a new al=
arm is enabled

Nicolas Chauvet (1):
      rtc: tps6586x: rename so module can be autoloaded

Qianyu Gong (1):
      rtc: ds3232: fix call trace when rtc->ops_lock is used as NULL

Sergey Yanovich (1):
      rtc: ds1302: rewrite using SPI

Stefan Agner (1):
      rtc: snvs: return error in case enable_irq_wake fails

Stephen Boyd (3):
      rtc: pcf8563: Remove CLK_IS_ROOT
      rtc: hym8563: Remove CLK_IS_ROOT
      rtc: ds1307: Remove CLK_IS_ROOT

Steve Twiss (1):
      rtc: da9053: fix access ordering error during RTC interrupt at system=
 power on

Sudip Mukherjee (1):
      rtc: stmp3xxx: print message on error

Thomas Koeller (1):
      rtc: rs5c372: r2025: fix check for 'oscillator halted' condition

Wolfram Sang (2):
      rtc: mxc: remove UIE signaling
      rtc: mc13xxx: remove UIE signaling

 .../devicetree/bindings/rtc/maxim-ds1302.txt       |  46 ++
 .../devicetree/bindings/rtc/sa1100-rtc.txt         |   2 +-
 drivers/rtc/Kconfig                                |  52 +-
 drivers/rtc/rtc-at91sam9.c                         |   2 +-
 drivers/rtc/rtc-cmos.c                             |   2 +-
 drivers/rtc/rtc-da9052.c                           |  13 +-
 drivers/rtc/rtc-ds1216.c                           |   3 -
 drivers/rtc/rtc-ds1286.c                           |   3 -
 drivers/rtc/rtc-ds1302.c                           | 348 ++++++------
 drivers/rtc/rtc-ds1307.c                           |  23 +-
 drivers/rtc/rtc-ds1343.c                           |   2 -
 drivers/rtc/rtc-ds1511.c                           |   3 -
 drivers/rtc/rtc-ds1553.c                           |   3 -
 drivers/rtc/rtc-ds1672.c                           |   5 -
 drivers/rtc/rtc-ds1685.c                           |   4 +-
 drivers/rtc/rtc-ds1742.c                           |   3 -
 drivers/rtc/rtc-ds3232.c                           |   9 +-
 drivers/rtc/rtc-ep93xx.c                           |   3 -
 drivers/rtc/rtc-gemini.c                           |   1 -
 drivers/rtc/rtc-hym8563.c                          |   2 +-
 drivers/rtc/rtc-isl12022.c                         |   5 -
 drivers/rtc/rtc-isl1208.c                          |   6 -
 drivers/rtc/rtc-m41t80.c                           | 447 ++++++++++------
 drivers/rtc/rtc-m48t35.c                           |   3 -
 drivers/rtc/rtc-m48t86.c                           |   4 -
 drivers/rtc/rtc-max6900.c                          |   5 -
 drivers/rtc/rtc-mc13xxx.c                          |  19 -
 drivers/rtc/rtc-mrst.c                             |   2 +-
 drivers/rtc/rtc-mxc.c                              |   3 -
 drivers/rtc/rtc-pcf2123.c                          |   4 -
 drivers/rtc/rtc-pcf8563.c                          |   7 +-
 drivers/rtc/rtc-rs5c313.c                          |   2 -
 drivers/rtc/rtc-rs5c348.c                          |   4 -
 drivers/rtc/rtc-rs5c372.c                          |  18 +-
 drivers/rtc/rtc-rv3029c2.c                         | 596 +++++++++++++----=
----
 drivers/rtc/rtc-rx8581.c                           |   5 -
 drivers/rtc/rtc-sh.c                               |   2 -
 drivers/rtc/rtc-snvs.c                             |   2 +-
 drivers/rtc/rtc-stk17ta8.c                         |   3 -
 drivers/rtc/rtc-stmp3xxx.c                         |   7 +-
 drivers/rtc/rtc-tps6586x.c                         |   2 +-
 drivers/rtc/rtc-x1205.c                            |   5 -
 drivers/rtc/rtc-zynqmp.c                           |  74 ++-
 43 files changed, 1019 insertions(+), 735 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXQHuPAAoJENiigzvaE+LCQC4P/1JJtFbkeNk5wzxVtdf4rKIm
XBAQk+AuPTOMLXshd5EkaH7KAdIj3c69aihd7zp8wa6vXnWK8wXKJBc8MMVqp07R
JXbmyHJdwwdxMVMFVeZY3Oex0r7UOgJeeWKSe0ShK69i4/FEnPjXG/rwlO0kqcH9
jkTRsq6tN6xHsAFVkn1WfON51ofGABYtH98lo4eNjJKZSdcYMDecxi+ztdHMjHyd
C/xvYfzYHHtQcx+wbSb6cL5IeTCN3TKgVRk0RRs8I06jQX7kDv6AKoHX2kFDNogp
SACWXuTVZ78+1pL52tuQFBjLIb2RZIM5uhbyWvDoZI0YVqSG7XcTWAprUk7/V8uW
8+fCb/R+2eYrbW4vfnk7Y+dhIiD1rmw8IwzLplo7ryFASOgEjkE2SJ9FodlCrmVX
uTR7vpez8/zVKEF4j1+wyr6K+8EJGQMVzwiCblRLGCyDijmZa3bB+CZa7Mso+ZTU
v1ZOaSTbHuKTsFpwj7oor/VCmMCUCPIotx1Zs2ocObgs6yxE+KZRNLFL+6CmyB5j
ZNlwSv9yys6fE29l+Wb5QsgYM9qLWgI+JMm1XqkrvgyNzXJKI/2c5ucP2nvkqGYu
kzH6AejAR/xFHpbtVYpGqIP87j/Op/0dZZX3xEhxoRbtjOk0p/XZhd8N6Y1VEWq9
6R5nDS6e4SK7wz3vZz1/
=AmV8
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
