Return-Path: <rtc-linux+bncBAABBZ7F3SWQKGQEDPPY32Q@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.113])
        by gmr-mx.google.com with ESMTPS id jv9si27392wid.0.2015.07.28.00.44.38
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 00:44:38 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
CC: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>, DEVICETREE
	<devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, "David Dajun
 Chen" <david.chen@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>,
	"Support Opensource" <Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH V3 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
Date: Tue, 28 Jul 2015 07:44:36 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B25C564@SW-EX-MBX02.diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws> <20150728054024.GA4558@dtor-ws>
 <20150728074234.GM21114@x1>
In-Reply-To: <20150728074234.GM21114@x1>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



On 28 July 2015 08:43 Lee Jones wrote:
> To: Dmitry Torokhov
> Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for DA9062 OnKey
> 
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
> > > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36
> ++++++++++++++++++++++
> > > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> > >
> > > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > > 9063, folded into the onkey patch and applied.
> >
> > Argh, da9062 core is not in mainline yet... OK, below is the patch I
> > had; if Lee does not pick it up I'll re-apply it when da9062 core hits
> > mainline.
> 
> I guess all 3 patches should be taken though one tree?  Happy to take
> them through MFD if that's okay with you.

Thanks Lee!
(please ignore my other e-mail ;)
Regards,
Stephen

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
