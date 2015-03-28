Return-Path: <rtc-linux+bncBAABBN5R3SUAKGQEKCBX7BI@googlegroups.com>
MIME-Version: 1.0
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi. [213.243.153.189])
        by gmr-mx.google.com with ESMTP id b6si364674lbc.1.2015.03.28.14.10.15
        for <rtc-linux@googlegroups.com>;
        Sat, 28 Mar 2015 14:10:15 -0700 (PDT)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [rtc-linux] [PATCH 3/3] rtc: hctosys: use function name in the error log
Date: Sat, 28 Mar 2015 23:09:36 +0200
Message-Id: <1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
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

Use function name in the error log instead of __FILE__.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/rtc/hctosys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index 6c719f2..7748a61 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -33,7 +33,7 @@ static int __init rtc_hctosys(void)
 
 	if (rtc == NULL) {
 		pr_err("%s: unable to open rtc device (%s)\n",
-			__FILE__, CONFIG_RTC_HCTOSYS_DEVICE);
+			__func__, CONFIG_RTC_HCTOSYS_DEVICE);
 		goto err_open;
 	}
 
-- 
2.2.0

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
