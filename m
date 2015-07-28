Return-Path: <rtc-linux+bncBDA7X7F2WUEBB3XE3SWQKGQEMDO2Y7A@googlegroups.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com. [209.85.212.180])
        by gmr-mx.google.com with ESMTPS id bk2si447983wib.1.2015.07.28.00.42.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 00:42:38 -0700 (PDT)
Received: by mail-wi0-f180.google.com with SMTP id gb10so143661809wic.1
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 00:42:38 -0700 (PDT)
Date: Tue, 28 Jul 2015 08:42:34 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: S Twiss <stwiss.opensource@diasemi.com>,
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
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V3 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
Message-ID: <20150728074234.GM21114@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150728054024.GA4558@dtor-ws>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 27 Jul 2015, Dmitry Torokhov wrote:

> On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > From: S Twiss <stwiss.opensource@diasemi.com>
> > >=20
> > > Add device tree bindings for the DA9062 OnKey driver component
> > >=20
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > >=20
> > > ---
> > > Changes in V3:
> > >  - Child driver specifics separated out into separate document
> > >    in this case ../input/da9062-onkey.txt
> > > Changes in V2:
> > >  - No change
> > >=20
> > > This patch applies against linux-next and next-20150708=20
> > >=20
> > >=20
> > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++++++=
++++++++++
> > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> >=20
> > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > 9063, folded into the onkey patch and applied.
>=20
> Argh, da9062 core is not in mainline yet... OK, below is the patch I
> had; if Lee does not pick it up I'll re-apply it when da9062 core hits
> mainline.

I guess all 3 patches should be taken though one tree?  Happy to take
them through MFD if that's okay with you.

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
