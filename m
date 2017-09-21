Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:6946 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbdIUGps (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Sep 2017 02:45:48 -0400
Subject: Re: [PATCH] rtc: interface: set the next alarm event appropriately
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1505877751-26566-1-git-send-email-xuyiping@hisilicon.com>
 <20170920091617.j7sie3mrncjkcj3m@piout.net>
CC: <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <roy.chenjun@hisilicon.com>,
        <colin.king@canonical.com>, <wanghao24@huawei.com>
From: YiPing Xu <xuyiping@hisilicon.com>
Message-ID: <b13fabbb-fe2e-b3a3-6e8e-c42b8bab063c@hisilicon.com>
Date: Thu, 21 Sep 2017 14:45:17 +0800
MIME-Version: 1.0
In-Reply-To: <20170920091617.j7sie3mrncjkcj3m@piout.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On 2017/9/20 17:16, Alexandre Belloni wrote:
> Hi,
>
> On 20/09/2017 at 11:22:31 +0800, Xu Yiping wrote:
>> From: Xu YiPing  <xuyiping@hisilicon.com>
>>
>> After commit 2b2f5ff00f63 ("rtc: interface: ignore expired timers when
>> enqueuing new timers"), the rtc_timer_enqueue will not reprogram the RTC
>> when there is any non-expired timers in the timerqueue. If we set a
>> RTC_TIMER between now and the next non-expired timers, it won't go into
>> effect in time.
>>
>> So, besides ignoring the expired timers, we should take the next effect
>> timer into account, and reprogram the RTC timer appropriately.
>>
>
> Can you try this patch instead? I think it solves this issue:
> http://patchwork.ozlabs.org/patch/792482/

    We've tested this patch, it works too.

    Will it be merged into the main tree?

>> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
>> Signed-off-by: Chen Jun <roy.chenjun@hisilicon.com>
>> ---
>>  drivers/rtc/interface.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>> index 8cec9a0..e237166 100644
>> --- a/drivers/rtc/interface.c
>> +++ b/drivers/rtc/interface.c
>> @@ -766,20 +766,23 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
>>  	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
>>  	struct rtc_time tm;
>>  	ktime_t now;
>> +	ktime_t next_effect = KTIME_MAX;
>>
>>  	timer->enabled = 1;
>>  	__rtc_read_time(rtc, &tm);
>>  	now = rtc_tm_to_ktime(tm);
>>
>> -	/* Skip over expired timers */
>> +	/* Skip over expired timers, get next effect timer */
>>  	while (next) {
>> -		if (next->expires >= now)
>> +		if (next->expires >= now) {
>> +			next_effect = next->expires;
>>  			break;
>> +		}
>>  		next = timerqueue_iterate_next(next);
>>  	}
>>
>>  	timerqueue_add(&rtc->timerqueue, &timer->node);
>> -	if (!next) {
>> +	if (timer->node.expires < next_effect) {
>>  		struct rtc_wkalrm alarm;
>>  		int err;
>>  		alarm.time = rtc_ktime_to_tm(timer->node.expires);
>> --
>> 2.7.4
>>
>
