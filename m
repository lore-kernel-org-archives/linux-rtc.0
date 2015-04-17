Return-Path: <rtc-linux+bncBAABBX5WYSUQKGQEOPA5JAY@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.146])
        by gmr-mx.google.com with ESMTPS id g5si120943wix.1.2015.04.17.07.40.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Apr 2015 07:40:30 -0700 (PDT)
Message-ID: <cover.1429280614.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Fri, 17 Apr 2015 15:23:34 +0100
Subject: [rtc-linux] [PATCH V1 0/6]  COVER LETTER
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
 - [PATCH V1 1/6]: MFD core support  
 - [PATCH V1 2/6]: BUCK and LDO regulator driver
 - [PATCH V1 3/6]: RTC driver
 - [PATCH V1 4/6]: OnKey driver
 - [PATCH V1 5/6]: Watchdog driver
 - [PATCH V1 6/6]: Add bindings for all DA9062 components

This patch applies against linux-next and v4.0 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (6):
  mfd: da9062: DA9062 MFD core driver
  regulator: da9062: DA9062 regulator driver
  rtc: da9062: DA9062 RTC driver
  input: misc: onkey: da9062: DA9062 OnKey driver
  watchdog: da9062: DA9062 watchdog driver
  devicetree: da9062: Add bindings for DA9062 driver

 Documentation/devicetree/bindings/mfd/da9062.txt |  107 +++
 drivers/input/misc/Kconfig                       |   10 +
 drivers/input/misc/Makefile                      |    1 +
 drivers/input/misc/da9062-onkey.c                |  223 +++++
 drivers/mfd/Kconfig                              |   12 +
 drivers/mfd/Makefile                             |    3 +-
 drivers/mfd/da9062-core.c                        |  611 ++++++++++++
 drivers/regulator/Kconfig                        |   10 +
 drivers/regulator/Makefile                       |    1 +
 drivers/regulator/da9062-regulator.c             |  968 +++++++++++++++++++
 drivers/rtc/Kconfig                              |   10 +
 drivers/rtc/Makefile                             |    1 +
 drivers/rtc/rtc-da9062.c                         |  367 +++++++
 drivers/watchdog/Kconfig                         |    9 +
 drivers/watchdog/Makefile                        |    1 +
 drivers/watchdog/da9062_wdt.c                    |  249 +++++
 include/linux/mfd/da9062/core.h                  |   61 ++
 include/linux/mfd/da9062/registers.h             | 1108 ++++++++++++++++++++++
 18 files changed, 3751 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 create mode 100644 drivers/input/misc/da9062-onkey.c
 create mode 100644 drivers/mfd/da9062-core.c
 create mode 100644 drivers/regulator/da9062-regulator.c
 create mode 100644 drivers/rtc/rtc-da9062.c
 create mode 100644 drivers/watchdog/da9062_wdt.c
 create mode 100644 include/linux/mfd/da9062/core.h
 create mode 100644 include/linux/mfd/da9062/registers.h

-- 
end-of-patch for PATCH V1

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
