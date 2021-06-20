Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6214C48BDF
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 21:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B834060FE6
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 21:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFTVvk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 20 Jun 2021 17:51:40 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40659 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTVvj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 Jun 2021 17:51:39 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D97EB240005;
        Sun, 20 Jun 2021 21:49:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: pcf2127: Fix the datasheet URL
Date:   Sun, 20 Jun 2021 23:49:25 +0200
Message-Id: <162422575669.1105012.119946293904077755.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603143447.2223353-1-festevam@gmail.com>
References: <20210603143447.2223353-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 3 Jun 2021 11:34:45 -0300, Fabio Estevam wrote:
> The current datasheet URL is no longer valid.
> 
> Replace with a valid one.

Applied, thanks!

[1/3] rtc: pcf2127: Fix the datasheet URL
      commit: 836e9ea3ccc263d17fdeb90f28089ff1d945500d
[2/3] rtc: pcf85063: Fix the datasheet URL
      commit: 663bff1753a88195328fa7dc97cb96c9916343ed
[3/3] rtc: pcf8563: Fix the datasheet URL
      commit: 94af1e732abe6e83fb146fc89d6f520e6a939c6a

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
