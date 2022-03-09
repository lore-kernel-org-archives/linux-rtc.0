Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59FC43217
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Mar 2022 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiCIQfy (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbiCIQa2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Mar 2022 11:30:28 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84771EAC9A;
        Wed,  9 Mar 2022 08:23:52 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB1F51C0002;
        Wed,  9 Mar 2022 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27WZaDQ3bI08b6QzGBBu1+1IXMwX9KV5Ak0D/tJcssI=;
        b=SEchdQ3pdX42IcP9zP/jf+yfL5qZIFfFASXsLCSNm27ZjbkCvRgQMhFrL0skJq8dyWMqWd
        UTd6lyaO6ijb1oqSJN1Im27kM6PqaIlPVdQl8fpFBzJ7ex6h/o1P59dtgP0A1gefEKM7rg
        UhrlB8aSOVyXoONpOn6ZmbtTmdzUnp9NGMoZx9+C9czVpTYUYkaKLhrYP6TCphEjKjEok8
        NbxlICFFlW8BOjnYkrX+LAV0H7cyipjFZoNB+OxmEEYYeUToX0qR2H23ZPuYuvOM+a7Ahe
        MJFrYgJysmmizf+2U3g3v3BWBTxk6ufhcOz9EMdFhi7wQYrxYFfaFog/6gL1UA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/29] rtc: hym8563: let the core handle the alarm resolution
Date:   Wed,  9 Mar 2022 17:22:57 +0100
Message-Id: <20220309162301.61679-26-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-hym8563.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index ce4cbf0f48e7..78f21f623d89 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -220,24 +220,6 @@ static int hym8563_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	u8 buf[4];
 	int ret;
 
-	/*
-	 * The alarm has no seconds so deal with it
-	 */
-	if (alm_tm->tm_sec) {
-		alm_tm->tm_sec = 0;
-		alm_tm->tm_min++;
-		if (alm_tm->tm_min >= 60) {
-			alm_tm->tm_min = 0;
-			alm_tm->tm_hour++;
-			if (alm_tm->tm_hour >= 24) {
-				alm_tm->tm_hour = 0;
-				alm_tm->tm_mday++;
-				if (alm_tm->tm_mday > 31)
-					alm_tm->tm_mday = 0;
-			}
-		}
-	}
-
 	ret = i2c_smbus_read_byte_data(client, HYM8563_CTL2);
 	if (ret < 0)
 		return ret;
@@ -562,6 +544,7 @@ static int hym8563_probe(struct i2c_client *client,
 		(ret & HYM8563_SEC_VL) ? "invalid" : "valid");
 
 	hym8563->rtc->ops = &hym8563_rtc_ops;
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, hym8563->rtc->features);
 	/* the hym8563 alarm only supports a minute accuracy */
 	hym8563->rtc->uie_unsupported = 1;
 
-- 
2.35.1

