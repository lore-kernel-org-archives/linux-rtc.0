Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6ORRO7QKGQEOR4D2CI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 82si2320589wmg.3.2016.09.21.13.09.28
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Sep 2016 13:09:28 -0700 (PDT)
Date: Wed, 21 Sep 2016 22:09:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH v4 2/2] rtc-cmos: Restore alarm after resume
Message-ID: <20160921200928.pq4ub7miunc33hxh@piout.net>
References: <20160919231244.6775-1-gabriele.mzt@gmail.com>
 <20160919231244.6775-2-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160919231244.6775-2-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/09/2016 at 01:12:44 +0200, Gabriele Mazzotta wrote :
> Some platform firmware may interfere with the RTC alarm over suspend,
> resulting in the kernel and hardware having different ideas about system
> state but also potentially causing problems with firmware that assumes the
> OS will clean this case up.  This patch restores the RTC alarm on resume
> to ensure that kernel and hardware are in sync.
> 
> The case we've seen is Intel Rapid Start, which is a firmware-mediated
> feature that automatically transitions systems from suspend-to-RAM to
> suspend-to-disk without OS involvement.  It does this by setting the RTC
> alarm and a flag that indicates that on wake it should perform the
> transition rather than re-starting the OS.  However, if the OS has set a
> wakeup alarm that would wake the machine earlier, it refuses to overwrite
> it and allows the system to wake instead.
> 
> This fails in the following situation:
> 
> 1) User configures Intel Rapid Start to transition after (say) 15
> minutes
> 2) User suspends to RAM. Firmware sets the wakeup alarm for 15 minutes
> in the future
> 3) User resumes after 5 minutes. Firmware does not reset the alarm, and
> as such it is still set for 10 minutes in the future
> 4) User suspends after 5 minutes. Firmware notices that the alarm is set
> for 5 minutes in the future, which is less than the 15 minute transition
> threshold. It therefore assumes that the user wants the machine to wake
> in 5 minutes
> 5) System resumes after 5 minutes
> 
> The worst case scenario here is that the user may have put the system in a
> bag between (4) and (5), resulting in it running in a confined space and
> potentially overheating.  This seems reasonably important.  The Rapid
> Start support code got added in 3.11, but it can be configured in the
> firmware regardless of kernel support.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/rtc/rtc-cmos.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
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
