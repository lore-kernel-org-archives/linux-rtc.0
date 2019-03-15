Return-Path: <SRS0=pWyL=RS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C93C43381
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Mar 2019 13:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B822420854
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Mar 2019 13:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfCONmC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:42:02 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59015 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfCONmC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Mar 2019 09:42:02 -0400
X-Originating-IP: 109.213.80.250
Received: from localhost (alyon-652-1-57-250.w109-213.abo.wanadoo.fr [109.213.80.250])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 547CA40008;
        Fri, 15 Mar 2019 13:42:00 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] rtc: mv: convert to SPDX identifier
In-Reply-To: <20190315133513.9909-1-alexandre.belloni@bootlin.com>
References: <20190315133513.9909-1-alexandre.belloni@bootlin.com>
Date:   Fri, 15 Mar 2019 14:41:59 +0100
Message-ID: <87ftrotftk.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,
 
 On ven., mars 15 2019, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Use SPDX-License-Identifier instead of a verbose license text.
>
> The original text refers to version 2 so also update MODULE_LICENSE() to
> "GPL v2" instead of "GPL".
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/rtc/rtc-mv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index e7f14bd12fe3..d13d06ea6709 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
> @@ -1,9 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the RTC in Marvell SoCs.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
>  
>  #include <linux/init.h>
> @@ -322,5 +319,5 @@ module_platform_driver_probe(mv_rtc_driver, mv_rtc_probe);
>  
>  MODULE_AUTHOR("Saeed Bishara <saeed@marvell.com>");
>  MODULE_DESCRIPTION("Marvell RTC driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:rtc-mv");
> -- 
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
