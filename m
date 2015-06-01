Return-Path: <rtc-linux+bncBDEKVJM7XAHRBQXQWKVQKGQEUCXHHFY@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id ec7si553002wib.3.2015.06.01.12.53.38
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:53:38 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <pang.xunlei@linaro.org>, Carlo Caione <carlo.caione@gmail.com>
Subject: [rtc-linux] Re: [PATCH RESEND 3/3] drivers/rtc/sunxi: Replace
 deprecated rtc_tm_to_time()
Date: Mon, 01 Jun 2015 21:53:03 +0200
Message-ID: <3461238.S8UhmYfQDn@wuerfel>
In-Reply-To: <1432911877-607-3-git-send-email-xlpang@126.com>
References: <1432911877-607-1-git-send-email-xlpang@126.com> <1432911877-607-3-git-send-email-xlpang@126.com>
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

On Friday 29 May 2015 23:04:37 Xunlei Pang wrote:
>         }
>  
> -       rtc_tm_to_time(alrm_tm, &time_set);
> -       rtc_tm_to_time(&tm_now, &time_now);
> +       time_set = rtc_tm_to_time64(alrm_tm);
> +       time_now = rtc_tm_to_time64(&tm_now);
>         if (time_set <= time_now) {
>                 dev_err(dev, "Date to set in the past\n");
>                 return -EINVAL;
>         }
>  
> +       if (time_set > time_now + 255 * SEC_IN_DAY) {
> +               dev_err(dev, "Day must be in the range 0 - 255\n");
> +               return -EINVAL;
> +       }
> +
> 

So this driver also uses the two values just to do a comparison
and to take the difference in seconds.

If we have a helper function that returns the difference between
two rtc_tm values as a time64_t, we can use that for both
this driver and isl1208.

	Arnd

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
