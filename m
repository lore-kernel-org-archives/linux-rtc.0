Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49595 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdITJQW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Sep 2017 05:16:22 -0400
Date: Wed, 20 Sep 2017 11:16:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xu Yiping <xuyiping@hisilicon.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, roy.chenjun@hisilicon.com,
        colin.king@canonical.com, wanghao24@huawei.com
Subject: Re: [PATCH] rtc: interface: set the next alarm event appropriately
Message-ID: <20170920091617.j7sie3mrncjkcj3m@piout.net>
References: <1505877751-26566-1-git-send-email-xuyiping@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505877751-26566-1-git-send-email-xuyiping@hisilicon.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 20/09/2017 at 11:22:31 +0800, Xu Yiping wrote:
> From: Xu YiPing  <xuyiping@hisilicon.com>
> 
> After commit 2b2f5ff00f63 ("rtc: interface: ignore expired timers when
> enqueuing new timers"), the rtc_timer_enqueue will not reprogram the RTC
> when there is any non-expired timers in the timerqueue. If we set a
> RTC_TIMER between now and the next non-expired timers, it won't go into
> effect in time.
> 
> So, besides ignoring the expired timers, we should take the next effect
> timer into account, and reprogram the RTC timer appropriately.
> 

Can you try this patch instead? I think it solves this issue:
http://patchwork.ozlabs.org/patch/792482/

> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
> Signed-off-by: Chen Jun <roy.chenjun@hisilicon.com>
> ---
>  drivers/rtc/interface.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 8cec9a0..e237166 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -766,20 +766,23 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
>  	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
>  	struct rtc_time tm;
>  	ktime_t now;
> +	ktime_t next_effect = KTIME_MAX;
> 
>  	timer->enabled = 1;
>  	__rtc_read_time(rtc, &tm);
>  	now = rtc_tm_to_ktime(tm);
> 
> -	/* Skip over expired timers */
> +	/* Skip over expired timers, get next effect timer */
>  	while (next) {
> -		if (next->expires >= now)
> +		if (next->expires >= now) {
> +			next_effect = next->expires;
>  			break;
> +		}
>  		next = timerqueue_iterate_next(next);
>  	}
> 
>  	timerqueue_add(&rtc->timerqueue, &timer->node);
> -	if (!next) {
> +	if (timer->node.expires < next_effect) {
>  		struct rtc_wkalrm alarm;
>  		int err;
>  		alarm.time = rtc_ktime_to_tm(timer->node.expires);
> --
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
