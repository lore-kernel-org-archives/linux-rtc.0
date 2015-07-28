Return-Path: <rtc-linux+bncBDP6N55ZUYDRBVXT32WQKGQET2RIH6I@googlegroups.com>
Received: from mail-pd0-x241.google.com (mail-pd0-x241.google.com. [2607:f8b0:400e:c02::241])
        by gmr-mx.google.com with ESMTPS id ct6si3878901pdb.1.2015.07.28.10.20.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 10:20:22 -0700 (PDT)
Received: by mail-pd0-x241.google.com with SMTP id v4so7530361pda.1
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 10:20:22 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:20:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20150728172018.GB19610@dtor-ws>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
 <20150728084019.GM14943@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150728084019.GM14943@x1>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jul 28, 2015 at 09:40:19AM +0100, Lee Jones wrote:
> On Mon, 27 Jul 2015, Dmitry Torokhov wrote:
> 
> > On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > > From: S Twiss <stwiss.opensource@diasemi.com>
> > > > 
> > > > Add device tree bindings for the DA9062 OnKey driver component
> > > > 
> > > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > > 
> > > > ---
> > > > Changes in V3:
> > > >  - Child driver specifics separated out into separate document
> > > >    in this case ../input/da9062-onkey.txt
> > > > Changes in V2:
> > > >  - No change
> > > > 
> > > > This patch applies against linux-next and next-20150708 
> > > > 
> > > > 
> > > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++++++++++++++++
> > > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> > > 
> > > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > > 9063, folded into the onkey patch and applied.
> > 
> > Argh, da9062 core is not in mainline yet... OK, below is the patch I
> > had; if Lee does not pick it up I'll re-apply it when da9062 core hits
> > mainline.
> 
> Hmm... that's annoying.  You've put the patch below your signature
> '--', so my mailer cuts it off.

OK, sorry, I'll make sure to put in before the signature next time.

> 
> [pasting]
> 
> > Input: add DA9062 OnKey capability to DA9063 OnKey driver
> > 
> > From: S Twiss <stwiss.opensource@diasemi.com>
> > 
> > Add DA9062 OnKey support into the existing DA9063 OnKey driver component by
> > using generic access tables for common register and bit mask definitions.
> > 
> > The following change will add generic register and bit mask support to the
> > DA9063 OnKey.
> > 
> > The following alterations have been made to the DA9063 OnKey:
> > 
> > - Addition of a da906x_chip_config structure to hold all
> >   generic registers and bitmasks for this type of OnKey component.
> > - Addition of an struct of_device_id table for DA9063 and DA9062
> >   defaults
> > - Refactoring functions to use struct da9063_onkey accesses to generic
> >   registers/masks instead of using defines from registers.h
> > - Re-work of da9063_onkey_probe() to use of_match_node() and
> >   dev_get_regmap() to provide initialisation of generic registers and
> >   masks and access to regmap
> > 
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  .../devicetree/bindings/input/da9062-onkey.txt     |   32 +++++
> >  drivers/input/misc/Kconfig                         |    8 +
> >  drivers/input/misc/da9063_onkey.c                  |  129 ++++++++++++++++----
> >  3 files changed, 140 insertions(+), 29 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
>  
> I'm confused.  What's the dependency?
> 
> There shouldn't be any issue applying input patches, just because
> there isn't an MFD counterpart.  In fact, I would take prior
> acceptance of the child into consideration (would be like a +1 vote)
> when reviewing the MFD part.

It's this chunk:

+#include <linux/mfd/da9062/core.h>
+#include <linux/mfd/da9062/registers.h>

and these header files are not in mainline yet.

> 
> One suggestion however, I would ask for the DT binding and the driver
> to be separated, as per [0].
> 
> [0] Documentation/devicetree/bindings/submitting-patches.txt

Right, but that says about submitting patches, not applying them ;)

When I chatted with Grant he said that the policy of separating binding
and code into separate patches is done so not to overwhelm devicetree
list and that is is perfectly fine to actually apply them as a single
commit. I try to combine them together so that when looking through
history they show up as one.

Thanks.

-- 
Dmitry

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
