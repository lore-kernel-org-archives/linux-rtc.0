Return-Path: <rtc-linux+bncBCHK5U7YZIJRBVPX563AKGQEDCWCF7A@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com. [2a00:1450:4010:c04::236])
        by gmr-mx.google.com with ESMTPS id jx10si289499lbc.2.2016.03.06.01.43.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 01:43:49 -0800 (PST)
Received: by mail-lb0-x236.google.com with SMTP id k15so102222953lbg.0
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 01:43:49 -0800 (PST)
From: Alexander Kochetkov <al.kochet@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexander Kochetkov <al.kochet@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: hym8563: fix invalid year calculation
Date: Sun,  6 Mar 2016 12:43:57 +0300
Message-Id: <1457257437-18975-1-git-send-email-al.kochet@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Year field must be in BCD format, according to
hym8563 datasheet.

Due to the bug year 2016 became 2010.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/rtc/rtc-hym8563.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 097325d..b1b4746 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -144,7 +144,7 @@ static int hym8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	 * it does not seem to carry it over a subsequent write/read.
 	 * So we'll limit ourself to 100 years, starting at 2000 for now.
 	 */
-	buf[6] = tm->tm_year - 100;
+	buf[6] = bin2bcd(tm->tm_year - 100);
 
 	/*
 	 * CTL1 only contains TEST-mode bits apart from stop,
-- 
1.7.9.5

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
