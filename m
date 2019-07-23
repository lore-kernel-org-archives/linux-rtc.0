Return-Path: <SRS0=SC1n=VU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC3C76186
	for <linux-rtc@archiver.kernel.org>; Tue, 23 Jul 2019 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6135E216C8
	for <linux-rtc@archiver.kernel.org>; Tue, 23 Jul 2019 18:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfGWSkW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:40:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42195 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfGWSkV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Jul 2019 14:40:21 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AFA3960003;
        Tue, 23 Jul 2019 18:40:19 +0000 (UTC)
Date:   Tue, 23 Jul 2019 20:40:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-rtc@vger.kernel.org, a.zummo@towertech.it, bth@kamstrup.com,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 0/4] rtc: pcf2127: tamper timestamp and watchdog feature
 support
Message-ID: <20190723184019.GK24911@piout.net>
References: <20190722155811.11980-1-bruno.thomsen@gmail.com>
 <CAH+2xPB7y703-WeiNBRoDXfWPKTRMzD=a5P+EYohYmV46BS2ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+2xPB7y703-WeiNBRoDXfWPKTRMzD=a5P+EYohYmV46BS2ZA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 23/07/2019 16:13:12+0200, Bruno Thomsen wrote:
> Hi all
> 
> > Patches has been tested on a pcf2127 chip using 2MHz SPI
> > interface both as built-in and module including with and
> > without watchdog feature.
> 
> I did some more testing as I could not understand this bugfix:
> 
> 3769a375ab83 rtc: pcf2127: bulk read only date and time registers.
> 
> This fix seems to be incomplete as root cause is not auto-increment
> read aka bulk read, but reading control register 2 triggers zero value
> in WD_VAL resulting in stopped watchdog until systemd kick the dog
> again :)
> 
> As the watchdog has 2 control registers I will do some more testing
> to see if this also apply to the other register. But more importantly
> this issue also affect timestamp0_{store,show} functions in tamper
> detection support, and I will therefor send a v2 of the patch series.
> 

Please Cc the watchdog maintainer on v2.

> /Bruno

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
