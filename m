Return-Path: <SRS0=Ax4F=PS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59801C43387
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Jan 2019 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2F2177B
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Jan 2019 21:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfAJVPU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:15:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33675 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfAJVPU (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 10 Jan 2019 16:15:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F2F74206DC; Thu, 10 Jan 2019 22:15:18 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id C6D51207B6;
        Thu, 10 Jan 2019 22:15:08 +0100 (CET)
Date:   Thu, 10 Jan 2019 22:15:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     linux-rtc@vger.kernel.org, a.zummo@towertech.it
Subject: Re: [PATCH] RTC: fix erroneous kerneldoc comment
Message-ID: <20190110211509.GC2362@piout.net>
References: <alpine.LFD.2.21.1812260516220.31274@IT-590-06364.gateway.2wire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812260516220.31274@IT-590-06364.gateway.2wire.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 26/12/2018 05:18:33-0600, Robert P. J. Day wrote:
> 
> Clearly a copy-and paste error.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 3b43787f154b..df45d9a01ff2 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -425,7 +425,7 @@ struct rtc_device *devm_rtc_device_register(struct device *dev,
>  EXPORT_SYMBOL_GPL(devm_rtc_device_register);
> 
>  /**
> - * devm_rtc_device_unregister - resource managed devm_rtc_device_unregister()
> + * devm_rtc_device_unregister - resource managed rtc_device_unregister()

This has been removed in 03f39f47dc86 rtc: class: remove
devm_rtc_device_unregister so the patch doesn't apply anymore.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
