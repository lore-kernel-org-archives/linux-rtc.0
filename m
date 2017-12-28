Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42542 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbdL1PAe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Dec 2017 10:00:34 -0500
Date: Thu, 28 Dec 2017 20:30:27 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Ozgur <ozgur@goosey.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: rtc: sysfs: move sysfs interface to Documentation/ABI
Message-ID: <20171228150027.GA11300@mordor.localdomain>
References: <20171228133132.GA3927@mordor.localdomain>
 <434381514470951@web50o.yandex.ru>
 <480511514471013@web35j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <480511514471013@web35j.yandex.ru>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Dec 28, 2017 at 05:23:33PM +0300, Ozgur wrote:
> 
> 
> 28.12.2017, 17:22, "Ozgur" <okaratas@yandex.com>:
> > 28.12.2017, 16:31, "Aishwarya Pant" <aishpant@gmail.com>:
> >>  Hi
> 
>  Hello,
> 
> >>  In Documentation/rtc.txt, there is a description of the sysfs
> >>  interface which could be moved to Documentation/ABI.
> >>
> >>  Would such a change be useful?
> >>
> >>  The ABI documentation format looks like the following:
> >>
> >>  What: (the full sysfs path of the attribute)
> >>  Date: (date of creation)
> >>  KernelVersion: (kernel version it first showed up in)
> >>  Contact: (primary contact)
> >>  Description: (long description on usage)
> >>
> >>  I am doing this in an exercise to move sysfs ABI interfaces (which are
> >>  documented) to their right place i.e. in Documentation/ABI along with the rest.
> 
>  Do I understand right? Are you want to make the rtc.txt part the same format as ABI folder?
>  for example create to RTC folder and add /dev/rtc what, date, kernelversion, contact right?

Yes I mentioned just the sysfs interface. But both ioctl and sysfs interface
should be there in Documentation/ABI. There could a new file called sysfs-rtc in
Documentation/ABI/stable with both these interfaces.

> 
>  This can be a good idea and I can help.

Sure thanks. I can maybe send a patch with these changes.

One question: who should be the primary contact for this ABI?

> 
> >>  Aishwarya
> 
> Ozgur
