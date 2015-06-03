Return-Path: <rtc-linux+bncBDS7HNEFSALRB65GXWVQKGQEL4ZPURI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p12si110508wiv.1.2015.06.03.12.20.26
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Jun 2015 12:20:27 -0700 (PDT)
Date: Wed, 3 Jun 2015 21:20:26 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	rtc-linux@googlegroups.com, lkml <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 0/2] change "client->irq >= 0" to "client->irq
 > 0"
Message-ID: <20150603192026.GO1715@piout.net>
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
 <20150603110241.GK1715@piout.net>
 <CAE1zot+nb9dc=pUZBphf8yMKyUbNk98QTTcHsmy2b3677yzn+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAE1zot+nb9dc=pUZBphf8yMKyUbNk98QTTcHsmy2b3677yzn+A@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 03/06/2015 at 20:05:56 +0300, Octavian Purdila wrote :
> On Wed, Jun 3, 2015 at 2:02 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 03/06/2015 at 00:34:11 +0300, Octavian Purdila wrote :
> >> This fixes an issue introduces by commit dab472eb931b ("i2c / ACPI:
> >> Use 0 to indicate that device does not have interrupt assigned") where
> >> drivers will try to request IRQ 0 when no GpioInt is defined in ACPI.
> >>
> >> The same issue occurs when the device is instantiated via device tree
> >> with no IRQ, or from the i2c sysfs interface, even before the patch
> >> above.
> >>
> >> Linus, since the commit above was already merged in the GPIO tree,
> >> should these fixes be merged also via the GPIO tree (with ACKs from
> >> the others subsystem maintainers)?
> >>
> >
> > Side question, has it been considered that IRQ 0 is valid on some
> > platform and that means i2c devices will not be able to be wired to that
> > IRQ anymore? Though, I don't think there are any existing design that
> > does so.
> >
> 
> Device tree instantiation does not allow you to used IRQ 0 anyway. And
> here is what Linus said about this:
> 
> http://yarchive.net/comp/linux/no_irq.html

I'm pretty sure his point doesn't hold anymore 10 years later. I don't
believe ARM is "the small percentage of a small percentage of a small
percentage" anymore and it is probably more tested than it was at the
time. Anyway, I'm fine with the change, you can add my
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
for your v2.

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
