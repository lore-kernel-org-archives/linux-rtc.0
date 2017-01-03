Return-Path: <rtc-linux+bncBAABB27FV7BQKGQEPAQ2RQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id f71si4544565wmf.2.2017.01.03.10.52.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:52:27 -0800 (PST)
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
Subject: [rtc-linux] [PATCH 2/3] ARM: dts: imx25.dtsi: DryIce security
 violation interrupt
Date: Tue,  3 Jan 2017 19:50:57 +0100
Message-Id: <1483469457-7863-1-git-send-email-martin@kaiser.cx>
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

The DryIce block on i.MX25 chipset uses two interrupts: A normal and a
security violation interrupt. Add the security violation interrupt to
the list, it is optional.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 831d09a..331d1e1 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -560,7 +560,7 @@
 				reg = <0x53ffc000 0x4000>;
 				clocks = <&clks 81>;
 				clock-names = "ipg";
-				interrupts = <25>;
+				interrupts = <25 56>;
 			};
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
