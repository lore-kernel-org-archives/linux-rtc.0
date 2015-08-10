Return-Path: <rtc-linux+bncBCRIZROPVQPBBSECUGXAKGQEWXY6DQA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com. [209.85.192.169])
        by gmr-mx.google.com with ESMTPS id qa1si579358pdb.1.2015.08.09.23.14.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2015 23:14:32 -0700 (PDT)
Received: by pdco4 with SMTP id o4so67773350pdc.3
        for <rtc-linux@googlegroups.com>; Sun, 09 Aug 2015 23:14:32 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: akpm@linux-foundation.org
Cc: linaro-kernel@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	adi-buildroot-devel@lists.sourceforge.net (moderated list:BLACKFIN RTC DRIVER),
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE),
	rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Subject: [rtc-linux] [PATCH V1 Resend 07/11] drivers: rtc: Drop (un)likely
 before IS_ERR(_OR_NULL)
Date: Mon, 10 Aug 2015 11:42:29 +0530
Message-Id: <2ea7e46d3a63b1229889b1e8f0a9976725578189.1439187003.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439187003.git.viresh.kumar@linaro.org>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439187003.git.viresh.kumar@linaro.org>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
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

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
is no need to do that again from its callers. Drop it.

gemini driver was using likely() for a failure case while the rtc driver
is getting registered. That looks wrong and it should really be
unlikely. But because we are killing all the unlikely() flags, lets kill
that too.

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com> (gemini)
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/rtc/interface.c  | 2 +-
 drivers/rtc/rtc-bfin.c   | 2 +-
 drivers/rtc/rtc-gemini.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 11b639067312..5836751b8203 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -564,7 +564,7 @@ enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer)
 void rtc_update_irq(struct rtc_device *rtc,
 		unsigned long num, unsigned long events)
 {
-	if (unlikely(IS_ERR_OR_NULL(rtc)))
+	if (IS_ERR_OR_NULL(rtc))
 		return;
 
 	pm_stay_awake(rtc->dev.parent);
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index 3d44b11721ea..535a5f9338d0 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -361,7 +361,7 @@ static int bfin_rtc_probe(struct platform_device *pdev)
 	/* Register our RTC with the RTC framework */
 	rtc->rtc_dev = devm_rtc_device_register(dev, pdev->name, &bfin_rtc_ops,
 						THIS_MODULE);
-	if (unlikely(IS_ERR(rtc->rtc_dev)))
+	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
 	/* Grab the IRQ and init the hardware */
diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 35f4486738fc..2fed93e1114a 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -148,7 +148,7 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
 					   &gemini_rtc_ops, THIS_MODULE);
-	if (likely(IS_ERR(rtc->rtc_dev)))
+	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
 	return 0;
-- 
2.4.0

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
