Return-Path: <rtc-linux+bncBDKZNNNLXAHBBZ4OWG4QKGQE3HG5FEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id xo2si2674355pab.0.2016.05.06.00.27.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 00:27:35 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O6Q00DGKVDVDI00@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 06 May 2016 08:27:31 +0100 (BST)
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
Subject: [rtc-linux] [PATCH v6 4/9] mfd: max8997: Change irq names to upper case
Date: Fri, 06 May 2016 09:27:11 +0200
Message-id: <1462519636-3250-3-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Robert Baldyga <r.baldyga@samsung.com>

This patch changes naming convention of MUIC interrupts form CamelCase
to upper case. It makes names more readable and consistent with another
interrupt names in max8997 driver.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

[For the mfd part]
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
[k.kozlowski: Collect acks, rebase on v4.6-rc6]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/extcon/extcon-max8997.c     | 32 ++++++++++++++++----------------
 include/linux/mfd/max8997-private.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9d27cc23038f..68754ac2c8ea 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -46,15 +46,15 @@ struct max8997_muic_irq {
 };
 
 static struct max8997_muic_irq muic_irqs[] = {
-	{ MAX8997_MUICIRQ_ADCError,	"muic-ADCERROR" },
-	{ MAX8997_MUICIRQ_ADCLow,	"muic-ADCLOW" },
-	{ MAX8997_MUICIRQ_ADC,		"muic-ADC" },
-	{ MAX8997_MUICIRQ_VBVolt,	"muic-VBVOLT" },
-	{ MAX8997_MUICIRQ_DBChg,	"muic-DBCHG" },
-	{ MAX8997_MUICIRQ_DCDTmr,	"muic-DCDTMR" },
-	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
-	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
-	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
+	{ MAX8997_MUICIRQ_ADCERROR,	"MUIC-ADCERROR" },
+	{ MAX8997_MUICIRQ_ADCLOW,	"MUIC-ADCLOW" },
+	{ MAX8997_MUICIRQ_ADC,		"MUIC-ADC" },
+	{ MAX8997_MUICIRQ_VBVOLT,	"MUIC-VBVOLT" },
+	{ MAX8997_MUICIRQ_DBCHG,	"MUIC-DBCHG" },
+	{ MAX8997_MUICIRQ_DCDTMR,	"MUIC-DCDTMR" },
+	{ MAX8997_MUICIRQ_CHGDETRUN,	"MUIC-CHGDETRUN" },
+	{ MAX8997_MUICIRQ_CHGTYP,	"MUIC-CHGTYP" },
+	{ MAX8997_MUICIRQ_OVP,		"MUIC-OVP" },
 };
 
 /* Define supported cable type */
@@ -540,17 +540,17 @@ static void max8997_muic_irq_work(struct work_struct *work)
 	}
 
 	switch (irq_type) {
-	case MAX8997_MUICIRQ_ADCError:
-	case MAX8997_MUICIRQ_ADCLow:
+	case MAX8997_MUICIRQ_ADCERROR:
+	case MAX8997_MUICIRQ_ADCLOW:
 	case MAX8997_MUICIRQ_ADC:
 		/* Handle all of cable except for charger cable */
 		ret = max8997_muic_adc_handler(info);
 		break;
-	case MAX8997_MUICIRQ_VBVolt:
-	case MAX8997_MUICIRQ_DBChg:
-	case MAX8997_MUICIRQ_DCDTmr:
-	case MAX8997_MUICIRQ_ChgDetRun:
-	case MAX8997_MUICIRQ_ChgTyp:
+	case MAX8997_MUICIRQ_VBVOLT:
+	case MAX8997_MUICIRQ_DBCHG:
+	case MAX8997_MUICIRQ_DCDTMR:
+	case MAX8997_MUICIRQ_CHGDETRUN:
+	case MAX8997_MUICIRQ_CHGTYP:
 		/* Handle charger cable */
 		ret = max8997_muic_chg_handler(info);
 		break;
diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/max8997-private.h
index f42ea222988f..2817fa69383e 100644
--- a/include/linux/mfd/max8997-private.h
+++ b/include/linux/mfd/max8997-private.h
@@ -411,14 +411,14 @@ enum max8997_irq {
 
 enum max8997_irq_muic {
 	MAX8997_MUICIRQ_ADC,
-	MAX8997_MUICIRQ_ADCLow,
-	MAX8997_MUICIRQ_ADCError,
-
-	MAX8997_MUICIRQ_ChgTyp,
-	MAX8997_MUICIRQ_ChgDetRun,
-	MAX8997_MUICIRQ_DCDTmr,
-	MAX8997_MUICIRQ_DBChg,
-	MAX8997_MUICIRQ_VBVolt,
+	MAX8997_MUICIRQ_ADCLOW,
+	MAX8997_MUICIRQ_ADCERROR,
+
+	MAX8997_MUICIRQ_CHGTYP,
+	MAX8997_MUICIRQ_CHGDETRUN,
+	MAX8997_MUICIRQ_DCDTMR,
+	MAX8997_MUICIRQ_DBCHG,
+	MAX8997_MUICIRQ_VBVOLT,
 
 	MAX8997_MUICIRQ_OVP,
 
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
