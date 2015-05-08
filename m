Return-Path: <rtc-linux+bncBDA7X7F2WUEBBB4HWKVAKGQEAN5KOEA@googlegroups.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com. [209.85.212.178])
        by gmr-mx.google.com with ESMTPS id m3si36277wia.1.2015.05.08.02.36.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 02:36:07 -0700 (PDT)
Received: by wiun10 with SMTP id n10so20812494wiu.1
        for <rtc-linux@googlegroups.com>; Fri, 08 May 2015 02:36:07 -0700 (PDT)
Date: Fri, 8 May 2015 10:36:03 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Subject: [rtc-linux] Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
Message-ID: <20150508093603.GB29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
 <1431074699.13593.4.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431074699.13593.4.camel@x220>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, 08 May 2015, Paul Bolle wrote:
> On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
>=20
> > +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> > +	bool
> > +	depends on CLKSRC_ST_LPC
> > +	default y
> > +	help
> > +	  Use Low Power controller timer clock source as sched_clock
>=20
> This adds, as far as I can see, a Kconfig symbol that will always be in
> lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
> CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be 'y'.
>=20
> Are there plans to break that lockstep in the future?

What's stopping CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=3Dn?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
