Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239109;
	b=3IZ1S3cnY82atKrQs5Zc3S2AsQsOEOXq7hLJXfByDA1l+EZhI1PgN5U4VvsgDss4ClPn
	 auRQgPjDXbAG1uM3bu3PzVbYoOGYE2UsCMNwslVlSM7CfOCifP/JkfEL6pl5yLSLEmnmK
	 GhYwmmbZ4e9LV1E7VbaBZ2QesX9zCL9fdpHpsI8d3pOwxUmFw6E8ReaiRBnhVuL3vgcOC
	 XP6YsMgL/8Emlj2keHF18NF0AM+i/bgK+rSSLQy9O62HSGvhYieRaZhqF2HBw33Lh564T
	 rJ0yG/JWkXMhNfkzHF4B8B0Thee6D1cvOsGEacEO0cOTXiQzzGn/js+Vb66N/uee+/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x1bUY6t5miUGSUVE/7aBxmDULKQY0VHYzL6IowA9kr8=;
	b=1Yl5o+vI2I8J3okUStKvFXlUIeQpa1UX1HqZS5n4Q6uCQGfKDOYk6dVNQp0V+sHfTE2X
	 apmmio1W9SzD6yVPphUSAnoZ6MJcnsY1s+LxgJxI1Mw+T6co89lgt3Sm5s33WFJLitzAe
	 l281d2KTRWvYnTvPIkskERG7czKWD1KGpxUaIEfOQ6dCBpZQpOKhzp3ufVG1meL/Q+ULJ
	 zK5KSe8RMFQbjAmFGoamUcZNJy2zTJ+sROyuX4doR5i9syhrRI8oNabTvO5x1zsEPVYNi
	 N1Sch6tmVxqS2ocm/KSCKj+pz22sauzu7kKM0xXTvZqu/qPRLYKBVSrT6Mp1+nHKpcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcMCynRQ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA77606EE8C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA77606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcMCynRQ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so8955335e9.2
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239108; x=1794843908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1bUY6t5miUGSUVE/7aBxmDULKQY0VHYzL6IowA9kr8=;
        b=fcMCynRQHOfFXHpsPa2fh2l4SqYGjiq/c+aLCOTpQNUxRjKpZiNpZHFBNPrPjOMzQu
         WnCmhof2moPC++9tuY4COJXGIMUUYzYgpF0GZ57PkqPKMZKwQeBnxMWIdDRFIB5XuPaQ
         Ar03UcwXdC8ifk9y1izpIVyPN55CB7RMyvbSPbf4h1fv457pyJU0atMdW9afLjl7Kmsb
         GF203ziCgUDxYv0vOST9mlg/611U/ojDl3Gv8g69Eov4vCiXl71Gf3NnrZrZi1p0oI1/
         v4ffDWWLhuH8ypSn6vcpp7bKQnz4nxfx61TJUG7gZmi38tvePbxhQzZLqgNTOj+lQX05
         6ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239108; x=1794843908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1bUY6t5miUGSUVE/7aBxmDULKQY0VHYzL6IowA9kr8=;
        b=LvWGySVZVTwrzEh5oR7x5ixRlTvHFBfzJj9CwRLTE0GW66+fMfSYHPpEyDQPdETbD+
         Wn9f+GXzllMdR+bCmSgQnJVkzq4oYE9AMfySzRJk0/IA6yLJ6j5lh6l7eaVyFkAgJjt7
         fGU1jUGhos8saQfUM1MiZSlU5h++iTQj+gdI5s1TbXiac/rdzq1Fd7aNWbElOKZhjhDr
         jo6MLgq+3CGhV1kUR52yA/vUz4adP4CxwIJCKcMo4y4MO+dloi+vIKSfG01sQRTeOFrd
         1fdsBkF8avDN8vPvEew9E8EL9hLb+PUZrWl0J7WmeispD5pZO+7rZvrTcFLXCYEsxxka
         qmBQ==
X-Forwarded-Encrypted: i=1; AL+hErFSjLJpCkfk/I1pjDJ4nodIjmY4rg9rcu6pmDgWTSvoXQRUg2ZohLcZw+sHoEWTJSrUII4Xyx2+H+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MioK4DMwIxBtXtTp+nxJMKHGrDBohpUvFL8H8Cl0wtfEVkBAc
	D50z0yb9c5QxPn1CBrfqJcrINQXcA3MXAO0mEmlzwT7CP26WGVhrKiJM
X-Gm-Gg: AYBFou1GxMyV39LVS7lSpF7Oar1GOmcfC08xUoVh9ckcKQ6aRRcTlds1xxM7W1L6BSP
	7sDs0wBBSIraf6KXNcdEEEydykx6DAjxSyHVONMoHE7Xr9fo+YhtaYjw1HvXLjoGAABnIBBnQLH
	utR+YGvZjdVIheemRTtRFpD+bVz88P6BGbNuejmG/JyMS5HDuiRlZ+e78YUSgS8l73B1s3q3G39
	/jOJobpL0zydknEPrdq3ii/G+zUYpVg1fLWTQhX2IcFTP8qCPH+1mfhbDYcnWg8mgWQ8j6BwypM
	4oyTGdKpNafwbBr9KkMtoa/nTd9FfOTaya6tGwdnxM37hJLpo1pe7XAy8GMWfidL766s/MPfj2f
	ax+3VUaSYEoADR+pbTkpKQjeK/iT898FWjzO423fna+QTKz5OsGYBePd0mgpcJSLsxLIS9mZPL0
	E7Vls9X2qIUbuY9Ax9RjSaCNguNoIjx1Zqhg3zqfVXbIth3a6DWlFIJw4K42ej9XObmmD8tH5VJ
	tGlBdm1JZuJs48bjYB4NUCeRaSsHUc1moazeNdiXgYOo0ma0jcGiKERaRLhr7sQTkzZRwALnBly
	gIZEV8NvUVUrHmuib9NZC1iS95W0rRvoS8hG1pcSvUmdQ0fR/i+FahA=
X-Received: by 2002:a05:600c:4f4c:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4b963c7d397mr102797505e9.26.1794239107281;
        Mon, 09 Nov 2026 07:45:07 -0800 (PST)
Received: from hp-z640.fritz.box ([51.37.204.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm257163645e9.5.2026.11.09.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:06 -0800 (PST)
From: Owen O'Hehir <oo.hehir@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Hal Feng <hal.feng@starfivetech.com>,
	"ziv.xu" <ziv.xu@starfivetech.com>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	E Shattow <e@freeshell.de>
Subject: [PATCH v3 2/4] rtc: Add StarFive JH7110 RTC driver
Date: Mon,  9 Nov 2026 15:44:59 +0000
Message-ID: <20261109154501.63762-3-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109154501.63762-1-oo.hehir@gmail.com>
References: <20261109154501.63762-1-oo.hehir@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "ziv.xu" <ziv.xu@starfivetech.com>

Add a driver for the RTC in the always-on domain of the StarFive JH7110
SoC. It supports time, alarm with wakeup, and the frequency offset.

Signed-off-by: ziv.xu <ziv.xu@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
[Owen: rework of the StarFive vendor driver for mainline: drop hardware
 calibration & the default time set in probe, use the generic wake IRQ
 helpers, wait for the update bit in set_time, re-read a time that rolls
 over during the read, round the offset to the nearest step & follow the
 sysfs offset sign, enable the 32k counter clock]
Co-developed-by: Owen O'Hehir <oo.hehir@gmail.com>
Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
---
 drivers/rtc/Kconfig      |  11 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-jh7110.c | 324 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 drivers/rtc/rtc-jh7110.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230e..332f2e022 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1807,6 +1807,17 @@ config RTC_DRV_MPC5121
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-mpc5121.
 
+config RTC_DRV_JH7110
+	tristate "StarFive JH7110 RTC"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	help
+	  If you say yes here you get support for the RTC in the always-on
+	  domain of StarFive JH7110 SoCs, with alarm and frequency offset
+	  support.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-jh7110.
+
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 46f1a0fc2..a5cddb8d8 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_RTC_DRV_IMX_BBM_SCMI)	+= rtc-imx-sm-bbm.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
 obj-$(CONFIG_RTC_DRV_ISL12026)	+= rtc-isl12026.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
+obj-$(CONFIG_RTC_DRV_JH7110)	+= rtc-jh7110.o
 obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
 obj-$(CONFIG_RTC_DRV_LOONGSON)	+= rtc-loongson.o
 obj-$(CONFIG_RTC_DRV_LP8788)	+= rtc-lp8788.o
diff --git a/drivers/rtc/rtc-jh7110.c b/drivers/rtc/rtc-jh7110.c
new file mode 100644
index 000000000..2dc9f64b1
--- /dev/null
+++ b/drivers/rtc/rtc-jh7110.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for the StarFive JH7110 SoC
+ *
+ * Copyright (C) 2021 StarFive Technology Co., Ltd.
+ * Copyright (C) 2026 Owen O'Hehir <oo.hehir@gmail.com>
+ */
+
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/reset.h>
+#include <linux/rtc.h>
+
+#define JH7110_RTC_CFG			0x00
+#define JH7110_RTC_CFG_ENABLE		BIT(0)
+#define JH7110_RTC_CFG_CAL_SEL_HW	BIT(2)
+#define JH7110_RTC_CFG_HOUR_24H		BIT(3)
+#define JH7110_RTC_SW_CAL_VALUE		0x04
+#define JH7110_RTC_IRQ_EN		0x10
+#define JH7110_RTC_IRQ_EVENT		0x14
+#define JH7110_RTC_IRQ_ALARM		BIT(4)
+#define JH7110_RTC_IRQ_ALL		GENMASK(4, 0)
+#define JH7110_RTC_EVENT_UPDATE		BIT(31)
+#define JH7110_RTC_CAL_VALUE		0x24
+#define JH7110_RTC_CFG_TIME		0x28
+#define JH7110_RTC_CFG_DATE		0x2c
+#define JH7110_RTC_ACT_TIME		0x34
+#define JH7110_RTC_ACT_DATE		0x38
+#define JH7110_RTC_TIME			0x3c
+#define JH7110_RTC_DATE			0x40
+
+#define JH7110_RTC_TIME_SEC		GENMASK(6, 0)
+#define JH7110_RTC_TIME_MIN		GENMASK(13, 7)
+#define JH7110_RTC_TIME_HOUR		GENMASK(20, 14)
+#define JH7110_RTC_DATE_DAY		GENMASK(5, 0)
+#define JH7110_RTC_DATE_MON		GENMASK(10, 6)
+#define JH7110_RTC_DATE_YEAR		GENMASK(18, 11)
+
+#define JH7110_RTC_CAL_MASK		GENMASK(15, 0)
+#define JH7110_RTC_TICKS_PER_SEC	32768
+
+#define JH7110_RTC_SYNC_TIMEOUT_US	1000
+
+struct jh7110_rtc {
+	struct rtc_device *rtc;
+	void __iomem *base;
+};
+
+static void jh7110_rtc_reg2tm(struct rtc_time *tm, u32 time, u32 date)
+{
+	tm->tm_sec = bcd2bin(FIELD_GET(JH7110_RTC_TIME_SEC, time));
+	tm->tm_min = bcd2bin(FIELD_GET(JH7110_RTC_TIME_MIN, time));
+	tm->tm_hour = bcd2bin(FIELD_GET(JH7110_RTC_TIME_HOUR, time));
+	tm->tm_mday = bcd2bin(FIELD_GET(JH7110_RTC_DATE_DAY, date));
+	tm->tm_mon = bcd2bin(FIELD_GET(JH7110_RTC_DATE_MON, date)) - 1;
+	tm->tm_year = bcd2bin(FIELD_GET(JH7110_RTC_DATE_YEAR, date)) + 100;
+}
+
+static u32 jh7110_rtc_tm2time(struct rtc_time *tm)
+{
+	return FIELD_PREP(JH7110_RTC_TIME_SEC, bin2bcd(tm->tm_sec)) |
+	       FIELD_PREP(JH7110_RTC_TIME_MIN, bin2bcd(tm->tm_min)) |
+	       FIELD_PREP(JH7110_RTC_TIME_HOUR, bin2bcd(tm->tm_hour));
+}
+
+static u32 jh7110_rtc_tm2date(struct rtc_time *tm)
+{
+	return FIELD_PREP(JH7110_RTC_DATE_DAY, bin2bcd(tm->tm_mday)) |
+	       FIELD_PREP(JH7110_RTC_DATE_MON, bin2bcd(tm->tm_mon + 1)) |
+	       FIELD_PREP(JH7110_RTC_DATE_YEAR, bin2bcd(tm->tm_year - 100));
+}
+
+static int jh7110_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+	u32 time, date;
+
+	/*
+	 * re-read if the time rolled over between reading TIME & DATE, since
+	 * that rollover can also change the date.
+	 */
+	do {
+		time = readl(jrtc->base + JH7110_RTC_TIME);
+		date = readl(jrtc->base + JH7110_RTC_DATE);
+	} while (time != readl(jrtc->base + JH7110_RTC_TIME));
+
+	jh7110_rtc_reg2tm(tm, time, date);
+
+	return 0;
+}
+
+static int jh7110_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+	u32 val;
+
+	writel(jh7110_rtc_tm2time(tm), jrtc->base + JH7110_RTC_CFG_TIME);
+	writel(jh7110_rtc_tm2date(tm), jrtc->base + JH7110_RTC_CFG_DATE);
+
+	/*
+	 * The counter loads CFG_TIME & CFG_DATE on this pulse; the bit appears
+	 * to read back as 1 until the load is done.
+	 */
+	writel(JH7110_RTC_EVENT_UPDATE, jrtc->base + JH7110_RTC_IRQ_EVENT);
+
+	return readl_poll_timeout(jrtc->base + JH7110_RTC_IRQ_EVENT, val,
+				  !(val & JH7110_RTC_EVENT_UPDATE), 10,
+				  JH7110_RTC_SYNC_TIMEOUT_US);
+}
+
+static int jh7110_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+	u32 val;
+
+	val = readl(jrtc->base + JH7110_RTC_IRQ_EN);
+	if (enabled)
+		val |= JH7110_RTC_IRQ_ALARM;
+	else
+		val &= ~JH7110_RTC_IRQ_ALARM;
+	writel(val, jrtc->base + JH7110_RTC_IRQ_EN);
+
+	return 0;
+}
+
+static int jh7110_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+
+	jh7110_rtc_reg2tm(&alrm->time, readl(jrtc->base + JH7110_RTC_ACT_TIME),
+			  readl(jrtc->base + JH7110_RTC_ACT_DATE));
+	alrm->enabled = !!(readl(jrtc->base + JH7110_RTC_IRQ_EN) & JH7110_RTC_IRQ_ALARM);
+
+	return 0;
+}
+
+static int jh7110_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+	u32 val;
+	int ret;
+
+	jh7110_rtc_alarm_irq_enable(dev, 0);
+	writel(jh7110_rtc_tm2time(&alrm->time), jrtc->base + JH7110_RTC_ACT_TIME);
+	writel(jh7110_rtc_tm2date(&alrm->time), jrtc->base + JH7110_RTC_ACT_DATE);
+	writel(JH7110_RTC_IRQ_ALARM, jrtc->base + JH7110_RTC_IRQ_EVENT);
+
+	ret = readl_poll_timeout(jrtc->base + JH7110_RTC_IRQ_EVENT, val,
+				 !(val & JH7110_RTC_IRQ_ALARM), 10,
+				 JH7110_RTC_SYNC_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	return jh7110_rtc_alarm_irq_enable(dev, alrm->enabled);
+}
+
+/*
+ * 1 sec for the RTC = CAL_VALUE + 1 cycles of the 32.768 kHz clock.
+ * Default of 0x7fff = exactly one second.
+ * Each step of CAL_VALUE changes the rate by 1/32768, about 30.5 ppm.
+ */
+static int jh7110_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+	s64 ticks;
+
+	ticks = (readl(jrtc->base + JH7110_RTC_CAL_VALUE) & JH7110_RTC_CAL_MASK) + 1;
+	*offset = DIV_S64_ROUND_CLOSEST((ticks - JH7110_RTC_TICKS_PER_SEC) * NSEC_PER_SEC,
+					JH7110_RTC_TICKS_PER_SEC);
+
+	return 0;
+}
+
+static int jh7110_rtc_set_offset(struct device *dev, long offset)
+{
+	struct jh7110_rtc *jrtc = dev_get_drvdata(dev);
+	s64 ticks;
+	u32 val;
+
+	if (offset < -NSEC_PER_SEC || offset > NSEC_PER_SEC)
+		return -ERANGE;
+
+	ticks = JH7110_RTC_TICKS_PER_SEC +
+		DIV_S64_ROUND_CLOSEST((s64)offset * JH7110_RTC_TICKS_PER_SEC, NSEC_PER_SEC);
+	if (ticks < 1 || ticks > JH7110_RTC_CAL_MASK + 1)
+		return -ERANGE;
+
+	writel(ticks - 1, jrtc->base + JH7110_RTC_SW_CAL_VALUE);
+	val = readl(jrtc->base + JH7110_RTC_CFG);
+	writel(val & ~JH7110_RTC_CFG_CAL_SEL_HW, jrtc->base + JH7110_RTC_CFG);
+
+	return 0;
+}
+
+static irqreturn_t jh7110_rtc_irq(int irq, void *data)
+{
+	struct jh7110_rtc *jrtc = data;
+	u32 events, val;
+
+	events = readl(jrtc->base + JH7110_RTC_IRQ_EVENT) &
+		 readl(jrtc->base + JH7110_RTC_IRQ_EN) & JH7110_RTC_IRQ_ALL;
+	if (!events)
+		return IRQ_NONE;
+
+	writel(events, jrtc->base + JH7110_RTC_IRQ_EVENT);
+	if (readl_poll_timeout_atomic(jrtc->base + JH7110_RTC_IRQ_EVENT, val,
+				      !(val & events), 0, JH7110_RTC_SYNC_TIMEOUT_US))
+		dev_warn_ratelimited(&jrtc->rtc->dev, "interrupt events 0x%x not cleared\n",
+				     events);
+
+	if (events & JH7110_RTC_IRQ_ALARM)
+		rtc_update_irq(jrtc->rtc, 1, RTC_AF | RTC_IRQF);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops jh7110_rtc_ops = {
+	.read_time		= jh7110_rtc_read_time,
+	.set_time		= jh7110_rtc_set_time,
+	.read_alarm		= jh7110_rtc_read_alarm,
+	.set_alarm		= jh7110_rtc_set_alarm,
+	.alarm_irq_enable	= jh7110_rtc_alarm_irq_enable,
+	.read_offset		= jh7110_rtc_read_offset,
+	.set_offset		= jh7110_rtc_set_offset,
+};
+
+static int jh7110_rtc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst;
+	struct jh7110_rtc *jrtc;
+	struct clk *clk;
+	int irq, ret;
+	u32 val;
+
+	jrtc = devm_kzalloc(dev, sizeof(*jrtc), GFP_KERNEL);
+	if (!jrtc)
+		return -ENOMEM;
+
+	jrtc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(jrtc->base))
+		return PTR_ERR(jrtc->base);
+
+	clk = devm_clk_get_enabled(dev, "apb");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable apb clock\n");
+
+	clk = devm_clk_get_enabled(dev, "cal");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable cal clock\n");
+
+	clk = devm_clk_get_enabled(dev, "32k");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable 32k clock\n");
+
+	/* Never asserted again, as that would stop the clock & lose the time */
+	rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "failed to get resets\n");
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert resets\n");
+
+	irq = platform_get_irq_byname(pdev, "rtc");
+	if (irq < 0)
+		return irq;
+
+	jrtc->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(jrtc->rtc))
+		return PTR_ERR(jrtc->rtc);
+
+	platform_set_drvdata(pdev, jrtc);
+
+	jrtc->rtc->ops = &jh7110_rtc_ops;
+	jrtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	jrtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	val = readl(jrtc->base + JH7110_RTC_CFG);
+	writel(val | JH7110_RTC_CFG_HOUR_24H | JH7110_RTC_CFG_ENABLE,
+	       jrtc->base + JH7110_RTC_CFG);
+
+	ret = devm_request_irq(dev, irq, jh7110_rtc_irq, 0, dev_name(dev), jrtc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	ret = devm_device_init_wakeup(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init wakeup\n");
+
+	ret = devm_pm_set_wake_irq(dev, irq);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set wake irq\n");
+
+	return devm_rtc_register_device(jrtc->rtc);
+}
+
+static const struct of_device_id jh7110_rtc_of_match[] = {
+	{ .compatible = "starfive,jh7110-rtc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_rtc_of_match);
+
+static struct platform_driver jh7110_rtc_driver = {
+	.driver = {
+		.name = "jh7110-rtc",
+		.of_match_table = jh7110_rtc_of_match,
+	},
+	.probe = jh7110_rtc_probe,
+};
+module_platform_driver(jh7110_rtc_driver);
+
+MODULE_AUTHOR("Samin Guo <samin.guo@starfivetech.com>");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

