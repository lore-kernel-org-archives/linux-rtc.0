Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C39CC43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 05:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB62064A
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 05:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFu0h85h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfCTFae (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:30:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52522 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTFae (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 01:30:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2K5UPOZ093801;
        Wed, 20 Mar 2019 00:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553059825;
        bh=4ayNZsMbsxRLGBTAoZF8i85pTgbX7zW9Hjp9k1YKfWY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SFu0h85hFHnt889JLts+eNimI2c8eR3iOxn67n8jhAQ4HdfoB89Yit4krfvlotQ45
         IWNI+9haO47CxUAYnt4UIWdqMJ4moVKGlAbnaw1f9OBzfOyP6BwYlHKA5+6MkwEZ1v
         jbXdpnFdiVerj5fStB3n1YMwVbCuDByHcFQxbrP4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2K5UPvK047863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 00:30:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 00:30:24 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 00:30:24 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2K5UMu9015270;
        Wed, 20 Mar 2019 00:30:23 -0500
Subject: Re: [PATCH] rtc: omap: let the core handle range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20190318124438.26327-1-alexandre.belloni@bootlin.com>
 <20190318124438.26327-2-alexandre.belloni@bootlin.com>
 <c9079ac1-0155-f5d8-2fce-3c94e99b7b3a@ti.com>
 <20190320051051.GJ29054@piout.net>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <11d60e1a-a884-80e7-f206-ccf8cb58692e@ti.com>
Date:   Wed, 20 Mar 2019 11:00:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320051051.GJ29054@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 20/03/19 10:40 AM, Alexandre Belloni wrote:
> On 20/03/2019 10:20:17+0530, Keerthy wrote:
>>
>>
>> On 18/03/19 6:14 PM, Alexandre Belloni wrote:
>>> Let the core handle the RTC range instead of open coding it.
>>
>> Tested for rtcwake and checked for rtc time ticking on am437x-gp-evm.
>>
> 
> Thanks!
> 
> BTW, I couldn't get the RTC to wake my BBB from suspend to mem.
> I used:
> 
> echo +5 > /sys/class/rtc/rtc0/wakealarm ; echo mem > /sys/power/state
> 
> The interrupt seems to fire correctly when I'm not suspended, is
> there something I'm missing?

Let me check what is happening with bbb. BTW I generally use:

rtcwake -d /dev/rtc0 -m mem -s 5

to wake up from mem via rtc.

> 
>> Tested-by: Keerthy <j-keerthy@ti.com>
>> Reviewed-by: Keerthy <j-keerthy@ti.com>
>>
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> ---
>>>    drivers/rtc/rtc-omap.c | 22 ++++++----------------
>>>    1 file changed, 6 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>>> index bbff0e2deb84..ea0eb48f3bb9 100644
>>> --- a/drivers/rtc/rtc-omap.c
>>> +++ b/drivers/rtc/rtc-omap.c
>>> @@ -271,7 +271,7 @@ static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>>>    }
>>>    /* this hardware doesn't support "don't care" alarm fields */
>>> -static int tm2bcd(struct rtc_time *tm)
>>> +static void tm2bcd(struct rtc_time *tm)
>>>    {
>>>    	tm->tm_sec = bin2bcd(tm->tm_sec);
>>>    	tm->tm_min = bin2bcd(tm->tm_min);
>>> @@ -279,13 +279,7 @@ static int tm2bcd(struct rtc_time *tm)
>>>    	tm->tm_mday = bin2bcd(tm->tm_mday);
>>>    	tm->tm_mon = bin2bcd(tm->tm_mon + 1);
>>> -
>>> -	/* epoch == 1900 */
>>> -	if (tm->tm_year < 100 || tm->tm_year > 199)
>>> -		return -EINVAL;
>>>    	tm->tm_year = bin2bcd(tm->tm_year - 100);
>>> -
>>> -	return 0;
>>>    }
>>>    static void bcd2tm(struct rtc_time *tm)
>>> @@ -328,8 +322,7 @@ static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>>    {
>>>    	struct omap_rtc *rtc = dev_get_drvdata(dev);
>>> -	if (tm2bcd(tm) < 0)
>>> -		return -EINVAL;
>>> +	tm2bcd(tm);
>>>    	local_irq_disable();
>>>    	rtc_wait_not_busy(rtc);
>>> @@ -378,8 +371,7 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>>>    	struct omap_rtc *rtc = dev_get_drvdata(dev);
>>>    	u8 reg, irqwake_reg = 0;
>>> -	if (tm2bcd(&alm->time) < 0)
>>> -		return -EINVAL;
>>> +	tm2bcd(&alm->time);
>>>    	local_irq_disable();
>>>    	rtc_wait_not_busy(rtc);
>>> @@ -444,11 +436,7 @@ static void omap_rtc_power_off(void)
>>>    	rtc_tm_to_time(&tm, &now);
>>>    	rtc_time_to_tm(now + 1, &tm);
>>> -	if (tm2bcd(&tm) < 0) {
>>> -		dev_err(&rtc->rtc->dev, "power off failed\n");
>>> -		rtc->type->lock(rtc);
>>> -		return;
>>> -	}
>>> +	tm2bcd(&tm);
>>>    	rtc_wait_not_busy(rtc);
>>> @@ -845,6 +833,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
>>>    	}
>>>    	rtc->rtc->ops = &omap_rtc_ops;
>>> +	rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_1900;
>>> +	rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
>>>    	omap_rtc_nvmem_config.priv = rtc;
>>>    	/* handle periodic and alarm irqs */
>>>
> 
