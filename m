Date: Thu, 30 Apr 2015 01:28:24 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>, CIH <cih@coventive.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Andrew Christian <andrew.christian@hp.com>,
	Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()
 and rtc_time_to_tm()
Message-ID: <20150429232824.GC3242@piout.net>
References: <1429089611-29776-5-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429089611-29776-5-git-send-email-xlpang@126.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 15/04/2015 at 17:20:11 +0800, Xunlei Pang wrote :
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),
> which will overflow in year 2106 on 32-bit machines.
> 
> This patch solves this by:
>  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
>  - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
> 
> Cc: CIH <cih@coventive.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Andrew Christian <andrew.christian@hp.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> ---
>  drivers/rtc/rtc-sa1100.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> index b6e1ca0..625a320 100644
> --- a/drivers/rtc/rtc-sa1100.c
> +++ b/drivers/rtc/rtc-sa1100.c
> @@ -157,19 +157,14 @@ static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  
>  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> -	rtc_time_to_tm(RCNR, tm);
> +	rtc_time64_to_tm(RCNR, tm);
>  	return 0;
>  }
>  
>  static int sa1100_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
> -	unsigned long time;
> -	int ret;
> -
> -	ret = rtc_tm_to_time(tm, &time);
> -	if (ret == 0)
> -		RCNR = time;
> -	return ret;
> +	RCNR = rtc_tm_to_time64(tm);

For the same reason that Russell pointed in patch 4/5, this hides that
it doesn't work after 2106-02-07 06:28:16 as the register is still 32
bits.
I would prefer that you return an error in that case.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
