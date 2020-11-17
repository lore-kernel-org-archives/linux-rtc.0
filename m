Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6585C63798
	for <linux-rtc@archiver.kernel.org>; Tue, 17 Nov 2020 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C10724631
	for <linux-rtc@archiver.kernel.org>; Tue, 17 Nov 2020 19:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgKQTeQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:34:16 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:47157 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQTeP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 Nov 2020 14:34:15 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2CF2B10000D;
        Tue, 17 Nov 2020 19:34:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: mxc: Convert the driver to DT-only
Date:   Tue, 17 Nov 2020 20:34:02 +0100
Message-Id: <160564162911.1268149.16831656983384027051.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201116180326.5199-1-festevam@gmail.com>
References: <20201116180326.5199-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 16 Nov 2020 15:03:26 -0300, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
> by removing the unused non-DT support.

Applied, thanks!

[1/1] rtc: mxc: Convert the driver to DT-only
      commit: 42882a8a22a86513c8c8c6bc7e0822bb14791999

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
