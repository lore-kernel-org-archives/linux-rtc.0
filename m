Date: Sat, 3 Oct 2015 14:25:40 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	kernel@pengutronix.de
Subject: Re: [PATCH] rtc: rtctest: enabling UIE for a chip that doesn't
 support it returns EINVAL
Message-ID: <20151003122540.GE10444@piout.net>
References: <20150916071545.GA28635@pengutronix.de>
 <1442387811-5384-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1442387811-5384-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-ID: <rtc-linux.googlegroups.com>

On 16/09/2015 at 09:16:51 +0200, Uwe Kleine-König wrote :
> Calling ioctl(..., RTC_UIE_ON, ...) without CONFIG_RTC_INTF_DEV_UIE_EMUL
> either ends in rtc_update_irq_enable if rtc->uie_unsupported is true
> or in __rtc_set_alarm in the if (!rtc->ops->set_alarm) branch. In both
> cases the return value is -EINVAL. So check for that one instead of
> ENOTTY.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  tools/testing/selftests/timers/rtctest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
