Return-Path: <rtc-linux+bncBCAP3QEPQIDBBV7J53CAKGQEWFVRT4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com. [2607:f8b0:400e:c05::244])
        by gmr-mx.google.com with ESMTPS id h130si762601pfe.1.2017.02.08.16.16.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 16:16:22 -0800 (PST)
Received: by mail-pg0-x244.google.com with SMTP id 204so16168236pge.2
        for <rtc-linux@googlegroups.com>; Wed, 08 Feb 2017 16:16:22 -0800 (PST)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH -next] rtc: sun6i: Fix return value check in sun6i_rtc_clk_init()
Date: Thu,  9 Feb 2017 00:16:13 +0000
Message-Id: <20170209001613.21665-1-weiyj.lk@gmail.com>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function of_io_request_and_map() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 08510ca..39cbc12 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -202,7 +202,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	spin_lock_init(&rtc->lock);
 
 	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (!rtc->base) {
+	if (IS_ERR(rtc->base)) {
 		pr_crit("Can't map RTC registers");
 		return;
 	}

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
