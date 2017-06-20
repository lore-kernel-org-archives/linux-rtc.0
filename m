Return-Path: <rtc-linux+bncBAABB46LUTFAKGQE3U4RI7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.140])
        by gmr-mx.google.com with ESMTPS id i63si3719222wmf.0.2017.06.20.06.41.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 06:41:03 -0700 (PDT)
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	"Support Opensource" <Support.Opensource@diasemi.com>, Alessandro Zummo
	<a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH 14/51] rtc: da9063: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 13:41:01 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD9700F@SW-EX-MBX02.diasemi.com>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-15-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-15-git-send-email-benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Benjamin,

On 20 June 2017 10:35, Benjamin Gaignard wrote:

> Subject: [PATCH 14/51] rtc: da9063: stop using rtc deprecated functions

Probably this subject should be "rtc: da9052" not 63.

> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
> 
[...]

> ---
>  drivers/rtc/rtc-da9052.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
> index 4273377..99a0489 100644
> --- a/drivers/rtc/rtc-da9052.c
> +++ b/drivers/rtc/rtc-da9052.c
> @@ -104,17 +104,15 @@ static int da9052_read_alarm(struct da9052_rtc
> *rtc, struct rtc_time *rtc_tm)
>  static int da9052_set_alarm(struct da9052_rtc *rtc, struct rtc_time *rtc_tm)
>  {
>  	struct da9052 *da9052 = rtc->da9052;
> -	unsigned long alm_time;
> +	unsigned long long alm_time;
>  	int ret;
>  	uint8_t v[3];
> 
> -	ret = rtc_tm_to_time(rtc_tm, &alm_time);
> -	if (ret != 0)
> -		return ret;
> +	alm_time = rtc_tm_to_time64(rtc_tm);

But they kind of use the same functions anyway.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/rtc.h?h=v4.12-rc6#n35
And I think they they are abstracted on purpose.

The DA9052/53 hardware can only handle alarms up to the end of 2063.

Regards,
Steve

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
