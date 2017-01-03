Return-Path: <rtc-linux+bncBAABBAHGV7BQKGQESIBG4DQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id h23si5744766wmi.1.2017.01.03.10.52.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:52:47 -0800 (PST)
From: Martin Kaiser <martin@kaiser.cx>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin Kaiser <martin@kaiser.cx>
Subject: [rtc-linux] [PATCH 3/3] Documentation: dt: rtc-imxdi: security
 violation interrupt
Date: Tue,  3 Jan 2017 19:51:25 +0100
Message-Id: <1483469485-8336-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Document the DryIce security violation interrupt.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 Documentation/devicetree/bindings/rtc/imxdi-rtc.txt |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
index c9d80d7..323cf26 100644
--- a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
@@ -8,10 +8,13 @@ Required properties:
   region.
 - interrupts: rtc alarm interrupt
 
+Optional properties:
+- interrupts: dryice security violation interrupt
+
 Example:
 
 rtc@80056000 {
 	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
 	reg = <0x80056000 2000>;
-	interrupts = <29>;
+	interrupts = <29 56>;
 };
-- 
1.7.10.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
