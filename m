Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58026 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936121AbdGTXSc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 20 Jul 2017 19:18:32 -0400
In-Reply-To: <20170720231745.GE31807@n2100.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH 1/4] rtc: pl031: constify amba_ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1dYKi9-0001kK-RQ@rmk-PC.armlinux.org.uk>
Date: Fri, 21 Jul 2017 00:18:25 +0100
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The AMBA device IDs should be marked const.  Make that so.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pl031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index e1687e19c59f..0d87b90b1903 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -446,7 +446,7 @@ static struct pl031_vendor_data stv2_pl031 = {
 	.irqflags = IRQF_SHARED | IRQF_COND_SUSPEND,
 };
 
-static struct amba_id pl031_ids[] = {
+static const struct amba_id pl031_ids[] = {
 	{
 		.id = 0x00041031,
 		.mask = 0x000fffff,
-- 
2.7.4
