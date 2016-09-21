Return-Path: <rtc-linux+bncBCU73AEHRQBBBBX4RG7QKGQEUTOGC7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtprelay.hostedemail.com (smtprelay0082.hostedemail.com. [216.40.44.82])
        by gmr-mx.google.com with ESMTPS id u125si2690865itc.0.2016.09.21.05.33.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 05:33:09 -0700 (PDT)
Date: Wed, 21 Sep 2016 08:33:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Alessandro Zummo
 <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Ingo Molnar <mingo@redhat.com>,
 John Stultz <john.stultz@linaro.org>, Mark Brown <broonie@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] time: alarmtimer: Add the trcepoints for alarmtimer
Message-ID: <20160921083305.24524304@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.20.1609210919390.5573@nanos>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
	<0d5cedb2f4ad46aa7fb07b990072bacb33517102.1474177609.git.baolin.wang@linaro.org>
	<alpine.DEB.2.20.1609202340560.5476@nanos>
	<CAMz4kuLYkyZzs33VKmo9B3JxTFFDYun7AHBYUUmHz=424yiq8g@mail.gmail.com>
	<alpine.DEB.2.20.1609210919390.5573@nanos>
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

On Wed, 21 Sep 2016 09:26:20 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > As suggested by Steven, change the type of RTC value to save trace buffer.  

The original code did everything just like the above but stored every
value into ints, I just said that the value could be stored in chars to
save space.

> 
> A single u64 does not take more storage space than this and it's a single
> store.

So to use rtc_tm_to_time64()? Is the work to do the calculations of the
conversion faster than a bunch of stores that are going to be in hot
cache?

-- Steve

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
