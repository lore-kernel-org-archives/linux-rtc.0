Return-Path: <SRS0=qdFt=SM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2679FC10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F3E20820
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 21:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfDJVLH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:11:07 -0400
Received: from mpt1.mothictech.com ([71.19.145.203]:53016 "EHLO
        mpt1.mothictech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDJVLH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 10 Apr 2019 17:11:07 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2019 17:11:07 EDT
Received: from wish.monmotha.net (wish.monmotha.net [IPv6:2001:470:c5f2:8::2])
        by mpt1.mothictech.com (Postfix) with ESMTPS id 435C743C56;
        Wed, 10 Apr 2019 14:02:17 -0700 (PDT)
Received: from [IPv6:2001:470:c5f2:14:3c2d:b94a:32ca:8297] (unknown [IPv6:2001:470:c5f2:14:3c2d:b94a:32ca:8297])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by wish.monmotha.net (Postfix) with ESMTPSA id 65A3759;
        Wed, 10 Apr 2019 17:01:43 -0400 (EDT)
Subject: Re: [PATCH 5/5] rtc: pcf85363: convert to SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
References: <20190410205604.25262-1-alexandre.belloni@bootlin.com>
 <20190410205604.25262-5-alexandre.belloni@bootlin.com>
From:   Brandon Martin <martinbv@mothictech.com>
Openpgp: preference=signencrypt
Autocrypt: addr=martinbv@mothictech.com; prefer-encrypt=mutual; keydata=
 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
Organization: Mothic Technologies
Message-ID: <8e70712a-c3d5-6101-f33c-8452559038f7@mothictech.com>
Date:   Wed, 10 Apr 2019 17:01:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410205604.25262-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 4/10/19 4:56 PM, Alexandre Belloni wrote:
> Use SPDX-License-Identifier instead of a verbose license text.
> 
> The original text refers to version 2 so also update MODULE_LICENSE() to
> "GPL v2" instead of "GPL".
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-pcf85363.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index afb1baacdaa7..a075e77617dc 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -1,15 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * drivers/rtc/rtc-pcf85363.c
>    *
>    * Driver for NXP PCF85363 real-time clock.
>    *
>    * Copyright (C) 2017 Eric Nelson
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * Based loosely on rtc-8583 by Russell King, Wolfram Sang and Juergen Beisert
>    */
>   #include <linux/module.h>
>   #include <linux/i2c.h>
> 

Looks like you did not update MODULE_LICENSE as stated in the comment?
-- 
Brandon Martin
Mothic Technologies
317-565-1357 x7000
