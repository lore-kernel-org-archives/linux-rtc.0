Return-Path: <rtc-linux+bncBCEPJZEDQIBBBXNPYW5QKGQEKQGYDQI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from rainbowdash.ducie.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by gmr-mx.google.com with ESMTPS id f10si510904wmg.2.2016.06.27.09.44.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jun 2016 09:44:13 -0700 (PDT)
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk,
	rtc-linux@googlegroups.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org
Cc: robh+dt@kernel.org,
	frowand.list@gmail.com,
	linux-amlogic@lists.infradead.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [rtc-linux] [PATCH v2 4/4] ARM: meson: enable RTC for ODroid-C1
Date: Mon, 27 Jun 2016 17:44:09 +0100
Message-Id: <1467045849-495-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Now the RTC node has been added, enable it on the ODroid-C1
board. Note, the C1 does not have a battery by default, so
the RTC will error out on those boards. The C1+ does have
power to the RTC block whilst the external power is applied.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index e50f1a1..5c7826f 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -76,3 +76,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&rtc {
+	status = "okay";
+};
+
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
