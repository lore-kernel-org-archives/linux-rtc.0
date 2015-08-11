Return-Path: <rtc-linux+bncBDEZ72H55YIBBWFYU6XAKGQEM7BNBEQ@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id fy14si160786pdb.2.2015.08.11.04.28.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 04:28:24 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSX02V3I17AUWD0@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 11 Aug 2015 20:28:22 +0900 (KST)
From: Joonyoung Shim <jy0922.shim@samsung.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 cw00.choi@samsung.com, k.kozlowski@samsung.com, jy0922.shim@samsung.com
Subject: [rtc-linux] [PATCH 2/4] rtc: s3c: remove unnecessary NULL assignment
Date: Tue, 11 Aug 2015 20:28:20 +0900
Message-id: <1439292502-22912-2-git-send-email-jy0922.shim@samsung.com>
In-reply-to: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
References: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
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

It's unnecessary the code that assigns info->rtc_clk to NULL in
s3c_rtc_remove.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d1866a4..44b2921 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -413,7 +413,6 @@ static int s3c_rtc_remove(struct platform_device *pdev)
 	if (info->data->needs_src_clk)
 		clk_unprepare(info->rtc_src_clk);
 	clk_unprepare(info->rtc_clk);
-	info->rtc_clk = NULL;
 
 	return 0;
 }
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
