Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD3C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 06:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9362184E
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 06:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gKA4Iz2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCTG1L (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:27:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59498 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCTG1L (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 02:27:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2K6I9NG113558;
        Wed, 20 Mar 2019 01:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553062689;
        bh=6aodIS9tgpg3gAA0gv+ROh/8yztnTP4qADaaQfkZKDw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gKA4Iz2n4AoJmRz1XCj0z3g+AyPakKDvKBaN4Y6Dv3/J4+b/2+PCus4tp/XgvfWKV
         4ANFsOKWfK79m6paQILUXfWwwdNmjVgwBYE5MaF+kw+vax0yzy+FP4NQV+ycJUX3km
         ZirQopQX35s3E7bkOd1Er++LuxiNieUVN8JYlrEQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2K6I9hr121987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 01:18:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 01:18:08 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 01:18:08 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2K6I63Z010010;
        Wed, 20 Mar 2019 01:18:07 -0500
Subject: Re: [PATCH] rtc: omap: let the core handle range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20190318124438.26327-1-alexandre.belloni@bootlin.com>
 <20190318124438.26327-2-alexandre.belloni@bootlin.com>
 <c9079ac1-0155-f5d8-2fce-3c94e99b7b3a@ti.com>
 <20190320051051.GJ29054@piout.net>
 <11d60e1a-a884-80e7-f206-ccf8cb58692e@ti.com>
 <6f9ff9e5-abb0-4aa4-5697-02799943bd25@ti.com>
 <20190320060845.GL29054@piout.net>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <c606f02c-091b-9b3a-2c35-a517b7ab6243@ti.com>
Date:   Wed, 20 Mar 2019 11:48:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320060845.GL29054@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 20/03/19 11:38 AM, Alexandre Belloni wrote:
> On 20/03/2019 11:25:31+0530, Keerthy wrote:
>> Hi Alexandre,
>>
>> https://pastebin.ubuntu.com/p/8w6HXKV6St/
>>
>> I applied this patch on top of linux-next. I am able to wake up from rtc
>> from suspend to memory on am33-bbb.
>>
>> Also i tried your commands:
>>
>> echo +5 > /sys/class/rtc/rtc0/wakealarm ; echo mem > /sys/power/state
>> [  147.046018] PM: suspend entry (deep)
>> [  147.049675] PM: Syncing filesystems ... done.
>> [  147.071869] Freezing user space processes ... (elapsed 0.001 seconds)
>> done.
>> [  147.080658] OOM killer disabled.
>> [  147.083974] Freezing remaining freezable tasks ... (elapsed 0.001
>> seconds) done.
>> [  147.092830] printk: Suspending console(s) (use no_console_suspend to
>> debug)
>> [  147.233280] cpsw 4a100000.ethernet eth0: Link is Down
>> [  147.248012] Disabling non-boot CPUs ...
>> [  147.248048] pm33xx pm33xx: PM: Successfully put all powerdomains to
>> target state
>> [  147.270934] net eth0: initializing cpsw version 1.12 (0)
>> [  147.374824] SMSC LAN8710/LAN8720 4a101000.mdio:00: attached PHY driver
>> [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=4a101000.mdio:00, irq=POLL)
>> [  147.562211] OOM killer enabled.
>> [  147.565489] Restarting tasks ... done.
>> [  147.616203] PM: suspend exit
>>
>> That also worked fine.
>>
>> For am335x-boneblack as well this patch works.
>>
> 
> Ok, thanks a lot for confirming, I'll try to fix my setup, I'm probably
> just missing the m3 firmware.

Yes. Just try:

echo mem > /sys/power/state

and try waking up from uart and if that fails then we need to look at m3
firmware. If this works only then move to rtcwake.

Regards,
Keerthy
> 
> 
