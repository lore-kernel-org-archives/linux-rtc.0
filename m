Return-Path: <SRS0=AWqx=O5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6544C43387
	for <linux-rtc@archiver.kernel.org>; Thu, 20 Dec 2018 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBD21720
	for <linux-rtc@archiver.kernel.org>; Thu, 20 Dec 2018 14:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeLTON1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:13:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731617AbeLTON1 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 20 Dec 2018 09:13:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBCDCAB3F3C00;
        Thu, 20 Dec 2018 22:13:18 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 22:13:18 +0800
Subject: Re: [PATCH] rtc: Fix UBSAN overflow warning
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>
References: <1545298616-62881-1-git-send-email-zhangxiaoxu5@huawei.com>
 <20181220110731.GC2188@piout.net>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <875eca7e-b10f-f2ea-a633-668b10e88560@huawei.com>
Date:   Thu, 20 Dec 2018 22:11:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181220110731.GC2188@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 12/20/2018 7:07 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 20/12/2018 17:36:56+0800, ZhangXiaoxu wrote:
>> Users may call 'ioctl' and pass a very big value on 'tm->tm_year'.
>> It can be overflowed in 'int' after add 1900.
>> In function 'rtc_month_days' and 'mktime64', also treated it as an
>> 'unsigned' parameter.
>>
>> UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:103:59
>> signed integer overflow:
>> 2147483647 + 1900 cannot be represented in type 'int'
>>
>> UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:119:30
>> signed integer overflow:
>> 2147483647 + 1900 cannot be represented in type 'int'
>>
>> So, covert it to 'unsigned' explicitly.
>>
>> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
>> ---
>>   drivers/rtc/rtc-lib.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
>> index ef160da..9714cb3 100644
>> --- a/drivers/rtc/rtc-lib.c
>> +++ b/drivers/rtc/rtc-lib.c
>> @@ -100,7 +100,7 @@ int rtc_valid_tm(struct rtc_time *tm)
>>   	if (tm->tm_year < 70
>>   		|| ((unsigned)tm->tm_mon) >= 12
>>   		|| tm->tm_mday < 1
>> -		|| tm->tm_mday > rtc_month_days(tm->tm_mon, (unsigned)(tm->tm_year + 1900))
>> +		|| tm->tm_mday > rtc_month_days(tm->tm_mon, ((unsigned)tm->tm_year + 1900))
> 
> Isn't the cast to unsigned done by rtc_month_days enough?
The undefined behaviour is 'tm->tm_year + 1900', rtc_month_days just convert the result to unsigned.
Also, signed integer overflow is undefined according to the C standard.
> 
>>   		|| ((unsigned)tm->tm_hour) >= 24
>>   		|| ((unsigned)tm->tm_min) >= 60
>>   		|| ((unsigned)tm->tm_sec) >= 60)
>> @@ -116,8 +116,8 @@ EXPORT_SYMBOL(rtc_valid_tm);
>>    */
>>   time64_t rtc_tm_to_time64(struct rtc_time *tm)
>>   {
>> -	return mktime64(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
>> -			tm->tm_hour, tm->tm_min, tm->tm_sec);
>> +	return mktime64(((unsigned)tm->tm_year + 1900), tm->tm_mon + 1,
>> +			tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);
> 
> mktime64 will fail way before tm->tm_year + 1900 overflows an int and
> also it already takes an unsigned int for year so I'm not sure this cast
> is actually necessary.
> 
>>   }
>>   EXPORT_SYMBOL(rtc_tm_to_time64);
>>   
>> -- 
>> 2.7.4
>>
> 

