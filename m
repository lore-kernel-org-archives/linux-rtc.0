Return-Path: <rtc-linux+bncBCH4V2OOTYHBBKVVTHFQKGQETJO4Q6Q@googlegroups.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id r131si3666307wmd.2.2017.07.12.10.21.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 10:21:45 -0700 (PDT)
Received: by mail-wm0-x241.google.com with SMTP id u23so182223wma.2
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 10:21:45 -0700 (PDT)
Date: Wed, 12 Jul 2017 19:20:17 +0200 (CEST)
From: "'Hans Ulli Kroll' via rtc-linux" <rtc-linux@googlegroups.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
cc: linaro-kernel@lists.linaro.org,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
    linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2 11/22] rtc: gemini: stop using rtc
 deprecated functions
In-Reply-To: <1499846682-14093-12-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <alpine.LNX.2.00.1707121915310.8002@T420s>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org> <1499846682-14093-12-git-send-email-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Benjamin,

On Wed, 12 Jul 2017, Benjamin Gaignard wrote:

> @@ -93,12 +93,12 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
>  	unsigned int sec, min, hour, day;
> -	unsigned long offset, time;
> +	unsigned long long offset, time;
>  
>  	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
>  		return -EINVAL;
>  
> -	rtc_tm_to_time(tm, &time);
> +	time = rtc_tm_to_time64(tm);
>  
>  	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>  	min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);

later on this will do

	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);

you are writing some 64bit value in a 32bit register ...

NACK here

Greetings from Cologne
Hans Ulli Kroll

> 1.9.1
> 
> 
