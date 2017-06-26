Return-Path: <rtc-linux+bncBCH67JWTV4DBBXXSYXFAKGQEWMWMVJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id 143si268764wmr.0.2017.06.26.14.15.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 14:15:10 -0700 (PDT)
Received: by mail-wm0-x243.google.com with SMTP id j85so2493151wmj.0
        for <rtc-linux@googlegroups.com>; Mon, 26 Jun 2017 14:15:10 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [rtc-linux] [PATCH v2 0/2] Broadcom STB wake-timer support
Date: Mon, 26 Jun 2017 14:15:01 -0700
Message-Id: <20170626211503.7471-1-f.fainelli@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

This patch series adds support for the Broadcom STB wake-timer. This is a 27Mhz
timer which allows the system to exit S2/S3/S5 sleep states when configured.

The wake-timer has has a long history within our internal/downstream tree, and
Brian authored it in the first place, then Markus added the rtc bits, and then I
cleaned it up for upstream.

Changes in v2:

- added Rob's Acked-by tag to the device tree binding patch
- removed dev_dbg() prints
- removed unnecessary initialization in .read_alarm callback
- rebase against latest rtc-next

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

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
