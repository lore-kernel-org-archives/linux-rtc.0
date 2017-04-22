Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB7P45XDQKGQEZRIBOXQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f136si18213wme.1.2017.04.22.09.02.05
        for <rtc-linux@googlegroups.com>;
        Sat, 22 Apr 2017 09:02:05 -0700 (PDT)
Date: Sat, 22 Apr 2017 18:02:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Brandt <chris.brandt@renesas.com>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: sh: mark PM functions as unused
Message-ID: <20170422160205.cwswr7sfjbr4ecl7@piout.net>
References: <20170419175346.37122-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170419175346.37122-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 19/04/2017 at 19:52:43 +0200, Arnd Bergmann wrote:
> The sh_rtc_set_irq_wake() function is only called from the suspend/resume handlers
> that may be hidden, causing a harmless warning:
> 
> drivers/rtc/rtc-sh.c:724:13: error: 'sh_rtc_set_irq_wake' defined but not used [-Werror=unused-function]
>  static void sh_rtc_set_irq_wake(struct device *dev, int enabled)
> 
> The most reliable way to avoid the warning is to remove the existing #ifdef
> and mark the two functions as __maybe_unused so the compiler can silently
> drop all three when there is no reference.
> 
> Fixes: dab5aec64bf5 ("rtc: sh: add support for rza series")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-sh.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
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
