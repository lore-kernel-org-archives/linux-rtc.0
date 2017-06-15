Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/2] Broadcom STB wake-timer support
Date: Thu, 15 Jun 2017 12:59:02 -0700
Message-Id: <20170615195904.12653-1-f.fainelli@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

Hi Alexandre,

This patch series adds support for the Broadcom STB wake-timer. This is a 27Mhz
timer which allows the system to exit S2/S3/S5 sleep states when configured.

The wake-timer has has a long history within our internal/downstream tree, and
Brian authored it in the first place, then Markus added the rtc bits, and then I
cleaned it up for upstream.

Thanks!

Brian Norris (1):
  rtc: brcmstb-waketimer: Add Broadcom STB wake-timer

Florian Fainelli (1):
  dt-bindings: Document the Broadcom STB wake-up timer node

 .../bindings/rtc/brcm,brcmstb-waketimer.txt        |  22 ++
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-brcmstb-waketimer.c                | 345 +++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c

-- 
2.9.3
