Return-Path: <rtc-linux+bncBDA7X7F2WUEBBR7WV2VAKGQEYYSBI2I@googlegroups.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com. [209.85.212.180])
        by gmr-mx.google.com with ESMTPS id g5si324040wix.1.2015.05.07.12.21.43
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 12:21:43 -0700 (PDT)
Received: by wief7 with SMTP id f7so21089382wie.0
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 12:21:43 -0700 (PDT)
Date: Thu, 7 May 2015 20:21:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 08/12] rtc: bindings: Supply
 knowledge of a third supported device - clocksource
Message-ID: <20150507192139.GE16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-9-git-send-email-lee.jones@linaro.org>
 <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt | 15 +++++++++---=
---
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b/Doc=
umentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > index 73407f50..daf8826 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > @@ -1,20 +1,23 @@
> >  STMicroelectronics Low Power Controller (LPC) - RTC
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > =20
> > -LPC currently supports Watchdog OR Real Time Clock functionality.
> > +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> > +functionality.
> > =20
> >  [See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
> > +[See: ../timer/st,stih407-lpc for Clocksource options]
> > =20
> >  Required properties
> > =20
> > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > -				  "st,stih415-lpc" "st,stid127-lpc"
> > +- compatible 	: Must be: "st,stih407-lpc"
>=20
> You are removing the compatibles documentation for the other supported So=
C's like
> stih416-lpc stih415-lpc here.

It would be pretty difficult to do that by mistake. :)

See the comment I made to the Watchdog bindings patch for more info.

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
