Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: at91sam9: remove duplicate assignment of variable mr
Date: Mon, 28 Mar 2016 12:24:00 +0100
Message-Id: <1459164240-6731-1-git-send-email-colin.king@canonical.com>
List-ID: <rtc-linux.googlegroups.com>

From: Colin Ian King <colin.king@canonical.com>

mr is written twice with the same value, remove one of the
redundant assignments to mr.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-at91sam9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7206e2f..99732e6 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -268,7 +268,7 @@ static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	struct sam9_rtc *rtc = dev_get_drvdata(dev);
-	u32 mr = mr = rtt_readl(rtc, MR);
+	u32 mr = rtt_readl(rtc, MR);
 
 	seq_printf(seq, "update_IRQ\t: %s\n",
 			(mr & AT91_RTT_RTTINCIEN) ? "yes" : "no");
-- 
2.7.4
