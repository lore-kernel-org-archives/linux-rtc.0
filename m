Return-Path: <rtc-linux+bncBDE6RCFOWIARB3WGSLCAKGQE72LYNWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x22b.google.com (mail-lf0-x22b.google.com. [2a00:1450:4010:c07::22b])
        by gmr-mx.google.com with ESMTPS id h62si377677wme.2.2017.01.22.04.19.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jan 2017 04:19:57 -0800 (PST)
Received: by mail-lf0-x22b.google.com with SMTP id v186so80688846lfa.1
        for <rtc-linux@googlegroups.com>; Sun, 22 Jan 2017 04:19:57 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	openwrt-devel@openwrt.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] [PATCH 08/22] rtc: Add device tree probing to the Gemini driver
Date: Sun, 22 Jan 2017 13:19:50 +0100
Message-Id: <20170122121950.10449-1-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This adds bindings and simple probing for the Cortina Systems Gemini
SoC RTC.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
RTC maintainers: please just apply this to the RTC tree when you
are pleased with it. It is functionally orthogonal to the rest of
the series and just in a series for context.
---
 Documentation/devicetree/bindings/rtc/cortina,gemini.txt | 14 ++++++++++++++
 drivers/rtc/rtc-gemini.c                                 |  7 +++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt

diff --git a/Documentation/devicetree/bindings/rtc/cortina,gemini.txt b/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
new file mode 100644
index 000000000000..4ce4e794ddbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
@@ -0,0 +1,14 @@
+* Cortina Systems Gemini RTC
+
+Gemini SoC real-time clock.
+
+Required properties:
+- compatible : Should be "cortina,gemini-rtc"
+
+Examples:
+
+rtc@45000000 {
+	compatible = "cortina,gemini-rtc";
+	reg = <0x45000000 0x100>;
+	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 688debc14348..ccf0dbadb62d 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -159,9 +159,16 @@ static int gemini_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id gemini_rtc_dt_match[] = {
+	{ .compatible = "cortina,gemini-rtc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gemini_rtc_dt_match);
+
 static struct platform_driver gemini_rtc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
+		.of_match_table = gemini_rtc_dt_match,
 	},
 	.probe		= gemini_rtc_probe,
 	.remove		= gemini_rtc_remove,
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
