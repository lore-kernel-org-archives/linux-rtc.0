Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6946C04FF3
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAAC61400
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhEXWff (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 May 2021 18:35:35 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54377 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXWfd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 May 2021 18:35:33 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C53B720006;
        Mon, 24 May 2021 22:34:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bixuan Cui <cuibixuan@huawei.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel-janitors@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH -next] rtc: mxc_v2: add missing MODULE_DEVICE_TABLE
Date:   Tue, 25 May 2021 00:34:01 +0200
Message-Id: <162189559732.210396.9793424249844915243.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210508031509.53735-1-cuibixuan@huawei.com>
References: <20210508031509.53735-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sat, 8 May 2021 11:15:09 +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied, thanks!

[1/1] rtc: mxc_v2: add missing MODULE_DEVICE_TABLE
      commit: 206e04ec7539e7bfdde9aa79a7cde656c9eb308e

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
