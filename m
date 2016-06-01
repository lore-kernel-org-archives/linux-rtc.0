Return-Path: <rtc-linux+bncBCL4FNGB7UHBB5EDXS5AKGQENB63FQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id l184si1537540wmg.2.2016.06.01.08.40.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 08:40:36 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id e3so7918950wme.2
        for <rtc-linux@googlegroups.com>; Wed, 01 Jun 2016 08:40:36 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH 2/2] rtc-cmos: Restore alarm after resume
Date: Wed,  1 Jun 2016 17:40:15 +0200
Message-Id: <1464795615-7748-2-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Some platform firmware may interfere with the RTC alarm over suspend,
resulting in the kernel and hardware having different ideas about system
state but also potentially causing problems with firmware that assumes the
OS will clean this case up.  This patch restores the RTC alarm on resume
to ensure that kernel and hardware are in sync.

The case we've seen is Intel Rapid Start, which is a firmware-mediated
feature that automatically transitions systems from suspend-to-RAM to
suspend-to-disk without OS involvement.  It does this by setting the RTC
alarm and a flag that indicates that on wake it should perform the
transition rather than re-starting the OS.  However, if the OS has set a
wakeup alarm that would wake the machine earlier, it refuses to overwrite
it and allows the system to wake instead.

This fails in the following situation:

1) User configures Intel Rapid Start to transition after (say) 15
minutes
2) User suspends to RAM. Firmware sets the wakeup alarm for 15 minutes
in the future
3) User resumes after 5 minutes. Firmware does not reset the alarm, and
as such it is still set for 10 minutes in the future
4) User suspends after 5 minutes. Firmware notices that the alarm is set
for 5 minutes in the future, which is less than the 15 minute transition
threshold. It therefore assumes that the user wants the machine to wake
in 5 minutes
5) System resumes after 5 minutes

The worst case scenario here is that the user may have put the system in a
bag between (4) and (5), resulting in it running in a confined space and
potentially overheating.  This seems reasonably important.  The Rapid
Start support code got added in 3.11, but it can be configured in the
firmware regardless of kernel support.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
This a rework of http://patchwork.ozlabs.org/patch/423494/.

I think rtc-cmos is the only timer that needs to be protected from unwated
firmware changes, but I'm not sure of this. This is enough to fix the
problem on my laptop.

 drivers/rtc/rtc-cmos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fd121e3..83fd4df 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -918,6 +918,9 @@ static void cmos_check_alarm(struct device *dev)
 		cmos->suspend_ctrl &= ~RTC_AIE;
 		rtc_set_alarm(cmos->rtc, &alarm);
 	}
+
+	/* The BIOS might have changed the alarm, restore it */
+	cmos_set_alarm(dev, &alarm);
 }
 
 static int cmos_resume(struct device *dev)
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
