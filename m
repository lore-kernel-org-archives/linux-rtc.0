Return-Path: <rtc-linux+bncBD62P6P6EQIJPT6NVICRUBACXZXNE@googlegroups.com>
MIME-Version: 1.0
Received: from mail-ob0-x231.google.com (mail-ob0-x231.google.com. [2607:f8b0:4003:c01::231])
        by gmr-mx.google.com with ESMTPS id j18si484598igt.3.2015.05.13.08.02.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 08:02:47 -0700 (PDT)
Received: by mail-ob0-x231.google.com with SMTP id e9so31647440obf.1
        for <rtc-linux@googlegroups.com>; Wed, 13 May 2015 08:02:47 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@arm.linux.org.uk>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>
Subject: [rtc-linux] [PATCH v4 0/6] SA1100/PXA RTC clean-up
Date: Wed, 13 May 2015 10:02:24 -0500
Message-Id: <1431529350-4597-1-git-send-email-robh@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This series enables building the SA1100 RTC driver for ARM64 in
preparation for enabling CONFIG_ARCH_MMP on ARM64. This is needed for
supporting the PXA1928 SOC. Clean-up of SA1100 RTC is complicated by the
fact that some PXA chips use both sa1100-rtc and pxa-rtc drivers and
share the same registers. This does not work well with the Linux driver
model. So the first step is removing this sharing by the 2 drivers and
making sa1100-rtc and pxa-rtc mutually exclusive.

The previous versions can be found here[1][2][3]. Patches 1 and 2 are new.
Patches 3, 5, and 6 are unchanged. Patch 4 is mostly the same, but
adjusted due to patches 1 and 2.

A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
testing on PXA27x/3xx.

Rob

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/391410
[2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/409740
[3] http://comments.gmane.org/gmane.linux.ports.arm.kernel/412047
[4] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git marvell/rtc

Rob Herring (6):
  rtc: sa1100: prepare to share sa1100_rtc_ops
  rtc: pxa: convert to use shared sa1100 functions
  ARM: pxa: add memory resource to SA1100 RTC device
  rtc: sa1100/pxa: convert to run-time register mapping
  ARM: sa1100: remove unused RTC register definitions
  ARM: mmp: remove unused RTC register definitions

 arch/arm/mach-mmp/include/mach/regs-rtc.h   |  23 -----
 arch/arm/mach-pxa/devices.c                 |  18 +---
 arch/arm/mach-pxa/pxa27x.c                  |   1 -
 arch/arm/mach-pxa/pxa3xx.c                  |   1 -
 arch/arm/mach-sa1100/include/mach/SA-1100.h |  34 -------
 drivers/rtc/Kconfig                         |   4 +-
 drivers/rtc/rtc-pxa.c                       |  55 +++++------
 drivers/rtc/rtc-sa1100.c                    | 139 +++++++++++++++++-----------
 drivers/rtc/rtc-sa1100.h                    |  23 +++++
 9 files changed, 140 insertions(+), 158 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h
 create mode 100644 drivers/rtc/rtc-sa1100.h

--
2.1.0

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
