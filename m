Return-Path: <rtc-linux+bncBC7M5BFO7YCRBNVR7PDQKGQEBCJJDOI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id q63si1559211itq.3.2017.04.24.22.03.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 22:03:49 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 0/2] DS1374 Watchdog fixes
To: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
Cc: moritz.fischer@ettus.com, linux-watchdog@vger.kernel.org, wim@iguana.be,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 rtc-linux@googlegroups.com, alex.williams@ni.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
Date: Mon, 24 Apr 2017 22:03:45 -0700
MIME-Version: 1.0
In-Reply-To: <1493071512-5718-1-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/24/2017 03:05 PM, Moritz Fischer wrote:
> Hi all,
>
> this series fixes two issues that I ran into when trying to use the
> watchdog part of the DS1374 on of our products.
>
> This series is basically a precursor to some further cleanup work,
> that turns the DS1374 into a MFD device with an RTC and WDT in
> separate drivers [1] each integrated in either the watchdog and
> the rtc frameworks.
>
> I'm very unhappy with the CONFIG_DRV_RTC_DS1374_WDT way of enabling
> the watchdog behavior and currently I'm investigating how to make
> that work via DT.
>
> Watchdog maintainers, do you have an idea on how to do that in a
> non breaking fashion?
>

Depends on what you mean with "non breaking". Just using the normal mfd
mechanisms, ie define an mfd cell for each client driver, should work.
Do you see any problems with that ? Either case, that doesn't seem
to be a watchdog driver problem, or am I missing something ?

> Thanks,
> Moritz
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux.git/log/?h=wip/mfd-ds1374-rfc
>
> Moritz Fischer (2):
>   rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt
>     ticks
>   rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL
>

I don't really see the point of doing that if you plan to move the watchdog
part of the driver into the watchdog directory. We for sure won't accept a
watchdog driver that does not use the watchdog infrastructure.

Regarding
+	/* WHY? */
+	ds1374->wdd.timeout = t;

Assuming you mean why the driver has to set the timeout value - not every
watchdog hardware supports timeouts in multiples of 1 second. The driver
is expected to set the value to the real timeout, not to the timeout asked
for by the infrastructure.

Guenter

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
