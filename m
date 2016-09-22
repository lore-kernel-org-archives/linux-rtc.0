Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6U2R67QKGQEQJBTZXA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e21si147136wmc.2.2016.09.22.05.24.25
        for <rtc-linux@googlegroups.com>;
        Thu, 22 Sep 2016 05:24:25 -0700 (PDT)
Date: Thu, 22 Sep 2016 14:24:25 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: cmos: avoid unused function warning
Message-ID: <20160922122425.ovw5kss2h7zh4vsc@piout.net>
References: <20160922094817.2325831-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160922094817.2325831-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/09/2016 at 11:48:00 +0200, Arnd Bergmann wrote :
> A bug fix for the ACPI side of this driver caused a harmless
> build warning:
> 
> drivers/rtc/rtc-cmos.c:1115:13: error: 'cmos_check_acpi_rtc_status' defined but not used [-Werror=unused-function]
>  static void cmos_check_acpi_rtc_status(struct device *dev,
> 
> We can avoid the warning and simplify the driver at the same time
> by removing the #ifdef for CONFIG_PM and rely on the SIMPLE_DEV_PM_OPS()
> to set everything up correctly. cmos_resume() has to get marked
> as __maybe_unused so we don't introduce another warning, and
> the two variants of cmos_poweroff() can get merged into one using
> an IS_ENABLED() check.
> 
> Fixes: 983bf1256edb ("rtc: cmos: Clear ACPI-driven alarms upon resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-cmos.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
