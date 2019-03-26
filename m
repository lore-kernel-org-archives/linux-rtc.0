Return-Path: <SRS0=Xh52=R5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6BAC43381
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Mar 2019 04:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B520811
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Mar 2019 04:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W5seFaJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCZEfM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:35:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48316 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZEfM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Mar 2019 00:35:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2Q4Y8sI058405;
        Mon, 25 Mar 2019 23:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553574848;
        bh=5D0uB3ylz/+6dWIqAfUzmCbuxe2y3J9KBf8O+3lvuRI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W5seFaJWsjn93oaxRUeqAHsNmMAq7SaLEJbHWvhK8oj/p9tnnouj2d1fshvsvh05P
         zbcbgA3YOdEVg+EAKdnSZTMov6koHVwSvFLIN7lfScza+Ue5QudrZu2yFdzEzP7pIB
         cjO2Tm4QPACQfw+Cdge6IA9VveHJJhWVSBZ9y1XY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2Q4Y8Jd061270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 23:34:08 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 23:34:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 25 Mar 2019 23:34:07 -0500
Received: from [172.22.219.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2Q4Y3TS009233;
        Mon, 25 Mar 2019 23:34:04 -0500
Subject: Re: [PATCH 0/5] AM437x: Add rtc-only + DDR mode support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>,
        <linux-rtc@vger.kernel.org>, <d-gerlach@ti.com>,
        <ssantosh@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322183253.w2uuhglttwmmxfnx@shell.armlinux.org.uk>
 <1fadeed8-b091-43c8-e7ec-f29ad0fff82c@ti.com>
 <20190325105920.4se5hjul2srkzre7@shell.armlinux.org.uk>
From:   keerthy <j-keerthy@ti.com>
Message-ID: <94ca9473-8649-e0e9-fbe2-e5dfd62cfc2a@ti.com>
Date:   Tue, 26 Mar 2019 10:04:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325105920.4se5hjul2srkzre7@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 3/25/2019 4:29 PM, Russell King - ARM Linux admin wrote:
> On Mon, Mar 25, 2019 at 07:13:53AM +0530, keerthy wrote:
>>
>>
>> On 3/23/2019 12:02 AM, Russell King - ARM Linux admin wrote:
>>> On Fri, Mar 22, 2019 at 10:46:14PM +0530, Keerthy wrote:
>>>> RTC plus DDR in self-refresh is power a saving mode where in the entire
>>>                                    "a power" ?
>>
>> Will correct the above typo.
>>
>>>
>>>> system including the different voltage rails from PMIC are shutdown except
>>>> the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
>>
>> As explained above All the voltage rails of PMIC are shut off except for RTC
>> and DDR Rails.
> 
> You seem to be replying to yourself there - the quote above your reply
> there is what you wrote.


well. I wanted point out that PMIC has granular control.

> 
>>
>>>> contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
>>>> we the ALARM2 is triggered we enter the mode with DDR in self-refresh
>>>
>>> Doesn't make sense.
>>>
>>>> and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
>>>> up the system.
>>>
>>> Huh, you start off explaining the wiring above... how does RTC ALARM1
>>> trigger waking up the system if RTC ALARM2 is connected to the PMIC
>>> and all other power is shut down?
>> The entire PMIC is shutdown but for RTC rail. RTC is a separate voltage
>> domain and is powered up during this power save mode.
>>
>> http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884.
> 
> I'm not asking for a reference, I'm asking for your cover letter to
> make sense and actually be useful.  Right now, it's far from that.

Okay I get it. I will definitely add more details in the next version.

> 
> Thanks.
> 
>>
>>>
>>>> The control goes to bootloader. The bootloader then checks
>>>> RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
>>>> a different path, configure bare minimal clocks for ddr and then jumps to
>>>> the resume address in another RTC scratchpad registers and transfers the
>>>> control to Kernel. Kernel then restores the saved context.
>>>>
>>>> The patch series adds rtc-only + DDR mode support am am437x
>>>> Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.
>>>>
>>>> This mode works only with u-boot built with am43xx_evm_rtconly_defconfig
>>>>
>>>> Additional patch is needed for omap-gpio save restore which will
>>>> come as fixes later.
>>>>
>>>> Keerthy (5):
>>>>     rtc: OMAP: Add support for rtc-only mode
>>>>     rtc: interface: Add power_off_program to rtc_class_ops
>>>>     arm: mach-omap2: pm33xx: Add support for rtc+ddr in self refresh mode
>>>>     soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
>>>>     soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support
>>>>
>>>>    arch/arm/mach-omap2/pm33xx-core.c    |  76 +++++++-
>>>>    drivers/rtc/interface.c              |  12 ++
>>>>    drivers/rtc/rtc-omap.c               |  49 ++++-
>>>>    drivers/soc/ti/Kconfig               |   5 +-
>>>>    drivers/soc/ti/pm33xx.c              | 272 ++++++++++++++++++++++-----
>>>>    include/linux/platform_data/pm33xx.h |   5 +
>>>>    include/linux/rtc.h                  |   2 +
>>>>    7 files changed, 360 insertions(+), 61 deletions(-)
>>>>
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
> 
