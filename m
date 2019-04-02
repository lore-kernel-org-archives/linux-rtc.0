Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F13C4360F
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 17:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3542075E
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 17:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDBRcg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:32:36 -0400
Received: from muru.com ([72.249.23.125]:44054 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBRcg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 2 Apr 2019 13:32:36 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A9C8A805F;
        Tue,  2 Apr 2019 17:32:49 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:32:32 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        t-kristo@ti.com, ssantosh@kernel.org, d-gerlach@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 2/5] rtc: interface: Add power_off_program to
 rtc_class_ops
Message-ID: <20190402173232.GP49658@atomide.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-3-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402034253.4928-3-j-keerthy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190402 03:43]:
> Add an interface function to set up the rtc for a power_off
> mode.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/interface.c | 12 ++++++++++++
>  drivers/rtc/rtc-omap.c  |  1 +
>  include/linux/rtc.h     |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index ccb7d6b4da3b..4846ec897067 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1070,3 +1070,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>  	trace_rtc_set_offset(offset, ret);
>  	return ret;
>  }
> +
> +/**
> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> + * line and can be used to power off the SoC.
> + *
> + * Kernel interface to program rtc to power off
> + */
> +int rtc_power_off_program(struct rtc_device *rtc)
> +{
> +	return rtc->ops->power_off_program(rtc->dev.parent);
> +}
> +EXPORT_SYMBOL_GPL(rtc_power_off_program);

This whole series looks OK to me. Not sure about the naming for
rtc_power_off_program(), would rtc_power_off_device() be more
generic?

Regards,

Tony

