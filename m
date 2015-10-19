Return-Path: <rtc-linux+bncBDULZYNR2QMRBDXISCYQKGQEU3W6FDA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-qg0-x233.google.com (mail-qg0-x233.google.com. [2607:f8b0:400d:c04::233])
        by gmr-mx.google.com with ESMTPS id i140si188251ywe.3.2015.10.18.17.06.38
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2015 17:06:38 -0700 (PDT)
Received: by mail-qg0-x233.google.com with SMTP id o38so100186413qge.0
        for <rtc-linux@googlegroups.com>; Sun, 18 Oct 2015 17:06:38 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH] rtc: isl1208: Pass the IRQF_ONESHOT flag
Date: Sun, 18 Oct 2015 22:06:22 -0200
Message-Id: <1445213182-5214-1-git-send-email-festevam@gmail.com>
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

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
bogus threaded irq requests") threaded IRQs without a primary handler
need to be requested with IRQF_ONESHOT, otherwise the request will fail.

So pass the IRQF_ONESHOT flag in this case.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/irqf_oneshot.cocci

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-isl1208.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index aa3b8f1..b57a304 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -638,7 +638,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (client->irq > 0) {
 		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					       isl1208_rtc_interrupt,
-					       IRQF_SHARED,
+					       IRQF_SHARED | IRQF_ONESHOT,
 					       isl1208_driver.driver.name,
 					       client);
 		if (!rc) {
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
