Return-Path: <rtc-linux+bncBDEKVJM7XAHRBTPG4PBQKGQEKTSFZ7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.134])
        by gmr-mx.google.com with ESMTPS id e134si155117wmd.3.2017.01.13.07.33.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 07:33:33 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 2/3] rtc: stm32: fix building without CONFIG_OF
Date: Fri, 13 Jan 2017 16:32:52 +0100
Message-Id: <20170113153311.2611510-2-arnd@arndb.de>
In-Reply-To: <20170113153311.2611510-1-arnd@arndb.de>
References: <20170113153311.2611510-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The new driver has a stray #ifdef in it that causes a build error:

drivers/rtc/rtc-stm32.c:718:21: error: 'stm32_rtc_of_match' undeclared here (not in a function); did you mean 'stm32_rtc_pm_ops'?

As the #ifdef serves no purpose here, let's just remove it.

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-stm32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 3513e052722f..8c599f52124c 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -490,13 +490,11 @@ static const struct rtc_class_ops stm32_rtc_ops = {
 	.alarm_irq_enable = stm32_rtc_alarm_irq_enable,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id stm32_rtc_of_match[] = {
 	{ .compatible = "st,stm32-rtc" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_rtc_of_match);
-#endif
 
 static int stm32_rtc_init(struct platform_device *pdev,
 			  struct stm32_rtc *rtc)
-- 
2.9.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
