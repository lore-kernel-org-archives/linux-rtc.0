Return-Path: <rtc-linux+bncBDEKVJM7XAHRBJU3QK4QKGQEQYSMDKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.134])
        by gmr-mx.google.com with ESMTPS id d2si412154igx.2.2016.04.27.03.00.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 03:00:06 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com, linux-arch@vger.kernel.org, deller@gmx.de, x86@kernel.org, jejb@parisc-linux.org, geert@linux-m68k.org, rtc-linux@googlegroups.com, ink@jurassic.park.msu.ru, rth@twiddle.net, a.zummo@towertech.it, tony.luck@intel.com, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, yasutake.koichi@jp.panasonic.com
Subject: [rtc-linux] Re: [PATCH 4/8] char/rtc: move mc146818rtc code out of asm-generic/rtc.h
Date: Wed, 27 Apr 2016 11:59:45 +0200
Message-ID: <13463932.UFUngJV7ZH@wuerfel>
In-Reply-To: <20160427084707.GI3264@piout.net>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <1461707052-1337718-5-git-send-email-arnd@arndb.de> <20160427084707.GI3264@piout.net>
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

On Wednesday 27 April 2016 11:29:12 Alexandre Belloni wrote:
> The subject should be:
> rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h

Good point, the functions are only used by rtc-cmos, not the old
drivers/char/rtc.c.
 
> Else, you can add:
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks.

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
