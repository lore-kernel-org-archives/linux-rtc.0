Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CEC433E0
	for <linux-rtc@archiver.kernel.org>; Mon, 15 Mar 2021 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8881864F4D
	for <linux-rtc@archiver.kernel.org>; Mon, 15 Mar 2021 22:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhCOWFV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:05:21 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35055 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhCOWFN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 15 Mar 2021 18:05:13 -0400
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id CA950100004;
        Mon, 15 Mar 2021 22:05:10 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: imxdi: Convert to a DT-only driver
Date:   Mon, 15 Mar 2021 23:05:10 +0100
Message-Id: <161584590322.569443.11856889005583073703.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315172029.173250-1-festevam@gmail.com>
References: <20210315172029.173250-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 15 Mar 2021 14:20:29 -0300, Fabio Estevam wrote:
> i.MX has been converted to a DT-only platform, so make the driver
> depend on OF, remove the CONFIG_OF ifdefery and remove of_match_ptr().

Applied, thanks!

[1/1] rtc: imxdi: Convert to a DT-only driver
      commit: 198da7be18c47637d69cdab1f65581b04ebd759d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
