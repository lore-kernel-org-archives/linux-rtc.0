Return-Path: <rtc-linux+bncBC2IT2GSZUDRBC4W6LBQKGQE2N75N5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com. [91.207.212.93])
        by gmr-mx.google.com with ESMTPS id 66si109003wml.3.2017.01.16.00.57.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jan 2017 00:57:47 -0800 (PST)
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Amelie Delaunay
	<amelie.delaunay@st.com>
Subject: [rtc-linux] [PATCH] rtc: stm32: use 0 instead of ~PWR_CR_DBP in regmap_update_bits
Date: Mon, 16 Jan 2017 09:57:38 +0100
Message-ID: <1484557058-21601-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Using the ~ operator on a BIT() constant results in a large 'unsigned long'
constant that won't fit into an 'unsigned int' function argument on 64-bit
architectures, resulting in a harmless build warning in x86 allmodconfig:

drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
  regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);

As PWR_CR_DBP mask prevents other bits to be cleared, replace all
~PWR_CR_DBP by 0.

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 8c599f5..03c97c1 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -648,7 +648,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 err:
 	clk_disable_unprepare(rtc->ck_rtc);
 
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
 
 	device_init_wakeup(&pdev->dev, false);
 
@@ -670,7 +670,7 @@ static int stm32_rtc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(rtc->ck_rtc);
 
 	/* Enable backup domain write protection */
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
 
 	device_init_wakeup(&pdev->dev, false);
 
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
