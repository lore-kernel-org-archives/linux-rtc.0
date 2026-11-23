Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471217;
	b=va3swDn3t+eJ3EE+uDYNqn5FZqmZ9OFJdNErKyLCHsbKifp10m8DXU98me9EU7NwIzW1
	 Efdnk9S7rJ++LvYwcZzHinCMTkZVjMYN0ajCjxjAsQNIPlLpr99OXp9xgpyWU87X+eUlx
	 +Ju4rUPFIirQxbvedPj2ETU9MHxG2URde+LU8i7aRHRAiBWL4YsIQt3q1zmttJAk495FY
	 IuiI6HhYHNaKpR2+1bigg9oSsYXSgyHtVgrrot/D9cIOZ1FAxv95LhBnqumiZSBlkTUWM
	 DzaXxun7pbaHWgNa3e02364afMnE2xmWGJ7IouS25SKZ9dcBKu8BErFzJ0K4YbH817w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471217;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8SxJzmblkGlUtzr6owCVm1G2TSc/7ZISziJAt5plU/8=;
	b=fgfZzu/yvetEjs0pL/vn4R8ikCrpqsFeB5B2JGZ17tli+ekVIir+Bk2sypZNx6hhOxKv
	 S3vZP+3pMtanCujskuXuXOxoISk3+AihJCR9p1gBkd/ZgLCf4gEn8ZTD2wirCjmhIBvDD
	 ERK63B3ud64dPi5j757MRCK3fzGZ1lWJlaqhaqIZFzOY13O2AucOzunjcg9tyvUgq8uJC
	 q5X7J2s0Ckz59XbWmp1MAYpi61jzi6Jd2LS3OBm24e4vZW9s+DhAloq81oKIjP2hUEFQA
	 wp92V208a4iJ4LLrW6+8n96/sH1D6gkmfpX0bHwdo03OTXNAM37Dzv8V1vibaXCShHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7vv9Jjf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6780606A681;
	Mon, 23 Nov 2026 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7vv9Jjf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795471216;
	b=1FgPklp7xdECEiUoT3rYF50aGI1d2Y3Gzrsugn/K9Li7QRnggYBQ0bwr2eRPFBBUrX5p
	 zANP22XR6xB5SRuXlMLWsTt7q35Sdd8t5g5oKLAx3nKo5J+8/AvKZ95JdPpSQCI/njFXt
	 W61ra7izUP69BG/hkTfmMLCj0ZNO1Yiwr8VI4tgBn0/zPRkMCcP9I3ZIQAPuD4/T+6M27
	 gtQ15nWMah8SJ3F7CuZ6YG1ELNvYDOW4NkRDaUgmURLBH7LNDrHO0waiWECpNgp+pFNL2
	 Pki0P9fnNPCWZdFXXM1MV5zYncW0FzlTy463mvDxV0l+a2egZL5tFdYp0Ojn9/D2nmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795471216;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8SxJzmblkGlUtzr6owCVm1G2TSc/7ZISziJAt5plU/8=;
	b=2aI5qwSRWbIg6cHco5sB4Cs8hVGI/Hv9XR1CJ3Er6r4gUQ9WozxQl1/ltUrIW5Kv62RR
	 LLk0Zs+W8okssaHzN+jAUji9va+LfYwJgifQ/RejPtca7xNcSbaClmc+zO5z27k+N68XS
	 1XNMrdLEx12zSmVAwDPHc1zwYCFH4sE2fuD6IP8Mde6f1j9j29yxSitrr4NeFLG9KJ+MG
	 0DB/BvWaL6py3Q9Kh0JfVCO3IwdKhb0iFoIZ1GR9NJoq8JJsWiEKKAC1TeK45ESeD3pd0
	 oW/hoDX8cKzXCw/G+2YMLN65/Wc/4lVMXFF+vHgZcSIg7Z1aYl+m/q+Zu/HTd+WbG0g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 820A11F000CA;
	Mon, 23 Nov 2026 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471216;
	bh=8SxJzmblkGlUtzr6owCVm1G2TSc/7ZISziJAt5plU/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=S7vv9Jjfbmt17nuSjmtvpaysL4Es1Y/eJMCRiEKGok4gCFh/+i2Lcko7JH0Q//FLS
	 OKe+nAzkLF6Y9iXo130mfYNpQgsB3nbUDohO9pFSLb9dY4hCysL9RHnkdXw8jwrgYO
	 WzAgeq8qKzsPNyiOaR0H8fnaDLINPaG6fAjr//dSJOZs4LNMsUbDuqWc5WR/SQfpDm
	 rdujey0eQLAb7uCXEENMTtfD4REPuT+fN9Vs7TXKgHqucm1BB6pCspFjIHYn5/wy1/
	 9x8/epsxNYHtUFy3YGS49X8M1gr1CjR5WRvrBY9BAvfqAwCVYpgD1nYczLmEo3hZqO
	 bFs70fkOrSaig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 123854C797;
	Mon, 23 Nov 2026 22:00:14 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 01:00:14 +0300
Subject: [PATCH v3 2/3] rtc: Add Cortina Systems CS7542 RTC driver
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
Message-Id: <20261124-b4-cs7542-rtc-v3-2-53902bfbe0ae@gmail.com>
References: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795471212; l=6987;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=L+MoNg0vZ0T4ofB68/ojNN5Egky7PkV9AoDRyZITIno=;
 b=Lxl/8aMMqtH3ioBM5EMZcxzuenTgLZnrcMaduEuWmgUIJjfNX4sAqfbByB2GYNpYRyYmoO1q3
 5JZISX3k7fGA94P1LnReYhP2PrXGLfE4XcKKKE0BAfB7TWAjPqbyyKO
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

The vendor BCDYEAR register defines a 16-bit year field, with its upper
16 bits reserved. Advertise 1970-9999 after verifying century carries,
non-leap 2100/2200, leap 2400 and read/set/counting at the 9999 endpoint
on Almond+. Those targeted hardware checks do not test every year.
Alarm interrupts and suspend wake are not supported.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/rtc/Kconfig      |   9 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cs75xx.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230e..642b70c5f 100644
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
+	  Read and set dates in the 1970-9999 range.
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
index 000000000..2e39304a4
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
+	p->rtc->range_min = 0;
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


