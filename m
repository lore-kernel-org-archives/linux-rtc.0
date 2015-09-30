Return-Path: <rtc-linux+bncBDA7X7F2WUEBBSMXV6YAKGQEPGTFK5Y@googlegroups.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com. [209.85.212.171])
        by gmr-mx.google.com with ESMTPS id bn1si5683wib.0.2015.09.30.04.47.21
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2015 04:47:21 -0700 (PDT)
Received: by mail-wi0-f171.google.com with SMTP id lk2so193871754wic.0
        for <rtc-linux@googlegroups.com>; Wed, 30 Sep 2015 04:47:21 -0700 (PDT)
Date: Wed, 30 Sep 2015 12:47:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>,
	DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V3 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
Message-ID: <20150930114717.GB27197@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
 <6ED8E3B22081A4459DAC7699F3695FB70173D121FD@SW-EX-MBX02.diasemi.com>
 <20150929235408.GC29469@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150929235408.GC29469@dtor-ws>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 29 Sep 2015, Dmitry Torokhov wrote:

> On Mon, Sep 28, 2015 at 08:19:27AM +0000, Opensource [Steve Twiss] wrote:
> >=20
> > > Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindi=
ngs for DA9062 OnKey
> > >=20
> > > On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > > > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > > > From: S Twiss <stwiss.opensource@diasemi.com>
> > > > >
> > > > > Add device tree bindings for the DA9062 OnKey driver component
> > > > >
> > > > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > > >
> > > > > ---
> > > > > Changes in V3:
> > > > >  - Child driver specifics separated out into separate document
> > > > >    in this case ../input/da9062-onkey.txt
> > > > > Changes in V2:
> > > > >  - No change
> > > > >
> > > > > This patch applies against linux-next and next-20150708
> > > > >
> > > > >
> > > > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36
> > > ++++++++++++++++++++++
> > > > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> > > >
> > > > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > > > 9063, folded into the onkey patch and applied.
> > >=20
> > > Argh, da9062 core is not in mainline yet... OK, below is the patch I
> > > had; if Lee does not pick it up I'll re-apply it when da9062 core hit=
s
> > > mainline.
> > >=20
> >=20
> > Hi Lee and Dmitry,
> >=20
> > This patch seems to have been missed. It is the main OnKey driver for D=
A9062 and this
> > component was waiting for the DA9062 MFD core to make it into linux-mai=
nline/v4.3-rc1.
> >=20
> > Is there any reply on this yet please? There just seems to be a little =
patch administration
> > problem holding things up.
>=20
> I queued it for 4.4.

Thanks Dmitry.

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
