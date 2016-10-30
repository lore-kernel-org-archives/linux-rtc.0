Return-Path: <rtc-linux+bncBC433LF43MBBBTHY3HAAKGQEW6AR6VQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id 18si880925wmr.0.2016.10.30.16.03.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 16:03:39 -0700 (PDT)
From: Paul Cercueil <paul@crapouillou.net>
To: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Cc: Paul Cercueil <paul@crapouillou.net>
Subject: [rtc-linux] [PATCH v2 6/7] MIPS: qi_lb60: Probe RTC driver from DT
 and use it as power controller
Date: Mon, 31 Oct 2016 00:02:46 +0100
Message-Id: <20161030230247.20538-7-paul@crapouillou.net>
In-Reply-To: <20161030230247.20538-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Since we already have a devicetree node for the jz4740-rtc driver, we
don't have to probe it from platform code.

Besides, using the jz4740-rtc driver as the power controller for the
qi_lb60 platform allows us to remove the jz4740 platform power-off code,
since this is the only jz4740-based board upstream.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 4 ++++
 arch/mips/jz4740/board-qi_lb60.c       | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

v2: New patch in this series

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 2414d63..be1a7d3 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -13,3 +13,7 @@
 &ext {
 	clock-frequency = <12000000>;
 };
+
+&rtc_dev {
+	system-power-controller;
+};
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 258fd03..a5bd94b 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -438,7 +438,6 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_pcm_device,
 	&jz4740_i2s_device,
 	&jz4740_codec_device,
-	&jz4740_rtc_device,
 	&jz4740_adc_device,
 	&jz4740_pwm_device,
 	&jz4740_dma_device,
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
