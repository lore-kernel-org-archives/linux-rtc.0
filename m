Return-Path: <rtc-linux+bncBDJLF25T6MIBBPGEWKVAKGQE7PEXRFI@googlegroups.com>
Received: from lb2-smtp-cloud6.xs4all.net (lb2-smtp-cloud6.xs4all.net. [194.109.24.28])
        by gmr-mx.google.com with ESMTPS id gt9si289647wib.2.2015.05.08.04.47.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 04:47:08 -0700 (PDT)
Message-ID: <1431085625.13593.39.camel@x220>
Subject: [rtc-linux] Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
 tglx@linutronix.de, wim@iguana.be, a.zummo@towertech.it,
 linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
 linux@roeck-us.net
Date: Fri, 08 May 2015 13:47:05 +0200
In-Reply-To: <20150508102938.GD29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
	 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
	 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
	 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1>
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

On Fri, 2015-05-08 at 11:29 +0100, Lee Jones wrote:
> Ah, you mean from menuconfig.  I almost forgot what that was. ;)
> 
> I can add a menu option, no problem.

It's not just menuconfig:
    $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config 
    CONFIG_ARCH_STI=y
    CONFIG_CLKSRC_ST_LPC=y
    CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=y
    $ vim .config 
    $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config 
    CONFIG_ARCH_STI=y
    # CONFIG_CLKSRC_ST_LPC is not set
    # CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK is not set
    $ make ARCH=arm silentoldconfig
    scripts/kconfig/conf  --silentoldconfig Kconfig
    #
    # configuration written to .config
    #
    $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config 
    CONFIG_ARCH_STI=y
    CONFIG_CLKSRC_ST_LPC=y
    CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=y

So I think that, if you want to be able to set
CLKSRC_ST_LPC_TIMER_SCHED_CLOCK to 'n' even though CLKSRC_ST_LPC is 'y',
you need to add a prompt. Or have you found a way around this?

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
