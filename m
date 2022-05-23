Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3812C433F5
	for <linux-rtc@archiver.kernel.org>; Mon, 23 May 2022 14:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiEWOyS (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 23 May 2022 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEWOyQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 23 May 2022 10:54:16 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFA3424AF;
        Mon, 23 May 2022 07:54:15 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 96B5A200002;
        Mon, 23 May 2022 14:54:10 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] rtc: isl1208: do not advertise update interrupt feature if no interrupt specified
Date:   Mon, 23 May 2022 16:53:20 +0200
Message-Id: <20220523145320.123713-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

If an ISL1208 device does not have an interrupt line routed, the feature
shouldn't be advertised (it is by default in rtc core) or it'll confuse
userspace requesting that feature (such as hwclock from util-linux).

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/rtc/rtc-isl1208.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 182dfa6055155..f448a525333e1 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -880,10 +880,14 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rc)
 		return rc;
 
-	if (client->irq > 0)
+	if (client->irq > 0) {
 		rc = isl1208_setup_irq(client, client->irq);
-	if (rc)
-		return rc;
+		if (rc)
+			return rc;
+
+	} else {
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, isl1208->rtc->features);
+	}
 
 	if (evdet_irq > 0 && evdet_irq != client->irq)
 		rc = isl1208_setup_irq(client, evdet_irq);
-- 
2.36.1

