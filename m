Return-Path: <rtc-linux+bncBCQJP74GSUDRBJXNQW5AKGQETZ3ZQ3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be. [2a02:1800:120:4::f00:14])
        by gmr-mx.google.com with ESMTPS id l68si255240wmd.3.2016.05.22.02.06.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:06:46 -0700 (PDT)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 39/54] MAINTAINERS: Add file patterns for rtc
 device tree bindings
Date: Sun, 22 May 2016 11:06:16 +0200
Message-Id: <1463907991-7916-40-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e204132911b63624..1942e29d55320f01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9580,6 +9580,7 @@ L:	rtc-linux@googlegroups.com
 Q:	http://patchwork.ozlabs.org/project/rtc-linux/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/
 F:	Documentation/rtc.txt
 F:	drivers/rtc/
 F:	include/linux/rtc.h
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
