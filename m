Return-Path: <rtc-linux+bncBCMNZUWXYYORBAONUOVQKGQEA5ACBNQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com. [209.85.220.48])
        by gmr-mx.google.com with ESMTPS id wh3si274970pbc.0.2015.05.29.15.21.53
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2015 15:21:53 -0700 (PDT)
Received: by pacrp13 with SMTP id rp13so22983000pac.2
        for <rtc-linux@googlegroups.com>; Fri, 29 May 2015 15:21:53 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	sameo@linux.intel.com,
	lee.jones@linaro.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
	zhaoy <zhaoy@marvell.com>
Subject: [rtc-linux] [PATCH 2/4] mfd: 88pm800: use irq_mode to configure
 interrupt status reg clear method
Date: Sat, 30 May 2015 03:49:20 +0530
Message-Id: <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

>From the spec, bit 1 of reg 0xe (page 0): IN_CLEAR_MODE controls the
method of clearing interrupt status register of 88pm800;

  0: clear on read
  1: clear on write

Signed-off-by: zhaoy <zhaoy@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c       | 4 +++-
 include/linux/mfd/88pm80x.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 06ee058..8ea4467 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -391,7 +391,8 @@ static int device_irq_init_800(struct pm80x_chip *chip)
 	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
 	    PM800_WAKEUP2_INT_MASK;
 
-	data = PM800_WAKEUP2_INT_CLEAR;
+	data = (chip->irq_mode) ?
+		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
 	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, data);
 
 	if (ret < 0)
@@ -514,6 +515,7 @@ static int device_800_init(struct pm80x_chip *chip,
 	}
 
 	chip->regmap_irq_chip = &pm800_irq_chip;
+	chip->irq_mode = pdata->irq_mode;
 
 	ret = device_irq_init_800(chip);
 	if (ret < 0) {
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 97cb283..6ed6c16 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -77,6 +77,8 @@ enum {
 #define PM800_WAKEUP2		(0x0E)
 #define PM800_WAKEUP2_INV_INT		(1 << 0)
 #define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
+#define PM800_WAKEUP2_INT_READ_CLEAR		(0 << 1)
+#define PM800_WAKEUP2_INT_WRITE_CLEAR		(1 << 1)
 #define PM800_WAKEUP2_INT_MASK		(1 << 2)
 
 #define PM800_POWER_UP_LOG	(0x10)
-- 
1.9.1

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
