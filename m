Return-Path: <rtc-linux+bncBDS7HNEFSALRBLEBVW3AKGQE7IMQZVI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h126si682355wme.0.2016.02.22.09.09.00
        for <rtc-linux@googlegroups.com>;
        Mon, 22 Feb 2016 09:09:00 -0800 (PST)
Date: Mon, 22 Feb 2016 17:58:47 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
Message-ID: <20160222165847.GR2222@piout.net>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <6269543.oe8MmZQUmX@wuerfel>
 <20160222155653.GP2222@piout.net>
 <2768647.1bFEcFDZRI@wuerfel>
 <56CB3A1D.6030604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56CB3A1D.6030604@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2016 at 11:41:01 -0500, Austin S. Hemmelgarn wrote :
> On 2016-02-22 11:18, Arnd Bergmann wrote:
> >On Monday 22 February 2016 16:56:53 Alexandre Belloni wrote:
> >>One other workaround is to asked distributions
> >>using systemd to stop using HCTOSYS so userspace would be responsible to
> >>set the system time and in that case we won't have the 32/64 discrepancy.
> >
> >I'm missing a bit of background here. This seems like a fairly useful
> >piece of infrastructure for the majority of the use cases (working RTC)
> >
> >How would the time get set when this is disabled? Is systemd able
> >to read the rtc and write it back to the kernel? That could in fact
> >be a nicer workaround for the problem, if it just does this before
> >setting up the timerfd.
> Traditional init systems on Linux have the option of using hwclock from
> util-linux to set the system time.  This is what Gentoo does by default, and
> I think Arch does it too, and I'm relatively certain that Debian and Ubuntu
> used to do it before they switched to systemd (I have no idea what they do
> now).  Based on the manpage for hwclock, it looks like systemd mandates that
> HCTOSYS is enabled in the kernel configuration, and then just calls hwclock
> to set the system timezone and correct for UTC.

I'm not sure it mandates HCTOSYS. On debian there is a udev rule that
needs the system time to already be set but from my point of view, it
doesn't matter whether it is from hwclock or HCTOSYS. systemd already
seems to read the RTC so it may as well set the system time if it needs
it.


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
