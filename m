Return-Path: <rtc-linux+bncBD747RFBYUPBBD4F5G5QKGQEAISNIQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id 62si240622pfx.1.2016.07.04.04.03.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Jul 2016 04:03:43 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9S02UU2EQ57870@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 04 Jul 2016 20:03:41 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
 javier@osg.samsung.com, pankaj.dubey@samsung.com, alim.akhtar@samsung.com
Subject: [rtc-linux] [RFC PATCH 1/2] rtc: s3c: Remove unnecessary call to
 disable already disabled clock
Date: Mon, 04 Jul 2016 16:33:13 +0530
Message-id: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

At the end of s3c_rtc_probe(), s3c_rtc_disable_clk() being called with rtc
clock already disabled, which looks extra and unnecessary call.
Lets clean it up.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/rtc/rtc-s3c.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d01ad7e..b083840 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -577,8 +577,6 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	s3c_rtc_setfreq(info, 1);
 
-	s3c_rtc_disable_clk(info);
-
 	return 0;
 
  err_nortc:
-- 
1.7.10.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
