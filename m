Return-Path: <rtc-linux+bncBDEKVJM7XAHRBX6BQK4QKGQEWLZ4E5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.75])
        by gmr-mx.google.com with ESMTPS id k143si266295wmg.1.2016.04.27.04.22.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 04:22:07 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony.luck@intel.com, geert@linux-m68k.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, rth@twiddle.net, ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, x86@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 6/8] char/genrtc: parisc: use asm-generic/rtc.h
Date: Wed, 27 Apr 2016 13:21:16 +0200
Message-ID: <18012781.hPTzXnRcSP@wuerfel>
In-Reply-To: <3034953.EvqV1iv2Ef@caliban.sf-tec.de>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <1461707052-1337718-7-git-send-email-arnd@arndb.de> <3034953.EvqV1iv2Ef@caliban.sf-tec.de>
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

On Wednesday 27 April 2016 00:07:47 Rolf Eike Beer wrote:
> Arnd Bergmann wrote:
> > The asm-generic/rtc.h header can now be included by
> > architectures that provide their own set_rtc_time/get_rtc_time
> > macros, letting us remove most of the common contents in
> > the powerpc implementation.
> 
> parisc in this case.
> 

Fixed, thanks!

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
