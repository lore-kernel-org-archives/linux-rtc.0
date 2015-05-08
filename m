Return-Path: <rtc-linux+bncBDA7X7F2WUEBB26JWGVAKGQEYS3J7YI@googlegroups.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com. [209.85.212.179])
        by gmr-mx.google.com with ESMTPS id bc3si384959wib.2.2015.05.08.00.25.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 00:25:31 -0700 (PDT)
Received: by widdi4 with SMTP id di4so17435921wid.0
        for <rtc-linux@googlegroups.com>; Fri, 08 May 2015 00:25:31 -0700 (PDT)
Date: Fri, 8 May 2015 08:25:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 06/12] watchdog: bindings:
 Supply knowledge of a third supported device - clocksource
Message-ID: <20150508072527.GI16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150507191909.GC16220@x1>
 <20150507195529.GA28554@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150508064918.GF16220@x1>
 <20150508071604.GA2232@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150508071604.GA2232@griffinp-ThinkPad-X1-Carbon-2nd>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, 08 May 2015, Peter Griffin wrote:
> On Fri, 08 May 2015, Lee Jones wrote:
> > > > > > =20
> > > > > > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-l=
pc"
> > > > > > -				  "st,stih415-lpc" "st,stid127-lpc"
> > > > > > +- compatible 	: Must be one of: "st,stih407-lpc"
> > > > >=20
> > > > > The same comment as the RTC DT patch, you are removing the compat=
ibles
> > > > > documentation for the other supported platforms like stih416-lpc.
> > > > > AFAIK they are required in the driver to get the correct sysconfi=
g register.
> > > >=20
> > > > That's intentional.  I haven't yet tested any of this IP on
> > > > STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not even
> > > > sure if this IP even exists on some of the other platforms.  I will
> > > > add them back when support is added to both driver and DTB and I've
> > > > been able to test them.
> > >=20
> > > That was kind of my point, the driver code AFAIK already contains sup=
port
> > > for these SoC's.
> > >=20
> > > I would either expect the patch to remove support from the DT docs AN=
D the
> > > driver, or leave it as is.
> > >=20
> > > It seems odd to only change the DT docs, and become unaligned to the
> > > code (this assumes I'm looking at the latest patchset here=20
> > > https://lkml.org/lkml/2015/3/4/1088 which includes support for these =
SoCs).
> >=20
> > The decision to remove these 'supported' platforms was made on the RTC
> > side, where there is only support for "st,stih407-lpc" in the driver.
>=20
> The change makes sense in the RTC case then.
>=20
> > I thought it best to mirror that thought over to the Watchdog LPC
> > bindings,
>=20
> Why? This is the bit I disagree with, the wdt DT docs IMHO should match t=
he wdt
> driver code.

Fair enough.  I'll add the 'supported' compatibles back in.

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
