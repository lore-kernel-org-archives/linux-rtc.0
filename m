Return-Path: <rtc-linux+bncBDJLF25T6MIBBA5PWCVQKGQELXOYADQ@googlegroups.com>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net. [194.109.24.24])
        by gmr-mx.google.com with ESMTPS id k10si490189wia.1.2015.06.01.01.27.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 01:27:47 -0700 (PDT)
Message-ID: <1433147260.2361.25.camel@x220>
Subject: [rtc-linux] Re: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE
 for NTP synchronization
From: Paul Bolle <pebolle@tiscali.nl>
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro
 Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, linux-cris-kernel@axis.com, Mikael Starvik
 <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Xunlei Pang
 <pang.xunlei@linaro.org>
Date: Mon, 01 Jun 2015 10:27:40 +0200
In-Reply-To: <1432910778-314-1-git-send-email-xlpang@126.com>
References: <1432910778-314-1-git-send-email-xlpang@126.com>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, 2015-05-29 at 22:46 +0800, Xunlei Pang wrote:
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig

>  config RTC_HCTOSYS_DEVICE
>  	string "RTC used to set the system time"
> -	depends on RTC_HCTOSYS = y || RTC_SYSTOHC = y
> +	depends on RTC_HCTOSYS = y

RTC_HCTOSYS and RTC_SYSTOHC are bool symbols. The "= y" test is not
needed and the common idiom is to use only
	depends on RTC_HCTOSYS

Since you're touching this you might as well switch to that idiom.

>  	default "rtc0"
>  	help
>  	  The RTC device that will be used to (re)initialize the system
> 	  minutes if userspace reports synchronized NTP status.

> +config RTC_SYSTOHC_DEVICE
> +	string "RTC used to synchronize NTP adjustment"
> +	depends on RTC_SYSTOHC = y

Likewise.

> +	default "rtc0"
> +	help
> +	  The RTC device used for NTP synchronization. The main difference
> +	  between RTC_HCTOSYS_DEVICE and RTC_SYSTOHC_DEVICE is that this
> +	  one can sleep when setting time, because it runs in the workqueue
> +	  context.


Paul Bolle

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
