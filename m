Return-Path: <rtc-linux+bncBDKZNNNLXAHBB2GVXK5AKGQEJGMMJAQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id tp10si8278008pac.2.2016.06.01.02.29.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 01 Jun 2016 02:29:12 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8300GCD6CK5C60@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 01 Jun 2016 10:29:08 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] [PATCH v7 0/6] mfd: (multiple trees): max8997: Add regmap
Date: Wed, 01 Jun 2016 11:28:53 +0200
Message-id: <1464773339-756-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,


I'm pushing old Robert's work. I miss only ack from regulator subsystem.
Mark, could you take a look at patch 1/6?

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
