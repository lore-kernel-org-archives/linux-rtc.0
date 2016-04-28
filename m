Return-Path: <rtc-linux+bncBDEKVJM7XAHRBMVUQ64QKGQESERSCFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id au10si1658937igc.3.2016.04.28.02.38.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 02:38:58 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rich Felker <dalias@libc.org>, linux-arch@vger.kernel.org, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 11:38:47 +0200
Message-ID: <5905519.cjzepiYx4I@wuerfel>
In-Reply-To: <2582931.5Q3899gsIm@wuerfel>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de> <20160427232122.GW21636@brightrain.aerifal.cx> <2582931.5Q3899gsIm@wuerfel>
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

On Thursday 28 April 2016 11:08:41 Arnd Bergmann wrote:
> I only see two of them anyway (dreamcast and sh03), so that should
> be easy enough to do. For instance in arch/sh/boards/mach-sh03/rtc.c,
> the sh03_time_init() function should register a platform driver,
> whose probe function calls devm_rtc_device_register() to register
> with the rtc subsystem. Then you move the entire file to drivers/rtc/
> and change the callers of sh03_time_init() to create the device
> manually (for the classic board file) or drop it (for DT).

Just FYI:

Another look at the sh03_rtc_settimeofday function shows that it's
always been wrong: unlike the set_mmss() function it calls, it should
set all the time fields, not just minutes and seconds.

	Arnd

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
