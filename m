Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbdKXAO4 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 23 Nov 2017 19:14:56 -0500
Subject: Re: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
 <20171123120451.v74j3z2c5oodxlud@piout.net>
 <20171123125300.GO31757@n2100.armlinux.org.uk>
Cc: Jason Gunthorpe <jgg@mellanox.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <f034d236-22e2-57d9-1d64-2b2821ba1839@gmx.com>
Date: Thu, 23 Nov 2017 19:13:58 -0500
MIME-Version: 1.0
In-Reply-To: <20171123125300.GO31757@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On 11/23/2017 07:53 AM, Russell King - ARM Linux wrote:
> On Thu, Nov 23, 2017 at 01:04:51PM +0100, Alexandre Belloni wrote:
>>

 8<

>> But nothing prevents you from using hwclock every 11 minutes from
>> userspace. I really don't think this should be done from the kernel.
> 
> It's not just about running hwclock every 11 minutes.  It's about
> running hwclock when NTP sync'd.  If the local clock is not sync'd
> you don't want to be running hwclock, especially if you've trimmed
> the RTC.  So merely throwing hwclock -uw into a cron job really
> doesn't solve it.
> 
> A way around that would be to install adjtimex, so that the kernel's
> NTP flags can be read out.  However, that comes with its own set of
> problems.
> 
> On Debian, installing adjtimex will disrupt the timekeeping because
> of the post-install scripts debian runs.  It seems Debian assumes
> that if you install something, it has the right to modify the system
> timekeeping parameters immediately, screwing up ntpd in the process,
> if it's running.  The thought that you're installing adjtimex because
> you want to _inspect_ the kernel ntp parameters is not one that
> Debian folk appear to have considered as being a reason for installing
> the package.
> 

IMO, adjtimex is broken anyway. Use ntptime, it should be included
in the ntp package:

 $ /usr/sbin/ntptime | grep status
  status 0x40 (UNSYNC),

'ntptime -f ppm' allows correcting the system clock. So adjtimex really
isn't needed anymore.
