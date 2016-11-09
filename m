Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB2W7RHAQKGQEPTR26HY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id 18si1483521wmr.1.2016.11.08.16.38.02
        for <rtc-linux@googlegroups.com>;
        Tue, 08 Nov 2016 16:38:02 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Paul Cercueil <paul@crapouillou.net>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: jz4740: remove unused EXPORT_SYMBOL
Date: Wed,  9 Nov 2016 01:37:52 +0100
Message-Id: <20161109003753.29759-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

jz4740_rtc_poweroff() is only called from the driver, stop exporting it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-jz4740.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 33ccd73ee947..18feae6c4e95 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -252,12 +252,11 @@ static irqreturn_t jz4740_rtc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-void jz4740_rtc_poweroff(struct device *dev)
+static void jz4740_rtc_poweroff(struct device *dev)
 {
 	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
 	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_HIBERNATE, 1);
 }
-EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
 
 static void jz4740_rtc_power_off(void)
 {
-- 
2.10.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
