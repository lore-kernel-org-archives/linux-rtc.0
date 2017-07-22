Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42588 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGVV6x (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 22 Jul 2017 17:58:53 -0400
Date: Sat, 22 Jul 2017 23:58:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: elseifthen@gmx.com
Cc: rtc <linux-rtc@vger.kernel.org>
Subject: Re: Hardware specific rtc regression in v4.4.76
Message-ID: <20170722215851.ezxptqxetju44hgo@piout.net>
References: <S1752256AbdGFSzp/20170706185546Z+86@vger.kernel.org>
 <5c2ebf93-e45b-bc2d-e13b-618fdc12b3f3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c2ebf93-e45b-bc2d-e13b-618fdc12b3f3@gmx.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

Thanks for the report.

On 06/07/2017 at 15:16:11 -0400, elseifthen@gmx.com wrote:
> There appears to be a hardware specific rtc regression in v4.4.76.
> 
> Introduced in v4.4.52 by:
> 
> commit f0414c1f8bb7a4e69064296f460773170c5435ac
> Author: Colin Ian King <colin.king@canonical.com>
> Date:   Mon May 16 17:22:54 2016 +0100
> 
>     rtc: interface: ignore expired timers when enqueuing new timers
>     
>     commit 2b2f5ff00f63847d95adad6289bd8b05f5983dd5 upstream.
> 
>  8< ---
> 
> The problem does not appear to be in v4.9.x kernels.
> 
> Maybe v4.4.76 is missing one of these?
> http://marc.info/?l=linux-rtc&m=149489307123605&w=2
> Which also includes the commit in question.
> 
> See this thread for more details:
> https://www.linuxquestions.org/questions/slackware-14/slow-hwclock-systohc-on-reboot-shutdown-4175609040/
> 
> Note: I am not the one having this issue. I'm only reporting it, so any
> questions would need to be asked in the above thread. Or perhaps the
> person with the problem will follow this email thread. I will post a
> link to it for them.
> 

I can see a small issue with f0414c1f8bb7a4e69064296f460773170c5435ac
but I'm not sure why it would be hit on v4.4 and not v4.9.

Maybe one has CONFIG_RTC_INTF_DEV_UIE_EMUL and not the other one.

Could you try with the following on top of v4.4.57 (or any other
v4.4.x):

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -764,7 +764,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc,
struct rtc_timer *timer)
        }
 
        timerqueue_add(&rtc->timerqueue, &timer->node);
-       if (!next) {
+       if (!next || ktime_before(timer->node.expires, next->expires)) {
                struct rtc_wkalrm alarm;
                int err;
                alarm.time = rtc_ktime_to_tm(timer->node.expires);



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
