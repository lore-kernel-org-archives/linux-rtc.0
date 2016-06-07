Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFGR3O5AKGQEWADOMMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s140si1084689wme.1.2016.06.07.08.30.28
        for <rtc-linux@googlegroups.com>;
        Tue, 07 Jun 2016 08:30:28 -0700 (PDT)
Date: Tue, 7 Jun 2016 17:30:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David Binderman <linuxdev.baldrick@gmail.com>
Cc: kumba@gentoo.org, a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, dcb314@hotmail.com
Subject: [rtc-linux] Re: linux-4.7-rc2/drivers/rtc/rtc-ds1685.c: 2 * bad if
 test ?
Message-ID: <20160607153027.GK3363@piout.net>
References: <CAMzoamZ64+P0Np6WQj-8JYhCw+zXdG-VQ7g2-q80fSS2cq+xyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAMzoamZ64+P0Np6WQj-8JYhCw+zXdG-VQ7g2-q80fSS2cq+xyQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 07/06/2016 at 16:18:31 +0100, David Binderman wrote :
> Hello there,
> 
> 1.
> 
> linux-4.7-rc2/drivers/rtc/rtc-ds1685.c:392]: (style) Redundant
> condition: If '!(mday >= 1)', the comparison 'mday <= 31' is always
> true.
> 
> Source code is
> 
>    if (!(mday >= 1) && (mday <= 31))
> 
> Maybe better code
> 
>    if (!((mday >= 1) && (mday <= 31)))
> 
> 2.
> 
> linux-4.7-rc2/drivers/rtc/rtc-ds1685.c:464]: (style) Redundant
> condition: If '!(mday >= 1)', the comparison 'mday <= 31' is always
> true.
> 

See
http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=c5776dec8f2a90a0aa9e197c2900f68fda8dd978

This should fix that issue.

> Duplicate. Also in the same file:
> 
> [drivers/rtc/rtc-ds1685.c:265]: (style) Variable 'ctrlb' is assigned a
> value that is never used.
> [drivers/rtc/rtc-ds1685.c:812]: (style) Variable 'ctrlc' is assigned a
> value that is never used.
> 

Well, feel free to send a patch. Please include the name of the tool you
used to find that as I pretty much prefer changes that are tested over
cleanup form static analysis tools.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
