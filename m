Return-Path: <rtc-linux+bncBDS7HNEFSALRB54A56UAKGQE3OON5DY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a14si84919wib.3.2015.04.01.02.55.02
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Apr 2015 02:55:02 -0700 (PDT)
Date: Wed, 1 Apr 2015 11:55:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: __rtc_read_time: reduce log level
Message-ID: <20150401095501.GS3849@piout.net>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
 <1427576976-22353-2-git-send-email-aaro.koskinen@iki.fi>
 <20150401032113.GP3849@piout.net>
 <1427858719.18175.32.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427858719.18175.32.camel@perches.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 31/03/2015 at 20:25:19 -0700, Joe Perches wrote :
> On Wed, 2015-04-01 at 05:21 +0200, Alexandre Belloni wrote:
> > On 28/03/2015 at 23:09:35 +0200, Aaro Koskinen wrote :
> > > __rtc_read_time logs should be debug logs instead of error logs.
> > > 
> > > For example, when the RTC clock is not set, it's not really useful
> > > to print a kernel error log every time someone tries to read the clock:
> > > 
> > > 	~ # hwclock -r
> > > 	[  604.508263] rtc rtc0: read_time: fail to read
> > > 	hwclock: RTC_RD_TIME: Invalid argument
> > > 
> > > If there's a real error, it's likely that lower level or higher level
> > > code will tell it anyway. Make these logs debug logs, and also print
> > > the error code for the read failure.
> > > 
> > 
> > That actually may be the only error message printed for some failures.
> > Some RTCs don't print anything in case of error in their .read_time()
> > and there are in-kernel users of rtc_read_time that simply bail out
> > without printing anything or have a trace that is already at the debug
> > level.
> > 
> > I would agree that this would need a better harmonization and I guess we
> > can do that for now. I'll try to fix the in-kernel cases.
> 
> Maybe these should use dev_err_once().
> 

As the issue may be sporadic, I would say that the reasoning behind the
patch is correct. Userspace is already aware that something went wrong
when reading and those debug messages are not adding any information.


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
