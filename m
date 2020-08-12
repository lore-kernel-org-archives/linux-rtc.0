Return-Path: <SRS0=Sgz1=BW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1261C433DF
	for <linux-rtc@archiver.kernel.org>; Wed, 12 Aug 2020 09:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E7206DA
	for <linux-rtc@archiver.kernel.org>; Wed, 12 Aug 2020 09:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLJsu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:48:50 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52211 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgHLJss (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Aug 2020 05:48:48 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 72E6EC0010;
        Wed, 12 Aug 2020 09:48:46 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     bruno.thomsen@gmail.com, a.zummo@towertech.it,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rtc: pcf2127: add alarm support
Date:   Wed, 12 Aug 2020 11:48:44 +0200
Message-Id: <159722570960.480982.6086499553279402600.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630024211.12782-1-liambeguin@gmail.com>
References: <20200630024211.12782-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 29 Jun 2020 22:42:09 -0400, Liam Beguin wrote:
> The board used to test this series has the interrupt line of the RTC
> connected to a circuit controlling the power of the board.
> An event on the interrupt line while the board is off will power it on.
> Because of these hardware limitations, the irq handler added in this
> patch wasn't fully tested.
> 
> The alarm fuctionality was tested on a PCA2129, with:
> 
> [...]

Applied, thanks!

[1/2] rtc: pcf2127: add pca2129 device id
      commit: 985b30dbe2cf58c27dd81da85410439ced8ce6d7
[2/2] rtc: pcf2127: add alarm support
      commit: 8a914bac44be33623cfcf27688b18b6f81a5c7d5

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
