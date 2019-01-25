Return-Path: <SRS0=r6Xw=QB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E8C282C2
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E324218D0
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfAYOgG (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:36:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54949 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfAYOgF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Jan 2019 09:36:05 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aR-0001ke-IM; Fri, 25 Jan 2019 15:36:03 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aQ-0007BE-4M; Fri, 25 Jan 2019 15:36:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-rtc@vger.kernel.org
Subject: [PATCH 4/5] rtc: ds1307: rx8130: honor Voltage Loss Flag when reading the time
Date:   Fri, 25 Jan 2019 15:35:57 +0100
Message-Id: <20190125143558.27450-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
References: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When voltage dropped since the RTC was last set the reported time is not
reliable. In this case return an error indicator instead of a bogus
time.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-ds1307.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 81e20653700d..974eafda9de4 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -194,6 +194,20 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 	const struct chip_desc *chip = &chips[ds1307->type];
 	u8 regs[7];
 
+	if (ds1307->type == rx_8130) {
+		unsigned int regflag;
+		ret = regmap_read(ds1307->regmap, RX8130_REG_FLAG, &regflag);
+		if (ret) {
+			dev_err(dev, "%s error %d\n", "read", ret);
+			return ret;
+		}
+
+		if (regflag & RX8130_REG_FLAG_VLF) {
+			dev_warn_once(dev, "oscillator failed, set time!\n");
+			return -EINVAL;
+		}
+	}
+
 	/* read the RTC date and time registers all at once */
 	ret = regmap_bulk_read(ds1307->regmap, chip->offset, regs,
 			       sizeof(regs));
@@ -293,6 +307,17 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		dev_err(dev, "%s error %d\n", "write", result);
 		return result;
 	}
+
+	if (ds1307->type == rx_8130) {
+		/* clear Voltage Loss Flag as data is available now */
+		result = regmap_write(ds1307->regmap, RX8130_REG_FLAG,
+				      ~(u8)RX8130_REG_FLAG_VLF);
+		if (result) {
+			dev_err(dev, "%s error %d\n", "write", result);
+			return result;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.20.1

