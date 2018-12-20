Return-Path: <SRS0=AWqx=O5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF03C43387
	for <linux-rtc@archiver.kernel.org>; Thu, 20 Dec 2018 11:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D9521741
	for <linux-rtc@archiver.kernel.org>; Thu, 20 Dec 2018 11:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeLTLHn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:07:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59394 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeLTLHn (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 20 Dec 2018 06:07:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9F6C0207AE; Thu, 20 Dec 2018 12:07:41 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6BAAB2079F;
        Thu, 20 Dec 2018 12:07:31 +0100 (CET)
Date:   Thu, 20 Dec 2018 12:07:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: Fix UBSAN overflow warning
Message-ID: <20181220110731.GC2188@piout.net>
References: <1545298616-62881-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545298616-62881-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 20/12/2018 17:36:56+0800, ZhangXiaoxu wrote:
> Users may call 'ioctl' and pass a very big value on 'tm->tm_year'.
> It can be overflowed in 'int' after add 1900.
> In function 'rtc_month_days' and 'mktime64', also treated it as an
> 'unsigned' parameter.
> 
> UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:103:59
> signed integer overflow:
> 2147483647 + 1900 cannot be represented in type 'int'
> 
> UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:119:30
> signed integer overflow:
> 2147483647 + 1900 cannot be represented in type 'int'
> 
> So, covert it to 'unsigned' explicitly.
> 
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/rtc/rtc-lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
> index ef160da..9714cb3 100644
> --- a/drivers/rtc/rtc-lib.c
> +++ b/drivers/rtc/rtc-lib.c
> @@ -100,7 +100,7 @@ int rtc_valid_tm(struct rtc_time *tm)
>  	if (tm->tm_year < 70
>  		|| ((unsigned)tm->tm_mon) >= 12
>  		|| tm->tm_mday < 1
> -		|| tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
> +		|| tm->tm_mday > rtc_month_days(tm->tm_mon, ((unsigned)tm->tm_year + 1900))

Isn't the cast to unsigned done by rtc_month_days enough?

>  		|| ((unsigned)tm->tm_hour) >= 24
>  		|| ((unsigned)tm->tm_min) >= 60
>  		|| ((unsigned)tm->tm_sec) >= 60)
> @@ -116,8 +116,8 @@ EXPORT_SYMBOL(rtc_valid_tm);
>   */
>  time64_t rtc_tm_to_time64(struct rtc_time *tm)
>  {
> -	return mktime64(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
> -			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +	return mktime64(((unsigned)tm->tm_year + 1900), tm->tm_mon + 1,
> +			tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);

mktime64 will fail way before tm->tm_year + 1900 overflows an int and
also it already takes an unsigned int for year so I'm not sure this cast
is actually necessary.

>  }
>  EXPORT_SYMBOL(rtc_tm_to_time64);
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
