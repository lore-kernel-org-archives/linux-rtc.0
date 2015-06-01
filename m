Return-Path: <rtc-linux+bncBDEKVJM7XAHRBUPOWKVQKGQEGVSVCXY@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id ec7si552558wib.3.2015.06.01.12.49.36
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:49:37 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <pang.xunlei@linaro.org>, Herbert Valerio Riedel <hvr@gnu.org>
Subject: [rtc-linux] Re: [PATCH RESEND 2/3] drivers/rtc/isl1208: Replace
 deprecated rtc_tm_to_time()
Date: Mon, 01 Jun 2015 21:49:24 +0200
Message-ID: <2324798.u1fgEdZHfl@wuerfel>
In-Reply-To: <1432911877-607-2-git-send-email-xlpang@126.com>
References: <1432911877-607-1-git-send-email-xlpang@126.com> <1432911877-607-2-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Friday 29 May 2015 23:04:36 Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> isl1208_i2c_set_alarm() uses deprecated rtc_tm_to_time(),
> which will overflow in year 2106 on 32-bit machines.
> 
> This patch solves this by:
>  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
> 
> Cc: Herbert Valerio Riedel <hvr@gnu.org>
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> ---
>  drivers/rtc/rtc-isl1208.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

The patch looks correct, but I wonder if this is the best solution.
The only use of the two time values in the function is in the
'alarm_secs <= rtc_secs' comparison.

Maybe we should introduce an 'rtc_tm_before' helper function that
performs the same check? Do other drivers use the same piece
of code as this one?

	Arnd

> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index c3c549d..06113e8 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -370,19 +370,16 @@ isl1208_i2c_set_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
>  	struct rtc_time *alarm_tm = &alarm->time;
>  	u8 regs[ISL1208_ALARM_SECTION_LEN] = { 0, };
>  	const int offs = ISL1208_REG_SCA;
> -	unsigned long rtc_secs, alarm_secs;
> +	time64_t rtc_secs, alarm_secs;
>  	struct rtc_time rtc_tm;
>  	int err, enable;
>  
>  	err = isl1208_i2c_read_time(client, &rtc_tm);
>  	if (err)
>  		return err;
> -	err = rtc_tm_to_time(&rtc_tm, &rtc_secs);
> -	if (err)
> -		return err;
> -	err = rtc_tm_to_time(alarm_tm, &alarm_secs);
> -	if (err)
> -		return err;
> +
> +	rtc_secs = rtc_tm_to_time64(&rtc_tm);
> +	alarm_secs = rtc_tm_to_time64(alarm_tm);
>  
>  	/* If the alarm time is before the current time disable the alarm */
>  	if (!alarm->enabled || alarm_secs <= rtc_secs)
> 

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
