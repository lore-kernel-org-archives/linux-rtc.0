Return-Path: <rtc-linux+bncBDEZ72H55YIBBWNYU6XAKGQEMFJD62A@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id fy14si160786pdb.2.2015.08.11.04.28.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 04:28:25 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSX018ES17AXT10@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 11 Aug 2015 20:28:22 +0900 (KST)
From: Joonyoung Shim <jy0922.shim@samsung.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 cw00.choi@samsung.com, k.kozlowski@samsung.com, jy0922.shim@samsung.com
Subject: [rtc-linux] [PATCH 4/4] rtc: s3c: enable/disable clocks for alarm
Date: Tue, 11 Aug 2015 20:28:22 +0900
Message-id: <1439292502-22912-4-git-send-email-jy0922.shim@samsung.com>
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

The clock enable/disable codes for alarm have removed from
'commit 24e1455493da ("drivers/rtc/rtc-s3c.c: delete duplicate clock
control")' and the clocks keep disabling even if alarm is set, so alarm
interrupt can't happen.

The s3c_rtc_setaie function can be called several times with that
enabled argument has same value, so it needs to check whether clocks is
enabled or not.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index abe2a6d..fce078c 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -39,6 +39,7 @@ struct s3c_rtc {
 	void __iomem *base;
 	struct clk *rtc_clk;
 	struct clk *rtc_src_clk;
+	bool clk_enabled;
 
 	struct s3c_rtc_data *data;
 
@@ -71,9 +72,12 @@ static void s3c_rtc_enable_clk(struct s3c_rtc *info)
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
-	clk_enable(info->rtc_clk);
-	if (info->data->needs_src_clk)
-		clk_enable(info->rtc_src_clk);
+	if (!info->clk_enabled) {
+		clk_enable(info->rtc_clk);
+		if (info->data->needs_src_clk)
+			clk_enable(info->rtc_src_clk);
+		info->clk_enabled = true;
+	}
 	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
 }
 
@@ -82,9 +86,12 @@ static void s3c_rtc_disable_clk(struct s3c_rtc *info)
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
-	if (info->data->needs_src_clk)
-		clk_disable(info->rtc_src_clk);
-	clk_disable(info->rtc_clk);
+	if (info->clk_enabled) {
+		if (info->data->needs_src_clk)
+			clk_disable(info->rtc_src_clk);
+		clk_disable(info->rtc_clk);
+		info->clk_enabled = false;
+	}
 	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
 }
 
@@ -128,6 +135,11 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 
 	s3c_rtc_disable_clk(info);
 
+	if (enabled)
+		s3c_rtc_enable_clk(info);
+	else
+		s3c_rtc_disable_clk(info);
+
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
