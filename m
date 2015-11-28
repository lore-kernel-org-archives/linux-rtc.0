Return-Path: <rtc-linux+bncBDU5DXUG4MFRBE5R46ZAKGQES5562HA@googlegroups.com>
MIME-Version: 1.0
Received: from youngberry.canonical.com (youngberry.canonical.com. [91.189.89.112])
        by gmr-mx.google.com with ESMTPS id g21si449133wmd.3.2015.11.28.08.38.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 28 Nov 2015 08:38:42 -0800 (PST)
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: imxdi: fix spelling mistake in warning message
Date: Sat, 28 Nov 2015 16:38:40 +0000
Message-Id: <1448728720-9214-1-git-send-email-colin.king@canonical.com>
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

From: Colin Ian King <colin.king@canonical.com>

Minor issue, fix spelling mistake, happend -> happened

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-imxdi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 7bffd7f..8d8049bd 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -303,7 +303,7 @@ static int di_handle_invalid_state(struct imxdi_dev *imxdi, u32 dsr)
 	sec = readl(imxdi->ioaddr + DTCMR);
 	if (sec != 0)
 		dev_warn(&imxdi->pdev->dev,
-			 "The security violation has happend at %u seconds\n",
+			 "The security violation has happened at %u seconds\n",
 			 sec);
 	/*
 	 * the timer cannot be set/modified if
-- 
2.6.2

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
