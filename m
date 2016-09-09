Return-Path: <rtc-linux+bncBD35ZY754EARBFESZK7AKGQEPSHBXCA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id z4si402176pam.0.2016.09.09.03.04.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2016 03:04:04 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id gi6so3645085pac.1
        for <rtc-linux@googlegroups.com>; Fri, 09 Sep 2016 03:04:04 -0700 (PDT)
From: Axel Lin <axel.lin@ingics.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Axel Lin <axel.lin@ingics.com>
Subject: [rtc-linux] [PATCH] rtc: ac100: Add NULL checking for devm_kzalloc call
Date: Fri,  9 Sep 2016 18:03:54 +0800
Message-Id: <1473415434-18956-1-git-send-email-axel.lin@ingics.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

devm_kzalloc can return NULL, add NULL checking to prevent NULL pointer
dereference.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/rtc/rtc-ac100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 2d0bb02..9e33618 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -554,6 +554,9 @@ static int ac100_rtc_probe(struct platform_device *pdev)
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, chip);
 	chip->dev = &pdev->dev;
 	chip->regmap = ac100->regmap;
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
