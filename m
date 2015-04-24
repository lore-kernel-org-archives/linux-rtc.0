Return-Path: <rtc-linux+bncBCC6ZWOPXENRBLFW5CUQKGQEWC4J4QY@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id bc3si106994wib.2.2015.04.24.03.30.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Apr 2015 03:30:04 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH 2nd try] RTC/i.MX/DryICE: add recovery
 routines to the driver
Date: Fri, 24 Apr 2015 12:32:30 +0200
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 kernel@pengutronix.de,
 Alessandro Zummo <a.zummo@towertech.it>,
 linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de> <20150421232615.GD8539@piout.net>
In-Reply-To: <20150421232615.GD8539@piout.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201504241232.30104.jbe@pengutronix.de>
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

On Wednesday 22 April 2015 01:26:15 Alexandre Belloni wrote:
> On 14/04/2015 at 11:11:51 +0200, Juergen Borleis wrote :
> > 2nd try, this time with a cover letter... m(
> >
> > The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a
> > tamper monitor unit which can keep some keys. When it does its tamper
> > detection job
>
> Does it have more functions? I would say that it also holds some keys
> but I don't have a handy Freescale representative to contact ;)

Yes it can hold some keys and will delete them if it detects a security=20
violation via its tamper detection feature.

> I'm fine getting that unlocking done in the RTC driver but maybe in the
> future, it will be necessary to handle that in an MFD driver when adding
> support for the other functions.

This change set just makes the RTC work again. Observation was, *sometimes*=
 and=20
*somehow* this unit tends to lock even if no of these tamper detection=20
features were enabled nor the externals signals (to detect these security=20
violations) were used.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions               =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
