Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF272C433DB
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Feb 2021 12:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6200D64F99
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Feb 2021 12:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBCMnp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:43:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12409 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBCMnK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Feb 2021 07:43:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DW1Wh06gwzjHFL;
        Wed,  3 Feb 2021 20:41:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 20:42:17 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/6] spin lock usage optimization for RTC drivers
Date:   Wed, 3 Feb 2021 20:39:35 +0800
Message-ID: <1612355981-6764-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Replace spin_lock_irqsave with spin_lock in hard IRQ of RTC drivers.
There is no function changes, but may speed up if interrupt happen
too often.

Xiaofei Tan (6):
  rtc: cmos: Replace spin_lock_irqsave with spin_lock in hard IRQ
  rtc: pm8xxx: Replace spin_lock_irqsave with spin_lock in hard IRQ
  rtc: r7301: Replace spin_lock_irqsave with spin_lock in hard IRQ
  rtc: tegra: Replace spin_lock_irqsave with spin_lock in hard IRQ
  rtc: mxc: Replace spin_lock_irqsave with spin_lock in hard IRQ
  rtc: mxc_v2: Replace spin_lock_irqsave with spin_lock in hard IRQ

 drivers/rtc/rtc-cmos.c   | 5 ++---
 drivers/rtc/rtc-mxc.c    | 5 ++---
 drivers/rtc/rtc-mxc_v2.c | 7 +++----
 drivers/rtc/rtc-pm8xxx.c | 9 ++++-----
 drivers/rtc/rtc-r7301.c  | 5 ++---
 drivers/rtc/rtc-tegra.c  | 6 +++---
 6 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.8.1

