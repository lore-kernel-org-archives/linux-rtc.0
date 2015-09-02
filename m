Return-Path: <rtc-linux+bncBCZN3WFA24DRBOG2TKXQKGQESHKTZZQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com. [2a00:1450:400c:c05::235])
        by gmr-mx.google.com with ESMTPS id r1si103421wiz.1.2015.09.02.01.03.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 01:03:03 -0700 (PDT)
Received: by mail-wi0-x235.google.com with SMTP id z8so55747480wib.1
        for <rtc-linux@googlegroups.com>; Wed, 02 Sep 2015 01:03:03 -0700 (PDT)
From: Mitja Spes <mitja@lxnav.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Philippe De Muyter <phdm@macqel.be>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Mitja Spes <mitja@lxnav.com>
Subject: [rtc-linux] [PATCH] rtc: Abracon ABX8XX write RTC fix
Date: Wed,  2 Sep 2015 10:02:29 +0200
Message-Id: <eb60f012f707d580f3c57f2f16e4c7aba9a4cc23.1441179975.git.mitja@lxnav.com>
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

Fixed RTC write bit as per application manual

Signed-off-by: Mitja Spes <mitja@lxnav.com>
---
 drivers/rtc/rtc-abx80x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 4337c3b..afea84c 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -28,7 +28,7 @@
 #define ABX8XX_REG_WD		0x07
 
 #define ABX8XX_REG_CTRL1	0x10
-#define ABX8XX_CTRL_WRITE	BIT(1)
+#define ABX8XX_CTRL_WRITE	BIT(0)
 #define ABX8XX_CTRL_12_24	BIT(6)
 
 #define ABX8XX_REG_CFG_KEY	0x1f
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
