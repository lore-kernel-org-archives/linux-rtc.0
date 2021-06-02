Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1062C47093
	for <linux-rtc@archiver.kernel.org>; Wed,  2 Jun 2021 07:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A576613AD
	for <linux-rtc@archiver.kernel.org>; Wed,  2 Jun 2021 07:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhFBHlA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:41:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3381 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhFBHko (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Jun 2021 03:40:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fw15G0BfQz66Tn;
        Wed,  2 Jun 2021 15:34:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 15:38:42 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 15:38:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc <linux-rtc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/8] rtc: rs5c372: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 15:38:15 +0800
Message-ID: <20210602073820.11011-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210602073820.11011-1-thunder.leizhen@huawei.com>
References: <20210602073820.11011-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/rtc/rtc-rs5c372.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 80980414890c703..eae0fbad64c109e 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -496,8 +496,8 @@ static const struct rtc_class_ops rs5c372_rtc_ops = {
 
 #if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
 
-static ssize_t rs5c372_sysfs_show_trim(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t trim_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	int err, trim;
 
@@ -507,10 +507,10 @@ static ssize_t rs5c372_sysfs_show_trim(struct device *dev,
 
 	return sprintf(buf, "%d\n", trim);
 }
-static DEVICE_ATTR(trim, S_IRUGO, rs5c372_sysfs_show_trim, NULL);
+static DEVICE_ATTR_RO(trim);
 
-static ssize_t rs5c372_sysfs_show_osc(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t osc_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
 	int err, osc;
 
@@ -520,7 +520,7 @@ static ssize_t rs5c372_sysfs_show_osc(struct device *dev,
 
 	return sprintf(buf, "%d.%03d KHz\n", osc / 1000, osc % 1000);
 }
-static DEVICE_ATTR(osc, S_IRUGO, rs5c372_sysfs_show_osc, NULL);
+static DEVICE_ATTR_RO(osc);
 
 static int rs5c_sysfs_register(struct device *dev)
 {
-- 
2.26.0.106.g9fadedd


