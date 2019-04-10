Return-Path: <SRS0=qdFt=SM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E3C10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 21:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E920818
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDJVF7 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:05:59 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42883 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDJVF7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 10 Apr 2019 17:05:59 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 007E24000B;
        Wed, 10 Apr 2019 21:05:57 +0000 (UTC)
Date:   Wed, 10 Apr 2019 23:05:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Brandon Martin <martinbv@mothictech.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH 5/5] rtc: pcf85363: convert to SPDX identifier
Message-ID: <20190410210557.GH3578@piout.net>
References: <20190410205604.25262-1-alexandre.belloni@bootlin.com>
 <20190410205604.25262-5-alexandre.belloni@bootlin.com>
 <8e70712a-c3d5-6101-f33c-8452559038f7@mothictech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e70712a-c3d5-6101-f33c-8452559038f7@mothictech.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 10/04/2019 17:01:42-0400, Brandon Martin wrote:
> On 4/10/19 4:56 PM, Alexandre Belloni wrote:
> > Use SPDX-License-Identifier instead of a verbose license text.
> > 
> > The original text refers to version 2 so also update MODULE_LICENSE() to
> > "GPL v2" instead of "GPL".
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >   drivers/rtc/rtc-pcf85363.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> > index afb1baacdaa7..a075e77617dc 100644
> > --- a/drivers/rtc/rtc-pcf85363.c
> > +++ b/drivers/rtc/rtc-pcf85363.c
> > @@ -1,15 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   /*
> >    * drivers/rtc/rtc-pcf85363.c
> >    *
> >    * Driver for NXP PCF85363 real-time clock.
> >    *
> >    * Copyright (C) 2017 Eric Nelson
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> > - * Based loosely on rtc-8583 by Russell King, Wolfram Sang and Juergen Beisert
> >    */
> >   #include <linux/module.h>
> >   #include <linux/i2c.h>
> > 
> 
> Looks like you did not update MODULE_LICENSE as stated in the comment?

Right, I'll remove that from the commit message.

Thanks!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
