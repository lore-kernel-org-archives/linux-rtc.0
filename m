Return-Path: <SRS0=JgwP=RJ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C03C10F0F
	for <linux-rtc@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDDE20661
	for <linux-rtc@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfCFJvn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:51:43 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34403 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbfCFJvm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Mar 2019 04:51:42 -0500
Received: from localhost (alyon-652-1-90-156.w90-42.abo.wanadoo.fr [90.42.94.156])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 328CA20000A;
        Wed,  6 Mar 2019 09:51:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: abx80x: remove useless .remove
Date:   Wed,  6 Mar 2019 10:51:34 +0100
Message-Id: <20190306095134.18550-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306095134.18550-1-alexandre.belloni@bootlin.com>
References: <20190306095134.18550-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

.remove is empty, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-abx80x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 90f25ac78abc..73830670a41f 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -851,11 +851,6 @@ static int abx80x_probe(struct i2c_client *client,
 	return rtc_register_device(priv->rtc);
 }
 
-static int abx80x_remove(struct i2c_client *client)
-{
-	return 0;
-}
-
 static const struct i2c_device_id abx80x_id[] = {
 	{ "abx80x", ABX80X },
 	{ "ab0801", AB0801 },
@@ -876,7 +871,6 @@ static struct i2c_driver abx80x_driver = {
 		.name	= "rtc-abx80x",
 	},
 	.probe		= abx80x_probe,
-	.remove		= abx80x_remove,
 	.id_table	= abx80x_id,
 };
 
-- 
2.20.1

