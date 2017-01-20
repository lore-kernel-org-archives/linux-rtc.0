Return-Path: <rtc-linux+bncBDSJBYGBRIMBBP7GRDCAKGQEOF2SKRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h62si130567wme.2.2017.01.20.07.56.46
        for <rtc-linux@googlegroups.com>;
        Fri, 20 Jan 2017 07:56:46 -0800 (PST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] [PATCH 4/6] rtc: sun6i: Force the mux to the external oscillator
Date: Fri, 20 Jan 2017 16:56:41 +0100
Message-Id: <409c56f0ed1c4b0026ad60cb1218c99fe1686408.1484927680.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The internal oscillator is way too inaccurate to do something useful with
it. Switch to the external oscillator if it is available.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/rtc-sun6i.c | 12 ++++++++++++
 1 file changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index edd5627da10f..1695fae24cd5 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -493,6 +493,7 @@ static const struct rtc_class_ops sun6i_rtc_ops = {
 static int sun6i_rtc_probe(struct platform_device *pdev)
 {
 	struct sun6i_rtc_dev *chip = sun6i_rtc;
+	struct clk *parent;
 	int ret;
 
 	if (!chip)
@@ -540,6 +541,17 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	/* disable alarm wakeup */
 	writel(0, chip->base + SUN6I_ALARM_CONFIG);
 
+	parent = clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(parent)) {
+		ret = clk_set_parent(chip->losc, parent);
+		clk_put(parent);
+
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to reparent the RTC to the external oscillator\n");
+			return ret;
+		}
+	}
 	clk_prepare_enable(chip->losc);
 
 	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
-- 
git-series 0.8.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
