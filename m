Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F89C433EF
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Nov 2021 23:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1982F611BF
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Nov 2021 23:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhKIXrq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:47:46 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59141 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhKIXro (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Nov 2021 18:47:44 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 18EBEC0009;
        Tue,  9 Nov 2021 23:44:55 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marex@denx.de>, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc-rv8803: fix writing back ctrl in flag register
Date:   Wed, 10 Nov 2021 00:44:55 +0100
Message-Id: <163650146694.105524.3377778790499124826.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
References: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 1 Nov 2021 10:33:59 +0900, Dominique Martinet wrote:
> ctrl is set from read_regs(..FLAG, 2, ctrl), so ctrl[0] is FLAG
> and ctrl[1] is the CTRL register.
> Use ctrl[0] to write back to the FLAG register as appropriate.
> 
> 

Applied, thanks!

[1/2] rtc-rv8803: fix writing back ctrl in flag register
      commit: 03a86cda4123084c7969387e7e0b69f23c2f8acf

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
