Return-Path: <rtc-linux+bncBDS7HNEFSALRBGENZ23AKGQEMWKTCXI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c140si228571wmh.1.2016.02.28.15.45.28
        for <rtc-linux@googlegroups.com>;
        Sun, 28 Feb 2016 15:45:28 -0800 (PST)
Date: Mon, 29 Feb 2016 00:45:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>, rtc-linux@googlegroups.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nsekhar@ti.com, linux-omap@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 0/7] mfd: Drop IRQF_EARLY_RESUME flag
Message-ID: <20160228234517.GB3190@piout.net>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 26/02/2016 at 17:42:50 +0200, Grygorii Strashko wrote :
> The IRQF_EARLY_RESUME flag is not required for nested irqs anymore,
> since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
> over system suspend") was merged.
> Hence, this flag can be dropped for MFD cell's devices where MFD interrupt
> controller defines nested IRQs as nested threaded IRQs.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Grygorii Strashko (7):
>   extcon: palmas: Drop IRQF_EARLY_RESUME flag
>   rtc: palmas: Drop IRQF_EARLY_RESUME flag
>   rtc: tps6586x: Drop IRQF_EARLY_RESUME flag
>   rtc: tps65910: Drop IRQF_EARLY_RESUME flag
>   rtc: tps80031: Drop IRQF_EARLY_RESUME flag
>   rtc: as3722: Drop IRQF_EARLY_RESUME flag
>   iio: adc: palmas: Drop IRQF_EARLY_RESUME flag
> 
>  drivers/extcon/extcon-palmas.c | 4 ++--
>  drivers/iio/adc/palmas_gpadc.c | 6 +++---
>  drivers/rtc/rtc-as3722.c       | 2 +-
>  drivers/rtc/rtc-palmas.c       | 3 +--
>  drivers/rtc/rtc-tps6586x.c     | 2 +-
>  drivers/rtc/rtc-tps65910.c     | 2 +-
>  drivers/rtc/rtc-tps80031.c     | 2 +-
>  7 files changed, 10 insertions(+), 11 deletions(-)
> 

I applied all the rtc related patches, thanks!

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
