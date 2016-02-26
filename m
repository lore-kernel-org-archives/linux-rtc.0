Return-Path: <rtc-linux+bncBAABBEPFYG3AKGQESY22OSA@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id ug8si220954igb.3.2016.02.26.07.43.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 07:43:13 -0800 (PST)
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <rtc-linux@googlegroups.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Chanwoo Choi
	<cw00.choi@samsung.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald
	<pmeerw@pmeerw.net>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon
	<nm@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH 0/7] mfd: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:50 +0200
Message-ID: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The IRQF_EARLY_RESUME flag is not required for nested irqs anymore,
since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
over system suspend") was merged.
Hence, this flag can be dropped for MFD cell's devices where MFD interrupt
controller defines nested IRQs as nested threaded IRQs.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>

Grygorii Strashko (7):
  extcon: palmas: Drop IRQF_EARLY_RESUME flag
  rtc: palmas: Drop IRQF_EARLY_RESUME flag
  rtc: tps6586x: Drop IRQF_EARLY_RESUME flag
  rtc: tps65910: Drop IRQF_EARLY_RESUME flag
  rtc: tps80031: Drop IRQF_EARLY_RESUME flag
  rtc: as3722: Drop IRQF_EARLY_RESUME flag
  iio: adc: palmas: Drop IRQF_EARLY_RESUME flag

 drivers/extcon/extcon-palmas.c | 4 ++--
 drivers/iio/adc/palmas_gpadc.c | 6 +++---
 drivers/rtc/rtc-as3722.c       | 2 +-
 drivers/rtc/rtc-palmas.c       | 3 +--
 drivers/rtc/rtc-tps6586x.c     | 2 +-
 drivers/rtc/rtc-tps65910.c     | 2 +-
 drivers/rtc/rtc-tps80031.c     | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.7.2

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
