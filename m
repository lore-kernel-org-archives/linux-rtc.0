Return-Path: <rtc-linux+bncBDRMFBMIXEGBBMWKTC6AKGQE4GNYFMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id w75si895371pfd.0.2016.07.13.04.25.38
        for <rtc-linux@googlegroups.com>;
        Wed, 13 Jul 2016 04:25:38 -0700 (PDT)
Date: Wed, 13 Jul 2016 12:25:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@lists.codethink.co.uk,
	linux-amlogic@lists.infradead.org, rtc-linux@googlegroups.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org, narmstrong@baylibre.com,
	khilman@baylibre.com
Subject: [rtc-linux] Re: [PATCH v3 2/4] meson-rtc: add device-tree binding
Message-ID: <20160713112525.GI14522@leverpostej>
References: <1467748122-14833-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467748122-14833-4-git-send-email-ben.dooks@codethink.co.uk>
 <5785D83C.2000809@gmail.com>
 <51411c13-8cb4-3623-f70e-03b4190655f2@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <51411c13-8cb4-3623-f70e-03b4190655f2@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jul 13, 2016 at 10:09:44AM +0100, Ben Dooks wrote:
> On 13/07/16 06:57, Frank Rowand wrote:
> > On 07/05/16 12:48, Ben Dooks wrote:
> >> Add documentation for the AMLogic Meson RTC.
> >>
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  .../devicetree/bindings/rtc/rtc-amlogic.txt         | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-amlogic.txt
> > 
> > Hi Ben,
> > 
> > I suspect you already know this since you have Rob's ack, but you need to
> > send bindings to
> > 
> >   Rob Herring <robh+dt@kernel.org>
> >   Mark Rutland <mark.rutland@arm.com>
> 
> Sorry, missed copying the email when sending.
> 
> I hope he's seen them from being on the devicetree@vger.kernel.org
> list? I've added him as an CC: on this one to check.

>From my perspective, having devicetree@vger.kernel.org alone is fine. I
appreciate tastes vary across maintainers, either way is fine by me. :)

You already have Rob's ack, which is sufficient, but FWIW the patch
looks fine, so feel free to add mine:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
