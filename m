Return-Path: <rtc-linux+bncBCNJ5VGR4ANRBWPZW3CAKGQE2P54SVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com. [192.185.145.3])
        by gmr-mx.google.com with ESMTPS id i64si923845itb.2.2017.01.29.01.58.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jan 2017 01:58:49 -0800 (PST)
Received: from cm4.websitewelcome.com (unknown [108.167.139.16])
	by gateway30.websitewelcome.com (Postfix) with ESMTP id 3778612157
	for <rtc-linux@googlegroups.com>; Sun, 29 Jan 2017 03:58:49 -0600 (CST)
From: Guy Shapiro <guy.shapiro@mobi-wize.com>
To: alexandre.belloni@free-electrons.com
Cc: sre@kernel.org,
	shawnguo@kernel.org,
	Frank.Li@freescale.com,
	fabio.estevam@nxp.com,
	a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: [rtc-linux] [PATCH] rtc: snvs: add a missing write sync
Date: Sun, 29 Jan 2017 11:57:19 +0200
Message-Id: <1485683839-8843-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The clear of the LPTA_EN flag should be synced before writing to the
alarm register. Omitting this synchronization creates a race when
trying to change existing alarm.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 drivers/rtc/rtc-snvs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0f11c2a..d51b07d 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -184,6 +184,7 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	rtc_tm_to_time(alrm_tm, &time);
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
+	rtc_write_sync_lp(data);
 	regmap_write(data->regmap, data->offset + SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
