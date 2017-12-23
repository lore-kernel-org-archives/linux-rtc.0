Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:2722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750842AbdLWLI2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 23 Dec 2017 06:08:28 -0500
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <ysxie@foxmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-rtc@vger.kernel.org>
Subject: [PATCH v3 12/27] rtc: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 18:59:39 +0800
Message-ID: <1514026779-33132-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/rtc/rtc-sh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 6c2d398..3e53039 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -592,8 +592,8 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	if (unlikely(!rtc->res))
 		return -EBUSY;
 
-	rtc->regbase = devm_ioremap_nocache(&pdev->dev, rtc->res->start,
-					rtc->regsize);
+	rtc->regbase = devm_ioremap(&pdev->dev, rtc->res->start,
+				    rtc->regsize);
 	if (unlikely(!rtc->regbase))
 		return -EINVAL;
 
-- 
1.8.3.1
