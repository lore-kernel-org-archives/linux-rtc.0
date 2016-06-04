Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBQ6TZO5AKGQEW42QGJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b77si305024wmb.0.2016.06.04.07.46.27
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jun 2016 07:46:27 -0700 (PDT)
Date: Sat, 4 Jun 2016 16:46:26 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
Message-ID: <20160604144626.GM4594@piout.net>
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 01/06/2016 at 17:40:14 +0200, Gabriele Mazzotta wrote :
> If the system wakes up because of a wake alarm, the internal state
> of the alarm is not updated. As consequence, the state no longer
> reflects the actual state of the hardware and setting a new alarm
> is not possible until the expired alarm is cleared.
> 

I'm not completely sure to understand what is happening but could you
check whether that one is solved by
2b2f5ff00f63847d95adad6289bd8b05f5983dd5 in my tree (rtc-next).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
