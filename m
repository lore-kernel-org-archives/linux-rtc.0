Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7729EC10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DA220883
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDIJBW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:01:22 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59329 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJBW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 05:01:22 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E858D1BF206;
        Tue,  9 Apr 2019 09:01:19 +0000 (UTC)
Date:   Tue, 9 Apr 2019 11:01:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mastro Gippo <gipmad@gmail.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: Infinite loop on edge cases
Message-ID: <20190409090119.GT7480@piout.net>
References: <CADjOgT97-8PM1=Nm+Mk4jw_8vzt3i9KXUohDAkUsptxS7JuU6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADjOgT97-8PM1=Nm+Mk4jw_8vzt3i9KXUohDAkUsptxS7JuU6Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 09/04/2019 10:44:27+0200, Mastro Gippo wrote:
> Hello, I have been testing the latest RTC drivers on an OpenWrt build on a
> MTK7688 SOC and I got an infinite loop on boot that would block the entire
> system.

You should not use hctosys that would solve you boot issue.

> Basically, if I don't have a RTC connected, any read would return 0xFF.
> That may be also be a problem of the I2C driver, that instead of generating
> an error just returns that value. But this may happen in other cases, like
> if we add an EEPROM or another IC with the same address as the RTC, or the
> RTC IC fails in some unpredictable way.
> The current implementation of that piece of code has some bad practices
> that lead to infinite loops due to this error.

You have to fix the i2c bus driver because this one has to return an
error so regmap can handle it properly.

Regarding other cases, like adding an EEPROM or another IC with the same
address as the RTC. Then the answer is to fix your device tree. If it
doesn't properly describe your hardware, then you shouldn't expect Linux
to run properly.

But again, this infinite loop doesn't have to be fatal anyway, as long
as you are not using hctosys.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
