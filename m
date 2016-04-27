Return-Path: <rtc-linux+bncBDEKVJM7XAHRBDX5QS4QKGQEC7RNDXY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id r72si2299wmd.2.2016.04.27.15.34.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 15:34:54 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au,
	dalias@libc.org,
	dhowells@redhat.com,
	linux-alpha@vger.kernel.org,
	a.zummo@towertech.it,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] [PATCH v3 00/16] genrtc removal
Date: Thu, 28 Apr 2016 00:34:14 +0200
Message-Id: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

I ended up stuffing the two patch series into one, as they are now
more dependent on one another. This now thoroughly removes the
genrtc driver including the asm/rtc.h headers it uses. For all
architectures that still have a meaningful asm/rtc.h, this goes
through two stages:

1) make the rtc-generic implementation independent of asm/rtc.h
2) remove the asm/rtc.h header and disallow the gen_rtc driver

As the last step, the driver itself gets removed.

	Arnd

 arch/alpha/include/asm/rtc.h          |   1 -
 arch/alpha/kernel/core_marvel.c       |   1 -
 arch/alpha/kernel/rtc.c               |   6 +-
 arch/frv/include/asm/mc146818rtc.h    |  16 -
 arch/h8300/include/asm/mc146818rtc.h  |   9 -
 arch/ia64/include/asm/mc146818rtc.h   |  10 -
 arch/m68k/amiga/config.c              |   1 -
 arch/m68k/apollo/config.c             |   1 -
 arch/m68k/bvme6000/config.c           |   1 -
 arch/m68k/hp300/config.c              |   2 +-
 arch/m68k/include/asm/rtc.h           |  79 -----
 arch/m68k/kernel/time.c               |  49 +++-
 arch/m68k/mac/config.c                |   3 +-
 arch/m68k/mac/misc.c                  |   1 -
 arch/m68k/mvme147/config.c            |   1 -
 arch/m68k/mvme16x/config.c            |   1 -
 arch/m68k/q40/config.c                |   2 +-
 arch/m68k/sun3/config.c               |   1 -
 arch/m68k/sun3/intersil.c             |   2 +-
 arch/m68k/sun3x/time.c                |   2 +-
 arch/mips/sni/time.c                  |   1 -
 arch/mn10300/include/asm/rtc.h        |   2 -
 arch/mn10300/kernel/rtc.c             |   2 +-
 arch/parisc/include/asm/mc146818rtc.h |   9 -
 arch/parisc/include/asm/rtc.h         | 131 ---------
 arch/parisc/kernel/time.c             |  36 ++-
 arch/powerpc/include/asm/rtc.h        |  78 -----
 arch/powerpc/kernel/time.c            |  29 +-
 arch/powerpc/platforms/Kconfig        |  11 +
 arch/powerpc/platforms/ps3/time.c     |   2 +-
 arch/sh/include/asm/mc146818rtc.h     |   7 -
 arch/sh/include/asm/rtc.h             |  11 -
 arch/sh/kernel/time.c                 |  32 +-
 arch/x86/include/asm/mc146818rtc.h    |   1 -
 arch/x86/include/asm/rtc.h            |   1 -
 arch/x86/kernel/hpet.c                |   3 +-
 arch/x86/kernel/rtc.c                 |   3 +-
 arch/x86/platform/efi/efi.c           |   1 -
 drivers/acpi/acpi_cmos_rtc.c          |   2 +-
 drivers/base/power/trace.c            |   6 +-
 drivers/char/Kconfig                  |  26 --
 drivers/char/Makefile                 |   1 -
 drivers/char/genrtc.c                 | 539 ----------------------------------
 drivers/rtc/rtc-cmos.c                |  12 +-
 drivers/rtc/rtc-generic.c             |  36 +--
 drivers/rtc/rtc-mrst.c                |   2 +-
 include/asm-generic/rtc.h             | 247 ----------------
 include/linux/mc146818rtc.h           | 194 ++++++++++++
 48 files changed, 358 insertions(+), 1256 deletions(-)

 [PATCH v3 01/16] rtc: cmos: remove empty asm/mc146818rtc.h files
 [PATCH v3 02/16] rtc: cmos: move mc146818rtc code out of
 [PATCH v3 03/16] char/genrtc: x86: remove remnants of asm/rtc.h
 [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
 [PATCH v3 05/16] char/genrtc: remove alpha support
 [PATCH v3 06/16] char/genrtc: remove mn10300 support
 [PATCH v3 07/16] rtc: parisc: provide rtc_class_ops directly
 [PATCH v3 08/16] char/genrtc: remove parisc support
 [PATCH v3 09/16] rtc: m68k: provide rtc_class_ops directly
 [PATCH v3 10/16] rtc: m68k: provide ioctl for q40
 [PATCH v3 11/16] char/genrtc: remove m68k support
 [PATCH v3 12/16] rtc: powerpc: provide rtc_class_ops directly
 [PATCH v3 13/16] char/genrtc: remove powerpc support
 [PATCH v3 14/16] rtc: generic: remove get_rtc_time/set_rtc_time
 [PATCH v3 15/16] char/genrtc: remove asm-generic/rtc.h from mips
 [PATCH v3 16/16] char/genrtc: remove the rest of the driver

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
