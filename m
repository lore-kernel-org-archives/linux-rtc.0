Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45883 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeH1M4q (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 28 Aug 2018 08:56:46 -0400
Subject: Re: [PATCH] rtc: rtc-omap: Replace mdelay() with msleep() in
 omap_rtc_power_off()
To: Johan Hovold <johan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: j-keerthy@ti.com, a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180730135314.9336-1-baijiaju1990@gmail.com>
 <20180827205517.GD24549@piout.net> <20180828084940.GA28861@localhost>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <72f42d57-90d1-83d5-3d1d-e82a2250a8ff@gmail.com>
Date: Tue, 28 Aug 2018 17:06:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180828084940.GA28861@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On 2018/8/28 16:49, Johan Hovold wrote:
> On Mon, Aug 27, 2018 at 10:55:17PM +0200, Alexandre Belloni wrote:
>> Hi,
>>
>> On 30/07/2018 21:53:14+0800, Jia-Ju Bai wrote:
>>> omap_rtc_power_off() is never called in atomic context.
>>> It calls mdelay() to busily wait, which is not necessary.
>>> mdelay() can be replaced with msleep().
>>>
>>> This is found by a static analysis tool named DCNS written by myself.
>>>
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> ---
>>>   drivers/rtc/rtc-omap.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>>> index 39086398833e..ef3d09525d0f 100644
>>> --- a/drivers/rtc/rtc-omap.c
>>> +++ b/drivers/rtc/rtc-omap.c
>>> @@ -476,7 +476,7 @@ static void omap_rtc_power_off(void)
>>>   	 * power off the system. Add a 500 ms margin for external latencies
>>>   	 * (e.g. debounce circuits).
>>>   	 */
>>> -	mdelay(2500);
>>> +	msleep(2500);
>> I'm not sure about that one because this is a poweroff function so it
>> doesn't really make sense to sleep versus busy waiting (all the drivers
>> in power/reset use mdelay())
> This power-off handler is called with interrupts disabled (as mentioned
> in the function header) and must not sleep.

Thanks for your reply :)

I check the code again, and find that you are right.
Sorry for my incorrect report.


Best wishes,
Jia-Ju Bai
