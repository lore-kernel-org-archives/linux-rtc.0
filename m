Return-Path: <rtc-linux+bncBDAMN6NI5EERBZOYQ27QKGQEFSPPN2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id w79si1644818wmw.0.2016.09.20.14.38.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 14:38:45 -0700 (PDT)
Date: Tue, 20 Sep 2016 23:36:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
    rostedt@goodmis.org, mingo@redhat.com, john.stultz@linaro.org,
    broonie@kernel.org, linux-kernel@vger.kernel.org,
    rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: Add some dummy static inline functions
In-Reply-To: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.20.1609202333220.5476@nanos>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, 18 Sep 2016, Baolin Wang wrote:

> The patch 2 in this patchset adding tracepoints for alarmtimers will build
> failed on S390 platform, due to S390 defconfig did not define CONFIG_RTC_LIB
> macro to define the rtc_ktime_to_tm() function which is used in this patch.
> Thus we should add some ummy static inline functions in case CONFIG_RTC_LIB
> is not defined.

I told you before that adding these inlines has the danger that we
introduce code which uses these functions in places which does not depend
on RTC_LIB. The resulting wreckage is going to be subtle and hard to debug.

This still stands and this patch is going nowhere.

Thanks,

	tglx

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
