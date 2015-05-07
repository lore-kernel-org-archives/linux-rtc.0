Return-Path: <rtc-linux+bncBDA7X7F2WUEBBA7WV2VAKGQEVKXRCUY@googlegroups.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com. [209.85.212.171])
        by gmr-mx.google.com with ESMTPS id t6si39798wiz.0.2015.05.07.12.20.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 12:20:35 -0700 (PDT)
Received: by wiun10 with SMTP id n10so3195772wiu.1
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 12:20:35 -0700 (PDT)
Date: Thu, 7 May 2015 20:20:31 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 12/12] ARM: STi: Update
 platform level menuconfig 'help'
Message-ID: <20150507192031.GD16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-13-git-send-email-lee.jones@linaro.org>
 <20150507141526.GB9793@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150507141526.GB9793@griffinp-ThinkPad-X1-Carbon-2nd>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 07 May 2015, Peter Griffin wrote:

> Hi Lee,
>=20
> On Thu, 07 May 2015, Lee Jones wrote:
>=20
> > Encompass newer STiH4{07,10} SoC based platforms.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/mach-sti/Kconfig | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> > index cb886de..59928d9 100644
> > --- a/arch/arm/mach-sti/Kconfig
> > +++ b/arch/arm/mach-sti/Kconfig
> > @@ -16,11 +16,9 @@ menuconfig ARCH_STI
> >  	select PL310_ERRATA_769419 if CACHE_L2X0
> >  	select RESET_CONTROLLER
> >  	help
> > -	  Include support for STiH41x SOCs like STiH415/416 using the device =
tree
> > -	  for discovery
> > -	  More information at Documentation/arm/STiH41x and
> > -	  at Documentation/devicetree
> > -
> > +	  Include support for STMicroelectronics' STiH415/416 and stih407/10
> > +	  family SoCs using the Device Tree for discovery.  More information
> > +	  can be found in Documentation/arm/sti/ & Documentation/devicetree.
>=20
> You should use the same capitalisation throughout.

Good spot, that was unintentional.  Will fix.

> Also you can mention STiH418, as that is now supported upstream.

Yep, thanks.

> Once fixed you can add my: -
>      Acked-by: Peter Griffin <peter.griffin@linaro.org>

Ta.

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
