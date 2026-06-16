Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BED2C1595;
	Tue, 16 Jun 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575838; cv=none; b=cG4RVFPcIYdM5n074S7stOo1dgj+i+ieTmBITDZI4BbiImHrYav7LsyuupCYUpzjBB8FrSlebvBMJdi0WgMv94EzAvHA6LzCW/7izw5nJAvNTB1Cl7a+ja5JDLrcW+FahkAu6PWnNho8gMrj5Q8zA1FS28MQXDN1Jav85ER+eNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575838; c=relaxed/simple;
	bh=JagMF5pR6Y0MfZQxbvJMfqnzgc45ByvnJqRKDiZBiQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GsQbivmFTMt92lvhR51wpOu6g1XmyGejIAuFg5Zp47SG/rfQAgS/DHby0Vku/YtZO+HqQwJOhsjTBPQqdZv0zUsuaiTc8a8wy8L1JTyxYyduTj8rEaMqEdklnbXdw91tduJU72vtmjMtf5Q2uwKdb+bakx3VQYgYwKBp5J6QiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oVwHa8+G; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oVwHa8+G"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lCTqUFkmJcPkeSt7DLWWXh0/FepqoR9UbwigpZdt+34=;
	b=oVwHa8+G+zP7BrMgaRiTrnMC0Q3JYODqGSms8vC9kOUB8ZjGJpNJH59KcpD6Fe+qVmKV/194r
	P7ZkwtWh6V3no6rkpYtg92SLARsEC4yGo3juFkVak6XEoJjUbbutK5OmtDbg4BOv+XggCEI3Uy1
	zi/AfV5f3gPaUoS4Sd5TWBc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gfVcG5hQvzRhwj;
	Tue, 16 Jun 2026 10:02:22 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A2DB40569;
	Tue, 16 Jun 2026 10:10:20 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 10:10:19 +0800
Message-ID: <06cdb8b3-8a5d-4f1d-b686-6122fa6f7af9@huawei.com>
Date: Tue, 16 Jun 2026 10:10:19 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: interface: Add rtc time jump debug in
 rtc_timer_do_work()
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260525130825.954214-1-ruanjinjie@huawei.com>
 <2026061515223171f111f5@mail.local>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2026061515223171f111f5@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 6/15/2026 11:22 PM, Alexandre Belloni wrote:
> Hello,
> 
> On 25/05/2026 21:08:25+0800, Jinjie Ruan wrote:
>> In virtualization environments like QEMU [1], or during hardware
>> clocksource anomalies, an extreme time-warp event can occur. When
>> the system time abruptly jumps forward, the rtc_timer_do_work() handler
>> falls into a prolonged processing loop to clear accumulated historical
>> timers via timerqueue_getnext(). Running this loop indefinitely under
>> the rtc->ops_lock mutex triggers a kernel softlockup, stalling
>> the system.
>>
>> Introduce an adaptive telemetry and loop guard mechanism to enhance debug
>> visibility and prevent softlockups:
>>
>> 1. Record `start_jiffies` upon entry and leverage `time_after()` to
>>    check if the loop has monopolized the CPU for more than 1s (HZ). If so,
>>    the handler prints a telemetry warning, triggers a WARN stack dump, and
>>    breaks the loop to safely yield the CPU.
>>
>> 2. Track the execution via a `loop_count` metric. Printing this counter
>>    in the warning log provides vital diagnostics to distinguish
>>    an aggressive time-warp storm (high count) from a bogged-down callback
>>    bug (low count).
>>
>> 3. Utilize the kernel format specifier `%ptR` to convert the raw ktime
>>    into a human-readable timestamp (YYYY-MM-DD HH:MM:SS), allowing
>>    developers to instantly pinpoint the exact boundary of the time
>>    jump in dmesg.
>>
>> This non-destructive telemetry guard provides precise hardware/emulator
>> diagnostic visibility while ensuring core kernel availability.
>>
>> [1]: https://lore.kernel.org/all/20260114013257.3500578-1-ruanjinjie@huawei.com/
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/rtc/interface.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>> index 1906f4884a83..f6c5fd16cc4e 100644
>> --- a/drivers/rtc/interface.c
>> +++ b/drivers/rtc/interface.c
>> @@ -927,10 +927,12 @@ static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer)
>>   */
>>  void rtc_timer_do_work(struct work_struct *work)
>>  {
>> -	struct rtc_timer *timer;
>> +	unsigned long start_jiffies = jiffies;
>>  	struct timerqueue_node *next;
>> -	ktime_t now;
>> +	struct rtc_timer *timer;
>>  	struct rtc_time tm;
>> +	int loop_count = 0;
>> +	ktime_t now;
>>  	int err;
>>  
>>  	struct rtc_device *rtc =
>> @@ -945,6 +947,15 @@ void rtc_timer_do_work(struct work_struct *work)
>>  	}
>>  	now = rtc_tm_to_ktime(tm);
>>  	while ((next = timerqueue_getnext(&rtc->timerqueue))) {
>> +		loop_count++;
>> +
>> +		if (unlikely(time_after(jiffies, start_jiffies + HZ))) {
>> +			dev_warn(&rtc->dev, "RTC time jump (loop: %d) to %ptR.\n",
>> +				 loop_count, &tm);
>> +			WARN_ON_ONCE(1);
> 
> So, your issue is that it is too slow so you make it even slower? There
> are already plenty of tracepoints that allow proper debugging in this
> loop, I'm pretty sure we don't want to bloat the kernel with more
> messages.

Hi, Alexandre,

The point here is not about the performance of the rtc_timer_do_work()
loop — it’s about making the problem debuggable when things go wrong.
And we can put it under a debug Kconfig option, so production kernels
see no extra overhead at all.

The patch is installed in the following scenarios:

If the RTC hardware fails, or if the QEMU-emulated RTC device code in a
KVM virtual machine has a problem (for example, the x86 RTC emulation
hardware mc146818 has an overflow issue[1]), the time may jump as shown
in the log below, which can cause a soft lockup.

However, when the issue occurs, it is only possible to know that too
many pending timers have accumulated in the timerqueue (for example, the
log shows that tens of millions of timer nodes have been processed) by
temporarily adding diagnostic code in rtc_timer_do_work().

To determine whether the root cause is hardware, kernel RTC code, an RTC
driver issue, or an RTC hardware problem, more debugging is needed. But
if the problem is indeed caused by RTC hardware, adding a diagnostic
print of the current RTC time when the loop takes too long (as this
diagnostic patch does) would make it easy to tell whether QEMU or the
hardware is faulty.

[1]: https://lore.kernel.org/all/20260613195116.1807273-21-mjt@tls.msk.ru/

     kworker/0:1-37      [000] .N..   489.159634: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281423
     kworker/0:1-37      [000] .N..   489.159635: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281424
     kworker/0:1-37      [000] .N..   489.159635: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281425
     kworker/0:1-37      [000] .N..   489.159636: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281426
     kworker/0:1-37      [000] .N..   489.159637: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281427
     kworker/0:1-37      [000] .N..   489.159638: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281428
     kworker/0:1-37      [000] .N..   489.159638: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281429
     kworker/0:1-37      [000] .N..   489.159639: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281430
     kworker/0:1-37      [000] .N..   489.159640: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281431
     kworker/0:1-37      [000] .N..   489.159641: rtc_timer_do_work:
timerqueue_getnext handle timer node count: 13281432


   swapper/0-1       [001] .N..    11.579334: __rtc_read_time: rtc:
0xff11000109896800, ops->read_time:2026:01:05:09:36:21
       swapper/0-1       [001] .N..    11.579421: __rtc_read_time: rtc:
0xff11000109896800, ops->read_time:2026:01:05:09:36:21
       swapper/0-1       [001] .N..    11.579469: __rtc_read_time: rtc:
0xff11000109896800, ops->read_time:2026:01:05:09:36:21
       swapper/0-1       [001] .N..    11.580816: __rtc_read_time: rtc:
0xff11000109896800, ops->read_time:2026:01:05:09:36:21
  syz-executor.5-7492    [003] ....   129.807406: __rtc_read_time: rtc:
0xff11000109896800, ops->read_time:2033:05:04:07:03:51
  syz-executor.5-7492    [003] ....   129.807419:
__rtc_update_irq_enable.part.8: rtc uie on: 0xff11000109896800, now:
2033:05:04:07:03:51, expire: 2033:05:04:07:03:52


Best regards,
Jinjie

> 
> 

