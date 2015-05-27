Return-Path: <rtc-linux+bncBDIYTLXUW4BRBYPVS2VQKGQEN7VKNLY@googlegroups.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com. [209.85.212.175])
        by gmr-mx.google.com with ESMTPS id p9si684035wiz.3.2015.05.27.05.38.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 05:38:57 -0700 (PDT)
Received: by mail-wi0-f175.google.com with SMTP id mx19so109755987wic.0
        for <rtc-linux@googlegroups.com>; Wed, 27 May 2015 05:38:57 -0700 (PDT)
Message-ID: <5565BAE1.1000704@linaro.org>
Date: Wed, 27 May 2015 14:38:57 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, tglx@linutronix.de, wim@iguana.be,
 a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
 rtc-linux@googlegroups.com, linux@roeck-us.net
CC: kernel@stlinux.com
Subject: [rtc-linux] Re: [PATCH v2.1 02/12] clocksource: sti: Provide support
 for the ST LPC Clocksource IP
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org> <1431435500-22899-3-git-send-email-lee.jones@linaro.org> <20150526123943.GI11677@x1>
In-Reply-To: <20150526123943.GI11677@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 05/26/2015 02:39 PM, Lee Jones wrote:
> clocksource: sti: Provide support for the ST LPC Clocksource IP
>
> This IP is shared with Watchdog and RTC functionality.  All 3 of
> these devices are mutually exclusive from one another i.e. Only 1
> IP can be used at any given time.  We use the device-driver model
> combined with a DT 'mode' property to enforce this.
>
> The ST LPC Clocksource IP can be used as the system (tick) timer.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
