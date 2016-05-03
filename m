Return-Path: <rtc-linux+bncBCR5PSMFZYORB6WGUC4QKGQEXKE5SEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ozlabs.org (ozlabs.org. [103.22.144.67])
        by gmr-mx.google.com with ESMTPS id xo2si177593pab.0.2016.05.02.21.05.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2016 21:05:13 -0700 (PDT)
Message-ID: <1462248309.12788.4.camel@ellerman.id.au>
Subject: [rtc-linux] Re: [PATCH v3 12/16] rtc: powerpc: provide rtc_class_ops directly
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni
	 <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org,
 dalias@libc.org, dhowells@redhat.com, linux-alpha@vger.kernel.org,
 a.zummo@towertech.it, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org,  linux-m68k@lists.linux-m68k.org,
 rtc-linux@googlegroups.com,  linux-arch@vger.kernel.org
Date: Tue, 03 May 2016 14:05:09 +1000
In-Reply-To: <1461796470-1291527-13-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
	 <1461796470-1291527-13-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 2016-04-28 at 00:34 +0200, Arnd Bergmann wrote:

> The rtc-generic driver provides an architecture specific
> wrapper on top of the generic rtc_class_ops abstraction,
> and powerpc has another abstraction on top, which is a bit
> silly.
> 
> This changes the powerpc rtc-generic device to provide its
> rtc_class_ops directly, to reduce the number of layers
> by one.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/kernel/time.c | 29 ++++++++++++++++++++++++++++-
>  drivers/rtc/rtc-generic.c  |  2 +-
>  2 files changed, 29 insertions(+), 2 deletions(-)

If this hits linux-next it will go through my automated boot testing, which
hopefully would be sufficient to catch any bugs in this patch, cross fingers.

I don't know jack about all the layers of RTC mess, so my ack is basically
worthless here. But if you like you can have one anyway :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

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
