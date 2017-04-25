Return-Path: <rtc-linux+bncBC7M5BFO7YCRB5W773DQKGQEC7HOOOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id q63si2072236itq.3.2017.04.25.13.22.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 13:22:14 -0700 (PDT)
Date: Tue, 25 Apr 2017 13:22:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	linux-watchdog@vger.kernel.org, wim@iguana.be, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, alex.williams@ni.com
Subject: [rtc-linux] Re: [PATCH 0/2] DS1374 Watchdog fixes
Message-ID: <20170425202210.GA20929@roeck-us.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
 <CAJYdmeP+XEBPpUECO1rWpRDs-RVihc_va970jtv6iau3OuWMWA@mail.gmail.com>
 <20170425161743.GA8443@roeck-us.net>
 <20170425163204.rj6on6phtbfuvcd7@piout.net>
 <20170425165824.GA10024@roeck-us.net>
 <CAJYdmePpHcYgjiCf=eWCkBBNBTTw4jW59_VNR6w44Yj_QDQqng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAJYdmePpHcYgjiCf=eWCkBBNBTTw4jW59_VNR6w44Yj_QDQqng@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Apr 25, 2017 at 12:58:36PM -0700, Moritz Fischer wrote:
> On Tue, Apr 25, 2017 at 09:58:24AM -0700, Guenter Roeck wrote:
> 
> > Ah, I missed the "n" in various #ifndef statements.
> >
> > I can't really comment on how to solve that; I simply don't know.
> > Also, even with a dt property, it still would be necessary to have
> > a non-DT means to configure one or the other. Making whatever solution
> > backward compatible also seems tricky; I don't have a solution for that
> > problem either.
> 
> How does one do these things in a non-dt context? Platform data? I'd let

Platform data is out of favor. You'd probably want to use device properties
(see drivers/base/property.c). Question though is if this is considered
configuration, hardware description, or both. Presumably the watchdog
only makes sense if the reset signal is wired, and the alarm only makes
sense if the interrupt is wired, but what if both are wired ?

> the MFD select the 'mode'. Maybe being backwards compatible isn't
> possible in any case. Is there a rule somewhere that we guarantee you'll
> never have to change your CONFIG_FOO options?
> 

That would be nice, but no, there is no such rule. You can probably argue
that no published kernel configuration enables the watchdog flag,
so there is nothing to be concerned about.

Guenter

> >
> > > > > The idea was to fix what's broken currently (this patchset) and then refactor.
> > > > > But if you prefer I can do all in one go instead.
> > > > >
> > > >
> > > > It just seemed a waste to me to change/fix a function which is going to
> > > > be removed in a subsequent patch (I seem to recall that there was a fix
> > > > to the ioctl function).
> > > >
> > >
> > > I'd say that it depends on whether you want to backport the fixes to the
> > > stable kernels. Backporting the full rework is probably riskier.
> 
> I suck at communicating these days. But yeah. That was basically my
> concern when I split it up into 'Fixes' and 'Rework'.
> 
> Mostly since the rework might take a couple of rounds of review, while the
> fix can unbrick stuff (might still need review of course)
> 
> Cheers,
> 
> Moritz

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
