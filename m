Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465635;
	b=OZ4Nli4ZrXED0maZLc93caKWHqNrxiIkKwM4LyTWvx6KCY8ngNCVVXboo0xAnW9jVKwB
	 o4aUb62OJi8zGI6iV6Gel92G4ihrBnlRmqXVWL7NWipfsOAfzdZloY7nm9qdNVsUfauAt
	 NZJLWraTbv2zo47XasSBHfg1Cw+fnr0yUvXzO/5QjJ4zsVrliSLHRk8zB+gykVLblPusd
	 b0bm1xMmpsVYAW3/i9p77o8Gn5TDuiRzY2hPDE1ker0yIW6uCTFBChb0PRcK2lkcachL9
	 ROzja+/fQp2GaOprv34w21zn91EciwaLOnXi/O+OlnewdK1t+MdW5FHX9wvP8v+H9fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465635;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OhWmimZIqkg9HQUoRo0vOAuz9vLw0fvzPCSsweRqk10=;
	b=46nYdHsksEKvzNkT6aOX7Xu6hFI2MUDS/Xch19sF/BVL8qMw4JBkgoYtJDIf97UXyc1w
	 ZjGqw/JbJMdmqTELJqjXduZIclrlOD2hvyP46f/2KwWk+3Nrc8OSUE8RsS377+VF9GKLf
	 QQBn/J4S8qzw7NQ4UXdAG0ZF2UK01TLyayV3sOZGSPzs7VYarEMPuJMv0nBfwx4MYQPDM
	 ZTnt1YQ/Rp63orMH4Bu90jLiafGdVunqPad0q3Y4XKiZ6PXSJvw54eGWGnbaRiQUEUH+z
	 57rEASZFwktMfNer8IH9NIaZWSzdxjGtjLJYhUelqXpx71/i/2xW56Td9BQWTktmYQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leFCaLDt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E5606A6A3;
	Mon, 23 Nov 2026 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leFCaLDt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465635;
	b=mrWEZvkVDCy0nSas3e0IiiCkKD5sqxXHB5qepOqi/iWpnlri1uDEnjfYWR1Dzbp8CggG
	 LtT4DE8k9QMZC3nx05SJMOnFNPw4VOkB/myPuczm2CscUZD5MFcB5OqvH4Q4UhdBpW1UV
	 lh7vBrE5Q2GsiwZE0TGaIttJmBVRpj+I1UpkDml/4lHaTjC1jZkQKR2+X4Vp0VZ22Ywkj
	 69MvDHNND/1TZIJgBUqnAVPpS1p0AiqAEPMRCSNZGGR+4W45n0ITY+dZpCVLIv2yLmsId
	 /OvWcHUDGNgeu4BqgjTSR4wAg49WhO53cd7SOAJ8cZTTYCVpgiazOsCBrEBYPMtSDrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465635;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OhWmimZIqkg9HQUoRo0vOAuz9vLw0fvzPCSsweRqk10=;
	b=ZC+Mz7tlyVYf9m493eQoHreiLwsCkyUw/OXdVIVK2NZ6fHbV6YGi8mnLW9iRFBGcq2ef
	 Eg/ZV2RltKQe/cZTQqdnIJVImXau8Sc7IbOE7fc/u027IVdRvRkP4V05y+7E3CMs/eCeS
	 h21pVLRu7Ul3hh7OwKBTBqEWEWtZKvYAy1YtZoNxwhwtnYjWmAAAy6PPLrvaiaCm5yCkk
	 B93zA0PVU73im+5DfOAxiYKNKxutk5VIbyN322IJtNb6IzYflFbXHGwMrJa+HPCr0nj75
	 RtioU/AmGsdrjJndZtRFTIcU23NLAcv162+nmKR/yyCR6oB+gdedgDqtoy2gS4rUtWw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04F4B1F0089E;
	Mon, 23 Nov 2026 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465635;
	bh=OhWmimZIqkg9HQUoRo0vOAuz9vLw0fvzPCSsweRqk10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=leFCaLDtWrBorX2xkRC80LPpCoN3fYEAdEnBbSQw3AvuWj6ZoynluE0hVuAbEhCGw
	 CmouZsnXUjN9zO6YcffUQc/W+fn+QTw4i+GTq0aB6W38A5wSaXKEvasInEp+m0WJ+m
	 VNZpV0K712HhN57tSRJYdlwEncdnXiKbzfjnMl24nCtgTZbohuxpS5LoyYKM0ZUCY1
	 7LYP2FZeiXB44vjzxH9/sN2Azz2FjNlRiCkiLGbZQsCiGez4YIhmPhO8r5nCOjs6U0
	 kwo295EA1Yr847rBuB9Dhxh2CKhIArl719sS2+9tBBTEmY0Fif+YgystjD9fxvXbAc
	 E4kVRXhkhGWcw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0ED354C6E9;
	Mon, 23 Nov 2026 20:27:03 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:27:02 +0300
Subject: [PATCH v2 2/3] rtc: Add Cortina Systems CS7542 RTC driver
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-cs7542-rtc-v2-2-31ab43f2cc8e@gmail.com>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465620; l=7105;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=QOCqd+uabd2B7duLw3XAC+zMqn5AZbL/CNFxqJTo8k4=;
 b=u79vd+3eXY1kOJh1/XZmCXfn9Egrq/vcJpM7YTnZfr5V4do+FaE8wBRljnDyYsIDw5oS+2UqJ
 8rXSJuxQ8tmBo7x3xT0avmWNbhxO5jGh/aPcsMV9R9dp/YlBDQ2HX0j
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Adapt the vendor-derived OpenWrt calendar implementation to an OF driver
without a platform Kconfig dependency. Decode the four-digit BCD year,
retry reads across second changes and preserve RTCEN after programming.
Expose the verified 2000-2099 calendar read/set operations. Do not
advertise alarm interrupts or suspend wake until their hardware
behaviour has been established.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/rtc/Kconfig      |   9 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cs75xx.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230e..2937f637a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1463,6 +1463,15 @@ config RTC_DRV_ASM9260
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-asm9260.
 
+config RTC_DRV_CS75XX
+	tristate "Cortina Systems CS7542 RTC"
+	depends on OF && HAS_IOMEM
+	help
+	  Support the calendar clock of the Cortina Systems CS7542 SoC.
+	  Read and set dates in the 2000-2099 range.
+	  Alarm interrupts are not supported.
+	  The module will be named rtc-cs75xx.
+
 config RTC_DRV_CV1800
 	tristate "Sophgo CV1800 RTC"
 	depends on SOPHGO_CV1800_RTCSYS || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 46f1a0fc2..516cc6c9c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
 obj-$(CONFIG_RTC_DRV_CROS_EC)	+= rtc-cros-ec.o
+obj-$(CONFIG_RTC_DRV_CS75XX)	+= rtc-cs75xx.o
 obj-$(CONFIG_RTC_DRV_CV1800)	+= rtc-cv1800.o
 obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
 obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
diff --git a/drivers/rtc/rtc-cs75xx.c b/drivers/rtc/rtc-cs75xx.c
new file mode 100644
index 000000000..2ba25ac04
--- /dev/null
+++ b/drivers/rtc/rtc-cs75xx.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#define DRV_NAME	"cs75xx-rtc"
+
+#define G2_RTC_RTCCON		0x00
+#define G2_RTC_RTCCON_STARTB	BIT(0)
+#define G2_RTC_RTCCON_RTCEN	BIT(1)
+#define G2_RTC_RTCCON_CLKRST	BIT(2)
+#define G2_RTC_RTCCON_OSCEN	BIT(3)
+
+#define G2_RTC_RTCSEC		0x24
+#define G2_RTC_RTCMIN		0x28
+#define G2_RTC_RTCHOUR		0x2c
+#define G2_RTC_RTCDATE		0x30
+#define G2_RTC_RTCDAY		0x34
+#define G2_RTC_RTCMON		0x38
+#define G2_RTC_RTCYEAR		0x3c
+struct g2_rtc {
+	void __iomem		*base;
+	struct rtc_device	*rtc;
+};
+
+static u32 g2_rtc_readl(struct g2_rtc *p, unsigned int addr)
+{
+	return readl(p->base + addr);
+}
+
+static u8 g2_rtc_readb(struct g2_rtc *p, unsigned int addr)
+{
+	return readl(p->base + addr) & 0xff;
+}
+
+static void g2_rtc_writel(struct g2_rtc *p, unsigned int addr, u32 val, u32 mask)
+{
+	u32 reg = (readl(p->base + addr) & ~mask) | (val & mask);
+
+	writel(reg, p->base + addr);
+}
+
+static void g2_rtc_write_enable(struct g2_rtc *p)
+{
+	u32 tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
+
+	g2_rtc_writel(p, G2_RTC_RTCCON,
+		      tmp | G2_RTC_RTCCON_RTCEN | G2_RTC_RTCCON_STARTB, 0xff);
+}
+
+static void g2_rtc_write_disable(struct g2_rtc *p)
+{
+	u32 tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
+
+	g2_rtc_writel(p, G2_RTC_RTCCON,
+		      tmp & ~G2_RTC_RTCCON_STARTB, 0xff);
+}
+
+static int g2_rtc_gettime(struct device *dev, struct rtc_time *tm)
+{
+	struct g2_rtc *p = dev_get_drvdata(dev);
+	u32 year, sec;
+	int retry;
+
+	for (retry = 0; retry < 3; retry++) {
+		sec = g2_rtc_readb(p, G2_RTC_RTCSEC);
+		tm->tm_min = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCMIN));
+		tm->tm_hour = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCHOUR));
+		tm->tm_mday = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCDATE));
+		tm->tm_mon = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCMON)) - 1;
+		year = g2_rtc_readl(p, G2_RTC_RTCYEAR) & 0xffff;
+		if (sec == g2_rtc_readb(p, G2_RTC_RTCSEC)) {
+			tm->tm_sec = bcd2bin(sec);
+			tm->tm_year = bcd2bin(year & 0xff) +
+				      bcd2bin(year >> 8) * 100 - 1900;
+			return rtc_valid_tm(tm);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static int g2_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct g2_rtc *p = dev_get_drvdata(dev);
+	int year = tm->tm_year + 1900;
+
+	g2_rtc_write_enable(p);
+	g2_rtc_writel(p, G2_RTC_RTCSEC,  bin2bcd(tm->tm_sec), 0xffffffff);
+	g2_rtc_writel(p, G2_RTC_RTCMIN,  bin2bcd(tm->tm_min), 0xffffffff);
+	g2_rtc_writel(p, G2_RTC_RTCHOUR, bin2bcd(tm->tm_hour), 0xffffffff);
+	g2_rtc_writel(p, G2_RTC_RTCDATE, bin2bcd(tm->tm_mday), 0xffffffff);
+	g2_rtc_writel(p, G2_RTC_RTCMON,  bin2bcd(tm->tm_mon + 1), 0xffffffff);
+	g2_rtc_writel(p, G2_RTC_RTCYEAR,
+		      (bin2bcd(year / 100) << 8) | bin2bcd(year % 100), 0xffff);
+	g2_rtc_write_disable(p);
+
+	return 0;
+}
+
+static const struct rtc_class_ops g2_rtcops = {
+	.read_time		= g2_rtc_gettime,
+	.set_time		= g2_rtc_settime,
+};
+
+static void g2_rtc_enable(struct device *dev, struct g2_rtc *p)
+{
+	u32 tmp;
+
+	if ((g2_rtc_readb(p, G2_RTC_RTCCON) & G2_RTC_RTCCON_RTCEN) == 0) {
+		dev_info(dev, "rtc disabled, re-enabling\n");
+		tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
+		g2_rtc_writel(p, G2_RTC_RTCCON, tmp | G2_RTC_RTCCON_RTCEN, 0xff);
+	}
+	if (g2_rtc_readb(p, G2_RTC_RTCCON) & G2_RTC_RTCCON_CLKRST) {
+		dev_info(dev, "removing RTCCON_CLKRST\n");
+		tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
+		g2_rtc_writel(p, G2_RTC_RTCCON, tmp & ~G2_RTC_RTCCON_CLKRST, 0xff);
+	}
+}
+
+static int g2_rtc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct g2_rtc *p;
+
+	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(p->base))
+		return PTR_ERR(p->base);
+
+	platform_set_drvdata(pdev, p);
+
+	g2_rtc_enable(dev, p);
+
+	p->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(p->rtc))
+		return PTR_ERR(p->rtc);
+	p->rtc->ops = &g2_rtcops;
+	p->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	p->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	/* Alarm interrupt generation has not yet been verified. */
+	clear_bit(RTC_FEATURE_ALARM, p->rtc->features);
+
+	return devm_rtc_register_device(p->rtc);
+}
+
+static const struct of_device_id cs75xx_rtc_of_match_table[] = {
+	{ .compatible = "cortina,cs7542-rtc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs75xx_rtc_of_match_table);
+
+static struct platform_driver g2_rtc_driver = {
+	.probe		= g2_rtc_probe,
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = cs75xx_rtc_of_match_table,
+	},
+};
+module_platform_driver(g2_rtc_driver);
+
+MODULE_DESCRIPTION("Cortina CS75xx RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cs75xx-rtc");

-- 
2.53.0


