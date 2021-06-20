Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C2CC49361
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A380360720
	for <linux-rtc@archiver.kernel.org>; Sun, 20 Jun 2021 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFTUhz (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:37:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42365 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhFTUhx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 Jun 2021 16:37:53 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0A739240005;
        Sun, 20 Jun 2021 20:35:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: ti,bq32k: Convert to json-schema
Date:   Sun, 20 Jun 2021 22:35:37 +0200
Message-Id: <162422133368.1091383.6886477741733498842.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <42d9c71b4ee1f120e0cdcf6b266547d29d1fb9a4.1623851377.git.geert+renesas@glider.be>
References: <42d9c71b4ee1f120e0cdcf6b266547d29d1fb9a4.1623851377.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 16 Jun 2021 15:51:43 +0200, Geert Uytterhoeven wrote:
> Convert the TI BQ32000 I2C Serial Real-Time Clock Device Tree binding
> documentation to json-schema.
> 
> Document missing properties.

Applied, thanks!

[1/1] dt-bindings: rtc: ti,bq32k: Convert to json-schema
      commit: 4a7e7408688de048bffa5e0e00d246b5f854bcf7

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
