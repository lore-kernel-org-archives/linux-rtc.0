Return-Path: <rtc-linux+bncBDS7HNEFSALRBW6VTKYAKGQEBTU5YLI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bn1si265545wib.0.2015.09.26.07.25.31
        for <rtc-linux@googlegroups.com>;
        Sat, 26 Sep 2015 07:25:31 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: rx8025: remove unnecessary braces
Date: Sat, 26 Sep 2015 16:25:28 +0200
Message-Id: <1443277528-21977-1-git-send-email-alexandre.belloni@free-electrons.com>
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

braces {} are not necessary for single statement blocks

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 24c3d69ce1b9..bd911bafb809 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -65,6 +65,7 @@
 
 static const struct i2c_device_id rx8025_id[] = {
 	{ "rx8025", 0 },
+	{ "rv8803", 1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rx8025_id);
@@ -518,9 +519,8 @@ static int rx8025_probe(struct i2c_client *client,
 	}
 
 	rx8025 = devm_kzalloc(&client->dev, sizeof(*rx8025), GFP_KERNEL);
-	if (!rx8025) {
+	if (!rx8025)
 		return -ENOMEM;
-	}
 
 	rx8025->client = client;
 	i2c_set_clientdata(client, rx8025);
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
