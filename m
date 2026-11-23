Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459324;
	b=Ffvha3hrdOml+LTfgFhLcXIl/BG0TIes2czutpjT59+t7d4JqXNyYUb6XNxPr/oBNeMj
	 9Fh2VhsUr4VpylcxDbQlHMkmtvsMhfTylrBSjex5W+zEdqOrVKIgZxTevX+9yns925qUP
	 paw5sr2GaonxGHI9nUoTR3/c/XEIYXPIr+uRMxoQHTmue3Or6onLR935XQECT3vcMrahi
	 wNkRmi1jUOU8a7NqPs7ry7YD9vtt8r9kRBZwMI79O+wpSf2I+nmIopxVv8c5Ic7asUd4c
	 PZPSQQPPbfEHe3kQP2HgQK5RsIEeP+dADEq8DaDZ0vV5S06+LHfSFX1iG4Y6lAaf/UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459324;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qttTN4ymDbf5U1h4cEZyyAQDtK1HID8crAui/74k7k4=;
	b=hlve36Ftz7f+2a5ojA3MCjEbe09CnZdb/xyYN4JCaphyUV2fzqcovBRphzZ+1O+ATmds
	 cz+2xBdLcsnp3SLtl5ThPUEAKj0VEt7Ti4uTj8v/VmPHlRgjUM8tc8YtsgBegFgkvWlCp
	 hUWbfSZpe7yXWcicOEj3cMnNvz2rEGRCMeFjIURuHNh6GLbSYeyWfOsSFTJ3AXiW3ooxD
	 BIKu6hgNEuKPKypnX6hqarE7AXHQ/9OX2O9ZHqeWJmoL+5ntiFmuhp/1ORBGtUwhLRthE
	 eFOi2J6MoEkZC6BMdBg055jeweJLVYCN21FMtGQhwmnnvmR27QXTx0rodk3eTMSMSoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUZjtSBx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2761606A337;
	Mon, 23 Nov 2026 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUZjtSBx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459323;
	b=ebu/86Ko3DbXfC3JowXhAN0tOUoZWWil/qboZTCtvDpaAYNW9nISvMXPOkt8gRSSo0ZA
	 I1bRXaYDsWi+fGIUC23KFH2TgmrWh0LExIp2Dyfp//i4cAbUA4hZMLCOwBqT6QOiU4lM1
	 4IS8VN4261tZSN7BjZpARx1zifqw4KjJSMb09YdpQjVxY/tIat6AnyMRxPh+YszdwFr4B
	 br1fEr0BwztSWVi4EBtydf1ZwBDgE/FqYMgWCCSgqq0cLlKXuMpq+J0io6hxqtzREbLYK
	 rV1jsFCBJ86iTP+c01s9x5/a2BH49+yF2C/lCxeBHX1+ZVk8Vm0SzSZyBHVux6QXs9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459323;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qttTN4ymDbf5U1h4cEZyyAQDtK1HID8crAui/74k7k4=;
	b=AHpjGUgG8LJ0YVGugVYck1PLkKh+CH/d9pNSgMlltSDehcCqgFtRez3EgGAP53K7kywE
	 IFXK+oSHSt/gVNg+oMgoJZs4u+FYgeLuukmF72mfvUJowEhmJB6IYrZzIk6cawqqyT4mn
	 0iwOUKIYE/U/tSEk+7n6STSWWeBgbsF/7Nn+Uy+7bMkXdTgNbR0lC0O/dP8SHHdrw8uaq
	 7lGHkrSeHQbcptsuPo4BiNi+5brnBD6bCUkGbVmdyndHdDFlVGJQR2inQTamUdvzV4aTz
	 FdFejtKPpuRkHQQM7cqawkycG5ltsmE5lVh7dvBGzM/6xB7NbsZuiIyfKV8xuL8S+kA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B673B1F0156A;
	Mon, 23 Nov 2026 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459323;
	bh=qttTN4ymDbf5U1h4cEZyyAQDtK1HID8crAui/74k7k4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OUZjtSBx6H0m0u8LdC9PGvZ3ZyTBcMMHvTlwmAJ7En/1NVzxnTgb8rgBiIHnvNZxG
	 gv9xpmJ/y3piTtqGUz0d7vEo6mxRo5j3RvQrCOmvyhS8cxCp3+BLCiAeoBqMIqJMlG
	 aBNVVnZ8ssLLEgaj7iGRX5u1mD/gMduPHuYBlMrNOG9hx8kHSci5L8O9XWoWXIzQ+p
	 76njguFQDrpMiiTLJLtGkpim93BVjIn5RZZxUI81tEOCGAviDACbLRbaxXMIdR0Pc6
	 43Cx4fuccRs3topUGNP7ZFQBZa3QirrzZLhwHw9HbdzuPltn0izR/ceZ2pOR/CgTa8
	 RWjqE23vUUoUA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 44BB34C5BB;
	Mon, 23 Nov 2026 18:41:32 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:41:32 +0300
Subject: [PATCH 2/3] rtc: Add Cortina Systems CS7542 RTC driver
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
Message-Id: <20261123-b4-cs7542-rtc-v1-2-6c53761ffa03@gmail.com>
References: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459290; l=6878;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=jcM5vyGwgCHh4U340a2tm5zkxATl0n1Mpb3h9SNWUog=;
 b=1N9M5LsCgDouu4rv0mbly7hYBwa01Sp9VOi/0pgqjDPgKBhe1k4jsS9mj2T7ZIENZYQkNkRN0
 dcK0ShPtrBFCmKBzSZVNOzf6HOYQ41d0cgqqVxbMbdUnLxaWkYXu65S
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
 drivers/rtc/Kconfig      |  10 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cs75xx.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230e..0878ec33c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -2212,4 +2212,14 @@ config RTC_DRV_HID_SENSOR_TIME
 	  If this driver is compiled as a module, it will be named
 	  rtc-hid-sensor-time.
 
+
+config RTC_DRV_CS75XX
+	tristate "Cortina Systems CS7542 RTC"
+	depends on OF && HAS_IOMEM
+	help
+	  Support the calendar clock of the Cortina Systems CS7542 SoC.
+	  Read and set dates in the 2000-2099 range.
+	  Alarm interrupts are not supported.
+	  The module will be named rtc-cs75xx.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 46f1a0fc2..bc73db37b 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -200,3 +200,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_DRV_CS75XX)		+= rtc-cs75xx.o
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


