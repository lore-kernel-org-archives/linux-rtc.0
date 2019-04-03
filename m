Return-Path: <SRS0=SXQY=SF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF47C4360F
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 04:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCAC206C0
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 04:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dn7wjlal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDCE1n (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:27:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44670 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCE1n (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Apr 2019 00:27:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x334RBnK114477;
        Tue, 2 Apr 2019 23:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554265631;
        bh=2rxWI6hP/lVz3GN/7z3TBLQs+geIkYSvd2Ea3AtbD+s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dn7wjlalo3HuGo3R27VaNzOwIrJp4AnrRWGQqBLPT/NlF5jXex2dVWYnpB+UH01jo
         MZx5D+CfmrgENT1sgO4U9x1xTQMYWxUz7JP8PxDFpLlNXM9LY9imBOTymqrTY9LA/l
         Y/SJGPqOJbzRCoHyF9WazhXsbQ6xU5MN2xDnJTTg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x334RBJc005181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 23:27:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 23:27:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 23:27:11 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x334R8Jm126446;
        Tue, 2 Apr 2019 23:27:08 -0500
Subject: Re: [PATCH v2 2/5] rtc: interface: Add power_off_program to
 rtc_class_ops
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <a.zummo@towertech.it>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <d-gerlach@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-3-j-keerthy@ti.com> <20190402173232.GP49658@atomide.com>
 <20190402210742.GH22216@piout.net>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <0c362e51-caaf-b282-6169-1deab7b18409@ti.com>
Date:   Wed, 3 Apr 2019 09:57:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402210742.GH22216@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 03/04/19 2:37 AM, Alexandre Belloni wrote:
> On 02/04/2019 10:32:32-0700, Tony Lindgren wrote:
>> * Keerthy <j-keerthy@ti.com> [190402 03:43]:
>>> Add an interface function to set up the rtc for a power_off
>>> mode.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>   drivers/rtc/interface.c | 12 ++++++++++++
>>>   drivers/rtc/rtc-omap.c  |  1 +
>>>   include/linux/rtc.h     |  2 ++
>>>   3 files changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>>> index ccb7d6b4da3b..4846ec897067 100644
>>> --- a/drivers/rtc/interface.c
>>> +++ b/drivers/rtc/interface.c
>>> @@ -1070,3 +1070,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>>>   	trace_rtc_set_offset(offset, ret);
>>>   	return ret;
>>>   }
>>> +
>>> +/**
>>> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
>>> + * line and can be used to power off the SoC.
>>> + *
>>> + * Kernel interface to program rtc to power off
>>> + */
>>> +int rtc_power_off_program(struct rtc_device *rtc)
>>> +{
>>> +	return rtc->ops->power_off_program(rtc->dev.parent);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rtc_power_off_program);
>>
>> This whole series looks OK to me. Not sure about the naming for
>> rtc_power_off_program(), would rtc_power_off_device() be more
>> generic?
>>
> 
> Well, even if this is more generic, this feels way too ad-hoc to me.
> The series is adding a function and a callback to the core for, from
> what I understand, only one particular board.
> 
> You may as well simply export the function directly from the rtc-omap
> driver as anyway, this is added as a dependency in the last patch.
> 
> Something else I would be open to but I'm not completely sure this fits
> your use case is a new interface that would take an alarm index as a
> parameter to allow setting any alarm on the RTC. This would at least be
> usable for multiple other drivers.

Agreed that this is pretty specific to am43 as of now. As you suggested 
i will export out omap_rtc_poweroff_program. I will post v3 with the 
interface patch removed.

Thanks for your feedback.

> 
