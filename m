Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279ABC43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 01:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA47F20896
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 01:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BzQSk0Av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfCYBow (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:44:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42926 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfCYBow (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 24 Mar 2019 21:44:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P1hwQw094214;
        Sun, 24 Mar 2019 20:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553478238;
        bh=yI477rMnTEIkrtS0KwZ7vnZ2b5wqEVMbwTrWvOjhgc8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BzQSk0AvyiNk+lPkgP0fEoeO5SYFBtOjATLCAm2pR40JgDOEhuKk15V5RRUPeRYar
         Y5yaQ7tDw3mRDjXnvksp1q5KyY3QKdZ81pOu42DpOy4/Y17MupsrKU9tn/RnzHnV7R
         eYA2JMYbQ6oYLibPbGrkzB81j0Wd0u78enSr/LiE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P1hwAq030957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 24 Mar 2019 20:43:58 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 24
 Mar 2019 20:43:57 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Sun, 24 Mar 2019 20:43:57 -0500
Received: from [172.22.217.24] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P1hr2Q012161;
        Sun, 24 Mar 2019 20:43:54 -0500
Subject: Re: [PATCH 0/5] AM437x: Add rtc-only + DDR mode support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>,
        <linux-rtc@vger.kernel.org>, <d-gerlach@ti.com>,
        <ssantosh@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322183253.w2uuhglttwmmxfnx@shell.armlinux.org.uk>
From:   keerthy <j-keerthy@ti.com>
Message-ID: <1fadeed8-b091-43c8-e7ec-f29ad0fff82c@ti.com>
Date:   Mon, 25 Mar 2019 07:13:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322183253.w2uuhglttwmmxfnx@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 3/23/2019 12:02 AM, Russell King - ARM Linux admin wrote:
> On Fri, Mar 22, 2019 at 10:46:14PM +0530, Keerthy wrote:
>> RTC plus DDR in self-refresh is power a saving mode where in the entire
>                                   "a power" ?

Will correct the above typo.

> 
>> system including the different voltage rails from PMIC are shutdown except
>> the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the

As explained above All the voltage rails of PMIC are shut off except for 
RTC and DDR Rails.

>> contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
>> we the ALARM2 is triggered we enter the mode with DDR in self-refresh
> 
> Doesn't make sense.
> 
>> and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
>> up the system.
> 
> Huh, you start off explaining the wiring above... how does RTC ALARM1
> trigger waking up the system if RTC ALARM2 is connected to the PMIC
> and all other power is shut down?
The entire PMIC is shutdown but for RTC rail. RTC is a separate voltage 
domain and is powered up during this power save mode.

http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884.

> 
>> The control goes to bootloader. The bootloader then checks
>> RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
>> a different path, configure bare minimal clocks for ddr and then jumps to
>> the resume address in another RTC scratchpad registers and transfers the
>> control to Kernel. Kernel then restores the saved context.
>>
>> The patch series adds rtc-only + DDR mode support am am437x
>> Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.
>>
>> This mode works only with u-boot built with am43xx_evm_rtconly_defconfig
>>
>> Additional patch is needed for omap-gpio save restore which will
>> come as fixes later.
>>
>> Keerthy (5):
>>    rtc: OMAP: Add support for rtc-only mode
>>    rtc: interface: Add power_off_program to rtc_class_ops
>>    arm: mach-omap2: pm33xx: Add support for rtc+ddr in self refresh mode
>>    soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
>>    soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support
>>
>>   arch/arm/mach-omap2/pm33xx-core.c    |  76 +++++++-
>>   drivers/rtc/interface.c              |  12 ++
>>   drivers/rtc/rtc-omap.c               |  49 ++++-
>>   drivers/soc/ti/Kconfig               |   5 +-
>>   drivers/soc/ti/pm33xx.c              | 272 ++++++++++++++++++++++-----
>>   include/linux/platform_data/pm33xx.h |   5 +
>>   include/linux/rtc.h                  |   2 +
>>   7 files changed, 360 insertions(+), 61 deletions(-)
>>
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
