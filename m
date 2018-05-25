Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:60706 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965130AbeEYJje (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 25 May 2018 05:39:34 -0400
Date: Fri, 25 May 2018 11:39:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: rtc_cmos 00:01: nvmem registration failed
Message-ID: <20180525093922.GA2500@piout.net>
References: <fa7eee0178fe888859730e7ce41e8e8af512f685.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa7eee0178fe888859730e7ce41e8e8af512f685.camel@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 25/05/2018 11:23:43+0200, Timur Kristóf wrote:
> Hi,
> 
> I've used kernel 4.17 rc5 and now using rc6 on Fedora 28 on a Dell XPS
> 13 9370 machine. Since upgrading to this kernel, I get the following
> messages in the journal:
> 
> máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: RTC can wake from S4
> máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: registered as rtc0
> máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: nvmem registration failed
> máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> 
> The "nvmem registration failed" is highlighted red in the journal, and also shows up on every boot.
> 

This is probably fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=c59b3715ac16544f8f68ab7af03f108e339b36aa

> This where the error message comes from:
> https://github.com/torvalds/linux/blob/master/drivers/rtc/rtc-cmos.c#L818
> And this is the commit that introduced it:
> https://github.com/torvalds/linux/commit/8b5b7958fd1cac54bdca62ec5552c6be0b38def4#diff-4dcdf420d40078042c28f0f3d8d6535c
> 
> The error message doesn't give any indication about why it failed.
> How can I help diagnose the what the problem is?
> 

My guess is that CONFIG_RTC_NVMEM is not enabled on your kernel.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
