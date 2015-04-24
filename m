Return-Path: <rtc-linux+bncBCC6ZWOPXENRBF5M5CUQKGQE4VSDOWY@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id k2si111733wif.0.2015.04.24.03.08.23
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Apr 2015 03:08:23 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH 1/5] RTC/i.MX/DryIce: add some background info
 about the states the machine can be in
Date: Fri, 24 Apr 2015 12:10:43 +0200
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Robert Schwebel <rsc@pengutronix.de>,
 kernel@pengutronix.de
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de> <1429002716-19821-2-git-send-email-jbe@pengutronix.de> <20150421220942.GB8539@piout.net>
In-Reply-To: <20150421220942.GB8539@piout.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201504241210.43768.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On Wednesday 22 April 2015 00:09:42 Alexandre Belloni wrote:
> [...]
> > ---
> >  drivers/rtc/rtc-imxdi.c | 43 +++++++++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> > index c666eab..8750477 100644
> > --- a/drivers/rtc/rtc-imxdi.c
> > +++ b/drivers/rtc/rtc-imxdi.c
> > @@ -129,6 +129,49 @@ struct imxdi_dev {
> >  	struct work_struct work;
> >  };
> >
> > +/* Some background:
> > + *
> > + * The DryIce unit is a complex security/tamper monitor device. To be =
able do
> > + * its job in a useful manner it runs a bigger statemachine to bring i=
t into
> > + * security/tamper failure state and once again to bring it out of thi=
s state.
> > + *=20
> > + * This unit can be in one of three states:
> > + *
> > + * - "NON-VALID STATE"
> > + *   always after the battery power was removed
> > + * - "FAILURE STATE"
> > + *   if one of the enabled security events have happend
>
>                                  has happened ^
>
> > + * - "VALID STATE"
> > + *   if the unit works as expected
> > + *
> > + * Everything stops when the unit enters the failure state including t=
he
> > RTC + * counter (to be able to detect the time the security event
> > happend).
>
>                                                        happened ^
> [...]

Thanks for the feedback. Fixed in the next version.

Regards,
Juergen
=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions               =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
