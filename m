Return-Path: <rtc-linux+bncBD66BCOYSQBBBTO5UGXAKGQERWZABTI@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id x1si693052igb.2.2015.08.10.02.28.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 02:28:45 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>
CC: <galak@codeaurora.org>, <paul@pwsan.com>,
        <alexandre.belloni@free-electrons.com>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v2 0/6]  ARM: AM4372: Enable RTC
Date: Mon, 10 Aug 2015 14:58:20 +0530
Message-ID: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
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

The series brings multiple fixes needed to get rtc ticking
on am437x-gp-evm.

This is tested on top of omap-for-v4.3/dt-v2 branch. Boot tested on
AM437X-GP-EVM also tested rtc ticking via sysfs nodes. 

The series is on top of this patch:
http://comments.gmane.org/gmane.linux.drivers.devicetree/131026

Keerthy (6):
  ARM: dts: AM43XX: Add clk_32k_rtc node
  rtc: omap: Add external clock enabling support
  ARM: AM43xx: Introduce a separate soc_is function for am438x series of
    SoCs
  ARM: dts: am43x-epos-evm: Add the am438 compatible string
  ARM: AM43XX: HWMOD: Add rtc hwmod
  ARM: dts: AM437X-GP-EVM: Enable rtc

Changes in v2:

  * Couple of patches already pulled in.
  * Removed dt ext-clk-src and made use of clocks property to determine
    presence of external clock source.

 .../devicetree/bindings/arm/omap/omap.txt          |  3 +++
 arch/arm/boot/dts/am4372.dtsi                      |  2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  4 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  6 +++++
 arch/arm/mach-omap2/board-generic.c                |  1 +
 arch/arm/mach-omap2/id.c                           |  2 ++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 16 ++++++++++--
 arch/arm/mach-omap2/soc.h                          |  7 +++--
 drivers/rtc/rtc-omap.c                             | 30 ++++++++++++++++++++++
 10 files changed, 68 insertions(+), 5 deletions(-)

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
