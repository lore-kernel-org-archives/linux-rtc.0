Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41409 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966364AbeBNBp2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Feb 2018 20:45:28 -0500
Date: Wed, 14 Feb 2018 02:45:16 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Peter Milley <pbmilley@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [BUG]: Error accessing realtime clock
Message-ID: <20180214014516.GB3354@piout.net>
References: <1516839170.2319.35.camel@gmail.com>
 <1518537392.3719.1.camel@gmail.com>
 <20180213202532.GA30929@piout.net>
 <1518554755.2607.4.camel@gmail.com>
 <20180213205802.GF30929@piout.net>
 <20180213222025.GA3354@piout.net>
 <1518566194.3441.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518566194.3441.3.camel@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13/02/2018 at 18:56:34 -0500, Peter Milley wrote:
> Okay, I've booted the new kernel.
> 
> peter@haven:~$ uname -a
> Linux haven 4.16.0-rc1+ #32 SMP Tue Feb 13 22:11:39 CET 2018 x86_64
> x86_64 x86_64 GNU/Linux
> peter@haven:~$ dmesg | grep -i rtc
> [    0.045403] RTC time: 23:46:52, date: 02/13/18
> [    1.368198] rtc_cmos 00:01: RTC can wake from S4
> [    1.368205] rtc_cmos: drivers/rtc/rtc-cmos.c +679 cmos_do_probe
> [    1.368235] rtc_cmos: drivers/rtc/rtc-cmos.c +684 cmos_do_probe
> [    1.368260] rtc_cmos: drivers/rtc/rtc-cmos.c +688 cmos_do_probe
> [    1.368285] rtc_cmos: 1: 70 8
> [    1.368302] rtc_cmos: probe of 00:01 failed with error -16
> [    1.408861] hctosys: unable to open rtc device (rtc0)
> 

[...]

> And /proc/ioports:
> peter@haven:~$ sudo cat /proc/ioports
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0072 : wdat_wdt

So I can tell you what is happening but I can't tell you why. You have a
watchdog at 0x70 (size 2) and the RTC at 0x70 (size 8).

Because the watchdog driver is probed first and it requests the io
region, when the RTC driver is probed, it fails to request the same
region.

Maybe your 4.10 kernel didn't have CONFIG_WDAT_WDT (this appeared in
4.9).
I'm afraid, that is as far as I can help, you'd have to ask someone that
is more knowledgeable about x86 to go further (I've added the wdat_wdt
driver author in Cc).

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
