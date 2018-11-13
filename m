Return-Path: <SRS0=UNq1=NY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8687C43441
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 12:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0162243E
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 12:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dc2adXba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0162243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeKMWNc (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:13:32 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53249 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeKMWNc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Nov 2018 17:13:32 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113121539euoutp014d481b9253194eb3ba0b8725d986e411~mrheo3r4H3027130271euoutp01f
        for <linux-rtc@vger.kernel.org>; Tue, 13 Nov 2018 12:15:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113121539euoutp014d481b9253194eb3ba0b8725d986e411~mrheo3r4H3027130271euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542111339;
        bh=eQanfUQYUBrUAQO7vdawypGrt+wCRAc1FbhzWfIWTJU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dc2adXbaSayqtSCQTbU10ejdanKhVHlqrXUoL90NG5qbNK8CsCP43yL2Xnnnl2UbV
         hCe93X2PNodcIcaNDGHcVCRzd32JQVa+b5f2ulvCiqYkr2hctQhYoKyH0k1UbBalq0
         fPGMUN8czbiPmhCnNjTmlQzpeKIYd5ElapAYs9yo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113121538eucas1p2a83acd9a6fc8534a6a130c815f98179b~mrheMcWiZ0061600616eucas1p2e;
        Tue, 13 Nov 2018 12:15:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.68.04441.A60CAEB5; Tue, 13
        Nov 2018 12:15:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181113121537eucas1p206e77c687ac3229cfa7e0030cb5bc6a3~mrhdNMZ6u1095010950eucas1p2A;
        Tue, 13 Nov 2018 12:15:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181113121537eusmtrp1bd8317399760cffa593ddc8b2f738cae~mrhc_Prvs3132931329eusmtrp1S;
        Tue, 13 Nov 2018 12:15:37 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-89-5beac06a69ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.78.04284.960CAEB5; Tue, 13
        Nov 2018 12:15:37 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181113121536eusmtip27b8533208b7e259a3b062e63a1361370~mrhcrb4cI1056110561eusmtip2O;
        Tue, 13 Nov 2018 12:15:36 +0000 (GMT)
Subject: Re: [PATCH] rtc: s3c-rtc: Avoid using broken ALMYEAR register
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-rtc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <333d1f33-11f7-b270-a919-e651143be08d@samsung.com>
Date:   Tue, 13 Nov 2018 13:15:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeKOEh9=eNB4FPGUJKykjPQK=6eM69AAw210FRD3SD7qA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7pZB15FG8x/L2ix5OJVdov2d8vY
        LTbOWM9qcf78BnaLY6uvsFnMOL+PyYHNY96aao9NqzrZPPq2rGL0mD7vJ5PH501yAaxRXDYp
        qTmZZalF+nYJXBln1s9kLdjLW7F04m3GBsYvXF2MnBwSAiYSNzsuMnUxcnEICaxglFj4/zYj
        hPOFUeJnywxmCOczo0R/9y02mJa7t89AVS1nlGhrXARV9Z5R4sGvv6wgVcICbhKX75xlAbFF
        BDQlrv/9zgpSxCzwiVHiZu87sCI2AUOJrrddQGM5OHgF7CS2TE8DCbMIqEpcn/MSLCwqECOx
        5oo/SJhXQFDi5MwnYCM5BQIlJjVtA7OZBeQltr+dwwxhi0vcejIf7B8JgXXsEjvm9LFDXO0i
        cfH5CiYIW1ji1fEtUHEZidOTe1ggGpoZJdpnzGKHcHoYJbbO2QH1s7XE4eMXWUEuYgb6Zv0u
        fYiwo8T747+ZQcISAnwSN94KQhzBJzFp23SoMK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IsJK/N
        QvLOLCTvzELYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg4jn97/inHYxfLyUd
        YhTgYFTi4T0x/WW0EGtiWXFl7iFGCQ5mJRHenSavooV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        VjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwSh5SSoi4yfJqgbeTYtxvrviow85XhJLnrU8RqPBc
        LG/TWMtzInf/AYll3cJM5QUhkj4z+589bP951+h9/SYWjVXP9j9YKcru9k8xRr1T6qX0hNWS
        l3Xjrsbaaz6v/jvn67wPJ47lh301vHlwbnHwvn8mC8o/f5Znc898Kbj3seYNrsXneNouKrEU
        ZyQaajEXFScCAPbrO484AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7qZB15FG3RO4rdYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/H5MDmMW9NtcemVZ1sHn1bVjF6TJ/3k8nj8ya5ANYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwz62eyFuzl
        rVg68TZjA+MXri5GTg4JAROJu7fPMILYQgJLGSWWbU+BiMtInJzWwAphC0v8udbF1sXIBVTz
        llFi7YHfTCAJYQE3ict3zrKA2CICmhLX/35nBSliFvjCKDH/7jxWiI4bjBJXOh6CdbAJGEp0
        vQUZxcHBK2AnsWV6GkiYRUBV4vqcl2wgtqhAjET3139gm3kFBCVOznwCtoBTIFBiUtM2MJtZ
        QF3iz7xLzBC2vMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCv
        ODG3uDQvXS85P3cTIzDSth37uXkH46WNwYcYBTgYlXh4T0x/GS3EmlhWXJl7iFGCg1lJhHen
        yatoId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJoG8knhDU0NzC0tDc2NzYzMLJXHe8waV
        UUIC6YklqdmpqQWpRTB9TBycUg2MgdYnVefelp/O/Wxdt7RxBtvGoK27+PJ4RELOdIYcambY
        HfB35pyneZ/iOTR0Z6RMMbuavkU0ynKhtO616KO9S9NWB36yWPBWN7nP0XXyHUumXI5ffMzu
        RV/FNr/MCuO/kx/5f2PxjXjO+0cSTHe8Mji7TSRFJnrXXqujun+e7RJ37XFqiL6kxFKckWio
        xVxUnAgAV3dd6soCAAA=
X-CMS-MailID: 20181113121537eucas1p206e77c687ac3229cfa7e0030cb5bc6a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6
References: <CGME20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6@eucas1p1.samsung.com>
        <20181113113250.15527-1-m.szyprowski@samsung.com>
        <CAJKOXPeKOEh9=eNB4FPGUJKykjPQK=6eM69AAw210FRD3SD7qA@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Krzysztof,

On 2018-11-13 12:50, Krzysztof Kozlowski wrote:
> On Tue, 13 Nov 2018 at 12:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> (RTC,ALM)YEAR registers of Exynos built-in RTC device contains 3 BCD
>> characters. s3c-rtc driver uses only 2 lower of them and supports years
>> from 2000..2099 range. The third BCD value is typically set to 0, but it
>> looks that handling of it is broken in the hardware. It sometimes
>> defaults to a random (even non-BCD) value. This is not an issue
>> for handling RTCYEAR register, because bcd2bin() properly handles only
>> 8bit values (2 BCD characters, the third one is skipped). The problem
>> is however with ALMYEAR register and proper RTC alarm operation. When
>> YEAREN bit is set for the configured alarm, RTC hardware triggers alarm
>> only when ALMYEAR and RTCYEAR matches. This usually doesn't happen
>> because of the random noise on the third BCD character.
>>
>> Fix this by simply skipping setting ALMYEAR register in alarm
>> configuration. This workaround fixes broken alarm operation on Exynos
>> built-in rtc device. My tests revealed that the issue happens on the
>> following Exynos series: 3250, 4210, 4412, 5250 and 5410.
> Does it mean that alarm set for 20.11.2019 will be triggered also this
> year on 20.11.2018 (and any other year as well)?
Yes, this will trigger one year earlier.
The question is if this is really and issue in typical use cases...

The only other workaround I see is to store the requested alarm time in
the driver context and check each time when it triggers interrupt if the
year matches requested value.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

