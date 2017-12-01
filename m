Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41522 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdLARKp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 1 Dec 2017 12:10:45 -0500
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Rabeeh Khoury <rabeeh@solid-run.com>
Subject: Re: Armada RTC power up reset
References: <20171130094049.fg3zoxgvhlb7jqw3@tarshish>
Date: Fri, 01 Dec 2017 18:10:34 +0100
In-Reply-To: <20171130094049.fg3zoxgvhlb7jqw3@tarshish> (Baruch Siach's
        message of "Thu, 30 Nov 2017 11:40:49 +0200")
Message-ID: <871skewf05.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Baruch,
 
 On jeu., nov. 30 2017, Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Thomas,
>
> As you know, the Armada 38x/8k RTC needs a reset sequence to be operational 
> when first powered up. This reset code is currently in the vendor provided 
> U-Boot RTC driver. But having to run 'date reset' from the U-Boot prompt every 
> first boot (happens quite a lot when dealing with SOMs) is not nice. An 
> automatic reset in the kernel driver would be much better.
>
> Rabeeh has mentioned to me that you had an idea how to detect at run time that 
> the RTC is in first power up state. Do you recall the details?

Actually it was me who worked on the RTC but I didn't remember having a
way to detect that the RTC is in first power up state. I dig in the
datasheet, errata sheet and alos on varisou branches of the vendor tree
and didn't find anything.

Maybe a solution could be to reset the RTC when we set the time.

Gregory


>
> Thanks,
> baruch
>
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
