Return-Path: <rtc-linux+bncBDS7HNEFSALRBJMEWSWAKGQENYRAEMI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si42651wib.1.2015.06.26.00.41.24
        for <rtc-linux@googlegroups.com>;
        Fri, 26 Jun 2015 00:41:24 -0700 (PDT)
Date: Fri, 26 Jun 2015 09:41:24 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [GIT PULL] RTC for 4.2
Message-ID: <20150626074124.GM485@piout.net>
References: <20150625191642.GA16184@piout.net>
 <CA+55aFzyTuindK63-jiYBdq-uB=_WWO0dgPciurgdFALz62iWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CA+55aFzyTuindK63-jiYBdq-uB=_WWO0dgPciurgdFALz62iWQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 25/06/2015 at 18:59:48 -0700, Linus Torvalds wrote :
> Looks fine, but:
> 
> > Conflicts:
> >    drivers/rtc/Makefile
> >
> > Trivial add/add conflicts with the mfd tree, solved in linux-next
> > Resolution: take both sides.
> 
> That's not the resolution I took - the re-sorting of the file made for
> more complex.
> 
> Can you check my resolution?
> 

I've checked and it is correct. Thanks!

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
