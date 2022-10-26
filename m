Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51EDFA3740
	for <linux-rtc@archiver.kernel.org>; Wed, 26 Oct 2022 03:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiJZDev (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 25 Oct 2022 23:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiJZDer (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 25 Oct 2022 23:34:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47562B626;
        Tue, 25 Oct 2022 20:34:44 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MxvSZ4MrBz15M1m;
        Wed, 26 Oct 2022 11:29:50 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:34:43 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 11:34:42 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: [RFC PATCH 0/2] rtc: fix race condition between uie enable and rtc set time
Date:   Wed, 26 Oct 2022 11:33:46 +0800
Message-ID: <20221026033348.1660732-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The patch series fixes two issues in rtc_set_time caused by race
conditions:
- rtc_timer_do_work will loop for a while when setting rtc time in the
  future with uie enabled.
- RTC_UIE_OFF does not work when RTC_UIE_OFF and RTC_SET_TIME are
  running in parallel.

Patch #1 extracts lockless version from rtc_update_irq_enable, and
patch #2 addresses the race condition issue.

Yu Liao (2):
  rtc: add lockless rtc_update_irq_enable
  rtc: fix race condition in rtc_set_time()

 drivers/rtc/interface.c | 43 ++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

-- 
2.25.1

