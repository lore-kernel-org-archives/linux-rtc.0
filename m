Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C086C2B9F7
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3961400
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhEXWpI (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 May 2021 18:45:08 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55493 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXWpI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 May 2021 18:45:08 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 38D37100003;
        Mon, 24 May 2021 22:43:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3] rtc: imxdi: add wakeup support
Date:   Tue, 25 May 2021 00:43:37 +0200
Message-Id: <162189608584.212202.5550918981493959437.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511161244.16111-1-martin@kaiser.cx>
References: <20210430093210.7034-1-martin@kaiser.cx> <20210511161244.16111-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 11 May 2021 18:12:44 +0200, Martin Kaiser wrote:
> The DryIce-based RTC supports alarms that trigger an interrupt.
> 
> Configure this interrupt as a wakeup source that wakes the system up
> from standby mode.

Applied, thanks!

[1/1] rtc: imxdi: add wakeup support
      commit: bcae59d0d45b866d5b9525ea8ece6d671e6767c8

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
