Return-Path: <SRS0=Sf1+=MP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C850C64EB8
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAEF20684
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Oct 2018 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMXx+YCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAEF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeJCUUf (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:20:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42356 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJCUUf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Oct 2018 16:20:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id n2-v6so5328368edo.9
        for <linux-rtc@vger.kernel.org>; Wed, 03 Oct 2018 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JoZeYtyQ79MOQHmmKRs1FkK/Yz7O5KeZm4argFjAYY0=;
        b=cMXx+YCQZ5J5RqGjss7KIV7Py4RMpHo8B/X0K0UPsBHA0QKeBDc58pO46L4ItXXUmP
         e1GmyBq387km/a3396gVPScog0YtRoEukYIyu0P8f2xDuE9F4MAiw9gHIINlAZw66Xal
         RYktRokK+rI4TwfwKpDIUMVwbYY8Tjc2rSb/kJ5KanlA+fatgIX9ikuW5Jf3YWy0kL4/
         jhjh5+PtOEyXbxtNW6K7dCL/3qPNeupQE4udWxEdo27DlFSaJvDvK5TK+kKDupiyjlNr
         X7rlwfybU/pV1eaCWn/IfDllHvfyu5rNxLSyzeW6EQ8V19ahDh82kFTz9fhpFxAMV6Tw
         Jd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JoZeYtyQ79MOQHmmKRs1FkK/Yz7O5KeZm4argFjAYY0=;
        b=PetmS6bWfwrg8N/E9m1Ca6hDGrE+gZ4sVAxn8gklgJQdqc1HsWfEo5znllqmKTkUkF
         sDLEmWvlexHimWLASRNJZBLelR9MBi3pGJ6JWypi9DryRirvYFac6XPmyIkIvEf68o1u
         aG9wGxGIqgbzn02w5RJUuddr0sZJoB4lANmOC5P/8Seyu73DRCK8K0aAjiKmUYraVpww
         2EQgix9oFyO3Hf5VPTBCCDdZakvpo79525Q1OLaDv2RnlOakdD3i+GaM0htrOiqTxXGg
         bpJvuXfNmwAxqgnWbpYmfsK+1QL2pyhE/GVjcywvnkjphXgnam6hb8Mzhll8IbhsyupW
         EYnA==
X-Gm-Message-State: ABuFfoi8fWzuAHPuQ+QoehRbmWn8+q8D+/6ipqDvLFDA5DCeUrXWNM0f
        os49E2wgLuQl8CIgV/kNnnU=
X-Google-Smtp-Source: ACcGV63V6goTyGOW8r3VDw46a7sNXr7JUXo8ra5L06AeiZMJ+F5MqZsRIX1qnzyY1shYmpbM1ekLeg==
X-Received: by 2002:a17:906:c28f:: with SMTP id r15-v6mr1920450ejz.188.1538573527457;
        Wed, 03 Oct 2018 06:32:07 -0700 (PDT)
Received: from aurora.jms.id.au ([213.244.178.17])
        by smtp.gmail.com with ESMTPSA id l34-v6sm547766eda.54.2018.10.03.06.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 06:32:06 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:32:05 +0200
From:   Joel Stanley <joel@jms.id.au>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Christian Svensson <christian@cmd.nu>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH 1/2] rtc: Add ASPEED RTC driver
Date:   Wed,  3 Oct 2018 15:31:54 +0200
Message-Id: <20181003133155.27494-2-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003133155.27494-1-joel@jms.id.au>
References: <20181003133155.27494-1-joel@jms.id.au>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Read and writes the time to the non-battery backed RTC in the ASPEED
AST2400 and AST2500 system on chip.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/rtc/Kconfig      |  10 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-aspeed.c | 142 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/rtc/rtc-aspeed.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef07b7ec..372944b59b69 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1783,6 +1783,16 @@ config RTC_DRV_RTD119X
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
index 290c1730fb0a..7d924577d133 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
 obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
 obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
+obj-$(CONFIG_RTC_DRV_ASPEED)	+= rtc-aspeed.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
new file mode 100644
index 000000000000..dce00e594910
--- /dev/null
+++ b/drivers/rtc/rtc-aspeed.c
@@ -0,0 +1,142 @@
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
+#define RTC_UNLOCK	0x02
+#define RTC_ENABLE	0x01
+
+static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int cent, year, mon, day, hour, min, sec;
+	unsigned long flags;
+	u32 reg1, reg2;
+
+	spin_lock_irqsave(&rtc->lock, flags);
+
+	do {
+		reg2 = readl(rtc->base + RTC_YEAR);
+		reg1 = readl(rtc->base + RTC_TIME);
+	} while (reg2 != readl(rtc->base + RTC_YEAR));
+
+	day  = (reg1 >> 24) & 0x1f;
+	hour = (reg1 >> 16) & 0x1f;
+	min  = (reg1 >>  8) & 0x3f;
+	sec  = (reg1 >>  0) & 0x3f;
+	cent = (reg2 >> 16) & 0x1f;
+	year = (reg2 >>  8) & 0x7f;
+	/*
+	 * Month is 1-12 in hardware, and 0-11 in struct rtc_time, however we
+	 * are using mktime64 which is 1-12, so no adjustment is necessary
+	 */
+	mon  = (reg2 >>  0) & 0x0f;
+
+	rtc_time64_to_tm(mktime64(cent * 100 + year, mon, day, hour, min, sec),
+			tm);
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
+	spin_lock_irqsave(&rtc->lock, flags);
+
+	cent = (tm->tm_year + 1900) / 100;
+	year = tm->tm_year % 100;
+
+	reg1 = (tm->tm_mday << 24) | (tm->tm_hour << 16) | (tm->tm_min << 8) |
+		tm->tm_sec;
+
+	/* Hardware is 1-12, convert to 0-11 */
+	reg2 = ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
+		((tm->tm_mon & 0xf) + 1);
+
+	ctrl = readl(rtc->base + RTC_CTRL);
+	writel(ctrl | RTC_UNLOCK, rtc->base + RTC_CTRL);
+
+	writel(reg1, rtc->base + RTC_TIME);
+	writel(reg2, rtc->base + RTC_YEAR);
+
+	writel(ctrl, rtc->base + RTC_CTRL);
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
+	struct resource *res;
+	struct aspeed_rtc *rtc;
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
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
+						&aspeed_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	spin_lock_init(&rtc->lock);
+
+	/* Enable RTC and clear the unlock bit */
+	writel(RTC_ENABLE, rtc->base + RTC_CTRL);
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_rtc_match[] = {
+	{ .compatible = "aspeed,ast2400-rtc", },
+	{ .compatible = "aspeed,ast2500-rtc", },
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
+MODULE_DESCRIPTION("Aspeed RTC driver");
+MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

