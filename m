Return-Path: <rtc-linux+bncBDEKVJM7XAHRBHHNWKVQKGQE6MIFA3A@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id gt9si556561wib.2.2015.06.01.12.46.36
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:46:36 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <pang.xunlei@linaro.org>, alexandre.belloni@free-electrons.com
Subject: [rtc-linux] Re: [PATCH RESEND 1/3] drivers/rtc/pcf8563: Replace
 deprecated rtc_time_to_tm() and rtc_tm_to_time()
Date: Mon, 01 Jun 2015 21:46:29 +0200
Message-ID: <2840029.d0aORC2jsD@wuerfel>
In-Reply-To: <1432911877-607-1-git-send-email-xlpang@126.com>
References: <1432911877-607-1-git-send-email-xlpang@126.com>
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

On Friday 29 May 2015 23:04:35 Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> pcf8563_rtc_set_alarm() uses deprecated rtc_tm_to_time()
> and rtc_time_to_tm(), which will overflow in year 2106
> on 32-bit machines.
> 
> This patch solves this by:
>  - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
>  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
> 
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>

(adding alexandre to Cc)

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>


>  drivers/rtc/rtc-pcf8563.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 0ba7e59..5f87f84 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -363,13 +363,13 @@ static int pcf8563_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	unsigned char buf[4];
>  	int err;
> -	unsigned long alarm_time;
>  
>  	/* The alarm has no seconds, round up to nearest minute */
>  	if (tm->time.tm_sec) {
> -		rtc_tm_to_time(&tm->time, &alarm_time);
> -		alarm_time += 60-tm->time.tm_sec;
> -		rtc_time_to_tm(alarm_time, &tm->time);
> +		time64_t alarm_time = rtc_tm_to_time64(&tm->time);
> +
> +		alarm_time += 60 - tm->time.tm_sec;
> +		rtc_time64_to_tm(alarm_time, &tm->time);
>  	}
>  
>  	dev_dbg(dev, "%s, min=%d hour=%d wday=%d mday=%d "
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
