Return-Path: <rtc-linux+bncBAABBR6SZ6WAKGQEHBUFVII@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com. [195.245.230.165])
        by gmr-mx.google.com with ESMTPS id t6si142292wiz.0.2015.07.01.06.21.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 06:21:11 -0700 (PDT)
Message-ID: <cover.1435756293.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Wed, 1 Jul 2015 14:11:33 +0100
Subject: [rtc-linux] [PATCH V5 0/2]  da9062: DA9062 driver submission
To: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss
	<stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, "Wim
 Van Sebroeck" <wim@iguana.be>
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
 - [PATCH V5 1/2]: MFD core support  
 - [PATCH V5 2/2]: Add bindings for all DA9062 components

Changes in V5
 - The [PATCH V4 2/3] Watchdog driver has made it into linux-next
   next-20150701 and has been dropped from this patch set.

Changes in V4
 - Rebase patches from linux-next/v4.1-rc3 to linux-next/v4.1-rc5
 - [PATCH V3 2/4] BUCK and LDO regulator driver accepted by Mark Brown
   - See https://lkml.org/lkml/2015/5/21/313 for details
 - Reorder remaining patches for the PATCH V4 submission

Changes in V3:
 - No overall main changes, see individal patches for details

Changes in V2:
 - Alter subject title in cover letter
 - Reordered the patch numbering: now 4/4 patches instead of 6/6
   - Dropped [PATCH V1 3/6] RTC driver
   - Dropped [PATCH V1 4/6] OnKey driver

This patch set applies against linux-next and next-20150701

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (2):
  mfd: da9062: DA9062 MFD core driver
  devicetree: da9062: Add bindings for DA9062 driver

 Documentation/devicetree/bindings/mfd/da9062.txt |   79 ++
 drivers/mfd/Kconfig                              |   12 +
 drivers/mfd/Makefile                             |    3 +-
 drivers/mfd/da9062-core.c                        |  512 ++++++++++
 include/linux/mfd/da9062/core.h                  |   50 +
 include/linux/mfd/da9062/registers.h             | 1108 ++++++++++++++++++++++
 6 files changed, 1763 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 create mode 100644 drivers/mfd/da9062-core.c
 create mode 100644 include/linux/mfd/da9062/core.h
 create mode 100644 include/linux/mfd/da9062/registers.h

-- 
end-of-patch for PATCH V5

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
