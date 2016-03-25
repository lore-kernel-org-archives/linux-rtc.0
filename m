Return-Path: <rtc-linux+bncBDS7HNEFSALRBO5R2K3QKGQERYAGYJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v68si53178wmd.1.2016.03.24.18.47.39
        for <rtc-linux@googlegroups.com>;
        Thu, 24 Mar 2016 18:47:39 -0700 (PDT)
Date: Fri, 25 Mar 2016 02:47:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC for 4.6 #2
Message-ID: <20160325014728.GA10837@piout.net>
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

A second pull request for v4.6 with a few fixesi before -rc1. The new
features for abx80x actually make the RTC behave correctly.

The following changes since commit cee2cc21550648679d222cbe2637fcc6d0f730ef=
:

  rtc: pcf2127: add pcf2129 device id (2016-03-14 17:08:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.6-2

for you to fetch changes up to ee087744247c421c83abea7f01217bfd39b8f5a9:

  rtc: abx80x: handle the oscillator failure bit (2016-03-25 02:41:13 +0100=
)

----------------------------------------------------------------
RTC for 4.6 #2

Drivers:
 - abx80x: handle both XT and RC oscillators, XT failure bit and autocalibr=
ation
 - m41t80: avoid out of range year values
 - rv8803: workaround an i2c HW issue

----------------------------------------------------------------
Alexandre Belloni (2):
      rtc: rv3029: stop mentioning rv3029c2
      rtc: rv8803: workaround i2c HW issue

Arnd Bergmann (1):
      rtc: asm9260: remove incorrect __init/__exit annotations

Emil Bartczak (1):
      rtc: mcp795: add devicetree support

Javier Martinez Canillas (1):
      rtc: s3c: Don't print an error on probe deferral

Myl=C4=8Dne Josserand (2):
      rtc: abx80x: handle autocalibration
      rtc: abx80x: handle the oscillator failure bit

Stefan Christ (1):
      rtc: m41t80: avoid out of range year values

 .../devicetree/bindings/rtc/maxim,mcp795.txt       |  11 +
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-abx80x.c                           | 252 +++++++++++++++++=
+++-
 drivers/rtc/rtc-asm9260.c                          |   4 +-
 drivers/rtc/rtc-m41t80.c                           |   6 +
 drivers/rtc/rtc-mcp795.c                           |  10 +
 drivers/rtc/rtc-rv8803.c                           |  28 ++-
 drivers/rtc/rtc-s3c.c                              |  19 +-
 8 files changed, 316 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt

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
