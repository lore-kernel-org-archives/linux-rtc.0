Return-Path: <SRS0=ug2M=OB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F8C43441
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 17:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4972220684
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 17:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4972220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406498AbeKWEao (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:30:44 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:48896 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732157AbeKWEao (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 22 Nov 2018 23:30:44 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 8F7E0440069;
        Thu, 22 Nov 2018 19:50:16 +0200 (IST)
References: <03de7e5c04091b69c550be82420c6a8ce5bbb71f.1542630842.git.baruch@tkos.co.il> <20181122171819.GK12656@piout.net>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: dt-binding: abx80x: fix resistance scale
In-reply-to: <20181122171819.GK12656@piout.net>
Date:   Thu, 22 Nov 2018 19:50:16 +0200
Message-ID: <87va4pdmsn.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

Alexandre Belloni writes:
> On 19/11/2018 14:34:02+0200, Baruch Siach wrote:
>> The abracon,tc-resistor property value is in KOhm.
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  Documentation/devicetree/bindings/rtc/abracon,abx80x.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
>> index be789685a1c2..e668b5f65314 100644
>> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
>> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
>> @@ -27,4 +27,4 @@ and valid to enable charging:
>>  
>>   - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
>>   - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
>> -                          resistor, the other values are in ohm.
>> +                          resistor, the other values are in KOhm.
>
> The correct SI prefix is k so this should be kOhm. If you agree, I can
> fix this up.

I am fine with that. Please fix the commit message as well.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
