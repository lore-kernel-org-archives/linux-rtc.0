Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:57462 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbeEPKFi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 May 2018 06:05:38 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id D841AB00BA8
        for <linux-rtc@vger.kernel.org>; Wed, 16 May 2018 12:05:34 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vmaOrFoGO9al for <linux-rtc@vger.kernel.org>;
        Wed, 16 May 2018 12:05:33 +0200 (CEST)
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v4 1/4] rtc: ds1307: fix data pointer to m41t0
Date: Wed, 16 May 2018 12:05:23 +0200
Message-Id: <20180516100526.73549-1-giulio.benetti@micronovasrl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

data field points to m41t00, instead it should point to m41t0.
Driver works correctly because on both cases(m41t0 and m41t00) chip_desc
are equal.

Point to right enum m41t0 instead of m41t00.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a13e59edff53..32aadcbc377f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -298,7 +298,7 @@ static const struct of_device_id ds1307_of_match[] = {
 	},
 	{
 		.compatible = "st,m41t0",
-		.data = (void *)m41t00
+		.data = (void *)m41t0
 	},
 	{
 		.compatible = "st,m41t00",
-- 
2.17.0
