Return-Path: <SRS0=SXQY=SF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBA9C4360F
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 04:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20283206C0
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 04:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K7yFTFO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfDCE17 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:27:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44704 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCE17 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Apr 2019 00:27:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x334Rh1H114736;
        Tue, 2 Apr 2019 23:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554265663;
        bh=ks0gcxSBYkNtz3TnfpsX/IsvMBKN5P60Hs7+EsDAb+c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K7yFTFO7z8uAQMJ3aYeM8FpP8PoAIBphO8+fYApgL9lLGAcZOJ5Xk8MsF8M7irYTP
         nHWR6UL3qfv5kH1jHL9LThCcQ8mLf9XKjcjvbrA9UYEJnqxNnGVSZnxfWtDmmXJVM/
         fue9PE3RYp1aYr0/ncVNuIf41gxm5z/NX3wik7Rk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x334Rh5K005578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 23:27:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 23:27:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 23:27:43 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x334ReRt057246;
        Tue, 2 Apr 2019 23:27:41 -0500
Subject: Re: [PATCH v2 4/5] soc: ti: pm33xx: Push the am33xx_push_sram_idle to
 the top
To:     Tony Lindgren <tony@atomide.com>
CC:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-5-j-keerthy@ti.com> <20190402173403.GQ49658@atomide.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <32b39137-bd70-64c6-fafe-d93143c88575@ti.com>
Date:   Wed, 3 Apr 2019 09:58:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402173403.GQ49658@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 02/04/19 11:04 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [190402 03:43]:
>> Push the am33xx_push_sram_idle function to the top as a preparation
>> for rtc+ddr mode as the function will be called by multiple functions
>> currently present before it.
> 
> How about say "Move the am33xx_push_sram_idle function to the top..."
> instead? And mention no functional changes assuming there aren't
> any.

Sure will edit commit description in the next version.

> 
> Regards,
> 
> Tony
> 
