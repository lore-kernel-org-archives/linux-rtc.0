Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6FQYXEQKGQECTPZR3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p127si264534wme.2.2017.06.02.05.22.16
        for <rtc-linux@googlegroups.com>;
        Fri, 02 Jun 2017 05:22:16 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/5] rtc: dev: remove rtc->name from debug message
Date: Fri,  2 Jun 2017 14:21:54 +0200
Message-Id: <20170602122157.4677-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
References: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc->name is superfluous here because the rtc is already registered at that
point and its name has already been printed.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index e81a8711fea7..794bc4fa4937 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -464,7 +464,7 @@ void rtc_dev_prepare(struct rtc_device *rtc)
 		return;
 
 	if (rtc->id >= RTC_DEV_MAX) {
-		dev_dbg(&rtc->dev, "%s: too many RTC devices\n", rtc->name);
+		dev_dbg(&rtc->dev, "too many RTC devices\n");
 		return;
 	}
 
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
