Return-Path: <rtc-linux+bncBC2IT2GSZUDRBSFX6LBQKGQEXNEWBEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id l66si847454wml.0.2017.01.16.02.09.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jan 2017 02:09:12 -0800 (PST)
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
Subject: [rtc-linux] [PATCH] rtc: stm32: fix comparison warnings
Date: Mon, 16 Jan 2017 11:08:53 +0100
Message-ID: <1484561333-12087-1-git-send-email-amelie.delaunay@st.com>
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

This patches fixes comparison between signed and unsigned values as it
could produce an incorrect result when the signed value is converted to
unsigned:

drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_valid_alrm':
drivers/rtc/rtc-stm32.c:404:21: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if ((((tm->tm_year > cur_year) &&
...

It also fixes comparison always true or false due to the fact that unsigned
value is compared against zero with >= or <:

drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_init':
drivers/rtc/rtc-stm32.c:514:35: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  for (pred_a = pred_a_max; pred_a >= 0; pred_a-- ) {

drivers/rtc/rtc-stm32.c:530:44: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
     (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?

Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 03c97c1..bd57eb1 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -383,7 +383,7 @@ static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
 {
-	unsigned int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
+	int cur_day, cur_mon, cur_year, cur_hour, cur_min, cur_sec;
 	unsigned int dr = readl_relaxed(rtc->base + STM32_RTC_DR);
 	unsigned int tr = readl_relaxed(rtc->base + STM32_RTC_TR);
 
@@ -509,7 +509,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
 	pred_s_max = STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
 
-	for (pred_a = pred_a_max; pred_a >= 0; pred_a--) {
+	for (pred_a = pred_a_max; pred_a + 1 > 0; pred_a--) {
 		pred_s = (rate / (pred_a + 1)) - 1;
 
 		if (((pred_s + 1) * (pred_a + 1)) == rate)
@@ -525,7 +525,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 		pred_s = (rate / (pred_a + 1)) - 1;
 
 		dev_warn(&pdev->dev, "ck_rtc is %s\n",
-			 (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?
+			 (rate < ((pred_a + 1) * (pred_s + 1))) ?
 			 "fast" : "slow");
 	}
 
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
