Return-Path: <rtc-linux+bncBDS7HNEFSALRBWMPZ23AKGQEVXHOK4Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 141si565540wmy.2.2016.02.28.15.50.48
        for <rtc-linux@googlegroups.com>;
        Sun, 28 Feb 2016 15:50:48 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: rv3029: reword Kconfig option
Date: Mon, 29 Feb 2016 00:50:32 +0100
Message-Id: <1456703432-5766-1-git-send-email-alexandre.belloni@free-electrons.com>
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

The Kconfig option for rv3029 is not mentioning any part number, explicitly
show rv3029.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 583c1e6412e5..08df14be7c15 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -594,10 +594,10 @@ config RTC_DRV_EM3027
 	  will be called rtc-em3027.
 
 config RTC_DRV_RV3029C2
-	tristate "Micro Crystal RTC"
+	tristate "Micro Crystal RV3029"
 	help
 	  If you say yes here you get support for the Micro Crystal
-	  RV3029-C2 RTC chips.
+	  RV3029 RTC chips.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rv3029c2.
-- 
2.7.0

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
