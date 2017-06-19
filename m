Return-Path: <rtc-linux+bncBCFLRKWERUHRBBEIT3FAKGQEXZPQJHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id s76si2811447wma.1.2017.06.19.00.57.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 00:57:56 -0700 (PDT)
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "john.stultz@linaro.org"
	<john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "a.zummo@towertech.it"
	<a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>
CC: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: st-lpc: make it robust against
 y2038/2106 bug
Date: Mon, 19 Jun 2017 07:57:48 +0000
Message-ID: <ba0475d6-b386-9bb9-0b3b-5a4568633e62@st.com>
References: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497621833-9942-4-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497621833-9942-4-git-send-email-benjamin.gaignard@linaro.org>
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

Hi Benjamin

On 06/16/2017 04:03 PM, Benjamin Gaignard wrote:
> Make driver use u64 variables and functions to be sure that
> it will support dates after year 2038.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   drivers/rtc/rtc-st-lpc.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index 74c0a33..82b0af1 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -99,7 +99,7 @@ static int st_rtc_read_time(struct device *dev, struct rtc_time *tm)
>   
>   	lpt = ((unsigned long long)lpt_msb << 32) | lpt_lsb;
>   	do_div(lpt, rtc->clkrate);
> -	rtc_time_to_tm(lpt, tm);
> +	rtc_time64_to_tm(lpt, tm);
>   
>   	return 0;
>   }
> @@ -107,13 +107,10 @@ static int st_rtc_read_time(struct device *dev, struct rtc_time *tm)
>   static int st_rtc_set_time(struct device *dev, struct rtc_time *tm)
>   {
>   	struct st_rtc *rtc = dev_get_drvdata(dev);
> -	unsigned long long lpt;
> -	unsigned long secs, flags;
> -	int ret;
> +	unsigned long long lpt, secs;
> +	unsigned long flags;
>   
> -	ret = rtc_tm_to_time(tm, &secs);
> -	if (ret)
> -		return ret;
> +	secs = rtc_tm_to_time64(tm);
>   
>   	lpt = (unsigned long long)secs * rtc->clkrate;
>   
> @@ -161,13 +158,13 @@ static int st_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>   {
>   	struct st_rtc *rtc = dev_get_drvdata(dev);
>   	struct rtc_time now;
> -	unsigned long now_secs;
> -	unsigned long alarm_secs;
> +	unsigned long long now_secs;
> +	unsigned long long alarm_secs;
>   	unsigned long long lpa;
>   
>   	st_rtc_read_time(dev, &now);
> -	rtc_tm_to_time(&now, &now_secs);
> -	rtc_tm_to_time(&t->time, &alarm_secs);
> +	now_secs = rtc_tm_to_time64(&now);
> +	alarm_secs = rtc_tm_to_time64(&t->time);
>   
>   	/* Invalid alarm time */
>   	if (now_secs > alarm_secs)
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
