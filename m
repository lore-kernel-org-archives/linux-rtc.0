Return-Path: <rtc-linux+bncBD747RFBYUPBB64J525QKGQEL2QDHVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id c11si372460pfc.2.2016.07.05.02.59.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 02:59:23 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9U01P9J6EWSH50@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 05 Jul 2016 18:59:20 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
 javier@osg.samsung.com, pankaj.dubey@samsung.com, alim.akhtar@samsung.com
Subject: [rtc-linux] [PATCH v2 1/2] rtc: s3c: Remove unnecessary call to
 disable already disabled clock
Date: Tue, 05 Jul 2016 15:28:52 +0530
Message-id: <1467712733-15800-1-git-send-email-alim.akhtar@samsung.com>
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
clock already disabled (by s3c_rtc_gettime()), which looks extra and
unnecessary call. Lets clean it up.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/rtc/rtc-s3c.c |    2 --
 1 file changed, 2 deletions(-)

* Changes from v1
   -updated commit message as suggested by Krzysztof.
   -updated reviewed-by, tested-by tags

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
