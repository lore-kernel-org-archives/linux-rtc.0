Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967DC5519F
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B73C2245F
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKNWbq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Nov 2020 17:31:46 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37403 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKNWbq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Nov 2020 17:31:46 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3EF4B240003;
        Sat, 14 Nov 2020 22:31:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it,
        "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kaixu Xia <kaixuxia@tencent.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: da9063: Simplify bool comparison
Date:   Sat, 14 Nov 2020 23:31:43 +0100
Message-Id: <160539309317.847457.7971248340408878350.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1604649637-1014-1-git-send-email-kaixuxia@tencent.com>
References: <1604649637-1014-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 6 Nov 2020 16:00:37 +0800, xiakaixu1987@gmail.com wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/rtc/rtc-da9063.c:246:5-18: WARNING: Comparison to bool

Applied, thanks!

[1/1] rtc: da9063: Simplify bool comparison
      commit: a48c6224ae07bed02893c58073ca2942acb5c3d5

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
