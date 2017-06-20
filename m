Return-Path: <rtc-linux+bncBDKNBMNKRMJRBH65UTFAKGQE7TW46XQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qt0-x22f.google.com (mail-qt0-x22f.google.com. [2607:f8b0:400d:c0d::22f])
        by gmr-mx.google.com with ESMTPS id y7si938423ywd.8.2017.06.20.07.18.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 07:18:07 -0700 (PDT)
Received: by mail-qt0-x22f.google.com with SMTP id u12so134450171qth.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 07:18:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD9700F@SW-EX-MBX02.diasemi.com>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-15-git-send-email-benjamin.gaignard@linaro.org> <6ED8E3B22081A4459DAC7699F3695FB7018CD9700F@SW-EX-MBX02.diasemi.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 20 Jun 2017 16:18:06 +0200
Message-ID: <CA+M3ks5cr3PEKnr3sT9KaA2VkqkrnAhoN7XfOr8vJX2T1CRGQw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 14/51] rtc: da9063: stop using rtc deprecated functions
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	Support Opensource <Support.Opensource@diasemi.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2017-06-20 15:41 GMT+02:00 Steve Twiss <stwiss.opensource@diasemi.com>:
> Hi Benjamin,
>
> On 20 June 2017 10:35, Benjamin Gaignard wrote:
>
>> Subject: [PATCH 14/51] rtc: da9063: stop using rtc deprecated functions
>
> Probably this subject should be "rtc: da9052" not 63.

yes you are right this patch is for da9052

>
>> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
>> rely on 32bits variables and that will make rtc break in y2038/2016.
>> Stop using those two functions to safer 64bits ones.
>>
> [...]
>
>> ---
>>  drivers/rtc/rtc-da9052.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
>> index 4273377..99a0489 100644
>> --- a/drivers/rtc/rtc-da9052.c
>> +++ b/drivers/rtc/rtc-da9052.c
>> @@ -104,17 +104,15 @@ static int da9052_read_alarm(struct da9052_rtc
>> *rtc, struct rtc_time *rtc_tm)
>>  static int da9052_set_alarm(struct da9052_rtc *rtc, struct rtc_time *rtc_tm)
>>  {
>>       struct da9052 *da9052 = rtc->da9052;
>> -     unsigned long alm_time;
>> +     unsigned long long alm_time;
>>       int ret;
>>       uint8_t v[3];
>>
>> -     ret = rtc_tm_to_time(rtc_tm, &alm_time);
>> -     if (ret != 0)
>> -             return ret;
>> +     alm_time = rtc_tm_to_time64(rtc_tm);
>
> But they kind of use the same functions anyway.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/rtc.h?h=v4.12-rc6#n35
> And I think they they are abstracted on purpose.
>
> The DA9052/53 hardware can only handle alarms up to the end of 2063.

That is the hardware limits but I don't know if we should align
framework functions to
for each driver limitation or use 64 bits functions everywhere.
but this discussion is on going on another thread...
>
> Regards,
> Steve
>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
