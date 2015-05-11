Return-Path: <rtc-linux+bncBDA7X7F2WUEBB3UUYKVAKGQEKRKY4KI@googlegroups.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com. [209.85.212.171])
        by gmr-mx.google.com with ESMTPS id bc3si382464wib.2.2015.05.11.03.54.38
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 03:54:38 -0700 (PDT)
Received: by mail-wi0-f171.google.com with SMTP id n10so91473927wiu.1
        for <rtc-linux@googlegroups.com>; Mon, 11 May 2015 03:54:38 -0700 (PDT)
Date: Mon, 11 May 2015 11:54:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Subject: Re: [rtc-linux] [PATCH 07/12] rtc: st: Update IP layout information
 to include Clocksource
Message-ID: <20150511105433.GB20742@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-8-git-send-email-lee.jones@linaro.org>
 <20150509135854.GE3338@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150509135854.GE3338@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, 09 May 2015, Alexandre Belloni wrote:

> On 07/05/2015 at 14:38:39 +0100, Lee Jones wrote :
> > Initial submission adding support for this IP only included Watchdog an=
d
> > the Real-Time Clock.  Now the third (and final) device is enabled this
> > trivial patch is required to update the comment in the RTC driver to
> > encompass Clocksource.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks.

> I'm guessing this will go through the mfd tree along with the driver?

Yes, that is the plan, if that's okay with you?

> > ---
> >  drivers/rtc/rtc-st-lpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> > index 3f9d0ac..74c0a33 100644
> > --- a/drivers/rtc/rtc-st-lpc.c
> > +++ b/drivers/rtc/rtc-st-lpc.c
> > @@ -208,7 +208,7 @@ static int st_rtc_probe(struct platform_device *pde=
v)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	/* LPC can either run in RTC or WDT mode */
> > +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> >  	if (mode !=3D ST_LPC_MODE_RTC)
> >  		return -ENODEV;
> > =20
>=20

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
