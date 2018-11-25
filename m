Return-Path: <SRS0=vYbA=OE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D61DC43441
	for <linux-rtc@archiver.kernel.org>; Sun, 25 Nov 2018 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445712084E
	for <linux-rtc@archiver.kernel.org>; Sun, 25 Nov 2018 14:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445712084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeKZBBx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 25 Nov 2018 20:01:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59782 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeKZBBw (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 25 Nov 2018 20:01:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C3B7920D72; Sun, 25 Nov 2018 15:10:41 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 99E0120714;
        Sun, 25 Nov 2018 15:10:41 +0100 (CET)
Date:   Sun, 25 Nov 2018 15:10:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Craig McQueen <craig.mcqueen@innerrange.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: rtc-pcf85063 driver bug in pcf85063_stop_clock()
Message-ID: <20181125141041.GC19871@piout.net>
References: <7f8c164eb0fd47788ec6bbd34735f4a5@innerrange.com>
 <4b6b1f5f601f459cb992c37c371ade50@innerrange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6b1f5f601f459cb992c37c371ade50@innerrange.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

On 19/11/2018 22:56:07+0000, Craig McQueen wrote:
> I wrote:
> > 
> > The function pcf85063_stop_clock() is intended to provide the value of the
> > Control_1 register via the pointer ctrl1.
> > 
> > However, it's really providing the return value of the last
> > i2c_smbus_write_byte_data() call, i.e., zero. So the register value needs to
> > be saved in a separate local variable other than ret. Or, the line *ctrl1 = ret;
> > needs to be moved up to be above the last i2c_smbus_write_byte_data()
> > call.
> 
> I'd like to follow up on this. I could perhaps submit a patch, but I'm not sure what is the best fix for this bug. Any recommendations?
> 

I replied a while ago, isn't that fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-pcf85063.c?id=ec9cf1b7a6af2c0cffaa887351e7c7acced5290e


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
