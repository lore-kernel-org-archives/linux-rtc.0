Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88EFC4360F
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 17:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D4120663
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 17:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfDBReH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:34:07 -0400
Received: from muru.com ([72.249.23.125]:44070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBReH (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 2 Apr 2019 13:34:07 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 36402805F;
        Tue,  2 Apr 2019 17:34:21 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:34:03 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        t-kristo@ti.com, ssantosh@kernel.org, d-gerlach@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 4/5] soc: ti: pm33xx: Push the am33xx_push_sram_idle
 to the top
Message-ID: <20190402173403.GQ49658@atomide.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-5-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402034253.4928-5-j-keerthy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190402 03:43]:
> Push the am33xx_push_sram_idle function to the top as a preparation
> for rtc+ddr mode as the function will be called by multiple functions
> currently present before it.

How about say "Move the am33xx_push_sram_idle function to the top..."
instead? And mention no functional changes assuming there aren't
any.

Regards,

Tony
