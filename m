Return-Path: <rtc-linux+bncBCL7FKNRWUNRBMFFQK6QKGQE2KRFUNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id i136si452083pfe.1.2016.08.02.05.31.44
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Aug 2016 05:31:44 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 0873/1285] Replace numeric parameter like 0444
 with macro
Date: Tue,  2 Aug 2016 19:54:03 +0800
Message-Id: <20160802115403.8176-1-baolex.ni@intel.com>
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
 drivers/rtc/rtc-max8997.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index db984d4..006c362 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -25,11 +25,11 @@
 
 /* Module parameter for WTSR function control */
 static int wtsr_en = 1;
-module_param(wtsr_en, int, 0444);
+module_param(wtsr_en, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wtsr_en, "Watchdog Timeout & Software Reset (default=on)");
 /* Module parameter for SMPL function control */
 static int smpl_en = 1;
-module_param(smpl_en, int, 0444);
+module_param(smpl_en, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(smpl_en, "Sudden Momentary Power Loss (default=on)");
 
 /* RTC Control Register */
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
