Return-Path: <rtc-linux+bncBCR5PSMFZYORBMWGZKZQKGQEQOI54RQ@googlegroups.com>
MIME-Version: 1.0
Received: from ozlabs.org (ozlabs.org. [103.22.144.67])
        by gmr-mx.google.com with ESMTPS id q142si1044543pfq.2.2015.12.17.03.57.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2015 03:57:38 -0800 (PST)
In-Reply-To: <1450163354-16894-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, akpm@linux-foundation.org,  Daniel Axtens <dja@axtens.net>
Subject: [rtc-linux] Re: powerpc: Remove broken GregorianDay()
Message-Id: <20151217115734.A5AAB14030D@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:34 +1100 (AEDT)
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 2015-15-12 at 07:09:14 UTC, Daniel Axtens wrote:
> GregorianDay() is supposed to calculate the day of the week
> (tm->tm_wday) for a given day/month/year. In that calcuation it
> indexed into an array called MonthOffset using tm->tm_mon-1. However
> tm_mon is zero-based, not one-based, so this is off-by-one. It also
> means that every January, GregoiranDay() will access element -1 of
> the MonthOffset array.
> 
> It also doesn't appear to be a correct algorithm either: see in
> contrast kernel/time/timeconv.c's time_to_tm function.
> 
> It's been broken forever, which suggests no-one in userland uses
> this. It looks like no-one in the kernel uses tm->tm_wday either
> (see e.g. drivers/rtc/rtc-ds1305.c:319).
> 
> tm->tm_wday is conventionally set to -1 when not available in
> hardware so we can simply set it to -1 and drop the function.
> (There are over a dozen other drivers in drivers/rtc that do
> this.)
> 
> Found using UBSAN.
> 
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Andrew Morton <akpm@linux-foundation.org> # as an example of what UBSan finds.
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00b912b0c88e690b1662067497

cheers

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
