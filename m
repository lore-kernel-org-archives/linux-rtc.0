Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIVCYG5QKGQEJAZLP4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a6si320182wma.1.2016.06.26.15.03.14
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Jun 2016 15:03:14 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 3/5] rtc: ds2404: move rtc-ds2404.h to platform_data
Date: Mon, 27 Jun 2016 00:03:01 +0200
Message-Id: <1466978583-13310-3-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc-ds2404.h belongs to include/linux/platform_data/

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds2404.c                       | 2 +-
 include/linux/{ => platform_data}/rtc-ds2404.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{ => platform_data}/rtc-ds2404.h (100%)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 16310fe79d76..9a1582ed7070 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -13,7 +13,7 @@
 #include <linux/rtc.h>
 #include <linux/types.h>
 #include <linux/bcd.h>
-#include <linux/rtc-ds2404.h>
+#include <linux/platform_data/rtc-ds2404.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
diff --git a/include/linux/rtc-ds2404.h b/include/linux/platform_data/rtc-ds2404.h
similarity index 100%
rename from include/linux/rtc-ds2404.h
rename to include/linux/platform_data/rtc-ds2404.h
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
