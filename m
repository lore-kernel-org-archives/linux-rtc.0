Return-Path: <rtc-linux+bncBC4IFTUFXEFBBIO64GWQKGQEKVM3BTI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com. [209.85.220.54])
        by gmr-mx.google.com with ESMTPS id ff6si3978152pac.2.2015.07.28.23.13.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 23:13:53 -0700 (PDT)
Received: by pacan13 with SMTP id an13so91298pac.1
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 23:13:53 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Deepak Saxena <dsaxena@plexity.net>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: fix typo for author email
Date: Wed, 29 Jul 2015 14:13:40 +0800
Message-Id: <1438150420-15035-1-git-send-email-leo.yan@linaro.org>
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

The email address missed character ">", so add it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/rtc/rtc-pl031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 99181fff..41dcb7d 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -476,6 +476,6 @@ static struct amba_driver pl031_driver = {
 
 module_amba_driver(pl031_driver);
 
-MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net");
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
 MODULE_DESCRIPTION("ARM AMBA PL031 RTC Driver");
 MODULE_LICENSE("GPL");
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
