Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52504 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbdKDPeQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 4 Nov 2017 11:34:16 -0400
Date: Sat, 4 Nov 2017 16:34:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Introduce clock precision to help time travelers was Re: Extreme
 time jitter with suspend/resume cycles
Message-ID: <20171104153415.bc6ttzfpwkkbbhsr@piout.net>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <20171015063738.GA24716@xo-6d-61-c0.localdomain>
 <20171018213449.523cd958@alans-desktop>
 <20171018210828.GA3581@amd>
 <20171018212645.7htby4qmnfbep3vx@piout.net>
 <20171018215638.GA7487@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018215638.GA7487@amd>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/10/2017 at 23:56:38 +0200, Pavel Machek wrote:
> > Some RTCs will tell you when they lost time/time accuracy and this
> > should be properly reported by the driver. If not, this has to be
> > implemented.
> 
> How is it reported to the userspace?
> 

Userspace will get -EINVAL when using the RTC_RD_TIME ioctl. The kernel
also get the same error when reading the time from the RTC.

> > For anything else, it is probably the job of userspace to try to be
> > clever.
> 
> Userspace would be fine with me, but as far as I can tell, there's no
> good way to do it in userspace.
> 
> My proposal would be: kernel keeps accuracy for timeofday.
> 
> If RTC says time is bad, accuracy is set to ~0.
> 
> settimeofday sets accuracy to 0 (completely accurate).
> 
> new_settimeofday gets new argument, accuracy.
> 
> new_gettimofday returns accuracy, too.
> 
> Does that sound sane? I'm not sure what other interfaces need to be extended.
> 
> Best regards,
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
