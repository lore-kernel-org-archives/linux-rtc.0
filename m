Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Philippe De Muyter <phdm@macqel.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/2] rtc: add Abracon ABx80x
Date: Sat, 14 Mar 2015 11:05:44 +0100
Message-Id: <1426327546-8085-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

As discussed, I reworked the abracon abx80x driver, merging Philippe's and mine.

I have added the Device Tree properties to enable the trickle charger and the
driver will detect the partnumber before doing that so that it won't try to
enable the charger when it is not available.

Alexandre Belloni (1):
  Documentation: bindings: add abracon,abx80x

Philippe De Muyter (1):
  rtc: add rtc-abx80x, a driver for the Abracon AB x80x i2c rtc

 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  32 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-abx80x.c                           | 330 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
 create mode 100644 drivers/rtc/rtc-abx80x.c

-- 
2.1.0
