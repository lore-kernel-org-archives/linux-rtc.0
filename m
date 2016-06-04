Return-Path: <rtc-linux+bncBCL4FNGB7UHBBVERZS5AKGQERLMARMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id n132si724709ywb.1.2016.06.04.09.59.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 09:59:00 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id l185so5628276qkc.2
        for <rtc-linux@googlegroups.com>; Sat, 04 Jun 2016 09:59:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160604144626.GM4594@piout.net>
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com> <20160604144626.GM4594@piout.net>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date: Sat, 4 Jun 2016 18:58:59 +0200
Message-ID: <CABFtUbQ7OWChggMPxYfpUeVCdTTtM74YpkqTF3--RT+wWkPoWQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, matthew.garrett@nebula.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-06-04 16:46 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 01/06/2016 at 17:40:14 +0200, Gabriele Mazzotta wrote :
>> If the system wakes up because of a wake alarm, the internal state
>> of the alarm is not updated. As consequence, the state no longer
>> reflects the actual state of the hardware and setting a new alarm
>> is not possible until the expired alarm is cleared.
>>
>
> I'm not completely sure to understand what is happening but could you
> check whether that one is solved by
> 2b2f5ff00f63847d95adad6289bd8b05f5983dd5 in my tree (rtc-next).
>

I picked 2b2f5ff00f63847d95adad6289bd8b05f5983dd5 and applied it
on top of 4.7-rc1, but that didn't fix the problem.

Let me explain the problem by showing you how I reproduce it:

root@localhost:~# cat /proc/driver/rtc | grep alarm_IRQ
alarm_IRQ       : no
root@localhost:~# echo +10 > /sys/class/rtc/rtc0/wakealarm
root@localhost:~# echo mem > /sys/power/state  # wait for auto-resume
root@localhost:~# echo +10 > /sys/class/rtc/rtc0/wakealarm
bash: echo: write error: Device or resource busy
root@localhost:~# cat /proc/driver/rtc | grep alarm_IRQ
alarm_IRQ       : yes

To set another alarm, I have to first write 0 to wakealarm. After that
I can set what I want. This doesn't happen if the alarm fires while
the system is awake, it happens only if the system is suspended and
the alarm wakes it.

I actually forgot to say that maybe this problem is not limited
to rtc-cmos and that maybe a general solution could be used.

I've just looked better into what is causing this and the problem
seems to be caused by the fact that rtc_timer_do_work() is not
executed if the timer expires while the system is suspended.

The following solves this particular problem:

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 74fd974..80d6a12 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -102,6 +102,9 @@ static int rtc_resume(struct device *dev)
     struct timespec64    sleep_time;
     int err;

+    /* A timer might have expired while suspended */
+    schedule_work(&rtc->irqwork);
+
     if (timekeeping_rtc_skipresume())
         return 0;


> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
