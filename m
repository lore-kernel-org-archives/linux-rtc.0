Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39836 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdLKQIh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 11 Dec 2017 11:08:37 -0500
Date: Mon, 11 Dec 2017 17:08:35 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        "nadavh@marvell.com" <nadavh@marvell.com>
Subject: Re: Armada RTC power up reset
Message-ID: <20171211160835.GC32306@piout.net>
References: <20171130094049.fg3zoxgvhlb7jqw3@tarshish>
 <871skewf05.fsf@free-electrons.com>
 <CA+j0ot=PqFYwN=+zUc5F1uyXQoB9dX1gmwxTbXP-QdzQU+zspQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+j0ot=PqFYwN=+zUc5F1uyXQoB9dX1gmwxTbXP-QdzQU+zspQ@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 11/12/2017 at 14:46:41 +0200, Rabeeh Khoury wrote:
> On Fri, Dec 1, 2017 at 7:10 PM, Gregory CLEMENT <
> gregory.clement@free-electrons.com> wrote:
> 
> > Hi Baruch,
> >
> >  On jeu., nov. 30 2017, Baruch Siach <baruch@tkos.co.il> wrote:
> >
> > > Hi Thomas,
> > >
> > > As you know, the Armada 38x/8k RTC needs a reset sequence to be
> > operational
> > > when first powered up. This reset code is currently in the vendor
> > provided
> > > U-Boot RTC driver. But having to run 'date reset' from the U-Boot prompt
> > every
> > > first boot (happens quite a lot when dealing with SOMs) is not nice. An
> > > automatic reset in the kernel driver would be much better.
> > >
> > > Rabeeh has mentioned to me that you had an idea how to detect at run
> > time that
> > > the RTC is in first power up state. Do you recall the details?
> >
> > Actually it was me who worked on the RTC but I didn't remember having a
> > way to detect that the RTC is in first power up state. I dig in the
> > datasheet, errata sheet and alos on varisou branches of the vendor tree
> > and didn't find anything.
> >
> > Maybe a solution could be to reset the RTC when we set the time.
> >
> 
> 
> This is one way to do it; but then on first boot you might get real awkward
> time; like year 2035 which can seriously confuse the boot process.
> Detecting an uninitialized RTC and forcing it to tick with time = 0 (i.e.
> 1970) is better way since boot failures can be reproduced in an orderly
> manner (and the developer would know what was really wrong).

Certainly not. If you know the time is invalid, then just return an
error. Else, userspace has no way to know whether it can rely on the
time from the RTC and act accordingly.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
