Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53961 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbdIDUqN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Sep 2017 16:46:13 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 3/7] rtc: ds1307: use u32
Date: Mon,  4 Sep 2017 22:46:04 +0200
Message-Id: <20170904204608.7090-3-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
References: <20170904204608.7090-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

u32 should be used instead of uint32_t

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 93fb08452159..328183e0e121 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -142,13 +142,13 @@ struct chip_desc {
 	irq_handler_t		irq_handler;
 	const struct rtc_class_ops *rtc_ops;
 	u16			trickle_charger_reg;
-	u8			(*do_trickle_setup)(struct ds1307 *, uint32_t,
+	u8			(*do_trickle_setup)(struct ds1307 *, u32,
 						    bool);
 };
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t);
 static int ds1307_set_time(struct device *dev, struct rtc_time *t);
-static u8 do_trickle_setup_ds1339(struct ds1307 *, uint32_t ohms, bool diode);
+static u8 do_trickle_setup_ds1339(struct ds1307 *, u32 ohms, bool diode);
 static irqreturn_t rx8130_irq(int irq, void *dev_id);
 static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
 static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t);
@@ -963,7 +963,7 @@ static int ds1307_nvram_write(void *priv, unsigned int offset, void *val,
 /*----------------------------------------------------------------------*/
 
 static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
-				  uint32_t ohms, bool diode)
+				  u32 ohms, bool diode)
 {
 	u8 setup = (diode) ? DS1307_TRICKLE_CHARGER_DIODE :
 		DS1307_TRICKLE_CHARGER_NO_DIODE;
@@ -989,7 +989,7 @@ static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
 static u8 ds1307_trickle_init(struct ds1307 *ds1307,
 			      const struct chip_desc *chip)
 {
-	uint32_t ohms;
+	u32 ohms;
 	bool diode = true;
 
 	if (!chip->do_trickle_setup)
-- 
2.14.1
