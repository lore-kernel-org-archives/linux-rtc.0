Return-Path: <rtc-linux+bncBCQPVKWLVAIRBD6OVTCQKGQEN7NVUUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id 14si841788wmn.2.2017.02.20.09.27.42
        for <rtc-linux@googlegroups.com>;
        Mon, 20 Feb 2017 09:27:42 -0800 (PST)
Date: Mon, 20 Feb 2017 09:27:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: cpcap: new rtc driver
Message-ID: <20170220172737.GJ21809@atomide.com>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170220073535.27393-2-sre@kernel.org>
 <20170220163155.GH21809@atomide.com>
 <20170220163858.4ocqnfhei67wbtl3@piout.net>
 <20170220172103.GI21809@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170220172103.GI21809@atomide.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Tony Lindgren <tony@atomide.com> [170220 09:21]:
> * Alexandre Belloni <alexandre.belloni@free-electrons.com> [170220 08:40]:
> > On 20/02/2017 at 08:31:56 -0800, Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@kernel.org> [170219 23:37]:
> > > > This driver supports the Motorola CPCAP PMIC found on
> > > > some of Motorola's mobile phones, such as the Droid 4.
> > > 
> > > Hey that's cool, works for me for reading and setting date :)
> > > Just noticed one thing, see below.
> > > 
> > > > +Requires node properties:
> > > > +- compatible: should contain "motorola,cpcap-rtc"
> > > > +- interrupts: An interrupt specifier for alarm and 1 Hz irq
> > > > +
> > > > +Example:
> > > > +
> > > > +cpcap_rtc: rtc {
> > > > +	compatible = "motorola,cpcap-rtc";
> > > > +	interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
> > > > +};
> > > 
> > > I tried rtcwake -s 3, but got the following:
> > > 
> > > rtcwake: cannot open /sys/class/rtc/rtc0/device/power/wakeup:
> > > No such file or directory
> > > rtcwake: /dev/rtc0 not enabled for wakeup events
> > > 
> > > Then tried adding "wakeup-source" to above but I think the driver
> > > needs something, maybe probably just PM ops?
> > > 
> > 
> > Probably device_init_wakeup(dev, 1) ?
> 
> That gets us a bit closer but now produces:
> 
> rtcwake: write error

Oh user error.. It needs to be done with:

# rtcwake -s 3 -m mem

And with the addition of device_init_wakeup(dev, 1) to the probe
it works for me. So Sebastian, with that change, please feel free
to add:

Tested-by: Tony Lindgren <tony@atomide.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
