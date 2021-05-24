Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE8DC04FF3
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A4F613D6
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 22:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhEXWfy (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 May 2021 18:35:54 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59809 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXWfw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 May 2021 18:35:52 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 11D1020004;
        Mon, 24 May 2021 22:34:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        ulli.kroll@googlemail.com, a.zummo@towertech.it
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: convert rtc/faraday,ftrtc01 to yaml
Date:   Tue, 25 May 2021 00:34:20 +0200
Message-Id: <162189565261.210747.11197366936508003529.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510182505.3968936-1-clabbe@baylibre.com>
References: <20210510182505.3968936-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 10 May 2021 18:25:05 +0000, Corentin Labbe wrote:
> Converts rtc/faraday,ftrtc01.txt to yaml.
> This permits to detect some missing properties: reg, resets, interrupts

Applied, thanks!

[1/1] dt-bindings: convert rtc/faraday,ftrtc01 to yaml
      commit: 8df65d4adca654180a5c05ecb853c15d1d74e410

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
