Return-Path: <rtc-linux+bncBDKZNNNLXAHBBA63S6VAKGQEXG3DB3I@googlegroups.com>
Received: from mail-vn0-x22a.google.com (mail-vn0-x22a.google.com. [2607:f8b0:400c:c0f::22a])
        by gmr-mx.google.com with ESMTPS id z9si272983vdj.0.2015.05.03.02.42.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 02:42:26 -0700 (PDT)
Received: by vnbg7 with SMTP id g7so12916447vnb.10
        for <rtc-linux@googlegroups.com>; Sun, 03 May 2015 02:42:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150503093953.GN12076@piout.net>
References: <1429791940-22169-1-git-send-email-k.kozlowski.k@gmail.com>
	<20150503093953.GN12076@piout.net>
Date: Sun, 3 May 2015 18:42:26 +0900
Message-ID: <CAJKOXPfTt_TSR69e78p7KUpAnbcz1ODX9GBB3cm4Dy+jbOxBXw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: interface: Fix coding style violations
From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-05-03 18:39 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 23/04/2015 at 21:25:39 +0900, Krzysztof Kozlowski wrote :
>> Fix issues reported by checkpatch:
>>   ERROR: open brace '{' following struct go on the same line
>>   ERROR: "foo* bar" should be "foo *bar"
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>> ---
>>  include/linux/rtc.h | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
>> index c8b68741994e..85b48b29a143 100644
>> --- a/include/linux/rtc.h
>> +++ b/include/linux/rtc.h
>> @@ -101,8 +101,7 @@ struct rtc_timer {
>>  /* flags */
>>  #define RTC_DEV_BUSY 0
>>
>> -struct rtc_device
>> -{
>> +struct rtc_device {
>>       struct device dev;
>>       struct module *owner;
>>
>> @@ -202,10 +201,10 @@ int rtc_register(rtc_task_t *task);
>>  int rtc_unregister(rtc_task_t *task);
>>  int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
>>
>> -void rtc_timer_init(struct rtc_timer *timer, void (*f)(void* p), void* data);
>> -int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer* timer,
>> +void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
>> +int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
>>                       ktime_t expires, ktime_t period);
>
> While at it, alignment here should match the open parenthesis.

Sure, I'll respin.

Best regards,
Krzysztof

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
