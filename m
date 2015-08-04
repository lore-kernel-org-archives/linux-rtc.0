Return-Path: <rtc-linux+bncBDS7HNEFSALRBTETQKXAKGQE4KWQEWI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si47221wib.1.2015.08.04.02.45.47
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:47 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 14/15] rtc: rx8025: fix RX8025_BIT_CTRL2_CTFG initialization
Date: Tue,  4 Aug 2015 11:45:33 +0200
Message-Id: <1438681534-12027-15-git-send-email-alexandre.belloni@free-electrons.com>
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

RX8025_BIT_CTRL2_CTFG was set to 0 only when it was already 0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index f9b86b92943f..f3f1de26c228 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -270,7 +270,7 @@ static int rx8025_init_client(struct i2c_client *client)
 		need_clear = 1;
 	}
 
-	if (!(ctrl[1] & RX8025_BIT_CTRL2_CTFG))
+	if (ctrl[1] & RX8025_BIT_CTRL2_CTFG)
 		need_clear = 1;
 
 	if (need_clear) {
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
