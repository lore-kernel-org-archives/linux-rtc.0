Return-Path: <rtc-linux+bncBAABBN6B5C2QKGQEEGTLNPQ@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 79si2073265pft.0.2016.02.09.09.24.07
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Feb 2016 09:24:07 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [rtc-linux] [PATCH] rtc: s3c: Document required clocks in the DT binding
Date: Tue,  9 Feb 2016 14:23:52 -0300
Message-Id: <1455038632-14545-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The S3C Real Time Clock driver requires the clock and source clock to
be defined in the device node but that requirement is not documented.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
index ac2fcd6ff4b8..1068ffce9f91 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
@@ -14,6 +14,10 @@ Required properties:
   interrupt number is the rtc alarm interrupt and second interrupt number
   is the rtc tick interrupt. The number of cells representing a interrupt
   depends on the parent interrupt controller.
+- clocks: Must contain a list of phandle and clock specifier for the rtc
+          and source clocks.
+- clock-names: Must contain "rtc" and "rtc_src" entries sorted in the
+               same order as the clocks property.
 
 Example:
 
@@ -21,4 +25,6 @@ Example:
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupts = <44 0 45 0>;
+		clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
+		clock-names = "rtc", "rtc_src";
 	};
-- 
2.5.0

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
