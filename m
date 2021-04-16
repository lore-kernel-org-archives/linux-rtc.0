Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD002C433ED
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 23:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D3610A1
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Apr 2021 23:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhDPXB4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:01:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42265 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXBz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 16 Apr 2021 19:01:55 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 34DC6E0004;
        Fri, 16 Apr 2021 23:01:29 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: add MODULE_TABLE()
Date:   Sat, 17 Apr 2021 01:01:28 +0200
Message-Id: <161861408333.874639.11397487632178539861.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414084006.17933-1-michael@walle.cc>
References: <20210414084006.17933-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 14 Apr 2021 10:40:06 +0200, Michael Walle wrote:
> The module doesn't load automatically. Fix it by adding the missing
> MODULE_TABLE().

Applied, thanks!

[1/1] rtc: fsl-ftm-alarm: add MODULE_TABLE()
      commit: 199bb382375ad1b2178e250f82f6d95f8d6f7709

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
