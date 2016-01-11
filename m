Return-Path: <rtc-linux+bncBDS7HNEFSALRBPEJ2C2AKGQECJTZMFY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c140si319424wmh.0.2016.01.11.11.38.35
        for <rtc-linux@googlegroups.com>;
        Mon, 11 Jan 2016 11:38:35 -0800 (PST)
Date: Mon, 11 Jan 2016 20:38:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v1 1/1] rtc: cmos: prevent kernel warning on
 IRQ flags mismatch
Message-ID: <20160111193834.GE3367@piout.net>
References: <1450892239-74224-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1450892239-74224-1-git-send-email-andriy.shevchenko@linux.intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/12/2015 at 19:37:19 +0200, Andy Shevchenko wrote :
> The Microsoft Surface 3 tablet shares interrupt line between RTC and one of SPI
> controllers. However, the rtc_cmos driver doesn't allow shared interrupts and
> user sees the following warning
> 
> genirq: Flags mismatch irq 8. 00000080 (8086228E:02) vs. 00000000 (rtc0)
> ...
> [<ffffffffa004eb01>] pxa2xx_spi_probe+0x151/0x600 [spi_pxa2xx_platform]
> 
> Allow RTC driver to use shared interrupts.
> 
> Seems we are on the safe side to do just this simple change since
> cmos_interrupt() handler checks for the actual hardware status anyway.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/rtc/rtc-cmos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
