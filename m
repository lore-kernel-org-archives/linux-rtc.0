Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546CC43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 04:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FED20854
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 04:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gkVQ//kD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbfCTEuK (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:50:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36832 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfCTEuJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 00:50:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2K4o0pO035714;
        Tue, 19 Mar 2019 23:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553057400;
        bh=GktjOL0+Z9EnnRJkO8lERomwZ4GI/UVQdtTiWLdh3u4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gkVQ//kDFqVK5c1aP3wPra2mQUSsJqq8U0BvyuB1owMWWgiHJzzZO0qz3oyJjPUdk
         APyGNm5pQGg48JJhu4wJtb5x8Dy39Kx38lVsGIW/d5knxRziznvV/s4zGVHQDu4uiN
         V5h42JL0SL3WUL1Km5TaTtenEj9h/+DuS+MJXFKQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2K4nx0f006099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 23:49:59 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 23:49:59 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 23:49:59 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2K4nvgg028038;
        Tue, 19 Mar 2019 23:49:58 -0500
Subject: Re: [PATCH] rtc: omap: let the core handle range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>
References: <20190318124438.26327-1-alexandre.belloni@bootlin.com>
 <20190318124438.26327-2-alexandre.belloni@bootlin.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <c9079ac1-0155-f5d8-2fce-3c94e99b7b3a@ti.com>
Date:   Wed, 20 Mar 2019 10:20:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318124438.26327-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 18/03/19 6:14 PM, Alexandre Belloni wrote:
> Let the core handle the RTC range instead of open coding it.

Tested for rtcwake and checked for rtc time ticking on am437x-gp-evm.

Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-omap.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index bbff0e2deb84..ea0eb48f3bb9 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -271,7 +271,7 @@ static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>   }
>   
>   /* this hardware doesn't support "don't care" alarm fields */
> -static int tm2bcd(struct rtc_time *tm)
> +static void tm2bcd(struct rtc_time *tm)
>   {
>   	tm->tm_sec = bin2bcd(tm->tm_sec);
>   	tm->tm_min = bin2bcd(tm->tm_min);
> @@ -279,13 +279,7 @@ static int tm2bcd(struct rtc_time *tm)
>   	tm->tm_mday = bin2bcd(tm->tm_mday);
>   
>   	tm->tm_mon = bin2bcd(tm->tm_mon + 1);
> -
> -	/* epoch == 1900 */
> -	if (tm->tm_year < 100 || tm->tm_year > 199)
> -		return -EINVAL;
>   	tm->tm_year = bin2bcd(tm->tm_year - 100);
> -
> -	return 0;
>   }
>   
>   static void bcd2tm(struct rtc_time *tm)
> @@ -328,8 +322,7 @@ static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
>   {
>   	struct omap_rtc *rtc = dev_get_drvdata(dev);
>   
> -	if (tm2bcd(tm) < 0)
> -		return -EINVAL;
> +	tm2bcd(tm);
>   
>   	local_irq_disable();
>   	rtc_wait_not_busy(rtc);
> @@ -378,8 +371,7 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>   	struct omap_rtc *rtc = dev_get_drvdata(dev);
>   	u8 reg, irqwake_reg = 0;
>   
> -	if (tm2bcd(&alm->time) < 0)
> -		return -EINVAL;
> +	tm2bcd(&alm->time);
>   
>   	local_irq_disable();
>   	rtc_wait_not_busy(rtc);
> @@ -444,11 +436,7 @@ static void omap_rtc_power_off(void)
>   	rtc_tm_to_time(&tm, &now);
>   	rtc_time_to_tm(now + 1, &tm);
>   
> -	if (tm2bcd(&tm) < 0) {
> -		dev_err(&rtc->rtc->dev, "power off failed\n");
> -		rtc->type->lock(rtc);
> -		return;
> -	}
> +	tm2bcd(&tm);
>   
>   	rtc_wait_not_busy(rtc);
>   
> @@ -845,6 +833,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
>   	}
>   
>   	rtc->rtc->ops = &omap_rtc_ops;
> +	rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_1900;
> +	rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
>   	omap_rtc_nvmem_config.priv = rtc;
>   
>   	/* handle periodic and alarm irqs */
> 
