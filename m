Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBONRSK6AKGQEXWVRX2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v14si143977wmf.0.2016.07.12.00.14.01
        for <rtc-linux@googlegroups.com>;
        Tue, 12 Jul 2016 00:14:01 -0700 (PDT)
Date: Tue, 12 Jul 2016 09:14:00 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Sudeep Holla <Sudeep.Holla@arm.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: isl12057: remove unused variables
Message-ID: <20160712071400.GT22202@piout.net>
References: <20160711214340.2574022-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160711214340.2574022-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

On 11/07/2016 at 23:42:57 +0200, Arnd Bergmann wrote :
> A cleanup patch introduced a harmless warning about now unused local variables:
> 
> drivers/rtc/rtc-isl12057.c: In function 'isl12057_rtc_read_alarm':
> drivers/rtc/rtc-isl12057.c:249:26: error: unused variable 'alarm_secs' [-Werror=unused-variable]
>   unsigned long rtc_secs, alarm_secs;
>                           ^~~~~~~~~~
> drivers/rtc/rtc-isl12057.c:249:16: error: unused variable 'rtc_secs' [-Werror=unused-variable]
>   unsigned long rtc_secs, alarm_secs;
>                 ^~~~~~~~
> drivers/rtc/rtc-isl12057.c:248:18: error: unused variable 'rtc_tm' [-Werror=unused-variable]
>   struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
>                   ^~~~~~
> 
> This removes the variables to shut up those warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4e30a585a343 ("rtc: isl12057: let the rtc core interpret the partial alarm")

I actually fixed it up in the patch yesterday.

> ---
>  drivers/rtc/rtc-isl12057.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
> index e0245fc6205e..0e7f0f52bfe4 100644
> --- a/drivers/rtc/rtc-isl12057.c
> +++ b/drivers/rtc/rtc-isl12057.c
> @@ -245,8 +245,7 @@ static int isl12057_rtc_update_alarm(struct device *dev, int enable)
>  static int isl12057_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  {
>  	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
> -	struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
> -	unsigned long rtc_secs, alarm_secs;
> +	struct rtc_time *alarm_tm = &alarm->time;
>  	u8 regs[ISL12057_A1_SEC_LEN];
>  	unsigned int ir;
>  	int ret;
> -- 
> 2.9.0
> 

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
