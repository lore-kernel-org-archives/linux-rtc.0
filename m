Return-Path: <rtc-linux+bncBDJLF25T6MIBB6MWWKVAKGQE6UHBCKY@googlegroups.com>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net. [194.109.24.22])
        by gmr-mx.google.com with ESMTPS id p12si277514wiv.1.2015.05.08.03.10.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 03:10:01 -0700 (PDT)
Message-ID: <1431079797.13593.28.camel@x220>
Subject: [rtc-linux] Re: [PATCH 02/12] clocksource: sti: Provide support for
 the ST LPC Clocksource IP
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
 tglx@linutronix.de, wim@iguana.be, a.zummo@towertech.it,
 linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
 linux@roeck-us.net
Date: Fri, 08 May 2015 12:09:57 +0200
In-Reply-To: <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
	 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
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

On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig

> +config CLKSRC_ST_LPC
> +	bool
> +	depends on ARCH_STI

By itself this does nothing. You can't set this symbol to 'y', even if
ARCH_STI is 'y', right? Of course, ARCH_STI will select this symbol (see
11/12) otherwise it would be inert. But as ARCH_STI selects
CLKSRC_ST_LPC I'd say this dependency isn't actually needed.

Are other selects of CLKSRC_ST_LPC expected to be added in the future?
If not, CLKSRC_ST_LPC should operate in lockstep with ARCH_STI. In that
case you might as well not bother with CLKSRC_ST_LPC and use ARCH_STI
directly. (But that forces you to move the select statement below into
the ARCH_STI entry, which might be ugly.)

> +	select CLKSRC_OF if OF
> +	help
> +	  Enable this option to use the Low Power controller timer
> +	  as clocksource.

(Please add an empty line.)

>  endmenu

Thanks,


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
