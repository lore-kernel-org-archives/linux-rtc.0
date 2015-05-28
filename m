Return-Path: <rtc-linux+bncBAABBC5UTSVQKGQEHBCLOMA@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.107])
        by gmr-mx.google.com with ESMTPS id t6si862338wiz.0.2015.05.28.06.37.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 06:37:15 -0700 (PDT)
Message-ID: <cover.1432820011.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 28 May 2015 14:33:31 +0100
Subject: [rtc-linux] [PATCH V4 0/3]  da9062: DA9062 driver submission
To: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss
	<stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Wim
 Van Sebroeck <wim@iguana.be>
CC: David Dajun Chen <david.chen@diasemi.com>, Support Opensource
	<support.opensource@diasemi.com>
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

From: S Twiss <stwiss.opensource@diasemi.com>

This patch set adds support for the Dialog DA9062 Power Management IC.

In this patch set the following is provided:
 - [PATCH V4 1/3]: MFD core support  
 - [PATCH V4 2/3]: Watchdog driver
 - [PATCH V4 3/3]: Add bindings for all DA9062 components

Changes in V4
 - Rebase patches from linux-next/v4.1-rc3 to linux-next/v4.1-rc5
 - [PATCH V3 2/4] BUCK and LDO regulator driver accepted by Mark Brown
   - See https://lkml.org/lkml/2015/5/21/313 for details
 - Reorder remaining patches for the PATCH V4 submission

Changes in V3:
 - No overall main changes, see individal patches for details

Changes in V2:
 - Alter subject title in 'cover letter'
 - Reordered the patch numbering: now 4/4 patches instead of 6/6
   - Dropped [PATCH V1 3/6] RTC driver
   - Dropped [PATCH V1 4/6] OnKey driver

This patch applies against linux-next and v4.1-rc5 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (3):
  mfd: da9062: DA9062 MFD core driver
  watchdog: da9062: DA9062 watchdog driver
  devicetree: da9062: Add bindings for DA9062 driver

 Documentation/devicetree/bindings/mfd/da9062.txt |   79 ++
 drivers/mfd/Kconfig                              |   12 +
 drivers/mfd/Makefile                             |    3 +-
 drivers/mfd/da9062-core.c                        |  512 ++++++++++
 drivers/watchdog/Kconfig                         |    9 +
 drivers/watchdog/Makefile                        |    1 +
 drivers/watchdog/da9062_wdt.c                    |  253 +++++
 include/linux/mfd/da9062/core.h                  |   50 +
 include/linux/mfd/da9062/registers.h             | 1108 ++++++++++++++++++++++
 9 files changed, 2026 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 create mode 100644 drivers/mfd/da9062-core.c
 create mode 100644 drivers/watchdog/da9062_wdt.c
 create mode 100644 include/linux/mfd/da9062/core.h
 create mode 100644 include/linux/mfd/da9062/registers.h

-- 
end-of-patch for PATCH V4

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
