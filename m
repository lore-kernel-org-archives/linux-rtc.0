Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33384C433FE
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Mar 2022 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiCIQfb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiCIQaG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Mar 2022 11:30:06 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19CC1154;
        Wed,  9 Mar 2022 08:23:23 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4D2A40005;
        Wed,  9 Mar 2022 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjKxC/kEurfp4S2xChG2/x2RBeO/yBKp4HZZXE2h9gg=;
        b=lqMrE7Ln2IQvWzVGzL4Xbzp2A/QaqEjKH6igU0H3FRipUvvYwtK49WGHwOIIJGHwiCSosT
        ZCKZc9cVVVLgXd4+VGvsT2fYUocKU8wL03zCfTinXL8lhct1A0CEJ684oeLwS3AkfiZlMt
        QT8/IJCne2FO/Tmu9mIwziuIX2CxRb9hgBIi73Pg0TuXfaL+D/S48cx6aINAXSyN5kj3o7
        EPNZTfay3XtcJdR2AYcL8p/o4zA+FtaHxjhT0oA9q2KqNqbqkCKWlCdeYeV+Jb3EPJWFEV
        55tWobElvrLCWg/GZyaPmfDYgf7FSGWmA8UvSQCKNx6YW/au0h7ye/5coRHrKQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/29] rtc: opal: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:38 +0100
Message-Id: <20220309162301.61679-7-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index f8f49a969c23..ad41aaf8a17f 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -250,7 +250,7 @@ static int opal_rtc_probe(struct platform_device *pdev)
 	rtc->ops = &opal_rtc_ops;
 	rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
 	rtc->range_max = RTC_TIMESTAMP_END_9999;
-	rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
 	return devm_rtc_register_device(rtc);
 }
-- 
2.35.1

