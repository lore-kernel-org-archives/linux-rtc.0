Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBHMY6TAAKGQEEG5YE4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id 18si875760wmr.0.2016.11.04.15.30.53
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Nov 2016 15:30:53 -0700 (PDT)
Date: Fri, 4 Nov 2016 23:30:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	"David S. Miller" <davem@davemloft.net>, rtc-linux@googlegroups.com,
	sparclinux@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: remove modular usage from
 non-modular code
Message-ID: <20161104223053.luroc2zcwfmppejo@piout.net>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161031185527.20279-1-paul.gortmaker@windriver.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/10/2016 at 14:55:24 -0400, Paul Gortmaker wrote :
> My ongoing audit looking for non-modular code that needlessly uses
> modular macros (vs. built-in equivalents) and/or has dead code
> relating to module unloading that can never be executed led to the
> creation of these rtc related commits.
> 
> For anyone new to the underlying goal of this cleanup, we are trying to
> not use module support for code that can never be built as a module since:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other code and spreads like weeds.
> 
> Build tested on current linux-next (sparc32) to ensure no silly typos
> or implicit include issues that would break compilation crept in.
> 
> ---
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: rtc-linux@googlegroups.com
> Cc: sparclinux@vger.kernel.org
> 
> Paul Gortmaker (3):
>   rtc: make rtc-lib explicitly non-modular
>   rtc: sparc: make starfire explicitly non-modular
>   rtc: sparc: make sun4v explicitly non-modular
> 
>  drivers/rtc/rtc-lib.c      |  4 +---
>  drivers/rtc/rtc-starfire.c | 10 ++++------
>  drivers/rtc/rtc-sun4v.c    | 10 ++++------
>  3 files changed, 9 insertions(+), 15 deletions(-)
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
