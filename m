Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64C3C10F03
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770F72084D
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkn4zj8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCYNcc (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:32:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37379 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYNcb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 09:32:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so6442998pfr.4;
        Mon, 25 Mar 2019 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNMynFsYBw4bJOkRxzZKAehBFlMsAcqfPwZnt4LHr6Y=;
        b=Tkn4zj8xOHgJLuaEbb8YRTPlsm7DpDp0dRUqUw2uFQaqihw44lfAPUcbw8Q++btstd
         kAqqVEP5d9cEEOyEOdeBQreb4sUh6xCU7Od2IZbnlpCMKgcL0xHDE1GDT22WnhRBfuJy
         cMzpnJjo8GtlrejLgOwfvvrC37HDuuaDZY23FM7t1A2GByWfzM1dnnzW0hubcIn+jMEJ
         EsVFPahDyTRsMaCLKPoF1U/hVnIykOjjDwuzjEfbrOeeAWYm3dKiUuY/Dd9qDcTpqZWn
         UWhexXpFKA3bCwKv7Ah50TE0W/NpYWjBgvYxgt9+cK+0jB1JbtRlYVYsrN8eItUyDZe/
         P8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZNMynFsYBw4bJOkRxzZKAehBFlMsAcqfPwZnt4LHr6Y=;
        b=ELV+s4B9fsk4Cqc7LANm0AParJsgx7T6NUXffkhAfkHERwNwMXMkrv8UcJE2aIH7Lu
         BERzdt8tZuJyKXbBONtKCez4tEpbovBt5ye+QPuB+JjY4zG7WipLkxaxwC/iuFseGmJC
         D58RlL3jYLfWre1Mf8U1wv37HWB0pAmP0ft53cgWtoKMy+eLxbF7eSW7gk80nR1hgoZO
         DZk8Q6o7EkcP27DTAY+YQzh1Vj8VfuNIY5Jc5SJ0C9HKgPZr/x6/e9m+6d70NjDGww8+
         A+ha5/KoSmlo253KQ1c2nUXiv62oaP3Pt75JMvqGYIvFUws3WZZzKVSk8EZhjXxTHXVy
         EHTQ==
X-Gm-Message-State: APjAAAXjE4pVIgt6uuZ/3bpS61P1jiHnndmDkM7VAv6tagu/8psY8Ub8
        LRoazluHrwfCmfiEPTGab0M=
X-Google-Smtp-Source: APXvYqxWmgl5NSWVyfiMFj1K6VYnIt5doHiSXnXRCtJB3R+x+8vSDkZ72cgv4gSxLujBuHtn6Nzr4w==
X-Received: by 2002:a63:28c:: with SMTP id 134mr18182510pgc.278.1553520750567;
        Mon, 25 Mar 2019 06:32:30 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id i64sm23498107pfb.112.2019.03.25.06.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 06:32:29 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Tue, 26 Mar 2019 00:02:22 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 2/2] rtc: Add ASPEED RTC driver
Date:   Tue, 26 Mar 2019 00:01:59 +1030
Message-Id: <20190325133159.10653-3-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325133159.10653-1-joel@jms.id.au>
References: <20190325133159.10653-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Read and writes the time to the non-battery backed RTC in the ASPEED BMC
system on chip families.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Address review from Alexandre
 - Use devm_rtc_allocate_device
 - Fill in range_min
 - Direcly fill in tm struct
 - Return EINVAL when RTC is not enabled

v1: https://lore.kernel.org/linux-arm-kernel/20181003133155.27494-2-joel@jms.id.au/
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/rtc/Kconfig      |  10 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-aspeed.c | 152 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/rtc/rtc-aspeed.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index dc0d66e80038..2d0482bc468b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1841,6 +1841,16 @@ config RTC_DRV_RTD119X
 	  If you say yes here, you get support for the RTD1295 SoC
 	  Real Time Clock.
 
+config RTC_DRV_ASPEED
+	tristate "Aspeed RTC"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	help
+	  If you say yes here you get support for the ASPEED AST2400 and
+	  AST2500 SoC real time clocks.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-aspeed".
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fe3962496685..9d997faa2c26 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
 obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
 obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
+obj-$(CONFIG_RTC_DRV_ASPEED)	+= rtc-aspeed.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
new file mode 100644
index 000000000000..9ddb3121b30d
--- /dev/null
+++ b/drivers/rtc/rtc-aspeed.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2015 IBM Corp.
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/io.h>
+
+struct aspeed_rtc {
+	struct rtc_device	*rtc_dev;
+	void __iomem		*base;
+	spinlock_t		lock;
+};
+
+#define RTC_TIME	0x00
+#define RTC_YEAR	0x04
+#define RTC_CTRL	0x10
+
+#define RTC_UNLOCK	BIT(1)
+#define RTC_ENABLE	BIT(0)
+
+static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int cent, year;
+	unsigned long flags;
+	u32 reg1, reg2;
+
+	spin_lock_irqsave(&rtc->lock, flags);
+
+	if (!(readl(rtc->base + RTC_CTRL) & RTC_ENABLE)) {
+		spin_unlock_irqrestore(&rtc->lock, flags);
+		dev_dbg(dev, "%s failing as rtc disabled\n", __func__);
+		return -EINVAL;
+	}
+
+	do {
+		reg2 = readl(rtc->base + RTC_YEAR);
+		reg1 = readl(rtc->base + RTC_TIME);
+	} while (reg2 != readl(rtc->base + RTC_YEAR));
+
+	tm->tm_mday = (reg1 >> 24) & 0x1f;
+	tm->tm_hour = (reg1 >> 16) & 0x1f;
+	tm->tm_min = (reg1 >> 8) & 0x3f;
+	tm->tm_sec = (reg1 >> 0) & 0x3f;
+
+	cent = (reg2 >> 16) & 0x1f;
+	year = (reg2 >> 8) & 0x7f;
+	tm->tm_mon = ((reg2 >>  0) & 0x0f) - 1;
+	tm->tm_year = year + (cent * 100) - 1900;
+
+	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
+			1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	spin_unlock_irqrestore(&rtc->lock, flags);
+
+	return 0;
+}
+
+static int aspeed_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long flags;
+	u32 reg1, reg2, ctrl;
+	int year, cent;
+
+	cent = (tm->tm_year + 1900) / 100;
+	year = tm->tm_year % 100;
+
+	reg1 = (tm->tm_mday << 24) | (tm->tm_hour << 16) | (tm->tm_min << 8) |
+		tm->tm_sec;
+
+	reg2 = ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
+		((tm->tm_mon + 1) & 0xf);
+
+	spin_lock_irqsave(&rtc->lock, flags);
+
+	ctrl = readl(rtc->base + RTC_CTRL);
+	writel(ctrl | RTC_UNLOCK, rtc->base + RTC_CTRL);
+
+	writel(reg1, rtc->base + RTC_TIME);
+	writel(reg2, rtc->base + RTC_YEAR);
+
+	/* Re-lock and ensure enable is set now that a time is programmed */
+	writel(ctrl | RTC_ENABLE, rtc->base + RTC_CTRL);
+
+	spin_unlock_irqrestore(&rtc->lock, flags);
+
+	return 0;
+}
+
+static const struct rtc_class_ops aspeed_rtc_ops = {
+	.read_time = aspeed_rtc_read_time,
+	.set_time = aspeed_rtc_set_time,
+};
+
+static int aspeed_rtc_probe(struct platform_device *pdev)
+{
+	struct aspeed_rtc *rtc;
+	struct resource *res;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rtc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rtc->base))
+		return PTR_ERR(rtc->base);
+
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtc_dev->ops = &aspeed_rtc_ops;
+	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
+
+	ret = rtc_register_device(rtc->rtc_dev);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&rtc->lock);
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_rtc_match[] = {
+	{ .compatible = "aspeed,ast2400-rtc", },
+	{ .compatible = "aspeed,ast2500-rtc", },
+	{ .compatible = "aspeed,ast2600-rtc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, aspeed_rtc_match);
+
+static struct platform_driver aspeed_rtc_driver = {
+	.driver = {
+		.name = "aspeed-rtc",
+		.of_match_table = of_match_ptr(aspeed_rtc_match),
+	},
+};
+
+module_platform_driver_probe(aspeed_rtc_driver, aspeed_rtc_probe);
+
+MODULE_DESCRIPTION("ASPEED RTC driver");
+MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

