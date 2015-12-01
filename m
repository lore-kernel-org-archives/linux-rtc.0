Return-Path: <rtc-linux+bncBDS7HNEFSALRBUUW7CZAKGQEXGMUT4Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y203si773725wmc.2.2015.12.01.13.04.18
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Dec 2015 13:04:18 -0800 (PST)
Date: Tue, 1 Dec 2015 22:04:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 6/9] rtc-pcf2123: avoid resetting the clock if possible
Message-ID: <20151201210417.GA22136@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
 <f801d4f26d4c4944b1a5353d5b5fde4e507b45b2.1446587705.git.stillcompiling@gmail.com>
 <20151124232512.GG3950@piout.net>
 <20151201122351.27e3f542@jclayton-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151201122351.27e3f542@jclayton-pc>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 01/12/2015 at 12:23:51 -0800, Joshua Clayton wrote :
> On Wed, 25 Nov 2015 00:25:12 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > On 04/11/2015 at 07:36:37 -0800, Joshua Clayton wrote :
> > > +	ret = pcf2123_rtc_read_time(dev, &tm);
> > > +	if (ret < 0)
> > > +		return false;
> > > +
> > > +	if (rtc_valid_tm(&tm) < 0) {
> > > +		dev_err(dev, "retrieved date/time is not
> > > valid.\n");
> > > +		return false;
> > > +	}
> > > +
> > 
> > I would remove that test as basically, the date/time will only be
> > valid when OSC_HAS_STOPPED is not set.
> > 
> OSC_HAS_STOPPED really only protects us in case everything else
> looks good, but we've lost power.
> There are other reasons to check for a valid time.
> Specifically, if there is no communication with the device, the spi
> operation will succeed and return all zeros or all ones.
> Since either of these results in an invalid time, it is a nice way
> to probe whether we really have a pcf2123 compatible device.
> 
> I don't think I should remove this test, but I can add a comment

OK but then pcf2123_rtc_read_time actually returns rtc_valid_tm(tm) ;)

The proper course of action is probably to do the OSC_HAS_STOPPED check
in pcf2123_rtc_read_time then you don't even need pcf2123_time_valid().

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
