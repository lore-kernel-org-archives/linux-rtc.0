Return-Path: <rtc-linux+bncBDKZNNNLXAHBBY5IR25QKGQEHWT7CYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id i135si1053364pfe.0.2016.06.16.23.10.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 23:10:43 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8W00J99JTRPP10@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 17 Jun 2016 07:10:39 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: r.baldyga@hackerion.com,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] [RESEND v7 0/6] regulator: mfd: max8997: Add regmap
Date: Fri, 17 Jun 2016 08:10:27 +0200
Message-id: <1466143833-5856-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Dear Mark,

I'm pushing old Robert's work and I miss only ack from you.
Could you take a look at patch 1/6?


Changes since v6
================
1. Add some acks.
2. Remove patches already applied.


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  extcon: max8997: Fix handling error code of regmap_irq_get_virq()
  rtc: max8997: Check for ERRNO of regmap_irq_get_virq()
  extcon: max8997: Fix inconsistent indenting

Robert Baldyga (3):
  mfd: max8997: Use regmap to access registers
  mfd: max8997: handle IRQs using regmap
  mfd: max8997: Change irq names to upper case

 drivers/extcon/extcon-max8997.c       |  72 +++----
 drivers/input/misc/max8997_haptic.c   |  34 +--
 drivers/leds/leds-max8997.c           |  13 +-
 drivers/mfd/Kconfig                   |   3 +-
 drivers/mfd/Makefile                  |   2 +-
 drivers/mfd/max8997-irq.c             | 383 ----------------------------------
 drivers/mfd/max8997.c                 | 245 +++++++++++++++-------
 drivers/power/max8997_charger.c       |  33 +--
 drivers/regulator/max8997-regulator.c |  87 ++++----
 drivers/rtc/rtc-max8997.c             |  60 +++---
 include/linux/mfd/max8997-private.h   |  82 ++++++--
 11 files changed, 385 insertions(+), 629 deletions(-)
 delete mode 100644 drivers/mfd/max8997-irq.c

-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
