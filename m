Return-Path: <rtc-linux+bncBDP6N55ZUYDRB5PMWKVQKGQEK3FY2PA@googlegroups.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com. [2607:f8b0:4001:c05::233])
        by gmr-mx.google.com with ESMTPS id x12si986841igx.1.2015.06.01.12.45.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:45:57 -0700 (PDT)
Received: by mail-ig0-x233.google.com with SMTP id sb11so70278190igb.0
        for <rtc-linux@googlegroups.com>; Mon, 01 Jun 2015 12:45:57 -0700 (PDT)
Date: Mon, 1 Jun 2015 12:45:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhi Li <lznuaa@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"Frank.Li@freescale.com" <Frank.Li@freescale.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-input@vger.kernel.org, rtc-linux@googlegroups.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v5 0/6] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150601194552.GD30024@dtor-ws>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <20150527121052.GH16165@dragon>
 <20150528121353.GP2185@piout.net>
 <CAHrpEqShyPKeKYdVZ05_qsbx0cC387a2QPCdbhR5C968n=ED0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHrpEqShyPKeKYdVZ05_qsbx0cC387a2QPCdbhR5C968n=ED0A@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, May 28, 2015 at 08:18:24AM -0500, Zhi Li wrote:
> On Thu, May 28, 2015 at 7:13 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 27/05/2015 at 20:10:53 +0800, Shawn Guo wrote :
> >> On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li@freescale.com wrote=
:
> >> > Frank Li (5):
> >> >   rtc: arm: imx: snvs: change use syscon to access register
> >> >   Document: dt: fsl: snvs: change support syscon
> >> >   ARM: dts: imx: update snvs to use syscon access register
> >> >   Document: devicetree: input: imx: i.mx snvs power device tree bind=
ings
> >> >   ARM: dts: imx6sx: enable snvs power key
> >> >
> >> > Robin Gong (1):
> >> >   input: keyboard: imx: add snvs power key driver
> >>
> >> The series looks fine to me now.  But I can only apply those two dts
> >> patches after the driver and binding parts get landed on mainline.
> >> Hopefully, you can get them in during the coming merge window through
> >> subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
> >> out.
> >>
> >
> > Actually, I was thinking you could take the whole series in your tree
> > (at least, I'm speaking for the RTC part).
> > Else, I'm wondering who should take the documentation changes.
> >
>=20
> Dmitry Torokhov:
>=20
> what's your opinion about input part=EF=BC=9F

I am fine with it merged through Shawn's tree. I added my ack to the mail
in question.

Thanks.

--=20
Dmitry

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
