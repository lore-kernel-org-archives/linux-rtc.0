Return-Path: <rtc-linux+bncBCQPVKWLVAIRBSEQ4LDAKGQEVYTG7PY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id s67si1470217pfs.4.2017.03.26.20.34.32
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Mar 2017 20:34:32 -0700 (PDT)
From: Tony Lindgren <tony@atomide.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: [rtc-linux] [PATCH] rtc: cpcap: fix improper use of IRQ_NONE for request_threaded_irq
Date: Sun, 26 Mar 2017 20:34:23 -0700
Message-Id: <20170327033423.4536-1-tony@atomide.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

There's a funny typo where IRQ_NONE is used instead of IRQF_TRIGGER_NONE
for request_threaded_irq(). Let's fix it before it gets copied elsewhere.

Fixes: dd3bf50b35e3 ("rtc: cpcap: new rtc driver")
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/rtc/rtc-cpcap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
--- a/drivers/rtc/rtc-cpcap.c
+++ b/drivers/rtc/rtc-cpcap.c
@@ -275,7 +275,7 @@ static int cpcap_rtc_probe(struct platform_device *pdev)
 
 	rtc->alarm_irq = platform_get_irq(pdev, 0);
 	err = devm_request_threaded_irq(dev, rtc->alarm_irq, NULL,
-					cpcap_rtc_alarm_irq, IRQ_NONE,
+					cpcap_rtc_alarm_irq, IRQF_TRIGGER_NONE,
 					"rtc_alarm", rtc);
 	if (err) {
 		dev_err(dev, "Could not request alarm irq: %d\n", err);
@@ -291,7 +291,7 @@ static int cpcap_rtc_probe(struct platform_device *pdev)
 	 */
 	rtc->update_irq = platform_get_irq(pdev, 1);
 	err = devm_request_threaded_irq(dev, rtc->update_irq, NULL,
-					cpcap_rtc_update_irq, IRQ_NONE,
+					cpcap_rtc_update_irq, IRQF_TRIGGER_NONE,
 					"rtc_1hz", rtc);
 	if (err) {
 		dev_err(dev, "Could not request update irq: %d\n", err);
-- 
2.12.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
