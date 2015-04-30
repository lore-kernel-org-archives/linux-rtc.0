Return-Path: <rtc-linux+bncBD62P6P6EQIP7JEKVICRUBFKSHPC2@googlegroups.com>
MIME-Version: 1.0
Received: from mail-oi0-x22a.google.com (mail-oi0-x22a.google.com. [2607:f8b0:4003:c06::22a])
        by gmr-mx.google.com with ESMTPS id x1si221231igb.2.2015.04.30.13.37.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 13:37:18 -0700 (PDT)
Received: by mail-oi0-x22a.google.com with SMTP id t201so57388067oif.3
        for <rtc-linux@googlegroups.com>; Thu, 30 Apr 2015 13:37:18 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@arm.linux.org.uk>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 0/4] SA1100 RTC clean-up for ARM64
Date: Thu, 30 Apr 2015 15:37:09 -0500
Message-Id: <1430426233-7461-1-git-send-email-robh@kernel.org>
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
supporting the PXA1928 SOC.

The previous version can be found here[1]. This is mostly an update to
summarize the discussion about SA1100 and PXA RTC support.

Rob

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/391410

Rob Herring (4):
  ARM: pxa: add memory resource to RTC device
  rtc: sa1100: convert to run-time register mapping
  ARM: sa1100: remove unused RTC register definitions
  ARM: mmp: remove unused RTC register definitions

 arch/arm/mach-mmp/include/mach/regs-rtc.h   | 23 --------
 arch/arm/mach-pxa/devices.c                 | 18 +-----
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 ------------
 drivers/rtc/rtc-sa1100.c                    | 86 ++++++++++++++++++++---------
 4 files changed, 61 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h

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
