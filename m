Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0AFC4338F
	for <linux-rtc@archiver.kernel.org>; Tue, 17 Aug 2021 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528E061042
	for <linux-rtc@archiver.kernel.org>; Tue, 17 Aug 2021 22:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhHQWIx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:08:53 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35909 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhHQWIw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 Aug 2021 18:08:52 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9AE46C0003;
        Tue, 17 Aug 2021 22:08:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Mathew McBride <matt@traverse.com.au>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/2] rtc: Implement support for EPSON RX-8035
Date:   Wed, 18 Aug 2021 00:08:16 +0200
Message-Id: <162923801494.571654.15730416924469451816.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210709044518.28769-1-matt@traverse.com.au>
References: <20210709044518.28769-1-matt@traverse.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 9 Jul 2021 04:45:16 +0000, Mathew McBride wrote:
> The EPSON RX-8035[SA] is a I2C real time clock module with
> built-in oscillator[1]. It is a very close relative of the EPSON
> RX-8025 that is supported by the rtc-rx8025 driver.
> 
> The main difference is that the RX-8035 has inverted the
> 'oscillator stop' bit in the control register. The operation
> of the devices is otherwise identical for the features currently
> supported.
> 
> [...]

Applied, thanks!

[1/2] rtc: rx8025: implement RX-8035 support
      commit: f120e2e33ac8ba1adac4f59eaf1ae1705305158f

I did remove the switch and dev_info in an attempt to cut down on unecessary
strings.

[2/2] dt-bindings: rtc: add Epson RX-8025 and RX-8035
      commit: 8158da6a33f2656c2a98c30eb9185a44e215a6b6

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
