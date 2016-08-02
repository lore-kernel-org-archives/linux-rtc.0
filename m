Return-Path: <rtc-linux+bncBCL7FKNRWUNRBNFFQK6QKGQEQ4VQXNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id i136si452143pfe.1.2016.08.02.05.31.48
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Aug 2016 05:31:48 -0700 (PDT)
From: Baole Ni <baolex.ni@intel.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	paulus@samba.org,
	mpe@ellerman.id.au,
	dwmw2@infradead.org,
	m.chehab@samsung.com,
	pawel@osciak.com,
	m.szyprowski@samsung.com,
	kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com,
	baolex.ni@intel.com
Subject: [rtc-linux] [PATCH 0874/1285] Replace numeric parameter like 0444
 with macro
Date: Tue,  2 Aug 2016 19:54:07 +0800
Message-Id: <20160802115407.8242-1-baolex.ni@intel.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/rtc/rtc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 3a2da4c..37e10e3 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 
 static int test_mmss64;
-module_param(test_mmss64, int, 0644);
+module_param(test_mmss64, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(test_mmss64, "Test struct rtc_class_ops.set_mmss64().");
 
 static struct platform_device *test0 = NULL, *test1 = NULL;
-- 
2.9.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
