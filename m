Return-Path: <rtc-linux+bncBC7M5BFO7YCRBGXU73DQKGQE7NAPXBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id j5si792232itb.1.2017.04.25.14.05.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:05:29 -0700 (PDT)
Date: Tue, 25 Apr 2017 14:05:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	linux-watchdog@vger.kernel.org, wim@iguana.be, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, alex.williams@ni.com
Subject: [rtc-linux] Re: [PATCH 0/2] DS1374 Watchdog fixes
Message-ID: <20170425210526.GA1629@roeck-us.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
 <CAJYdmeP+XEBPpUECO1rWpRDs-RVihc_va970jtv6iau3OuWMWA@mail.gmail.com>
 <20170425161743.GA8443@roeck-us.net>
 <20170425163204.rj6on6phtbfuvcd7@piout.net>
 <20170425165824.GA10024@roeck-us.net>
 <CAJYdmePpHcYgjiCf=eWCkBBNBTTw4jW59_VNR6w44Yj_QDQqng@mail.gmail.com>
 <20170425202210.GA20929@roeck-us.net>
 <20170425203418.GA5198@tyrael.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170425203418.GA5198@tyrael.amer.corp.natinst.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Apr 25, 2017 at 01:34:18PM -0700, Moritz Fischer wrote:
> On Tue, Apr 25, 2017 at 01:22:10PM -0700, Guenter Roeck wrote:
> > On Tue, Apr 25, 2017 at 12:58:36PM -0700, Moritz Fischer wrote:
> > > On Tue, Apr 25, 2017 at 09:58:24AM -0700, Guenter Roeck wrote:
> > > 
> > > > Ah, I missed the "n" in various #ifndef statements.
> > > >
> > > > I can't really comment on how to solve that; I simply don't know.
> > > > Also, even with a dt property, it still would be necessary to have
> > > > a non-DT means to configure one or the other. Making whatever solution
> > > > backward compatible also seems tricky; I don't have a solution for that
> > > > problem either.
> > > 
> > > How does one do these things in a non-dt context? Platform data? I'd let
> > 
> > Platform data is out of favor. You'd probably want to use device properties
> > (see drivers/base/property.c). Question though is if this is considered
> > configuration, hardware description, or both. Presumably the watchdog
> > only makes sense if the reset signal is wired, and the alarm only makes
> > sense if the interrupt is wired, but what if both are wired ?
> 
> To make things worse you can even remap the reset output to the INT pin
> (which my platform does).
> 

So that is what the weird 250ms "interrupt signal" is for. I had wondered
what that is supposed to be used for.

> I'll look at device properties. Thanks for the pointer.
> 
> > 
> > > the MFD select the 'mode'. Maybe being backwards compatible isn't
> > > possible in any case. Is there a rule somewhere that we guarantee you'll
> > > never have to change your CONFIG_FOO options?
> > > 
> > 
> > That would be nice, but no, there is no such rule. You can probably argue
> > that no published kernel configuration enables the watchdog flag,
> > so there is nothing to be concerned about.
> 
> Alright, cool. Thanks
> 
> Moritz
> 
> PS: Haven't forgotten about the cros-ec-hwmon patch that I sent out ...

No, still trying to get internal feedback. I'll have to ask again.

Guenter

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
