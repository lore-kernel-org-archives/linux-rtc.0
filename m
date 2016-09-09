Return-Path: <rtc-linux+bncBDAMN6NI5EERBLWPZS7AKGQEFWIWNTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de ([2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id w79si176363wmw.0.2016.09.09.08.17.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 08:17:07 -0700 (PDT)
Date: Fri, 9 Sep 2016 17:14:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
    rostedt@goodmis.org, mingo@redhat.com, john.stultz@linaro.org,
    broonie@kernel.org, linux-kernel@vger.kernel.org,
    rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: Add some dummy static inline functions
In-Reply-To: <1a8cf6da9924b566aef1d00a31414e46e7f7fb71.1473302325.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.20.1609091712120.5679@nanos>
References: <1a8cf6da9924b566aef1d00a31414e46e7f7fb71.1473302325.git.baolin.wang@linaro.org>
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

On Thu, 8 Sep 2016, Baolin Wang wrote:

> The patch (commit id: a0a6e06d545a753740c9d8d5ce2c4fdd3ab1c021) adding
> tracepoints for alarmtimers will build failed on S390 platform, due to
> S390 defconfig did not define CONFIG_RTC_LIB macro to define the
> rtc_ktime_to_tm() function which is used in this patch. Thus we should
> add dummy static inline functions in case CONFIG_RTC_LIB is not defined.

I doubt this is a good idea. It will paper over usage of rtc lib functions
in generic code which will then lead to weird results on builds with
RTC_LIB=n.

Johns variant of making it conditional in the tracepoint is way safer.

Thanks

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
