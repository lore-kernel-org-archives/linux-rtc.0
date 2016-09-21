Return-Path: <rtc-linux+bncBCN63E7T2ALBBCGUQ67QKGQE5EZJIZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yb0-x22c.google.com (mail-yb0-x22c.google.com. [2607:f8b0:4002:c09::22c])
        by gmr-mx.google.com with ESMTPS id v21si2135438ywa.7.2016.09.20.19.01.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2016 19:01:44 -0700 (PDT)
Received: by mail-yb0-x22c.google.com with SMTP id x93so18280496ybh.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Sep 2016 19:01:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609202333220.5476@nanos>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
 <alpine.DEB.2.20.1609202333220.5476@nanos>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 21 Sep 2016 10:01:44 +0800
Message-ID: <CAMz4ku+2DFxhTqcqcv_5XXwPL20jAY3TW72j+3OFQdr5JtRupw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: Add some dummy static inline functions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, John Stultz <john.stultz@linaro.org>,
	Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 21 September 2016 at 05:36, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 18 Sep 2016, Baolin Wang wrote:
>
>> The patch 2 in this patchset adding tracepoints for alarmtimers will build
>> failed on S390 platform, due to S390 defconfig did not define CONFIG_RTC_LIB
>> macro to define the rtc_ktime_to_tm() function which is used in this patch.
>> Thus we should add some ummy static inline functions in case CONFIG_RTC_LIB
>> is not defined.
>
> I told you before that adding these inlines has the danger that we
> introduce code which uses these functions in places which does not depend
> on RTC_LIB. The resulting wreckage is going to be subtle and hard to debug.

Make sense. (By the way I am sorry I did not receive your previous
comments in my mailbox and I checked again I found it was treated as
spam.)

>
> This still stands and this patch is going nowhere.
>
> Thanks,
>
>         tglx



-- 
Baolin.wang
Best Regards

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
