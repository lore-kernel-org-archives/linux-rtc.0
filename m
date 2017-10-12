Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49600 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbdJLJgu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 05:36:50 -0400
Date: Thu, 12 Oct 2017 10:36:38 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>
Cc: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: DryIce , RTC not working on imx53.
Message-ID: <20171012093638.GA20805@n2100.armlinux.org.uk>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Oct 12, 2017 at 07:50:41AM +0000, Patrick Brünn wrote:
> Novice question: Is hwclock still required these days? For me it looks
> like the kernel is synchronizing with rtc on it's own. Maybe some kernel
> config is incompatible with hwclock?

It depends on your application.  If you want the kernel's idea of time
to be wrong up to a second or two, then you can rely on the kernel's
time setting.

Please realise that the kernel has always set the time from the RTC,
even on x86 where hwclock has been used.  hwclock, however, has some
advanced features and advantages that are beneficial if you're after
accuracy.

1) hwclock will try to read the RTC as close to a second-change as
   possible, so that the time read from the RTC is as close to the
   second.

2) hwclock can measure and correct the RTC time for its own drift if
   hwclock has been allowed to capture and process the offset.

What this means is that hwclock has the capability to precisely set
the kernel's time at boot, way more accurately than the kernel does.
The kernel's time setting is focused on speed, not accuracy.

So, if your userspace application is to monitor something using a
precise timestamp, and you are NTP synchronising (or other method) the
time on the system, then you need the kernel's idea of time to be set
much more precisely to avoid NTP making big corrections over the
following three to six hours.

This happens because NTP will slew the clock for a few seconds of
difference, which makes storing and reloading the PPM value useless,
and can also mean that in such a monitoring application, the results
are unreliable until NTP has re-stabilised.

Here's an example of an application where this may matter: average
speed camera system.  You have two cameras over a section of road,
each with their own processing, which are NTP synchronised.  Each
reads the numberplate of passing vehicles using ANPR technology,
and timestamps the passing of the vehicle using their local clock.
The distance is known, so it's an easy calculation to calculate the
vehicle speed.  If the vehicle speed is over the limit, the driver
is fined.

Consider what the implications are if one of the systems rebooted
and then had incorrect time (up to two seconds wrong) for up to six
hours after - a two second error is about a 3% error in recorded
speed.  Would you want to be sent a speeding fine from such a system?

(We have the first non-motorway road in Surrey, UK to have average
speed cameras installed down its entire length because of "piston
heads" who think the speed limit is 60mph rather than the sign-
posted 40mph.)

Another, probably more relevant application is a stratum-1 NTP server
synchronised via PPS to a GPS.  I wonder how many people are aware
that if you reboot such a setup relying on the kernel's time setting
only, the time sent to clients will be wrong while NTP slews the local
clock.  I've seen these effects locally, where rebooting exactly such
a system results in slaved systems which have no other source of time
also making big corrections.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
