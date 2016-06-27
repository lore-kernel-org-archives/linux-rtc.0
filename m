Return-Path: <rtc-linux+bncBDX5ZRH7XQGRBTN7YW5QKGQEMMTOL5A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com. [2607:f8b0:400e:c00::230])
        by gmr-mx.google.com with ESMTPS id un17si2723262pab.0.2016.06.27.10.18.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 10:18:05 -0700 (PDT)
Received: by mail-pf0-x230.google.com with SMTP id t190so63756428pfb.3
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 10:18:05 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,  rtc-linux@googlegroups.com,  a.zummo@towertech.it,  alexandre.belloni@free-electrons.com,  devicetree@vger.kernel.org,  robh+dt@kernel.org,  frowand.list@gmail.com,  linux-amlogic@lists.infradead.org
Subject: [rtc-linux] Re: RTC support for AMlogic devies
References: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
Date: Mon, 27 Jun 2016 10:18:02 -0700
In-Reply-To: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
	(Ben Dooks's message of "Mon, 27 Jun 2016 15:52:11 +0100")
Message-ID: <m2bn2mtut1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> This series is support for the RTC block on some of the AMLogic
> Meson ARM SoCs.
>
> The first patch is the driver, followed by device-tree patches
> and enablement for the ODRoid-C1 (where it has been tested)

In the cover letter, please be explicit about any dependencies that are
not upstream.  This series applies to mainline (v4.7-rc*) but does not
build.  I tested it with my v4.7/integ branch and it seems to work.

The series also has a handful of checkpatch warnings that should be
addressed (see: http://hastebin.com/tacurokasu.pas)

Other than that, I gave it a quick spin on meson8b-odroidc1 using
tools/testing/selftests/timers/rtctest.c, and the basic time stuff seems
to be working:

/ # ./rtctest

                        RTC Driver Test Example.


...Update IRQs not supported.


Current RTC date/time is 27-6-2016, 00:01:41.
RTC_ALM_READ ioctl: Invalid argument


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
