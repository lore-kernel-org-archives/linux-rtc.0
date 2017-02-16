Return-Path: <rtc-linux+bncBC6YH6VTZQDRBZULS7CQKGQE5UBY2PA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f7si27466wmg.3.2017.02.16.07.31.49
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Feb 2017 07:31:49 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] [PATCH 3/3] arm64: dts: marvell: add RTC description for
 Armada 7K/8K
Date: Thu, 16 Feb 2017 16:31:36 +0100
Message-Id: <20170216153136.27009-4-gregory.clement@free-electrons.com>
In-Reply-To: <20170216153136.27009-1-gregory.clement@free-electrons.com>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This RTC IP is found in the CP110 which is part of the Armada 8K SoCs and
of the subset family the Armada 7K.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 3a99c36433d6..3a3bbc488736 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -79,6 +79,13 @@
 					"cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 			};
 
+			rtc: rtc@284000 {
+				compatible = "marvell,armada-8k-rtc";
+				reg = <0x284000 0x20>, <0x284080 0x24>;
+				reg-names = "rtc", "rtc-soc";
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			cpm_sata0: sata@540000 {
 				compatible = "marvell,armada-8k-ahci",
 					     "generic-ahci";
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
