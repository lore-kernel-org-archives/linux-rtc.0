Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4233C5519F
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81E423A32
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKNWnS (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Nov 2020 17:43:18 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42909 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKNWnS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Nov 2020 17:43:18 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 758531BF205;
        Sat, 14 Nov 2020 22:43:15 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zheng Liang <zhengliang6@huawei.com>, linus.walleij@linaro.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        fangwei1@huawei.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wangli74@huawei.com
Subject: Re: [PATCH] rtc: pl031: fix resource leak in pl031_probe
Date:   Sat, 14 Nov 2020 23:43:14 +0100
Message-Id: <160539374920.848863.12018987177638877006.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112093139.32566-1-zhengliang6@huawei.com>
References: <20201112093139.32566-1-zhengliang6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 12 Nov 2020 17:31:39 +0800, Zheng Liang wrote:
> When devm_rtc_allocate_device is failed in pl031_probe, it should release
> mem regions with device.

Applied, thanks!

[1/1] rtc: pl031: fix resource leak in pl031_probe
      commit: 1eab0fea2514b269e384c117f5b5772b882761f0

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
