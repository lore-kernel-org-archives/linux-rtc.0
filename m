Return-Path: <rtc-linux+bncBCUYRNXYZECRBTWIZGVAKGQECALNKGQ@googlegroups.com>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id p9si154288wiz.3.2015.05.12.13.36.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 13:36:29 -0700 (PDT)
Date: Tue, 12 May 2015 21:36:13 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Daniel Mack <daniel@zonque.org>
Subject: [rtc-linux] Re: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
Message-ID: <20150512203613.GQ2067@n2100.arm.linux.org.uk>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <87lhgumi4b.fsf@belgarion.home>
 <878uctmtm6.fsf@belgarion.home>
 <53644246.uSkhGz7C05@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <53644246.uSkhGz7C05@wuerfel>
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, May 12, 2015 at 10:30:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 12 May 2015 22:24:49 Robert Jarzmik wrote:
> > 
> > I made the try, and Russell was right, this breaks the pxa architecture. The
> > relevant extract of kernel message is in [1].
> > 
> > The consequences with your patches :
> >  - pxa27x_init()
> >    - platform_add_devices()
> >      - the pxa_device_rtc fails (as resource is duplicated)
> >      - all the devices are unregistered (rollback)
> > And pxa27x fails.
> > 
> > Now I'm pondering about the right approach :
> >  - either remove sa1100_device_rtc from pxas
> >  - or remove pxa_device_rtc
> >  - or both
> >  - or something else
> > 
> > Let me think a bit about it.
> > 
> 
> To solve the problem with the duplicate registration of one resource,
> I'd suggest using platform_device_register_simple() for the registration,
> which will copy the resource. You can then mark the resource as __initconst
> and remove the device to save a little memory at runtime.

No, a better solution is to solve the problem which requires the
duplication in the first place, which is a broken driver structure.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

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
