Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC48C04FF3
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A884B6128B
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhEXWlj (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 May 2021 18:41:39 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54269 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEXWlj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 May 2021 18:41:39 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D6551100004;
        Mon, 24 May 2021 22:40:09 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: efi: Remove the repeated module alias
Date:   Tue, 25 May 2021 00:40:08 +0200
Message-Id: <162189599856.211844.1726016707734132342.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1621848834-20857-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1621848834-20857-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 24 May 2021 17:33:54 +0800, Shaokun Zhang wrote:
> 'MODULE_ALIAS' is declared twice, cleanup one.

Applied, thanks!

[1/1] rtc: efi: Remove the repeated module alias
      commit: 37401019fe32b37c78b50163e4b4ffc2dbce4830

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
