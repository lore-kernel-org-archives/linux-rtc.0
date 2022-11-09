Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F0C4332F
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Nov 2022 06:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKIGvl (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 9 Nov 2022 01:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKIGvk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Nov 2022 01:51:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519A18B35;
        Tue,  8 Nov 2022 22:51:37 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6bGR3nbszHvkH;
        Wed,  9 Nov 2022 14:51:11 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 14:51:36 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 14:51:35 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: [PATCH v1 0/2] rtc: fix race condition between uie enable and rtc set time
Date:   Wed, 9 Nov 2022 14:41:45 +0800
Message-ID: <20221109064147.1836133-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Changlog:

rfc -> V1:
1. fix smatch warnings reported by Dan Carpenter and kernel test robot:
	rtc_set_time() warn: inconsistent returns '&rtc->ops_lock'.

Yu Liao (2):
  rtc: add lockless rtc_update_irq_enable
  rtc: fix race condition in rtc_set_time()

 drivers/rtc/interface.c | 43 ++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

-- 
2.25.1

