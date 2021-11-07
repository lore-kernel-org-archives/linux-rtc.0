Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB915C433F5
	for <linux-rtc@archiver.kernel.org>; Sun,  7 Nov 2021 22:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89108613A6
	for <linux-rtc@archiver.kernel.org>; Sun,  7 Nov 2021 22:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKGW4j (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 7 Nov 2021 17:56:39 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:40335 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhKGW4i (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 7 Nov 2021 17:56:38 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D2796240003;
        Sun,  7 Nov 2021 22:53:53 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] rtc: pcf85063: silence cppcheck warning
Date:   Sun,  7 Nov 2021 23:53:48 +0100
Message-Id: <20211107225349.110707-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

cppcheck warnings: (new ones prefixed by >>)

>> drivers/rtc/rtc-pcf85063.c:292:40: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     status = status & PCF85063_REG_SC_OS ? RTC_VL_DATA_INVALID : 0;

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 4a70d6bae859..15e50bb10cf0 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -299,7 +299,7 @@ static int pcf85063_ioctl(struct device *dev, unsigned int cmd,
 		if (ret < 0)
 			return ret;
 
-		status = status & PCF85063_REG_SC_OS ? RTC_VL_DATA_INVALID : 0;
+		status = (status & PCF85063_REG_SC_OS) ? RTC_VL_DATA_INVALID : 0;
 
 		return put_user(status, (unsigned int __user *)arg);
 
-- 
2.31.1

