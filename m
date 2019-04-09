Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B44C10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC18C208C0
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfDIOUK (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:20:10 -0400
Received: from muru.com ([72.249.23.125]:44986 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDIOUK (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 9 Apr 2019 10:20:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 513988027;
        Tue,  9 Apr 2019 14:20:24 +0000 (UTC)
Date:   Tue, 9 Apr 2019 07:20:06 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        t-kristo@ti.com, ssantosh@kernel.org, d-gerlach@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
Message-ID: <20190409142006.GB2839@atomide.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
 <20190408172654.GL49658@atomide.com>
 <20190408174349.GM49658@atomide.com>
 <643643f2-c855-5cb6-79b5-96a4f9752955@ti.com>
 <accde963-4cb0-2db3-d482-f6ca1a386398@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <accde963-4cb0-2db3-d482-f6ca1a386398@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190409 05:21]:
> 
> 
> On 09/04/19 9:29 AM, Keerthy wrote:
> > 
> > 
> > On 08/04/19 11:13 PM, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [190408 10:26]:
> > > > * Keerthy <j-keerthy@ti.com> [190402 21:57]:
> > > > > Changes in v3:
> > > > > 
> > > > >    * Exported out omap_rtc_poweroff_program function & removed
> > > > >      the patch to add a generic rtc interface as it is specific
> > > > >      to am43 at the moment.
> > > > 
> > > > Thanks I'll be applying this series into omap-for-v5.2/am4-pm
> > > > today.
> > > 
> > > Sorry correction for the branch named above. I noticed a build
> > > warning and folded in the following fix. We need to return
> > > -EINVAL if tm2bcd() fails like we do elsewhere in the driver.
> > > 
> > > So I just pushed out a new branch omap-for-v5.2/am4-pm-v2.
> > > Please just ignore the earlier branch omap-for-v5.2/am4-pm.
> > 
> > Thanks Tony!
> 
> Tony,
> 
> Seems like your for-next is a little behind. Hence you noticed the
> compilation error which i did not notice. The rtc driver patch i formatted
> from your for-next branch does not apply cleanly on linux-next as there are
> more patches already applied by Alexandre on next.
> 
> So the patch you made to return -EINVAL is no longer needed on latest next.

Yeah I noticed there's now a minor conflict with the rtc
tree changes, that's trivial to resolve though.

Regards,

Tony
