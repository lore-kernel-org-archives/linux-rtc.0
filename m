Return-Path: <rtc-linux+bncBDXOFUXT2UGBBIUUZLDAKGQEH6OUQVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com. [210.160.252.173])
        by gmr-mx.google.com with ESMTP id a3si394236pfb.2.2017.03.22.07.28.49
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Mar 2017 07:28:50 -0700 (PDT)
From: Chris Brandt <chris.brandt@renesas.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [rtc-linux] [PATCH v2 0/7] rtc: Reuse rtc-sh driver to support RZ/A1
Date: Wed, 22 Mar 2017 10:27:47 -0400
Message-Id: <20170322142754.30888-1-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Basically, the same RTC that was used in SuperH devices is now used in
RZ/A1 devices. Therefore with some slight changes, that driver can be
reused.

Additionally, since ARM architectures require Device Tree configurations,
device tree support has been added.

This was tested on RZ/A1H RSK board. Once the correct time was programmed
into the RTC running off a 32.768kHz crystal, you can retain an accurate
system clock between reboots (hard and soft) until power is finally removed
from the board (there is no batter backup on the RSK board).

v2:
* removed HAVE_CLK from Kconfig
* when using DT, look for "fck" instead of "rtc0"
* changed (res == NULL) to (!res)
* added Reviewed-by for rtc-sh.c
* added interrupt-names and clock-names
* clocks now include counting sources
* added clock-names "fck", "rtc_x1", "rtc_x3", "extal"
* changed 'is a RTC' to 'is an RTC' in commit message
* changed "rtc0" to "rtc"
* Added clock nodes for RTC_X1 and RTC_X3 pin inputs
* each commit now has a log message


Chris Brandt (7):
  rtc: rtc-sh: add support for rza series
  rtc: Add rtc-sh
  ARM: dts: r7s72100: add rtc clock to device tree
  ARM: dts: r7s72100: add RTC_X clock inputs to device tree
  ARM: dts: r7s72100: add rtc to device tree
  ARM: dts: rskrza1: set rtc_x1 clock value
  ARM: dts: rskrza1: add rtc DT support

 Documentation/devicetree/bindings/rtc/rtc-sh.txt | 29 +++++++++++++++++++
 arch/arm/boot/dts/r7s72100-rskrza1.dts           |  8 +++++
 arch/arm/boot/dts/r7s72100.dtsi                  | 37 ++++++++++++++++++++++++
 drivers/rtc/Kconfig                              |  4 +--
 drivers/rtc/rtc-sh.c                             | 33 +++++++++++++++++----
 include/dt-bindings/clock/r7s72100-clock.h       |  3 ++
 6 files changed, 107 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt

-- 
2.10.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
