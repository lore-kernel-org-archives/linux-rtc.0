Return-Path: <rtc-linux+bncBDHPTCWTXEHRBN4O6CVQKGQEC6CPUCA@googlegroups.com>
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id q10si217901wiz.0.2015.06.13.03.34.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jun 2015 03:34:30 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: hym8563: make the irq optional
Date: Sat, 13 Jun 2015 12:34:04 +0200
Message-ID: <2559079.JyXCpe7EYV@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Sometimes the irq line is not connected to any soc-pin. This does
not hinder basic timekeeping functionality of the rtc, so probe
should not fail in this case.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/rtc/haoyu,hym8563.txt          |  2 +-
 drivers/rtc/rtc-hym8563.c                              | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
index 5c199ee..a8934fe 100644
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
@@ -6,11 +6,11 @@ as well as a clock output of up to 32kHz.
 Required properties:
 - compatible: should be: "haoyu,hym8563"
 - reg: i2c address
-- interrupts: rtc alarm/event interrupt
 - #clock-cells: the value should be 0
 
 Optional properties:
 - clock-output-names: From common clock binding
+- interrupts: rtc alarm/event interrupt
 
 Example:
 
diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 0f710e9..e9da795 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -548,14 +548,16 @@ static int hym8563_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, hym8563_irq,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					client->name, hym8563);
-	if (ret < 0) {
-		dev_err(&client->dev, "irq %d request failed, %d\n",
-			client->irq, ret);
-		return ret;
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, hym8563_irq,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						client->name, hym8563);
+		if (ret < 0) {
+			dev_err(&client->dev, "irq %d request failed, %d\n",
+				client->irq, ret);
+			return ret;
+		}
 	}
 
 	/* check state of calendar information */
-- 
2.1.4


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
