Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:44476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbeHMOZM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 13 Aug 2018 10:25:12 -0400
From: zhong jiang <zhongjiang@huawei.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <baruch@tkos.co.il>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] rtc: Use PTR_ERR_OR_ZERO to replace the open code
Date: Mon, 13 Aug 2018 19:31:23 +0800
Message-ID: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The issue is detected with the help of Coccinelle.

zhong jiang (2):
  rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace the open code
  rtc:rtc-ds1347: Use PTR_ERR_OR_ZERO to replace the open code

 drivers/rtc/rtc-digicolor.c | 4 +---
 drivers/rtc/rtc-ds1347.c    | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

-- 
1.7.12.4
