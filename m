Return-Path: <rtc-linux+bncBAABBJFWRC2QKGQE6C7FQZY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si638444pac.2.2016.01.22.04.05.55
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Jan 2016 04:05:55 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 03/10] rtc: max77686: Use usleep_range()
 instead of msleep()
To: Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-4-git-send-email-javier@osg.samsung.com>
 <56A1F935.2040904@nvidia.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A21B1D.8030303@osg.samsung.com>
Date: Fri, 22 Jan 2016 09:05:49 -0300
MIME-Version: 1.0
In-Reply-To: <56A1F935.2040904@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Laxman,

On 01/22/2016 06:41 AM, Laxman Dewangan wrote:
>
> On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
>>       RTC_SEC = 0,
>> @@ -130,7 +130,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
>>                   __func__, ret, data);
>>       else {
>>           /* Minimum 16ms delay required before RTC update. */
>> -        msleep(MAX77686_RTC_UPDATE_DELAY);
>> +        usleep_range(MAX77686_RTC_UPDATE_DELAY,
>> +                 MAX77686_RTC_UPDATE_DELAY * 2);
>>       }
>>
>
> Instead of making usleep_range(16000, 32000), can we make small range as
> usleep_range(16000, 17000)?
>

Yes, I also didn't know how to make the delay smaller. If I do for example

usleep_range(delay, delay + 10000), then the 10000 delta would be too big
for max77802 (50 times the minimum required 200 delay).

So I used delay * 2 for two reasons:

1) That way is generic enough and can work for any delay

2) My understanding is that most of times the delay should be precise and
    is not that bad if sometimes the delay is the worst case (2 * X) since
    after all the delay is the minimum required.

I also see that usleep_range(X, X * 2) is a used pattern across the kernel.

> I am using as usleep_range(16000, 16000) always.

According to Documentation/timers/timers-howto.txt, that's not a good
idea since usleep_range() is implemented using high-resolution timers
so by not using a range, the kernel won't be able to merge the wakeup
with other wakeups which leads to much more interrupts being triggered.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
