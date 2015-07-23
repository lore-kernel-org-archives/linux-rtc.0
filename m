Return-Path: <rtc-linux+bncBDS7HNEFSALRBH6XYOWQKGQEMHGDBKQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hm7si875364wib.0.2015.07.23.06.26.54
        for <rtc-linux@googlegroups.com>;
        Thu, 23 Jul 2015 06:26:54 -0700 (PDT)
Date: Thu, 23 Jul 2015 15:26:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v3 1/2] iio: fix drivers that consider 0 as a
 valid IRQ in client->irq
Message-ID: <20150723132653.GT2853@piout.net>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
 <1433512783-8183-2-git-send-email-octavian.purdila@intel.com>
 <CAE1zotJ_u+ysf+HkD=4=Nv_mJ-4++SZxjKGMRkbKzYzyunLJUg@mail.gmail.com>
 <CACRpkdYE2HG3Cm74Hg9jXy2FwvwveqpbJbwTPKvmOm6aR7BNmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CACRpkdYE2HG3Cm74Hg9jXy2FwvwveqpbJbwTPKvmOm6aR7BNmQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 23/07/2015 at 15:11:47 +0200, Linus Walleij wrote :
> On Thu, Jul 23, 2015 at 12:59 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
> > On Fri, Jun 5, 2015 at 4:59 PM, Octavian Purdila
> > <octavian.purdila@intel.com> wrote:
> >> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
> >> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
> >> change all driver's checks accordingly.
> >>
> >> The same issue occurs when the device is instantiated via device tree
> >> with no IRQ, or from the i2c sysfs interface, even before the patch
> >> above.
> >>
> >> [1] http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
> >>
> >> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Hi Jonathan,
> >
> > Does this look OK to you? If so, could you pleas ACK the patch so that
> > Linus can pick it up in its for-next branch if/when needed?
> 
> Me or Torvalds?
> 
> This looks more like a Wolfram patch to me if it should not
> go through IIO.
> 

The first cover letter had:

"Linus, since the commit above was already merged in the GPIO tree,
should these fixes be merged also via the GPIO tree (with ACKs from
the others subsystem maintainers)?"

I believe it was referring to you ;). I can take the rtc patch if you
don't plan to take it.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
