Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC15C43217
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Mar 2022 16:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiCIQgH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiCIQaJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Mar 2022 11:30:09 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF8CEA16;
        Wed,  9 Mar 2022 08:23:29 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AE231240005;
        Wed,  9 Mar 2022 16:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAFhyrjp5VycTxXaHMiU9XiKXpAImKksYhJ4bWcA3hQ=;
        b=FAN5Dt83CTz4LwVRzoe/n8NunPj20COLtI6tzXNAwmW0lkeh0karwt+wGPnMuAQDXXvFmw
        oUnHellS+DpbzLcWuhbd7Nrr4fM4QgI9+LqL71/9FUSBBnXsNBSW83J+N/B95B23RTUO6l
        iQ+lLE1pvHrVLo0Q03clULY4YRRTWPkMeU0vkj51IJBnVhg+EHQvdPnlMmympJopxbYqcZ
        UdvKNguOKHrZzqV8J4+g7cfff8GsNeCYdvZqhJg2cS90shJfpMdxGpPokSFdExW2tJ22X+
        HddrAqSgwpDF1/b9iXRGN44bKDgdDBpxGn3JllmxyFKJw8ve7PDykBihKqlZsw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/29] rtc: pcf2127: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:41 +0100
Message-Id: <20220309162301.61679-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Stop using uie_unsupported and clear RTC_FEATURE_UPDATE_INTERRUPT instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index eae9ecbc7fb5..f8469b134411 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -656,7 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
-	pcf2127->rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
 	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 
 	if (alarm_irq > 0) {
-- 
2.35.1

