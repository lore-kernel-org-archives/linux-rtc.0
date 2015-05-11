Return-Path: <rtc-linux+bncBD62P6P6EQIKLYGEVICRUBBUYU4H2@googlegroups.com>
MIME-Version: 1.0
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com. [2607:f8b0:4003:c06::235])
        by gmr-mx.google.com with ESMTPS id x1si127091igb.2.2015.05.11.15.41.41
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 15:41:41 -0700 (PDT)
Received: by mail-oi0-x235.google.com with SMTP id a37so116547111oic.0
        for <rtc-linux@googlegroups.com>; Mon, 11 May 2015 15:41:41 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v3 0/4] SA1100 RTC clean-up for ARM64
Date: Mon, 11 May 2015 17:41:25 -0500
Message-Id: <1431384089-28367-1-git-send-email-robh@kernel.org>
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

The previous versions can be found here[1][2]. Changes in this version are
some whitespace fixes and using BIT() macro. I've added Robert's ack as
well.

Russell and Eric/Haojian, Can I get an ack for the SA1100 and MMP bits so
Alexandre can apply.

Rob

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/391410
[2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/409740

Rob Herring (4):
  ARM: pxa: add memory resource to RTC device
  rtc: sa1100: convert to run-time register mapping
  ARM: sa1100: remove unused RTC register definitions
  ARM: mmp: remove unused RTC register definitions

 arch/arm/mach-mmp/include/mach/regs-rtc.h   | 23 --------
 arch/arm/mach-pxa/devices.c                 | 18 +-----
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 -----------
 drivers/rtc/rtc-sa1100.c                    | 87 ++++++++++++++++++++---------
 4 files changed, 62 insertions(+), 100 deletions(-)
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
