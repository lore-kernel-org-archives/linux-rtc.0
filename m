Return-Path: <rtc-linux+bncBDXOFUXT2UGBBJUUZLDAKGQEZX2WB3A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relmlie4.idc.renesas.com (relmlor1.renesas.com. [210.160.252.171])
        by gmr-mx.google.com with ESMTP id a3si394301pfb.2.2017.03.22.07.28.54
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Mar 2017 07:28:54 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 6/7] ARM: dts: rskrza1: set rtc_x1 clock value
Date: Wed, 22 Mar 2017 10:27:53 -0400
Message-Id: <20170322142754.30888-7-chris.brandt@renesas.com>
In-Reply-To: <20170322142754.30888-1-chris.brandt@renesas.com>
References: <20170322142754.30888-1-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Enable the 32.768 kHz RTC_X1 clock by setting the frequency value to
non-zero.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index 02b59c5..cab5857 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -43,6 +43,10 @@
 	clock-frequency = <48000000>;
 };
 
+&rtc_x1_clk {
+	clock-frequency = <32768>;
+};
+
 &mtu2 {
 	status = "okay";
 };
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
