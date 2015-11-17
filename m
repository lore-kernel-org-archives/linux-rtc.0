Return-Path: <rtc-linux+bncBDS7HNEFSALRB65JVWZAKGQEZQWDCYI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 68si465823wmw.1.2015.11.17.08.25.30
        for <rtc-linux@googlegroups.com>;
        Tue, 17 Nov 2015 08:25:30 -0800 (PST)
Date: Tue, 17 Nov 2015 17:25:30 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/9] rtc-2123: access the clock offset feature
Message-ID: <20151117162530.GC14677@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
 <2107368.j5bIbb5cBF@jclayton-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2107368.j5bIbb5cBF@jclayton-pc>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 17/11/2015 at 07:30:48 -0800, Joshua Clayton wrote :
> On Wednesday, November 04, 2015 07:36:31 AM Joshua Clayton wrote:
> > Greetings,
> > This series was prompted by a need to adjust the clock rate of the rtc
> > The existing code performs a soft reset during probe, which wipes out
> > several registers including the offset register, which performs adjustments
> > to the clock rate.
> > 
> > The first several patches are cleanup, with patch 5 and 6 avoiding the reset,
> > and patch 9 adding a nice sysfs interface to the clock offset.
> > 
> > I know that this is not the only rtc to provide a programmable clock offset
> > I wonder if this interface would make a good addition to the rtc api?
> > 
> > The rtc chips I have seen list their clock adjustments in parts per million.
> > I went with parts per billion, since the ppm listed was listed with a
> > fractional component.
> > 
> > Joshua Clayton (9):
> >   rtc-pcf2123: Document all registers and useful bits
> >   rtc-pcf2123: clean up reads from the chip
> >   rtc-pcf2123: clean up writes to the rtc chip
> >   rtc-pcf2123: replace magic numbers with defines
> >   rtc-pcf2123: put the chip reset into a function
> >   rtc-pcf2123: avoid resetting the clock if possible
> >   rtc-pcf2123: allow sysfs to accept hexidecimal
> >   rtc-pcf2123: use sysfs groups
> >   rtc-pcf2123: adjust the clock rate via sysfs
> > 
> >  drivers/rtc/rtc-pcf2123.c | 391 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 257 insertions(+), 134 deletions(-)
> > 
> > 
> Any comments on this series?
> I realize now that I submitted it during the merge window, so it may have been overlooked.
> 

I will have a few comments but I didn't review everything thoroughly
yet. As you mentioned, you submitted during the merge window so this was
not going to be in 4.4 anyway.

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
