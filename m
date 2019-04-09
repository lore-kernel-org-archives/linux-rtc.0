Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2774C10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 05:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3F20883
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 05:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cyzCrqH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDIFV3 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:21:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34990 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfDIFV3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 01:21:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x395LAAR070618;
        Tue, 9 Apr 2019 00:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554787270;
        bh=vDMDRNN4tUQ3FudWYpG3M8PvvcwxK6FlYMZvqX+hy6Y=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=cyzCrqH36lmn8UiaigI6KbBpllPRRCwG2X3dTUfV/o79n+JZRNqV4It4IJQSglMJi
         e45fSU+woOyZMmbzVlBqGjurDo63kKO7Ds2tRV7cJ/JppPk4m4tKO1sBLMbREu+Qty
         HsiXTnYZhkMVN7Tif/BHqOKvXA6f9sdglsxmuxlA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x395LAdO126739
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 00:21:10 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 00:21:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 00:21:10 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x395L6sG089943;
        Tue, 9 Apr 2019 00:21:06 -0500
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
From:   Keerthy <j-keerthy@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>
References: <20190403045742.2243-1-j-keerthy@ti.com>
 <20190408172654.GL49658@atomide.com> <20190408174349.GM49658@atomide.com>
 <643643f2-c855-5cb6-79b5-96a4f9752955@ti.com>
Message-ID: <accde963-4cb0-2db3-d482-f6ca1a386398@ti.com>
Date:   Tue, 9 Apr 2019 10:51:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <643643f2-c855-5cb6-79b5-96a4f9752955@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 09/04/19 9:29 AM, Keerthy wrote:
> 
> 
> On 08/04/19 11:13 PM, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [190408 10:26]:
>>> * Keerthy <j-keerthy@ti.com> [190402 21:57]:
>>>> Changes in v3:
>>>>
>>>>    * Exported out omap_rtc_poweroff_program function & removed
>>>>      the patch to add a generic rtc interface as it is specific
>>>>      to am43 at the moment.
>>>
>>> Thanks I'll be applying this series into omap-for-v5.2/am4-pm
>>> today.
>>
>> Sorry correction for the branch named above. I noticed a build
>> warning and folded in the following fix. We need to return
>> -EINVAL if tm2bcd() fails like we do elsewhere in the driver.
>>
>> So I just pushed out a new branch omap-for-v5.2/am4-pm-v2.
>> Please just ignore the earlier branch omap-for-v5.2/am4-pm.
> 
> Thanks Tony!

Tony,

Seems like your for-next is a little behind. Hence you noticed the 
compilation error which i did not notice. The rtc driver patch i 
formatted from your for-next branch does not apply cleanly on linux-next 
as there are more patches already applied by Alexandre on next.

So the patch you made to return -EINVAL is no longer needed on latest next.

Thanks,
Keerthy
> 
>>
>> Regards,
>>
>> Tony
>>
>> 8< --------------------
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -447,7 +447,7 @@ int omap_rtc_power_off_program(struct device *dev)
>>       if (tm2bcd(&tm) < 0) {
>>           dev_err(&rtc->rtc->dev, "power off failed\n");
>>           rtc->type->lock(rtc);
>> -        return;
>> +        return -EINVAL;
>>       }
>>       rtc_wait_not_busy(rtc);
>>
