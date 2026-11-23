Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795474214;
	b=qYvZ4d3hiXWKrXDUvV9g1Kq7reD9CEDqN6wDaQ2NSO+dOkvV0h96hc3OyJCuERLEX13A
	 X9TEaGRjFpFwI4v4ny+OvSqcsRtS4AXXWFMDYzV6pOMR4fAlKDUbE2wxkwtWJhdo9yY4h
	 r8TxEtwlBSRji9eGEJ4j7mf5C1uhPxCiuztUApSFyGKXDdgg3DI2wDUkCQcy0KhaXMUHY
	 15kxJDNysuJ8K8v0HdjY6Bejhtxv7bwMf+59M4NNYvFRVJ8Rbndytu0Lq89FIAND2MGdU
	 6H+JCuTrYyX9Cd9V4P+5AsyjVACHc6/adwXjA1PJyOml3gTscK9faqKn8nBwjdge47g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474214;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eZY4Md2Mn1mF5VRqkw4gWdxxhirtIkLziyS1NyK/aTo=;
	b=ri3VMcY88T25aV7/tJ3ndYWCE9g0GOzq/wJhMCfWpyUaP8/QMf+NgT9TAhQ+OBeW4Zdm
	 4Sfsw/aCR279GAzw2j8LlEAiRefhG5sNBqbxrTcW1Rijiu4xZXdJDDAW+atYV5tZGVqBD
	 FYMMzuIDtz0ZNF0XbRnftydwrVwe0Q8yv+8gLJ4TpHGttNTlD1iFvw9vSMRHQMbbxtC6z
	 56SDeg1fONg/M5pI5ROTl2Cx2JRRVl9v0zTf3BPhSBmaswv/lXbkOHeW4S9ZAms3THEL9
	 dgZMZVkbdXWp+TrLTl1Z10GeGipctaE/lt6W1WEbnBNc0StFsPeFmFZlQCIDN0Ha4vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtqszdU6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097E606A322;
	Mon, 23 Nov 2026 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtqszdU6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795474213;
	b=3G7a/BsqSEJWwSrPU8CIC6V1d9mJaCEsPy/PsmIXr/+S2+ddAwggVpZpTFbqxBTD057Y
	 DibN7rDp8vpNUks2rTfofnqAwKhBhXiSLS98jgPDUsT/7qtnqjPQB4n+Z8hEBlmHmXJDo
	 A95UZj0vZGD+RsVnRxhCj1hmy4C6N+f3JrLFLj5y9sDocb2DR3DTUVF9d8cXPCZy31jq/
	 tMvObApljIH48CHmC2vh9fgSG79hMxPvXZwrTzW1j3aTYLuUKqoBsydX5fTJWtL4uVgWZ
	 tmPZtbEmwQNi/Qk+a0EhMnEIwBZrpa45S+dx5BNHjTn1ihxnbWjDNeFmu6+HERFTaUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474213;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eZY4Md2Mn1mF5VRqkw4gWdxxhirtIkLziyS1NyK/aTo=;
	b=gy6qAO4aWszJDdRDNskIcg4mCqu/YR91rLWFZW9zP0ROUcS3Dcq83YZQaS1TOy0uQk08
	 4FfHCV0f1DXUonGigY05s4SPgY2sm+YcD/AxdaquoYHi9gH0zbUZndwVIV0P1yJvDejJI
	 7ySViIGUKihW0ReIKTiXLF+Tqt9ZjadbUmUFtiyvKoY0qxPNwLJHZsLV7fQOIhSk/eNLv
	 a76IF/XrxpzbJUZAjoEq3epg7otLc1OfTGRprkQ5h6bR+53sRtFdx/VY8jUFo8NmD1G8T
	 Xn9rR4dA0zksBUTIekftKgYGA75HB3uNXEdnI4Jfa4ZtMNQ8Bvki/AoKxpKezDyWN5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04C391F000C4;
	Mon, 23 Nov 2026 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474213;
	bh=eZY4Md2Mn1mF5VRqkw4gWdxxhirtIkLziyS1NyK/aTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BtqszdU6BMH5dHstudJD0uZzIgE9O7HSA4rep8wOFlWQT77gyXt0RQ1yuEvmyb8GT
	 auFKkJLGv6CLDUnBLgBo0YbjHy6zvbA6+GBE8gfsnr3/Cn9lMtmKPS8I+rOxhcKaVB
	 arWWppxMMDZGoDEUjMfQ/DMuoObLlEZSNvx2KdBiUCXycBUYfFWG0fSaB10CF9X1GX
	 JBD7YGOcQHga7z2FDRfHs4DQ7YPDmD/KB2LAYTlGgVL7Bl0JsPbPng3s5pOzGRcfS6
	 W2yYqC80ftYtoj+xxn/HcD2KCg3KNXlHJtlpwFLrsH/Nv78zEEAc+yUG+BLtQU0q0p
	 7orah1FmYwxcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8788F4C7B5;
	Mon, 23 Nov 2026 22:50:01 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 01:50:02 +0300
Subject: [PATCH v4 2/3] rtc: Add Cortina Systems CS7542 RTC driver
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
Message-Id: <20261124-b4-cs7542-rtc-v4-2-bceefd844074@gmail.com>
References: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795474200; l=7239;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=3y4dhdM81ScD1PX2zJH//bIg+oja/F142CEVGUvmYsk=;
 b=HrmsFiQX8H1WBNPV3FcwUY90yOGXI56CiX4MI+byFOZ73RGnuFdjq407TJd04ZRJZH3mtGfGT
 R7OVb8Y3AD/DqPw1Hq1I9kgFQU3WiduPWscCBbhCgl7zE3IVTj41Ni1
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

Leave the RTC control state unchanged at probe and reject reads when it
is disabled or held in reset. Enable it and clear reset when a known
time is supplied through set_time. Let the RTC core validate calendar
fields and handle the absence of alarm callbacks.

Describe the physical 0000-9999 calendar with RTC_TIMESTAMP_BEGIN_0000
and RTC_TIMESTAMP_END_9999. The vendor BCDYEAR register has 16 year-data
bits; direct-callback RAM tests on Almond+ verified year 0000 and early
century carry/leap transitions, plus 1969 to 1970, in addition to the
upper-century
and 9999 endpoint tests. Core validation of normal reads/sets before 1970
is unchanged; only the separate fixture bypassed it. These are targeted
hardware checks, not a sweep of every year.

Alarm interrupts and suspend wake are not supported.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/rtc/Kconfig      |   9 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cs75xx.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230e..e8d6aaf37 100644
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
+	  The hardware's four-digit calendar covers years 0000-9999.
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
index 000000000..8ab8cfc33
--- /dev/null
+++ b/drivers/rtc/rtc-cs75xx.c
@@ -0,0 +1,159 @@
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
+		      (tmp & ~G2_RTC_RTCCON_CLKRST) | G2_RTC_RTCCON_RTCEN |
+		      G2_RTC_RTCCON_STARTB, 0xff);
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
+	u32 year, sec, ctrl;
+	int retry;
+
+	ctrl = g2_rtc_readb(p, G2_RTC_RTCCON);
+	if (!(ctrl & G2_RTC_RTCCON_RTCEN) || (ctrl & G2_RTC_RTCCON_CLKRST))
+		return -EINVAL;
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
+			return 0;
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
+	p->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(p->rtc))
+		return PTR_ERR(p->rtc);
+	p->rtc->ops = &g2_rtcops;
+	p->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
+	p->rtc->range_max = RTC_TIMESTAMP_END_9999;
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


