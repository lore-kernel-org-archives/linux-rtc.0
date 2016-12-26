Return-Path: <rtc-linux+bncBDBMPSMMRELRBAX7QPBQKGQEPEGNGSQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com. [2607:f8b0:400e:c05::241])
        by gmr-mx.google.com with ESMTPS id t67si11519045pfd.3.2016.12.26.03.31.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Dec 2016 03:31:14 -0800 (PST)
Received: by mail-pg0-x241.google.com with SMTP id g1so9056966pgn.0
        for <rtc-linux@googlegroups.com>; Mon, 26 Dec 2016 03:31:14 -0800 (PST)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	jason@lakedaemon.net,
	andrew@lunn.ch,
	gregory.clement@free-electrons.com,
	sebastian.hesselbarth@gmail.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: keescook@chromium.org,
	Bhumika Goyal <bhumirks@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
Date: Mon, 26 Dec 2016 17:01:02 +0530
Message-Id: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The object armada38x_rtc_ops of type rtc_class_ops structure is not
modified after getting initialized by armada38x_rtc_probe. Apart from
getting referenced in init it is also passed as an argument to the function
devm_rtc_device_register but this argument is of type const struct
rtc_class_ops *. Therefore add __ro_after_init to its declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/rtc/rtc-armada38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 9a3f2a6..7883c7f 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -202,7 +202,7 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops armada38x_rtc_ops = {
+static struct rtc_class_ops armada38x_rtc_ops __ro_after_init = {
 	.read_time = armada38x_rtc_read_time,
 	.set_time = armada38x_rtc_set_time,
 	.read_alarm = armada38x_rtc_read_alarm,
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
