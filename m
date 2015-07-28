Return-Path: <rtc-linux+bncBDA7X7F2WUEBBWHY32WQKGQEQMNEXUA@googlegroups.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com. [209.85.212.178])
        by gmr-mx.google.com with ESMTPS id ec7si583441wib.3.2015.07.28.10.31.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 10:31:04 -0700 (PDT)
Received: by mail-wi0-f178.google.com with SMTP id xm9so167267011wib.0
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 10:31:04 -0700 (PDT)
Date: Tue, 28 Jul 2015 18:30:58 +0100
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
Message-ID: <20150728173058.GB2284@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
 <20150728084019.GM14943@x1>
 <20150728172018.GB19610@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150728172018.GB19610@dtor-ws>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 28 Jul 2015, Dmitry Torokhov wrote:

> On Tue, Jul 28, 2015 at 09:40:19AM +0100, Lee Jones wrote:
> > On Mon, 27 Jul 2015, Dmitry Torokhov wrote:
> >=20
> > > On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > > > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > > > From: S Twiss <stwiss.opensource@diasemi.com>
> > > > >=20
> > > > > Add device tree bindings for the DA9062 OnKey driver component
> > > > >=20
> > > > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > > >=20
> > > > > ---
> > > > > Changes in V3:
> > > > >  - Child driver specifics separated out into separate document
> > > > >    in this case ../input/da9062-onkey.txt
> > > > > Changes in V2:
> > > > >  - No change
> > > > >=20
> > > > > This patch applies against linux-next and next-20150708=20
> > > > >=20
> > > > >=20
> > > > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++=
++++++++++++++
> > > > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> > > >=20
> > > > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > > > 9063, folded into the onkey patch and applied.
> > >=20
> > > Argh, da9062 core is not in mainline yet... OK, below is the patch I
> > > had; if Lee does not pick it up I'll re-apply it when da9062 core hit=
s
> > > mainline.
> >=20
> > Hmm... that's annoying.  You've put the patch below your signature
> > '--', so my mailer cuts it off.
>=20
> OK, sorry, I'll make sure to put in before the signature next time.

Appreciated.

> > [pasting]
> >=20
> > > Input: add DA9062 OnKey capability to DA9063 OnKey driver
> > >=20
> > > From: S Twiss <stwiss.opensource@diasemi.com>
> > >=20
> > > Add DA9062 OnKey support into the existing DA9063 OnKey driver compon=
ent by
> > > using generic access tables for common register and bit mask definiti=
ons.
> > >=20
> > > The following change will add generic register and bit mask support t=
o the
> > > DA9063 OnKey.
> > >=20
> > > The following alterations have been made to the DA9063 OnKey:
> > >=20
> > > - Addition of a da906x_chip_config structure to hold all
> > >   generic registers and bitmasks for this type of OnKey component.
> > > - Addition of an struct of_device_id table for DA9063 and DA9062
> > >   defaults
> > > - Refactoring functions to use struct da9063_onkey accesses to generi=
c
> > >   registers/masks instead of using defines from registers.h
> > > - Re-work of da9063_onkey_probe() to use of_match_node() and
> > >   dev_get_regmap() to provide initialisation of generic registers and
> > >   masks and access to regmap
> > >=20
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  .../devicetree/bindings/input/da9062-onkey.txt     |   32 +++++
> > >  drivers/input/misc/Kconfig                         |    8 +
> > >  drivers/input/misc/da9063_onkey.c                  |  129 ++++++++++=
++++++----
> > >  3 files changed, 140 insertions(+), 29 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/da9062-on=
key.txt
> > =20
> > I'm confused.  What's the dependency?
> >=20
> > There shouldn't be any issue applying input patches, just because
> > there isn't an MFD counterpart.  In fact, I would take prior
> > acceptance of the child into consideration (would be like a +1 vote)
> > when reviewing the MFD part.
>=20
> It's this chunk:
>=20
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
>=20
> and these header files are not in mainline yet.

Ah, thanks for the clarification.

I will apply the other patches.

> > One suggestion however, I would ask for the DT binding and the driver
> > to be separated, as per [0].
> >=20
> > [0] Documentation/devicetree/bindings/submitting-patches.txt
>=20
> Right, but that says about submitting patches, not applying them ;)
>=20
> When I chatted with Grant he said that the policy of separating binding
> and code into separate patches is done so not to overwhelm devicetree
> list and that is is perfectly fine to actually apply them as a single
> commit. I try to combine them together so that when looking through
> history they show up as one.

Got you. :)

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
