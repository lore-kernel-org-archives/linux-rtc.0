Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBVFOZO5AKGQELDRFXUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s140si503631wme.1.2016.06.04.06.27.47
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jun 2016 06:27:48 -0700 (PDT)
Date: Sat, 4 Jun 2016 15:27:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: interface: ignore exprired timers one
 enqueing new timers
Message-ID: <20160604132747.GI4594@piout.net>
References: <1463415774-28014-1-git-send-email-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1463415774-28014-1-git-send-email-colin.king@canonical.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 16/05/2016 at 17:22:54 +0100, Colin King wrote :
> From: Colin Ian King <colin.king@canonical.com>
> 
> This patch fixes a RTC wakealarm issue, namely, the event fires during
> hibernate and is not cleared from the list, causing hwclock to block.
> 
> The current enqueuing does not trigger an alarm if any expired timers
> already exist on the timerqueue. This can occur when a RTC wake alarm
> is used to wake a machine out of hibernate and the resumed state has
> old expired timers that have not been removed from the timer queue.
> This fix skips over any expired timers and triggers an alarm if there
> are no pending timers on the timerqueue. Note that the skipped expired
> timer will get repead later on, so there is no need to clean it up
> immediately.
> 
> The issue can be reproduced by putting a machine into hibernate and
> waking it with the RTC wakealarm.  Running the example RTC test program
> from tools/testing/selftests/timers/rtctest.c after the hibernate will
> block indefinitely.  With the fix, it no longer blocks after the
> hibernate resume.
> 
> BugLink: http://bugs.launchpad.net/bugs/1333569
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/interface.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
Applied, thanks.

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
