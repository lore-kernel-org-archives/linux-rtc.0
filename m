Return-Path: <rtc-linux+bncBCRZZFOBYEFRBU7ERHDQKGQEXA74C5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net. [2001:4b98:c:538::196])
        by gmr-mx.google.com with ESMTPS id w130si21880wmf.0.2017.04.03.09.03.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 09:03:31 -0700 (PDT)
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: chris.brandt@renesas.com,
	horms+renesas@verge.net.au,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [rtc-linux] [PATCH] arm: dts: genmai: Enable rtc and rtc_x1 clock
Date: Mon,  3 Apr 2017 18:03:18 +0200
Message-Id: <1491235398-26549-1-git-send-email-jacopo+renesas@jmondi.org>
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
non-zero and enable the realtime clock.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---

This patch depends on Chris Brandt's series
"rtc: Reuse rtc-sh driver to support RZ/A1"
Please queue this on top of that.

 arch/arm/boot/dts/r7s72100-genmai.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 118a8e2..52a7b58 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -44,6 +44,10 @@
 	clock-frequency = <48000000>;
 };

+&rtc_x1_clk {
+	clock-frequency = <32768>;
+};
+
 &mtu2 {
 	status = "okay";
 };
@@ -59,6 +63,10 @@
 	};
 };

+&rtc {
+	status = "okay";
+};
+
 &scif2 {
 	status = "okay";
 };
--
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
