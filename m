Return-Path: <rtc-linux+bncBDJLF25T6MIBB4HJYGVAKGQEGQUUDHI@googlegroups.com>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net. [194.109.24.24])
        by gmr-mx.google.com with ESMTPS id k2si380261wif.0.2015.05.11.02.22.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 02:22:56 -0700 (PDT)
Message-ID: <1431336170.2398.73.camel@x220>
Subject: [rtc-linux] Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
From: Paul Bolle <pebolle@tiscali.nl>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@stlinux.com,
 devicetree@vger.kernel.org,  tglx@linutronix.de, wim@iguana.be,
 a.zummo@towertech.it,  linux-watchdog@vger.kernel.org,
 rtc-linux@googlegroups.com, linux@roeck-us.net
Date: Mon, 11 May 2015 11:22:50 +0200
In-Reply-To: <55506CB0.2030909@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
		 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
		 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
		 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1>
	 <1431085625.13593.39.camel@x220> <55506CB0.2030909@linaro.org>
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

On Mon, 2015-05-11 at 10:47 +0200, Daniel Lezcano wrote:
> The general policy is to have non-prompted options in the clocksource's 
> Kconfig and let the platform's config to select the right components.

If you want to stick to that policy here there's no reason to add
CLKSRC_ST_LPC_TIMER_SCHED_CLOCK in this patch. It currently adds
nothing, as it will always be equal to whatever value CLKSRC_ST_LPC will
have, right?


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
