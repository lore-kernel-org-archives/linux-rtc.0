Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB91C77B7A
	for <linux-rtc@archiver.kernel.org>; Thu, 18 May 2023 00:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjERAd1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 17 May 2023 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjERAd0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 17 May 2023 20:33:26 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B152D4C
        for <linux-rtc@vger.kernel.org>; Wed, 17 May 2023 17:33:23 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1F9C88619F;
        Thu, 18 May 2023 02:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684370001;
        bh=hxaBw3zLHq4nC0LiaZaAIEBAOvcgQ4XJh+parRnKWv4=;
        h=From:To:Cc:Subject:Date:From;
        b=ugvCku3SpM0TfGqNBHoBcjvayZvnC423+pGQIaq7/A3jcy/7TcxfkQGXFWbqvLSwL
         v6NdbkE8XEGXKwu4l5D11ywNUx0LJMez9qKtcmgZyJkMEaaM5OBTMh5kp9/sgB5BhP
         5UosV0L7yqZlJB/eyE7UYVP94HZN6k71num5APVcm3a44ZRE9kWtGncfR0rhvWZ8xg
         hT1Zo2E9F/XYi2rAu8nh4hiALAz9mWATTvkdepEQrWHIpgFGRRB8PhHlsYQ5wMqRi2
         IXRGxCip/rkrYE3DV9k8aVfTcX21yARzaKyrc9GWvVvLpQsRS0ZEbCjBgYr3jED1Zs
         fWaiN3oKJK87w==
From:   Marek Vasut <marex@denx.de>
To:     linux-rtc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] rtc: stm32: Handle single EXTI IRQ as wake up source
Date:   Thu, 18 May 2023 02:33:11 +0200
Message-Id: <20230518003311.415018-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The arch/arm/boot/dts/stm32mp151.dtsi specifies one interrupt for the
RTC node, while the expectation of the RTC driver is two interrupts on
STM32MP15xx SoC, one connected to GIC interrupt controller and another
one to EXTI. Per STM32MP15xx reference manual, the two interrupts serve
the same purpose, except the EXTI one can also wake the system up. The
EXTI driver already internally handles this GIC and EXTI duality and
maps the EXTI interrupt onto GIC during runtime, and only uses the EXTI
for wake up functionality.

Therefore, fix the driver such that if on STM32MP15xx there is only one
interrupt specified in the DT, use that interrupt as EXTI interrupt and
set it as wake up source.

This fixes the following warning in the kernel log on STM32MP15xx:
"
stm32_rtc 5c004000.rtc: error -ENXIO: IRQ index 1 not found
stm32_rtc 5c004000.rtc: alarm can't wake up the system: -6
"

This also fixes the system wake up via built-in RTC using e.g.:
$ rtcwake -s 5 -m mem

Fixes: b72252b6580c ("rtc: stm32: add stm32mp1 rtc support")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/rtc/rtc-stm32.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 229cb2847cc48..72994b9f95319 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -780,14 +780,15 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	ret = device_init_wakeup(&pdev->dev, true);
 	if (rtc->data->has_wakeirq) {
-		rtc->wakeirq_alarm = platform_get_irq(pdev, 1);
+		rtc->wakeirq_alarm = platform_get_irq_optional(pdev, 1);
 		if (rtc->wakeirq_alarm > 0) {
 			ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
 							    rtc->wakeirq_alarm);
-		} else {
+		} else if (rtc->wakeirq_alarm == -EPROBE_DEFER) {
 			ret = rtc->wakeirq_alarm;
-			if (rtc->wakeirq_alarm == -EPROBE_DEFER)
-				goto err;
+			goto err;
+		} else {
+			ret = dev_pm_set_wake_irq(&pdev->dev, rtc->irq_alarm);
 		}
 	}
 	if (ret)
-- 
2.39.2

