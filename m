Return-Path: <rtc-linux+bncBCPM5SUWUYIRB5GKQ63AKGQERGQGCDY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id yd9si201422pab.1.2016.02.15.06.49.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 06:49:24 -0800 (PST)
Received: by mail-pa0-x241.google.com with SMTP id yy13so7279087pab.1
        for <rtc-linux@googlegroups.com>; Mon, 15 Feb 2016 06:49:24 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/4] rtc-rx8025: protect ctrl1 register update by rtc->ops_lock
Date: Mon, 15 Feb 2016 23:49:07 +0900
Message-Id: <1455547749-5229-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1455547749-5229-1-git-send-email-akinobu.mita@gmail.com>
References: <1455547749-5229-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The ctrl1 register is accessed by alarm operations.  But it is updated
in threaded interrupt handler without acquiring rtc->ops_lock.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 561248a..e667f01 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -147,8 +147,10 @@ static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
 	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
+	struct mutex *lock = &rx8025->rtc->ops_lock;
 	int status;
 
+	mutex_lock(lock);
 	status = rx8025_read_reg(client, RX8025_REG_CTRL2);
 	if (status < 0)
 		goto out;
@@ -173,6 +175,8 @@ static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 	}
 
 out:
+	mutex_unlock(lock);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.5.0

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
