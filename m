Return-Path: <rtc-linux+bncBDIYTLXUW4BRBNGZYGVAKGQERM3MGSI@googlegroups.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com. [209.85.212.174])
        by gmr-mx.google.com with ESMTPS id p12si367466wiv.1.2015.05.11.01.47.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 01:47:47 -0700 (PDT)
Received: by mail-wi0-f174.google.com with SMTP id di4so96270024wid.0
        for <rtc-linux@googlegroups.com>; Mon, 11 May 2015 01:47:47 -0700 (PDT)
Message-ID: <55506CB0.2030909@linaro.org>
Date: Mon, 11 May 2015 10:47:44 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>, Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, devicetree@vger.kernel.org, tglx@linutronix.de,
 wim@iguana.be, a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
 rtc-linux@googlegroups.com, linux@roeck-us.net
Subject: [rtc-linux] Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>	 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>	 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>	 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1> <1431085625.13593.39.camel@x220>
In-Reply-To: <1431085625.13593.39.camel@x220>
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

On 05/08/2015 01:47 PM, Paul Bolle wrote:
> On Fri, 2015-05-08 at 11:29 +0100, Lee Jones wrote:
>> Ah, you mean from menuconfig.  I almost forgot what that was. ;)
>>
>> I can add a menu option, no problem.
>
> It's not just menuconfig:
>      $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config
>      CONFIG_ARCH_STI=3Dy
>      CONFIG_CLKSRC_ST_LPC=3Dy
>      CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=3Dy
>      $ vim .config
>      $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config
>      CONFIG_ARCH_STI=3Dy
>      # CONFIG_CLKSRC_ST_LPC is not set
>      # CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK is not set
>      $ make ARCH=3Darm silentoldconfig
>      scripts/kconfig/conf  --silentoldconfig Kconfig
>      #
>      # configuration written to .config
>      #
>      $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config
>      CONFIG_ARCH_STI=3Dy
>      CONFIG_CLKSRC_ST_LPC=3Dy
>      CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=3Dy
>
> So I think that, if you want to be able to set
> CLKSRC_ST_LPC_TIMER_SCHED_CLOCK to 'n' even though CLKSRC_ST_LPC is 'y',
> you need to add a prompt. Or have you found a way around this?

The general policy is to have non-prompted options in the clocksource's=20
Kconfig and let the platform's config to select the right components.


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
