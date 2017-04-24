Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBAXG7DDQKGQEPYN45ZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id b84si857408wmh.2.2017.04.24.10.16.49
        for <rtc-linux@googlegroups.com>;
        Mon, 24 Apr 2017 10:16:49 -0700 (PDT)
Date: Mon, 24 Apr 2017 19:16:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: Rob Herring <robh@kernel.org>, rtc-linux <rtc-linux@googlegroups.com>,
	Devicetree List <devicetree@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1374: Add trickle charger device tree binding
Message-ID: <20170424171639.6vv5hxrejylloh3b@piout.net>
References: <1492468810-17224-1-git-send-email-mdf@kernel.org>
 <20170420155634.gs7qkufw7j4mfqpx@rob-hp-laptop>
 <20170420172538.GA13892@tyrael.amer.corp.natinst.com>
 <CAAtXAHfNuRXninLWySAOdtV99ih4PBt=JPszn3UkNa08OvXLFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAAtXAHfNuRXninLWySAOdtV99ih4PBt=JPszn3UkNa08OvXLFQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/04/2017 at 10:54:23 -0700, Moritz Fischer wrote:
> On Thu, Apr 20, 2017 at 10:25 AM, Moritz Fischer <mdf@kernel.org> wrote:
> > On Thu, Apr 20, 2017 at 10:56:34AM -0500, Rob Herring wrote:
> >> On Mon, Apr 17, 2017 at 03:40:10PM -0700, Moritz Fischer wrote:
> >> > Introduce a device tree binding for specifying the trickle charger
> >> > configuration for ds1374. This is based on the code for ds13390.
> >> >
> >> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >> > ---
> >> >  .../devicetree/bindings/rtc/dallas,ds1374.txt      | 18 ++++++++
> >> >  drivers/rtc/rtc-ds1374.c                           | 54 ++++++++++++++++++++++
> >> >  2 files changed, 72 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> >> > new file mode 100644
> >> > index 0000000..4cf5bd7
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> >> > @@ -0,0 +1,18 @@
> >> > +* Dallas DS1374            I2C Real-Time Clock / WDT
> >>
> >> Please remove from trivial-devices.txt, too. (which is moving in 4.12
> >> BTW)
> >
> > Ok, I'll redo this on top of b7e252fcddfa573bb1ee275b53bba6cef85671d4
> > (Documentation: devicetree: move trivial-devices out of I2C realm) then.
> 
> Follow up question, right now one selects between WDT and ALARM mode with
> a CONFIG_RTC_DRV_DS1374_WDT=y statically at compile time.
> 
> I'd like to add a 'dallas,mode = <DS1374_WDT>;' or
> dallas,enable-watchdog property
> to the binding, same goes for the ability to remap the WDT reset output to the
> interrupt pin (which is currently not supported, but my hardware needs this).
> 
> Would be the right way to add the remapping something like
> 'dallas,remap-reset-to-int' ?
> 
> Ideas? This change would obviously break people's setups where they
> select one or
> the other behavior via the build time option. Is that acceptable seen
> that relying on
> build time CONFIG_FOO seems like a bad assumption to begin with?
> 
> A bit of background: I currently started cleaning up a bunch of issues
> in this driver,
> like refactoring it to use the watchdog framework instead of open
> coding everything,
> make setting the timeout actually work (right now it the timeout to
> tick conversion is
> hosed).
> 

I think I would do something with MFD as you were suggesting on IRC. You
can have a look at the flexcom driver (atmel-flexcom.c) which is simply
selecting a mode and then using whatever IP driver already existed
(UART, I2C or SPI).

I didn't have a close look but maybe that fits. Then, as you are
concerned wtih backward compatibility, you could enforce the mode from
the MFD driver, depending on the CONFIG_RTC_DRV_DS1374_WDT value.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
