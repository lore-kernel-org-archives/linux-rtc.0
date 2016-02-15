Return-Path: <rtc-linux+bncBCPM5SUWUYIRB6OKQ63AKGQE6P5BHQA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id ff2si2930966pad.2.2016.02.15.06.49.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 06:49:28 -0800 (PST)
Received: by mail-pa0-x242.google.com with SMTP id fl4so7266975pad.2
        for <rtc-linux@googlegroups.com>; Mon, 15 Feb 2016 06:49:28 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 4/4] rtc-rx8025: unsupport UIE mode
Date: Mon, 15 Feb 2016 23:49:09 +0900
Message-Id: <1455547749-5229-4-git-send-email-akinobu.mita@gmail.com>
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

The alarm for rx8025 only has a minute accuracy, so unsupport UIE mode.

pcf8563 and hym8563 also have a minute accuracy and unsupport it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 23fe242..4199556 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -564,6 +564,9 @@ static int rx8025_probe(struct i2c_client *client,
 
 	rx8025->rtc->max_user_freq = 1;
 
+	/* the rx8025 alarm only supports a minute accuracy */
+	rx8025->rtc->uie_unsupported = 1;
+
 	err = rx8025_sysfs_register(&client->dev);
 	return err;
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
