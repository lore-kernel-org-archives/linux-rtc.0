Return-Path: <SRS0=NKr3=SK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932B0C10F13
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 17:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D41E20879
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDHRny (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:43:54 -0400
Received: from muru.com ([72.249.23.125]:44832 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfDHRny (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 8 Apr 2019 13:43:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 24DFB80AA;
        Mon,  8 Apr 2019 17:44:08 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:43:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        t-kristo@ti.com, ssantosh@kernel.org, d-gerlach@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
Message-ID: <20190408174349.GM49658@atomide.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
 <20190408172654.GL49658@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408172654.GL49658@atomide.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190408 10:26]:
> * Keerthy <j-keerthy@ti.com> [190402 21:57]:
> > Changes in v3:
> > 
> >   * Exported out omap_rtc_poweroff_program function & removed
> >     the patch to add a generic rtc interface as it is specific
> >     to am43 at the moment.
> 
> Thanks I'll be applying this series into omap-for-v5.2/am4-pm
> today.

Sorry correction for the branch named above. I noticed a build
warning and folded in the following fix. We need to return
-EINVAL if tm2bcd() fails like we do elsewhere in the driver.

So I just pushed out a new branch omap-for-v5.2/am4-pm-v2.
Please just ignore the earlier branch omap-for-v5.2/am4-pm.

Regards,

Tony

8< --------------------
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -447,7 +447,7 @@ int omap_rtc_power_off_program(struct device *dev)
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
 		rtc->type->lock(rtc);
-		return;
+		return -EINVAL;
 	}
 
 	rtc_wait_not_busy(rtc);
