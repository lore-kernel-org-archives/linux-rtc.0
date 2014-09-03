Return-Path: <boris.brezillon@free-electrons.com>
From: Boris BREZILLON <boris.brezillon@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [PATCH 0/5] rtc: at91sam9: add DT support
Date: Wed,  3 Sep 2014 10:45:29 +0200
Message-Id: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

Hello,

This patch series adds DT support to the atmel at91sam9 RTC driver.

It also removes any machine specific inclusions to prepare the migration
to multi platform kernel support, and retain the slow clock to prevent
the CCF from disabling it at the end of boot.

Best Regards,

Boris

Boris BREZILLON (5):
  rtc: at91sam9: remove references to mach specific headers
  rtc: at91sam9: use standard readl/writel functions instead of raw
    versions
  rtc: at91sam9: add DT support
  rtc: at91sam9: retain slow clock and check its rate
  rtc: at91sam9: add DT bindings documentation

 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 20 +++++++
 drivers/rtc/rtc-at91sam9.c                         | 63 +++++++++++++++++++---
 2 files changed, 75 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

-- 
1.9.1
