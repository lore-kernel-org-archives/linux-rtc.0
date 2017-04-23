Return-Path: <rtc-linux+bncBAABBD6F6LDQKGQEG4FEVKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from m50-132.163.com (m50-132.163.com. [123.125.50.132])
        by gmr-mx.google.com with ESMTP id w197si2616301pfd.3.2017.04.23.05.48.14
        for <rtc-linux@googlegroups.com>;
        Sun, 23 Apr 2017 05:48:15 -0700 (PDT)
From: Pan Bian <bianpan201602@163.com>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>
Subject: [rtc-linux] [PATCH 1/1] rtc: gemini: add return value validation
Date: Sun, 23 Apr 2017 20:48:07 +0800
Message-Id: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Pan Bian <bianpan2016@163.com>

Function devm_ioremap() will return a NULL pointer if it fails to remap
IO address, and its return value should be validated before it is used.
However, in function gemini_rtc_probe(), its return value is not
checked. This may result in bad memory access bugs on future access,
e.g. calling the function gemini_rtc_read_time().

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/rtc/rtc-gemini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index ccf0dba..5279390 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -139,6 +139,8 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc_base = devm_ioremap(dev, res->start,
 				     resource_size(res));
+	if (!rtc->rtc_base)
+		return -ENOMEM;
 
 	ret = devm_request_irq(dev, rtc->rtc_irq, gemini_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
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
