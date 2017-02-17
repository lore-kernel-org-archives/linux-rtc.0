Return-Path: <rtc-linux+bncBC6YH6VTZQDRBIM4TPCQKGQEQF6GSMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si56587wma.3.2017.02.17.02.19.13
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Feb 2017 02:19:13 -0800 (PST)
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
Subject: [rtc-linux] [PATCH v2 0/3] Extend rtc-armada38x support for Armada 7K/8K
Date: Fri, 17 Feb 2017 11:19:04 +0100
Message-Id: <20170217101907.8963-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
the SOC integration differs in 2 points:
     - MBUS bridge timing initialization
     - IRQ configuration at SoC level

This patch set extends the driver support to these SoCs family.

In this second version the device tree was updated allowing to use the
RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
CP master is not connected (by package) to the oscillator. So this one
is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
will be the RTC clock in CP slave connected to the oscillator which
will be used.

Thanks,

Gregory

Gregory CLEMENT (3):
  rtc: armada38x: Prepare driver to manage different versions
  rtc: armada38x: Add support for Armada 7K/8K
  arm64: dts: marvell: add RTC description for Armada 7K/8K

 .../devicetree/bindings/rtc/armada-380-rtc.txt     |   8 +-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  10 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   9 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   7 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   7 +
 drivers/rtc/rtc-armada38x.c                        | 217 ++++++++++++++++-----
 6 files changed, 202 insertions(+), 56 deletions(-)

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
