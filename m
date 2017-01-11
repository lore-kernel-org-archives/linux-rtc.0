Return-Path: <rtc-linux+bncBDEKVJM7XAHRB3UM3HBQKGQEGHP3W2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id i196si1120838wmd.3.2017.01.11.06.51.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 06:51:25 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: armada38x: hide maybe-uninitialized warning
Date: Wed, 11 Jan 2017 15:50:31 +0100
Message-Id: <20170111145112.722743-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The function is too complicated for gcc to realize that this variable
does eventually get initialized, causing a harmless warning:

drivers/rtc/rtc-armada38x.c: In function 'read_rtc_register_wa':
drivers/rtc/rtc-armada38x.c:131:25: warning: 'index_max' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds an explicit initializion at the start of the function.
I generally try to avoid that, but it seems appropriate here,
as we start out with max=0 as well.

Fixes: 61cffa2438e3 ("rtc: armada38x: Follow the new recommendation for errata implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-armada38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 6c9a2cbdc1a9..65e16965af7e 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -90,7 +90,7 @@ static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
 
 static u32 read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
 {
-	int i, index_max, max = 0;
+	int i, index_max = 0, max = 0;
 
 	for (i = 0; i < SAMPLE_NR; i++) {
 		rtc->val_to_freq[i].value = readl(rtc->regs + rtc_reg);
-- 
2.9.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
