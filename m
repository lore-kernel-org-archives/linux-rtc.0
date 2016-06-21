Return-Path: <rtc-linux+bncBDKOBWPM5ABRB75FU65QKGQEKTKJHUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com. [2607:f8b0:4002:c05::232])
        by gmr-mx.google.com with ESMTPS id c2si3970177ywf.5.2016.06.21.16.51.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 16:51:27 -0700 (PDT)
Received: by mail-yw0-x232.google.com with SMTP id i12so28002613ywa.1
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 16:51:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160621213219.GC5809@piout.net>
References: <1466493519-11277-1-git-send-email-andrew.smirnov@gmail.com> <20160621213219.GC5809@piout.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 21 Jun 2016 16:51:26 -0700
Message-ID: <CAHQ1cqHyw8BXxpMVRmFTUP9HUy6TAau48wZc3=XJB8ZexuVkjw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 00/17] DS1341 support and code cleanup
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

>>
>> Andrey Smirnov (17):
>>   RTC: ds1307: Add DS1341 variant
>>   RTC: ds1307: Disable square wave and timers as default
>>   RTC: ds1307: Add devicetree bindings for DS1341
>>   RTC: ds1307: Add DS1341 specific power-saving options
>>   RTC: ds1307: Convert ds1307_can_wakeup_device into a predicate
>>   RTC: ds1307: Convert want_irq into a predicate
>
> I'll have to triple check that one, it breaks in thousand different
> ways, every time someone touches that code :)

Wouldn't you agree that this might be an indication that the code is a
bit convoluted and some cleanup is in order? ;-)

>
>>   RTC: ds1307: Move chip configuration into a separate routine
>>   RTC: ds1307: Move chip sanity checking into a separate routine
>
> I'm not sure about the cleanup in those two patches yet, It moves a lot
> of code and the readability improvement is not obvious

OK, I agree that this patch moves a lot of code, and can't really
argue with "not obvious" since that is subjective. Please let me know
what you decide and I'll change v3 appropriately.

Thanks,
Andrey

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
