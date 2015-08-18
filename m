Return-Path: <rtc-linux+bncBD66BCOYSQBBBRX3ZOXAKGQELKEW7BI@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id i10si1033515igh.3.2015.08.18.02.41.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Aug 2015 02:41:26 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <alexandre.belloni@free-electrons.com>, <tony@atomide.com>
CC: <bcousson@baylibre.com>, <johan@kernel.org>, <linux-omap@vger.kernel.org>,
        <rtc-linux@googlegroups.com>, <grygorii.strashko@ti.com>,
        <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v5 0/3] ARM: AM437X: Add rtc clock handling
Date: Tue, 18 Aug 2015 15:11:13 +0530
Message-ID: <1439890876-19024-1-git-send-email-j-keerthy@ti.com>
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

The series is applicable for all am437x series of processors.
It adds clock handling support. Boot tested on am437x-gp-evm.

Keerthy (3):
  ARM: dts: AM437x: Add the internal and external clock nodes for rtc
  rtc: omap: Add internal clock enabling support
  rtc: omap: Add external clock enabling support

Changes in v5:

  * Added devicetree documentation for omap-rtc clocks.

Changes in v4:

  * Optimized pointer checks for clk pointer.

Changes in v3:

  * Split internal and external clock enabling to separate patches.
  * Using one variable to store the clk info in omap_rtc struct.

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  4 +++
 arch/arm/boot/dts/am4372.dtsi                      |  2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts                | 13 +++++++++
 arch/arm/boot/dts/am437x-idk-evm.dts               |  9 ++++++
 arch/arm/boot/dts/am437x-sk-evm.dts                |  9 ++++++
 drivers/rtc/rtc-omap.c                             | 33 ++++++++++++++++++++++
 6 files changed, 70 insertions(+)

-- 
1.9.1

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
