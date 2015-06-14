Return-Path: <rtc-linux+bncBDS7HNEFSALRBAUZ66VQKGQECIAEBFY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h1si387046wiw.1.2015.06.14.11.48.34
        for <rtc-linux@googlegroups.com>;
        Sun, 14 Jun 2015 11:48:34 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] MAINTAINERS: Add RTC subsystem repository
Date: Sun, 14 Jun 2015 20:47:57 +0200
Message-Id: <1434307677-8057-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The RTC subsystem patches are available through my kernel.org repository.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19395134063d..f63c649e552e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8210,6 +8210,7 @@ M:	Alessandro Zummo <a.zummo@towertech.it>
 M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
 L:	rtc-linux@googlegroups.com
 Q:	http://patchwork.ozlabs.org/project/rtc-linux/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 S:	Maintained
 F:	Documentation/rtc.txt
 F:	drivers/rtc/
-- 
2.1.4

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
