Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EE4C433E0
	for <linux-rtc@archiver.kernel.org>; Sat, 23 Jan 2021 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C645422B48
	for <linux-rtc@archiver.kernel.org>; Sat, 23 Jan 2021 13:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAWN62 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:58:28 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53229 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWN62 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 23 Jan 2021 08:58:28 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A1BAFC0004;
        Sat, 23 Jan 2021 13:57:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 0/3] rtc: remove obsolete drivers
Date:   Sat, 23 Jan 2021 14:57:44 +0100
Message-Id: <161141025561.1573837.15965671549699329228.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120154158.1860736-1-arnd@kernel.org>
References: <20210120154158.1860736-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 20 Jan 2021 16:41:55 +0100, Arnd Bergmann wrote:
> A few Arm platforms are getting removed in v5.12, this removes
> the corresponding rtc drivers.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/
> 
> 
> Arnd Bergmann (3):
>   rtc: remove sirfsoc driver
>   rtc: remove ste coh901 driver
>   rtc: remove ste ab3100 driver
> 
> [...]

Applied, thanks!

[1/3] rtc: remove sirfsoc driver
      commit: 9d0735519f99948c5b5c22426b682ced7f7af9be
[2/3] rtc: remove ste coh901 driver
      commit: dd2d3b40039d0278f25a21aa3e50955a01a92a62
[3/3] rtc: remove ste ab3100 driver
      commit: 2f58f5eea8c60052100ff325688f2d987bde572b

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
