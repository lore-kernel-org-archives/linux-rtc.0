Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB77C83F12
	for <linux-rtc@archiver.kernel.org>; Mon, 28 Aug 2023 09:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjH1J2E (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 28 Aug 2023 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjH1J1p (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2023 05:27:45 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3D19BE;
        Mon, 28 Aug 2023 02:27:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="177908448"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Aug 2023 18:27:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B32CF41BEAB5;
        Mon, 28 Aug 2023 18:27:39 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-rtc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] rtc: m41t80: Simplify probe()
Date:   Mon, 28 Aug 2023 10:27:37 +0100
Message-Id: <20230828092737.30816-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Simplify probe() by replacing device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 * This patch is only compile tested.
---
 drivers/rtc/rtc-m41t80.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 866489ad56d6..04d05d571f9e 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -896,13 +896,7 @@ static int m41t80_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	m41t80_data->client = client;
-	if (client->dev.of_node) {
-		m41t80_data->features = (unsigned long)
-			of_device_get_match_data(&client->dev);
-	} else {
-		const struct i2c_device_id *id = i2c_match_id(m41t80_id, client);
-		m41t80_data->features = id->driver_data;
-	}
+	m41t80_data->features = (unsigned long)i2c_get_match_data(client);
 	i2c_set_clientdata(client, m41t80_data);
 
 	m41t80_data->rtc =  devm_rtc_allocate_device(&client->dev);
-- 
2.25.1

