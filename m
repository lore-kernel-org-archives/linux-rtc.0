Return-Path: <SRS0=UNq1=NY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C4C43441
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A46A22507
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 11:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ur3ClxtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A46A22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeKMVut (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:50:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56553 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKMVut (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Nov 2018 16:50:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181113115300euoutp021ea8e53d9e4480232ddd5ee2a51cd2b2~mrNtw7TYg2435824358euoutp026
        for <linux-rtc@vger.kernel.org>; Tue, 13 Nov 2018 11:53:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181113115300euoutp021ea8e53d9e4480232ddd5ee2a51cd2b2~mrNtw7TYg2435824358euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542109980;
        bh=9UQiOUt5iBWzTVWfUL4CjZG1PxoETaAkVLNPgi7mZ0k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ur3ClxtHo3Ks4uSSILC445PFFjOSFvGEHsoF1Nrcz0iek0ENxUPFZaPUrkq8uON03
         CHFm+Ld525Vacw4Nv1SGZ6guvM827Q3EA9wfTymMVR4OG+sho+SIAJZnOXZ5AW+EXX
         w1wVdO9Dbj0pHQXRt1pRCr6Hk9Mj5JdI1lTygXx0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113115300eucas1p23901ad0df37eb268ccfdb564b2ad1a26~mrNtL9ktP1134011340eucas1p2o;
        Tue, 13 Nov 2018 11:53:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.91.04806.B1BBAEB5; Tue, 13
        Nov 2018 11:53:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181113115259eucas1p2d476e2e3c28e6129d6b9f5ebdfddae5c~mrNsD6BnZ1136211362eucas1p2h;
        Tue, 13 Nov 2018 11:52:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181113115258eusmtrp1db70417ed8a6599f45606db2616d145f~mrNr1augM2416324163eusmtrp19;
        Tue, 13 Nov 2018 11:52:58 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-35-5beabb1b553c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.F9.04128.A1BBAEB5; Tue, 13
        Nov 2018 11:52:58 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181113115258eusmtip28e9a186de0b2bb290ee590fcf98b5ff3~mrNrdUKt70379603796eusmtip25;
        Tue, 13 Nov 2018 11:52:58 +0000 (GMT)
Subject: Re: [PATCH] rtc: s3c-rtc: Avoid using broken ALMYEAR register
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9df3598b-cd6b-ec83-29b6-2fa312fcd0ff@samsung.com>
Date:   Tue, 13 Nov 2018 12:52:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181113113911.GQ29768@piout.net>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7oyu19FGyxwtlhy8Sq7Rfu7ZewW
        G2esZ7U4f34Du8Wx1VfYLGac38fkwOYxb021x6ZVnWwefVtWMXpMn/eTyePzJrkA1igum5TU
        nMyy1CJ9uwSujKeT/7EVrOOuWN/6n62BcQZnFyMnh4SAicT2g//Yuxi5OIQEVjBKnOt7zwbh
        fGGUWNd0kBnC+cwosfrwJqYuRg6wlhkL6iHiyxklTtyezQLhvGeUaFv0ghFkrrCAm8TlO2dZ
        QGwRAVOJ1sZdYGOZBU4xSjS++84KkmATMJToetvFBmLzCthJPN/cAxZnEVCV+L75HjPINlGB
        GIk1V/whSgQlTs58AjaTU0Bf4tSNg2A2s4C8xPa3c5ghbHGJW0/mM0H8to5d4sD5DAjbReL5
        hn2MELawxKvjW9ghbBmJ05N7wB6QEGhmlGifMYsdwulhlNg6ZwcbRJW1xOHjF1lBDmIW0JRY
        v0sfIuwo8f74b2ZIqPBJ3HgrCHEDn8SkbdOhwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkHw2
        C8k3s5B8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBSef0v+NfdzDu+5N0
        iFGAg1GJh/fE9JfRQqyJZcWVuYcYJTiYlUR4d5q8ihbiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        W83wIFpIID2xJDU7NbUgtQgmy8TBKdXAOL+ZQ9XjUGyx/ozW/G0znObulbS4wzD7TTJbxztz
        79DZqwreTH2V+ODd6T07ZRQOdVfvmfrd4XDekzWt3X+Wlz6X/i36yZpLy6az5YH+9i+HnH+y
        Bkm4K30qux/ls2az3by0xZ/XnDP76ZfNrrFUTYdHbp/1d9mpnHM51kn/mLv01bp8vU2TBZRY
        ijMSDbWYi4oTAUYJGk02AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7pSu19FGyzrNLJYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/H5MDmMW9NtcemVZ1sHn1bVjF6TJ/3k8nj8ya5ANYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYynk/+xFazj
        rljf+p+tgXEGZxcjB4eEgInEjAX1XYxcHEICSxklDqw/xNrFyAkUl5E4Oa0ByhaW+HOtiw3E
        FhJ4yyhxtt0YxBYWcJO4fOcsC4gtImAq0dq4iw1kELPAGUaJif0HWCGmbmOU+PH0PiNIFZuA
        oUTXW4hJvAJ2Es8394BtYBFQlfi++R4ziC0qECPR/fUfK0SNoMTJmU/ANnAK6EucunEQzGYW
        UJf4M+8SM4QtL7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIr
        TswtLs1L10vOz93ECIy0bcd+btnB2PUu+BCjAAejEg/viekvo4VYE8uKK3MPMUpwMCuJ8O40
        eRUtxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAJJBXEm9oamhuYWlobmxubGahJM573qAy
        SkggPbEkNTs1tSC1CKaPiYNTChhJS+y/Kl1hjVflnWmxolOxQlK54rD8gbhtvk2Lqi4eZhJJ
        Ym58ZPg7cNNco1dzHgW1WLXtCeV5PW97XVDYX6/bqdlhD+edsV3zpVhdjfdQjb0tj8CyqZWd
        134dt/o0aZlLRaDj3seaP10O5899XDV532VVP7djHCe6alr3PNZczyiUsf3RVn4lluKMREMt
        5qLiRACxhFlsygIAAA==
X-CMS-MailID: 20181113115259eucas1p2d476e2e3c28e6129d6b9f5ebdfddae5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6
References: <CGME20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6@eucas1p1.samsung.com>
        <20181113113250.15527-1-m.szyprowski@samsung.com>
        <20181113113911.GQ29768@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

On 2018-11-13 12:39, Alexandre Belloni wrote:
> On 13/11/2018 12:32:50+0100, Marek Szyprowski wrote:
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
> I'm probably missing something but can't you set that third BCD value to
> 0 in ALMYEAR?


s3c-rtc code sets it to 0 already, both for ALMYEAR and RTCYEAR registers
(bin2bcd returns 2 BCD characters, which are written to the register as u32,
with leading zeros). However I've observed that both mentioned registers
after such operation can still contain random noise on the third BCD
character, what make the alarm completely unreliable.

> ...


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

