Return-Path: <rtc-linux+bncBDTKFPPJUEHRBUWT33BQKGQEIQTHFVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id l66si245609wml.0.2017.01.12.08.07.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 08:07:46 -0800 (PST)
Received: by mail-wm0-x244.google.com with SMTP id l2so4734403wml.2
        for <rtc-linux@googlegroups.com>; Thu, 12 Jan 2017 08:07:46 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Martin Michlmayr <tbm@cyrius.com>,
	rtc-linux@googlegroups.com,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 1/2] rtc: tegra: Sort includes alphabetically
Date: Thu, 12 Jan 2017 17:07:42 +0100
Message-Id: <20170112160743.23367-1-thierry.reding@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Thierry Reding <treding@nvidia.com>

The ordering of includes is currently completely arbitrary, making it
impossible to decide where to put new includes. Remove the dilemma by
sort the include list alphabetically.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/rtc/rtc-tegra.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 3853ba963bb5..38e662ff1a70 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -17,16 +17,17 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
-#include <linux/kernel.h>
+
+#include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/rtc.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
 
 /* set to 1 = busy every eight 32kHz clocks during copy of sec+msec to AHB */
 #define TEGRA_RTC_REG_BUSY			0x004
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
