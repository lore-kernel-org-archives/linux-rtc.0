Return-Path: <rtc-linux+bncBC36JT6HRIDRBONU2GUQKGQEH52CPYI@googlegroups.com>
Received: from resqmta-ch2-04v.sys.comcast.net (resqmta-ch2-04v.sys.comcast.net. [2001:558:fe21:29:69:252:207:36])
        by gmr-mx.google.com with ESMTPS id ks9si458265qcb.3.2015.04.19.18.45.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 Apr 2015 18:45:29 -0700 (PDT)
Message-ID: <55345A35.5000003@gentoo.org>
Date: Sun, 19 Apr 2015 21:45:25 -0400
From: Joshua Kinard <kumba@gentoo.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Alessandro Zummo <a.zummo@towertech.it>
CC: LKML <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
 Linux MIPS List <linux-mips@linux-mips.org>
Subject: [rtc-linux] [PATCH]: MIPS: IP32: Fix two build errors in reset code
 introduced in DS1685 platform hook patch
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

From: Joshua Kinard <kumba@gentoo.org>

Fix two build errors that somehow got into upstream.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Fixes: 15beb694c661: "mips: ip32: add platform data hooks to use DS1685
driver"
---
 arch/mips/sgi-ip32/ip32-platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 0134db2..686a372 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -130,9 +130,9 @@ struct platform_device ip32_rtc_device = {
 	.resource		= ip32_rtc_resources,
 };
 
-+static int __init sgio2_rtc_devinit(void)
+static int __init sgio2_rtc_devinit(void)
 {
 	return platform_device_register(&ip32_rtc_device);
 }
 
-device_initcall(sgio2_cmos_devinit);
+device_initcall(sgio2_rtc_devinit);

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
