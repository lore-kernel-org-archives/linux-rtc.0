Return-Path: <rtc-linux+bncBCEPJZEDQIBBBUMGY25QKGQEDWP3TYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk. [185.25.241.215])
        by gmr-mx.google.com with ESMTPS id f10si570209wmg.2.2016.06.27.12.49.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 12:49:36 -0700 (PDT)
Subject: [rtc-linux] Re: RTC support for AMlogic devies
To: Kevin Hilman <khilman@baylibre.com>
References: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
 <m2bn2mtut1.fsf@baylibre.com>
Cc: linux-kernel@lists.codethink.co.uk, rtc-linux@googlegroups.com,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
 linux-amlogic@lists.infradead.org
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-ID: <70b8eaf9-b07c-8a56-8205-58bf6475a3f4@codethink.co.uk>
Date: Mon, 27 Jun 2016 20:49:28 +0100
MIME-Version: 1.0
In-Reply-To: <m2bn2mtut1.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 27/06/16 18:18, Kevin Hilman wrote:
> Ben Dooks <ben.dooks@codethink.co.uk> writes:
> 
>> This series is support for the RTC block on some of the AMLogic
>> Meson ARM SoCs.
>>
>> The first patch is the driver, followed by device-tree patches
>> and enablement for the ODRoid-C1 (where it has been tested)
> 
> In the cover letter, please be explicit about any dependencies that are
> not upstream.  This series applies to mainline (v4.7-rc*) but does not
> build.  I tested it with my v4.7/integ branch and it seems to work.

I think this is just the DT bindings for the reset controller which
are currently in -next.

> The series also has a handful of checkpatch warnings that should be
> addressed (see: http://hastebin.com/tacurokasu.pas)

The msleep() ones I think are not a big isuse. The line length could
be solved, but at the moment is one of the few issues that are in the
rtc-meson.c driver.

The documentation one is solved by the patch adding the device-tree
binding information.

> Other than that, I gave it a quick spin on meson8b-odroidc1 using
> tools/testing/selftests/timers/rtctest.c, and the basic time stuff seems
> to be working:

Thank you.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
