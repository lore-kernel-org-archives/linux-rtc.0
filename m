Return-Path: <rtc-linux+bncBCQJP74GSUDRBAFMTS4QKGQEPVR3SAA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from michel.telenet-ops.be (michel.telenet-ops.be. [2a02:1800:110:4::f00:18])
        by gmr-mx.google.com with ESMTPS id a124si764277wme.0.2016.05.02.01.55.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2016 01:55:27 -0700 (PDT)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [rtc-linux] [PATCH 1/2] m68k/bvme6000: Include generic <linux/rtc.h>
Date: Mon,  2 May 2016 10:46:22 +0200
Message-Id: <1462178783-29294-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1462178783-29294-1-git-send-email-geert@linux-m68k.org>
References: <1462178783-29294-1-git-send-email-geert@linux-m68k.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The BVME6000 RTC driver doesn't use any MC146818-specific definitions,
hence include the generic <linux/rtc.h> instead of
<linux/mc146818rtc.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To avoid a build failure after "rtc: cmos: move mc146818rtc code out of
asm-generic/rtc.h".
---
 arch/m68k/bvme6000/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/bvme6000/rtc.c b/arch/m68k/bvme6000/rtc.c
index cf12a17dc289c5f9..f7984f44ff0f8072 100644
--- a/arch/m68k/bvme6000/rtc.c
+++ b/arch/m68k/bvme6000/rtc.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/module.h>
-#include <linux/mc146818rtc.h>	/* For struct rtc_time and ioctls, etc */
+#include <linux/rtc.h>	/* For struct rtc_time and ioctls, etc */
 #include <linux/bcd.h>
 #include <asm/bvme6000hw.h>
 
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
