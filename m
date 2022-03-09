Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7FC433F5
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Mar 2022 16:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiCIQfn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiCIQaM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4522DBD1A;
        Wed,  9 Mar 2022 08:23:35 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D0945E000A;
        Wed,  9 Mar 2022 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PhtHtkZZK9HVygDdN0GO9ORgJzMGpc/jqGFpWnt+qY=;
        b=Sf/JZRCNGnB/mfrS8gcLIpXPU5kpdNmN86Dw5+3Lt8CxCP2QsrQhaHFXVTfjUN4QOUOrqN
        Dg/fdxER+W9SL9f1cmhugp1MIcXrhPuh/w4plaaZr11unaGTCszSTU4UXpVNN0VNPW7dHR
        GQwQRGk1PgklhJx4yUwRmqModUqzTaPpEWjFgUZTWB3zapCLq1Xw9BXu3x6UJEhUd3Gb7l
        GpzgUvyIzNun1/Gonmj7RwppQcrlOAQqyPz8FD11JMSu2xIxrOq4yvEVegP2IRxYColyMH
        GHySL4m9EoPJk5Iy+/fKchN91tSTGObJUtyph859oo9SQRq5pjKtZxwsciQTHQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/29] rtc: pcf8523: let the core handle the alarm resolution
Date:   Wed,  9 Mar 2022 17:22:46 +0100
Message-Id: <20220309162301.61679-15-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Set RTC_FEATURE_ALARM_RES_MINUTE, so the core knows alarms have a
resolution of a minute. Also, the core will properly round down the alarm
instead of up.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index cd55fdfe1d39..b1b1943de844 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -212,14 +212,6 @@ static int pcf8523_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
 	if (err < 0)
 		return err;
 
-	/* The alarm has no seconds, round up to nearest minute */
-	if (tm->time.tm_sec) {
-		time64_t alarm_time = rtc_tm_to_time64(&tm->time);
-
-		alarm_time += 60 - tm->time.tm_sec;
-		rtc_time64_to_tm(alarm_time, &tm->time);
-	}
-
 	regs[0] = bin2bcd(tm->time.tm_min);
 	regs[1] = bin2bcd(tm->time.tm_hour);
 	regs[2] = bin2bcd(tm->time.tm_mday);
@@ -450,6 +442,7 @@ static int pcf8523_probe(struct i2c_client *client,
 	rtc->ops = &pcf8523_rtc_ops;
 	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
 	if (client->irq > 0) {
-- 
2.35.1

