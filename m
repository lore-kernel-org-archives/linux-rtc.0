Return-Path: <SRS0=pWyL=RS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74005C43381
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Mar 2019 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC132186A
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Mar 2019 13:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfCONto (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:49:44 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48357 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCONtn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Mar 2019 09:49:43 -0400
X-Originating-IP: 109.213.80.250
Received: from localhost (alyon-652-1-57-250.w109-213.abo.wanadoo.fr [109.213.80.250])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7AACB40006;
        Fri, 15 Mar 2019 13:49:41 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] rtc: mv: add range
In-Reply-To: <20190315133513.9909-3-alexandre.belloni@bootlin.com>
References: <20190315133513.9909-1-alexandre.belloni@bootlin.com> <20190315133513.9909-3-alexandre.belloni@bootlin.com>
Date:   Fri, 15 Mar 2019 14:49:40 +0100
Message-ID: <87a7hwtfgr.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,
 
 On ven., mars 15 2019, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> This RTC handles time from 2000-01-01 00:00:00 to 2099-12-31 23:59:59 with
> a weird rollover to 2000-06-23 00:00:00.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

on Armada XP GP

Thanks,

Gregory

> ---
>  drivers/rtc/rtc-mv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index ef704aef8663..e357a0b3f612 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
> @@ -57,7 +57,7 @@ static int mv_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	rtc_reg = (bin2bcd(tm->tm_mday) << RTC_MDAY_OFFS) |
>  		(bin2bcd(tm->tm_mon + 1) << RTC_MONTH_OFFS) |
> -		(bin2bcd(tm->tm_year % 100) << RTC_YEAR_OFFS);
> +		(bin2bcd(tm->tm_year - 100) << RTC_YEAR_OFFS);
>  	writel(rtc_reg, ioaddr + RTC_DATE_REG_OFFS);
>  
>  	return 0;
> @@ -156,7 +156,7 @@ static int mv_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  			<< RTC_MONTH_OFFS;
>  
>  	if (alm->time.tm_year >= 0)
> -		rtc_reg |= (RTC_ALARM_VALID | bin2bcd(alm->time.tm_year % 100))
> +		rtc_reg |= (RTC_ALARM_VALID | bin2bcd(alm->time.tm_year - 100))
>  			<< RTC_YEAR_OFFS;
>  
>  	writel(rtc_reg, ioaddr + RTC_ALARM_DATE_REG_OFFS);
> @@ -277,6 +277,9 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
>  		pdata->rtc->ops = &mv_rtc_ops;
>  	}
>  
> +	pdata->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	pdata->rtc->range_max = RTC_TIMESTAMP_END_2099;
> +
>  	ret = rtc_register_device(pdata->rtc);
>  	if (!ret)
>  		return 0;
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
