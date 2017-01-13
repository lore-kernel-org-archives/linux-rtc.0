Return-Path: <rtc-linux+bncBDEKVJM7XAHRBP7G4PBQKGQELKM4VHQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.135])
        by gmr-mx.google.com with ESMTPS id i196si150354wmd.3.2017.01.13.07.33.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 07:33:18 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 1/3] rtc: stm32: remove __exit annotation on
 remove callback
Date: Fri, 13 Jan 2017 16:32:51 +0100
Message-Id: <20170113153311.2611510-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The remove function can be called at runtime for a manual 'unbind'
operation and must not be left out from a built-in driver, as kbuild
complains:

`stm32_rtc_remove' referenced in section `.data.stm32_rtc_driver' of drivers/rtc/rtc-stm32.o: defined in discarded section `.exit.text' of drivers/rtc/rtc-stm32.o

This removes the extraneous annotation.

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index c4789b5a5d81..3513e052722f 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -657,7 +657,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit stm32_rtc_remove(struct platform_device *pdev)
+static int stm32_rtc_remove(struct platform_device *pdev)
 {
 	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
 	unsigned int cr;
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
