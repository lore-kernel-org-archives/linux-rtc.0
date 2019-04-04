Return-Path: <SRS0=xpCi=SG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA51AC4360F
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 14:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04FC2082E
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 14:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfDDOLN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:11:13 -0400
Received: from muru.com ([72.249.23.125]:44338 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDOLN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 4 Apr 2019 10:11:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C710080D4;
        Thu,  4 Apr 2019 14:11:26 +0000 (UTC)
Date:   Thu, 4 Apr 2019 07:11:09 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Keerthy <j-keerthy@ti.com>, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, t-kristo@ti.com, ssantosh@kernel.org,
        d-gerlach@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Message-ID: <20190404141108.GC49658@atomide.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322171619.4180-4-j-keerthy@ti.com>
 <20190401175245.GJ49658@atomide.com>
 <20190401203854.3b6ec1a2@kemnade.info>
 <20190401204033.GK49658@atomide.com>
 <20190404125111.3800e26d@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190404125111.3800e26d@kemnade.info>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190404 10:53]:
> On Mon, 1 Apr 2019 13:40:33 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190401 18:39]:
> > > Could we somehow describe this property of the hardware
> > > (is-offmode-capable or is-wired-for-offmode) as a separate devicetree
> > > property of the soc?
> > > 
> > > In mmc we have for example "cap-power-off-card" for
> > > indicating some is-wired-suitable-for thing.  
> > 
> > And we also have "regulator-off-in-suspend".
> > 
> > How about "soc-off-in-suspend" for the generic name?
> > 
> Well, remember my "omap3: give off mode enable a more prominent place"
> maybe we can use the same  capability property for both proposes.

Yes. I don't think we need a Kconfig option for it though.
Seems just a device specific property should be enough for now.

Regards,

Tony
