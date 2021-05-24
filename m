Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD87DC04FF3
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0F761402
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhEXWh4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 May 2021 18:37:56 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60583 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXWh4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 May 2021 18:37:56 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 15A0FFF803;
        Mon, 24 May 2021 22:36:24 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "Kim, Milo" <Milo.Kim@ti.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel-janitors@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] rtc: fix snprintf() checking in is_rtc_hctosys()
Date:   Tue, 25 May 2021 00:36:24 +0200
Message-Id: <162189577175.211185.2359785793574104400.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YJov/pcGmhLi2pEl@mwanda>
References: <YJov/pcGmhLi2pEl@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 11 May 2021 10:19:26 +0300, Dan Carpenter wrote:
> The scnprintf() function silently truncates the printf() and returns
> the number bytes that it was able to copy (not counting the NUL
> terminator).  Thus, the highest value it can return here is
> "NAME_SIZE - 1" and the overflow check is dead code.  Fix this by
> using the snprintf() function which returns the number of bytes that
> would have been copied if there was enough space and changing the
> condition from "> NAME_SIZE" to ">= NAME_SIZE".

Applied, thanks!

[1/1] rtc: fix snprintf() checking in is_rtc_hctosys()
      commit: 54b909436ede47e0ee07f1765da27ec2efa41e84

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
