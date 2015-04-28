Return-Path: <rtc-linux+bncBCZ273NM4EARBAXR7SUQKGQESOEN4PQ@googlegroups.com>
Received: from mailgw01.mediatek.com ([210.61.82.183])
        by gmr-mx.google.com with ESMTPS id dv5si2586091pbb.0.2015.04.28.00.36.33
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 Apr 2015 00:36:34 -0700 (PDT)
From: Eddie Huang <eddie.huang@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Matthias Brugger <matthias.bgg@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Tomasz Figa <tfiga@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <kernel@pengutronix.de>
CC: <srv_heupstream@mediatek.com>, Samuel Ortiz <sameo@linux.intel.com>, Greg
 KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
	<linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Eddie Huang <eddie.huang@mediatek.com>
Subject: [rtc-linux] [PATCH v3 3/3] MAINTAINERS: add Mediatek RTC driver
Date: Tue, 28 Apr 2015 15:35:56 +0800
Message-ID: <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
In-Reply-To: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Add Mediatek RTC driver to maintainer entry.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e5bbc0..eb80610 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1223,6 +1223,13 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
 S:	Maintained
 F:	arch/arm/mach-orion5x/ts78xx-*
 
+ARM/Mediatek RTC DRIVER
+M:	Eddie Huang <eddie.huang@mediatek.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/rtc/rtc-mt*
+
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.8.1.1.dirty

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
