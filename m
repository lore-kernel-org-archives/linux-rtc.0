Return-Path: <rtc-linux+bncBAABBWEPQCYAKGQEPVGQIAQ@googlegroups.com>
MIME-Version: 1.0
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id w5si3187418pbt.1.2015.09.21.06.36.23
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 06:36:24 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NV100MUG4GJDS30@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 21 Sep 2015 14:36:19 +0100 (BST)
From: Andrzej Hajda <a.hajda@samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 24/38] rtc: opal: fix type of token
Date: Mon, 21 Sep 2015 15:33:56 +0200
Message-id: <1442842450-29769-25-git-send-email-a.hajda@samsung.com>
In-reply-to: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
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

The variable can take signed values.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/rtc/rtc-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 6fbf9e6..590e1a4 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -152,10 +152,10 @@ exit:
 /* Set Timed Power-On */
 static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	u64 h_m_s_ms = 0, token;
+	u64 h_m_s_ms = 0;
 	struct opal_msg msg;
 	u32 y_m_d = 0;
-	int rc;
+	int token, rc;
 
 	tm_to_opal(&alarm->time, &y_m_d, &h_m_s_ms);
 
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
