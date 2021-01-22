Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1070C433DB
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Jan 2021 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D924239D4
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Jan 2021 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbhAVRBr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:01:47 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39182 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbhAVRBf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Jan 2021 12:01:35 -0500
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0006E3B914E
        for <linux-rtc@vger.kernel.org>; Fri, 22 Jan 2021 16:49:12 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 73BD724000E;
        Fri, 22 Jan 2021 16:47:10 +0000 (UTC)
Date:   Fri, 22 Jan 2021 17:47:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] rtc: mrst: Remove driver for deprecated platform
Message-ID: <20210122164710.GH1196852@piout.net>
References: <20210122122226.38334-1-andriy.shevchenko@linux.intel.com>
 <YArxN6KF0R1Q8gMu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YArxN6KF0R1Q8gMu@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 22/01/2021 17:37:27+0200, Andy Shevchenko wrote:
> On Fri, Jan 22, 2021 at 02:22:26PM +0200, Andy Shevchenko wrote:
> > Intel Moorestown and Medfield are quite old Intel Atom based
> > 32-bit platforms, which were in limited use in some Android phones,
> > tablets and consumer electronics more than eight years ago.
> > 
> > There are no bugs or problems ever reported outside from Intel
> > for breaking any of that platforms for years. It seems no real
> > users exists who run more or less fresh kernel on it. The commit
> > 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> > with this theory.
> > 
> > Due to above and to reduce a burden of supporting outdated drivers
> > we remove the support of outdated platforms completely.
> 
> Dear maintainers, the idea is to get ack from you, so we can collect these
> clean up patches in less amount of trees to reduce burden of the merging all
> together w/o build conflicts.
> 

Well, this info should have been in the initial patch ;)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
