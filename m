Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7706EC6379D
	for <linux-rtc@archiver.kernel.org>; Tue, 17 Nov 2020 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3643924631
	for <linux-rtc@archiver.kernel.org>; Tue, 17 Nov 2020 19:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgKQTck (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:32:40 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42507 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgKQTck (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 Nov 2020 14:32:40 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 33896200009;
        Tue, 17 Nov 2020 19:32:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudius Heine <ch@denx.de>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Johannes Hahn <johannes-hahn@siemens.com>,
        Werner Zeh <werner.zeh@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH v3 0/2] Adding I2C support to RX6110 RTC
Date:   Tue, 17 Nov 2020 20:32:30 +0100
Message-Id: <160564143104.1267360.6956466409291115159.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117121817.953924-1-ch@denx.de>
References: <20201117121817.953924-1-ch@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 17 Nov 2020 13:18:15 +0100, Claudius Heine wrote:
> based on the last feedback round we decided to remove the ACPI patch from this
> patchset for now until we have the correct one. I have also moved the typo fix
> to the front, so it can be applied independently.
> 
> best regards,
> Claudius
> 
> [...]

Applied, thanks!

[1/2] rtc: Kconfig: Fix typo in help message of rx 6110
      commit: 7e6066ca1f1fa5c79915dfb4720ca20c5e62edcc
[2/2] rtc: rx6110: add i2c support
      commit: afa819c2c6bf0d6b99d3e41217a2c7d3b3b53228

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
