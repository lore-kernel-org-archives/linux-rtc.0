Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA7C4360F
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B56820674
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfDBVHq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:07:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40517 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVHq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Apr 2019 17:07:46 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 354E820006;
        Tue,  2 Apr 2019 21:07:42 +0000 (UTC)
Date:   Tue, 2 Apr 2019 23:07:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, t-kristo@ti.com,
        ssantosh@kernel.org, d-gerlach@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 2/5] rtc: interface: Add power_off_program to
 rtc_class_ops
Message-ID: <20190402210742.GH22216@piout.net>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-3-j-keerthy@ti.com>
 <20190402173232.GP49658@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402173232.GP49658@atomide.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 02/04/2019 10:32:32-0700, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [190402 03:43]:
> > Add an interface function to set up the rtc for a power_off
> > mode.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  drivers/rtc/interface.c | 12 ++++++++++++
> >  drivers/rtc/rtc-omap.c  |  1 +
> >  include/linux/rtc.h     |  2 ++
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> > index ccb7d6b4da3b..4846ec897067 100644
> > --- a/drivers/rtc/interface.c
> > +++ b/drivers/rtc/interface.c
> > @@ -1070,3 +1070,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
> >  	trace_rtc_set_offset(offset, ret);
> >  	return ret;
> >  }
> > +
> > +/**
> > + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> > + * line and can be used to power off the SoC.
> > + *
> > + * Kernel interface to program rtc to power off
> > + */
> > +int rtc_power_off_program(struct rtc_device *rtc)
> > +{
> > +	return rtc->ops->power_off_program(rtc->dev.parent);
> > +}
> > +EXPORT_SYMBOL_GPL(rtc_power_off_program);
> 
> This whole series looks OK to me. Not sure about the naming for
> rtc_power_off_program(), would rtc_power_off_device() be more
> generic?
> 

Well, even if this is more generic, this feels way too ad-hoc to me.
The series is adding a function and a callback to the core for, from
what I understand, only one particular board.

You may as well simply export the function directly from the rtc-omap
driver as anyway, this is added as a dependency in the last patch.

Something else I would be open to but I'm not completely sure this fits
your use case is a new interface that would take an alarm index as a
parameter to allow setting any alarm on the RTC. This would at least be
usable for multiple other drivers.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
