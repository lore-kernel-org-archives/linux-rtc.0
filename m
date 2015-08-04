Return-Path: <rtc-linux+bncBDS7HNEFSALRBS4TQKXAKGQEYFFENWA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si37236wib.3.2015.08.04.02.45.47
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:47 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 10/15] rtc: rx8025: continue without alarm when
 irq request fails
Date: Tue,  4 Aug 2015 11:45:29 +0200
Message-Id: <1438681534-12027-11-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Instead of bailing out, disable alarms and continue when
devm_request_threaded_irq() fails. This allows to still provide some
functionality.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index bf96f40fd200..ab5fb4fe2a83 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -533,8 +533,8 @@ static int rx8025_probe(struct i2c_client *client,
 						rx8025_handle_irq, 0, "rx8025",
 						client);
 		if (err) {
-			dev_err(&client->dev, "unable to request IRQ\n");
-			return err;
+			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
+			client->irq = 0;
 		}
 	}
 
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
