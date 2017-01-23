Return-Path: <rtc-linux+bncBDSJBYGBRIMBB7N3S7CAKGQEXQ4HXNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si989180wmf.0.2017.01.23.02.42.05
        for <rtc-linux@googlegroups.com>;
        Mon, 23 Jan 2017 02:42:05 -0800 (PST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	stable@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 3/7] rtc: sun6i: Switch to the external oscillator
Date: Mon, 23 Jan 2017 11:41:48 +0100
Message-Id: <5da36927ceab1743e2e39822e0606bd0e6002539.1485168100.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The RTC is clocked from either an internal, imprecise, oscillator or an
external one, which is usually much more accurate.

The difference perceived between the time elapsed and the time reported by
the RTC is in a 10% scale, which prevents the RTC from being useful at all.

Fortunately, the external oscillator is reported to be mandatory in the
Allwinner datasheet, so we can just switch to it.

Cc: stable@vger.kernel.org
Fixes: 9765d2d94309 ("rtc: sun6i: Add sun6i RTC driver")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/rtc-sun6i.c | 6 ++++++
 1 file changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 5527f5eb597b..47f2022948a6 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -37,9 +37,11 @@
 
 /* Control register */
 #define SUN6I_LOSC_CTRL				0x0000
+#define SUN6I_LOSC_CTRL_KEY			(0x16aa << 16)
 #define SUN6I_LOSC_CTRL_ALM_DHMS_ACC		BIT(9)
 #define SUN6I_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
 #define SUN6I_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
+#define SUN6I_LOSC_CTRL_EXT_OSC			BIT(0)
 #define SUN6I_LOSC_CTRL_ACC_MASK		GENMASK(9, 7)
 
 /* RTC */
@@ -417,6 +419,10 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	/* disable alarm wakeup */
 	writel(0, chip->base + SUN6I_ALARM_CONFIG);
 
+	/* switch to the external, more precise, oscillator */
+	writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
+	       chip->base + SUN6I_LOSC_CTRL);
+
 	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
 					&sun6i_rtc_ops, THIS_MODULE);
 	if (IS_ERR(chip->rtc)) {
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
