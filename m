Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284DC433F5
	for <linux-rtc@archiver.kernel.org>; Wed, 19 Jan 2022 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbiASR1i (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:27:38 -0500
Received: from mail.hugovil.com ([162.243.120.170]:48980 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344918AbiASR1i (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 19 Jan 2022 12:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=sIcETtD24jLuSBZYMuc93M+kDOsLooydnj1DFAZelSs=; b=P
        kgVSx/FAefRAxUz171WmFRekoMAUNpVUoQSjuBTQKG8zA1INbtfAOsvZNfj2xT10ezwcriLAJtyNP
        Tr/S0K6Ce5SwUykJL23M3chjujyqYD3ROzTr7OptsnkaDayH7ixJYQjN+NUzb24CkwplEm4xkymaA
        p5IvO4Qz9phFyjAY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54844 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nAEk8-0003vv-Oh; Wed, 19 Jan 2022 12:27:33 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jan 2022 12:27:21 -0500
Message-Id: <20220119172721.1856233-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] rtc: pcf2127: add error message if reading CLKOUT register fails
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If reading CLKOUT register fails, the probe operation will be aborted
without a meaningful error message.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index cea10fdbb010..3d1f57e54372 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -709,8 +709,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "reading CLKOUT register failed\n");
 		return ret;
+	}
 
 	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
 		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
-- 
2.30.2

