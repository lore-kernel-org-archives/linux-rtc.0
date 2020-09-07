Return-Path: <SRS0=uQpp=CQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F21C433E2
	for <linux-rtc@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D42207DE
	for <linux-rtc@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgIGQaI (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgIGO2h (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 7 Sep 2020 10:28:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561DC06179E
        for <linux-rtc@vger.kernel.org>; Mon,  7 Sep 2020 07:27:45 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1kFI7U-0003nx-5F; Mon, 07 Sep 2020 16:27:44 +0200
From:   Bastian Krause <bst@pengutronix.de>
To:     linux-rtc@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        Bastian Krause <bst@pengutronix.de>
Subject: [PATCH 5/8] rtc: ds1307: introduce requires_trickle_resistor per chip
Date:   Mon,  7 Sep 2020 16:27:24 +0200
Message-Id: <20200907142727.26472-6-bst@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907142727.26472-1-bst@pengutronix.de>
References: <20200907142727.26472-1-bst@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Make trickle-resistor-ohms optional for charging setups that do not
require specifying ROUT bits (specifying the resistor value between Vcc
and Vbackup). In order to allow specifying that, introduce
requires_trickle_resistor per chip.

Signed-off-by: Bastian Krause <bst@pengutronix.de>
---
No previous version.
---
 drivers/rtc/rtc-ds1307.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index ff5242d10b21..7983438b677a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -190,6 +190,10 @@ struct chip_desc {
 	u16			trickle_charger_reg;
 	u8			(*do_trickle_setup)(struct ds1307 *, u32,
 						    bool);
+	/* Does the RTC require trickle-resistor-ohms to select the value of
+	 * the resistor between Vcc and Vbackup?
+	 */
+	bool			requires_trickle_resistor;
 };
 
 static const struct chip_desc chips[last_ds_type];
@@ -981,6 +985,7 @@ static const struct chip_desc chips[last_ds_type] = {
 		.bbsqi_bit	= DS1339_BIT_BBSQI,
 		.trickle_charger_reg = 0x10,
 		.do_trickle_setup = &do_trickle_setup_ds1339,
+		.requires_trickle_resistor = true,
 	},
 	[ds_1340] = {
 		.century_reg	= DS1307_REG_HOUR,
@@ -988,6 +993,7 @@ static const struct chip_desc chips[last_ds_type] = {
 		.century_bit	= DS1340_BIT_CENTURY,
 		.do_trickle_setup = &do_trickle_setup_ds1339,
 		.trickle_charger_reg = 0x08,
+		.requires_trickle_resistor = true,
 	},
 	[ds_1341] = {
 		.century_reg	= DS1307_REG_MONTH,
@@ -1302,7 +1308,7 @@ static u8 ds1307_trickle_init(struct ds1307 *ds1307,
 		return 0;
 
 	if (device_property_read_u32(ds1307->dev, "trickle-resistor-ohms",
-				     &ohms))
+				     &ohms) && chip->requires_trickle_resistor)
 		return 0;
 
 	if (device_property_read_bool(ds1307->dev, "trickle-diode-disable"))
-- 
2.28.0

