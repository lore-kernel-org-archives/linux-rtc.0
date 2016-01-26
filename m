Return-Path: <rtc-linux+bncBAABBHUOT62QKGQENORP75Q@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si277405pac.2.2016.01.26.11.21.01
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 11:21:01 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [rtc-linux] [PATCH v3 07/10] rtc: max77686: Use dev_warn() instead of pr_warn()
Date: Tue, 26 Jan 2016 16:20:17 -0300
Message-Id: <1453836020-29579-8-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
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

It is better to use dev_*() log functions instead of pr_*() to print
information about the device in the kernel log in a standardized way.

This also allows to remove the local pr_fmt() defined macro.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

---

Changes in v3:
- Add Laxman Dewangan's Acked-by tag to patch #7.

Changes in v2: None

 drivers/rtc/rtc-max77686.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 09fc73016d3a..da47b1d85793 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -12,8 +12,6 @@
  *
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/slab.h>
 #include <linux/rtc.h>
 #include <linux/delay.h>
@@ -245,8 +243,9 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data,
 		data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
 
 		if (tm->tm_year < 100) {
-			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
-				1900 + tm->tm_year);
+			dev_warn(info->dev,
+				 "RTC can't handle year %d. Assume it's 2000\n",
+				 1900 + tm->tm_year);
 			return -EINVAL;
 		}
 	} else {
-- 
2.5.0

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
