Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60639 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdJaQ1o (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 31 Oct 2017 12:27:44 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: omap: Support scratch registers
Date: Tue, 31 Oct 2017 17:27:31 +0100
Message-Id: <20171031162731.27019-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Register an nvmem device to expose the 3 scratch registers (total of 12
bytes) to both userspace and kernel space.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-omap.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d56d937966dc..1d666ac9ef70 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -70,6 +70,10 @@
 #define OMAP_RTC_COMP_MSB_REG		0x50
 #define OMAP_RTC_OSC_REG		0x54
 
+#define OMAP_RTC_SCRATCH0_REG		0x60
+#define OMAP_RTC_SCRATCH1_REG		0x64
+#define OMAP_RTC_SCRATCH2_REG		0x68
+
 #define OMAP_RTC_KICK0_REG		0x6c
 #define OMAP_RTC_KICK1_REG		0x70
 
@@ -667,6 +671,45 @@ static struct pinctrl_desc rtc_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+static int omap_rtc_scratch_read(void *priv, unsigned int offset, void *_val,
+				 size_t bytes)
+{
+	struct omap_rtc	*rtc = priv;
+	u32 *val = _val;
+	int i;
+
+	for (i = 0; i < bytes / 4; i++)
+		val[i] = rtc_readl(rtc,
+				   OMAP_RTC_SCRATCH0_REG + offset + (i * 4));
+
+	return 0;
+}
+
+static int omap_rtc_scratch_write(void *priv, unsigned int offset, void *_val,
+				  size_t bytes)
+{
+	struct omap_rtc	*rtc = priv;
+	u32 *val = _val;
+	int i;
+
+	rtc->type->unlock(rtc);
+	for (i = 0; i < bytes / 4; i++)
+		rtc_writel(rtc,
+			   OMAP_RTC_SCRATCH0_REG + offset + (i * 4), val[i]);
+	rtc->type->lock(rtc);
+
+	return 0;
+}
+
+static struct nvmem_config omap_rtc_nvmem_config = {
+	.name = "omap_rtc_scratch",
+	.word_size = 4,
+	.stride = 4,
+	.size = OMAP_RTC_KICK0_REG - OMAP_RTC_SCRATCH0_REG,
+	.reg_read = omap_rtc_scratch_read,
+	.reg_write = omap_rtc_scratch_write,
+};
+
 static int omap_rtc_probe(struct platform_device *pdev)
 {
 	struct omap_rtc	*rtc;
@@ -804,6 +847,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->rtc->ops = &omap_rtc_ops;
+	omap_rtc_nvmem_config.priv = rtc;
+	rtc->rtc->nvmem_config = &omap_rtc_nvmem_config;
 
 	/* handle periodic and alarm irqs */
 	ret = devm_request_irq(&pdev->dev, rtc->irq_timer, rtc_irq, 0,
-- 
2.15.0.rc2
