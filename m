Return-Path: <rtc-linux+bncBD66BCOYSQBBBWO5UGXAKGQEZ2XTOXI@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id f17si696947igt.0.2015.08.10.02.28.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 02:28:57 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>
CC: <galak@codeaurora.org>, <paul@pwsan.com>,
        <alexandre.belloni@free-electrons.com>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v2 4/6] ARM: dts: am43x-epos-evm: Add the am438
 compatible string
Date: Mon, 10 Aug 2015 14:58:24 +0530
Message-ID: <1439198906-31189-5-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
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

The SoCs on am43x-epos-evm are named am438x.
Hence add the compatiblity string and remove the am4372 string.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 86c2dfb..7e473c2 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "TI AM43x EPOS EVM";
-	compatible = "ti,am43x-epos-evm","ti,am4372","ti,am43";
+	compatible = "ti,am43x-epos-evm","ti,am438x","ti,am43";
 
 	aliases {
 		display0 = &lcd0;
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
