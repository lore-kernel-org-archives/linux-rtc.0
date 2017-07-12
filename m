Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34583 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756689AbdGLFuG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:50:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so3202360wrc.1
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:50:06 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/9] rtc: ds1307: constify struct chip_desc variables
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Message-ID: <49e8545e-e1a1-3465-5640-822a4658ed11@gmail.com>
Date: Wed, 12 Jul 2017 07:49:33 +0200
MIME-Version: 1.0
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Constify struct chip_desc variables.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d7158c9d..115fe1c5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -147,7 +147,7 @@ struct chip_desc {
 
 static u8 do_trickle_setup_ds1339(struct ds1307 *, uint32_t ohms, bool diode);
 
-static struct chip_desc chips[last_ds_type] = {
+static const struct chip_desc chips[last_ds_type] = {
 	[ds_1307] = {
 		.nvram_offset	= 8,
 		.nvram_size	= 56,
@@ -941,7 +941,7 @@ static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
 }
 
 static u8 ds1307_trickle_init(struct ds1307 *ds1307,
-			      struct chip_desc *chip)
+			      const struct chip_desc *chip)
 {
 	uint32_t ohms;
 	bool diode = true;
@@ -1311,7 +1311,7 @@ static int ds1307_probe(struct i2c_client *client,
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
 	int			tmp, wday;
-	struct chip_desc	*chip;
+	const struct chip_desc	*chip;
 	bool			want_irq = false;
 	bool			ds1307_can_wakeup_device = false;
 	unsigned char		*buf;
-- 
2.13.2
