Return-Path: <rtc-linux+bncBDA7X7F2WUEBBFVAWKVAKGQEWFSILXA@googlegroups.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com. [74.125.82.54])
        by gmr-mx.google.com with ESMTPS id gt9si278316wib.2.2015.05.08.03.29.42
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 03:29:42 -0700 (PDT)
Received: by wgiu9 with SMTP id u9so68340595wgi.3
        for <rtc-linux@googlegroups.com>; Fri, 08 May 2015 03:29:42 -0700 (PDT)
Date: Fri, 8 May 2015 11:29:38 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Subject: [rtc-linux] Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
Message-ID: <20150508102938.GD29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
 <1431074699.13593.4.camel@x220>
 <20150508093603.GB29044@x1>
 <1431078730.13593.14.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431078730.13593.14.camel@x220>
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

> On Fri, 2015-05-08 at 10:36 +0100, Lee Jones wrote:
> > On Fri, 08 May 2015, Paul Bolle wrote:
> > > On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > >=20
> > > > +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> > > > +	bool
> > > > +	depends on CLKSRC_ST_LPC
> > > > +	default y
> > > > +	help
> > > > +	  Use Low Power controller timer clock source as sched_clock
> > >=20
> > > This adds, as far as I can see, a Kconfig symbol that will always be =
in
> > > lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
> > > CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be 'y=
'.
> > >=20
> > > Are there plans to break that lockstep in the future?
> >=20
> > What's stopping CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=3Dn?
>=20
> If CLKSRC_ST_LPC=3Dy you mean? The lack of a prompt, I'd say. Ie, you
> would need
> 	bool "A very short description"
>=20
> to be able to set these independently.
>=20
> But now I notice that I missed that there appears to be a problem with
> CLKSRC_ST_LPC too. I'll reply to 2/12 shortly.

Ah, you mean from menuconfig.  I almost forgot what that was. ;)

I can add a menu option, no problem.

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
