Return-Path: <rtc-linux+bncBCEJHTXX7MFBBDMY4C4AKGQE54SCL6A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kmu-office.ch (mail.kmu-office.ch. [178.209.48.109])
        by gmr-mx.google.com with ESMTPS id d92si477262wma.2.2016.04.20.16.09.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 16:09:01 -0700 (PDT)
From: Stefan Agner <stefan@agner.ch>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [rtc-linux] [PATCH] rtc: snvs: return error in case enable_irq_wake fails
Date: Wed, 20 Apr 2016 16:09:57 -0700
Message-Id: <1461193797-18015-1-git-send-email-stefan@agner.ch>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If enable_irq_wake fails, we should return that error code so that
entering suspend fails. Otherwise we will get a WARNING along with
the hint of a unbalanced wake disable:
Unbalanced IRQ 37 wake disable

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/rtc/rtc-snvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 950c5d0..0f11c2a2 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -322,7 +322,7 @@ static int snvs_rtc_suspend(struct device *dev)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(data->irq);
+		return enable_irq_wake(data->irq);
 
 	return 0;
 }
-- 
2.8.0

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
