Return-Path: <SRS0=JmaL=7S=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B5FC433DF
	for <linux-rtc@archiver.kernel.org>; Fri,  5 Jun 2020 22:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC622065C
	for <linux-rtc@archiver.kernel.org>; Fri,  5 Jun 2020 22:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFEWTR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:19:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56371 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgFEWTR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 5 Jun 2020 18:19:17 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A685720003;
        Fri,  5 Jun 2020 22:19:15 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, "Kevin P. Fleming" <kevin+linux@km6g.us>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v2] rtc: abx80x: Provide debug feedback for invalid dt properties
Date:   Sat,  6 Jun 2020 00:19:11 +0200
Message-Id: <159139542922.1280481.7812332701432935431.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530122956.360689-1-kevin+linux@km6g.us>
References: <20200530122956.360689-1-kevin+linux@km6g.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sat, 30 May 2020 08:29:56 -0400, Kevin P. Fleming wrote:
> When the user provides an invalid value for tc-diode or
> tc-resistor generate a debug message instead of silently
> ignoring it.

Applied, thanks!

[1/1] rtc: abx80x: Provide debug feedback for invalid dt properties
      commit: 6e429f6b8c6b8f40874c50c1e8485783dd0f97a8

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
