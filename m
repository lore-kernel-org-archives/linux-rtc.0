Return-Path: <rtc-linux+bncBDS7HNEFSALRBUG6ZSUAKGQESVA7IRY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bz6si1018924wib.3.2015.03.25.14.57.36
        for <rtc-linux@googlegroups.com>;
        Wed, 25 Mar 2015 14:57:36 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] MAINTAINERS: Add Alexandre Belloni as an RTC maintainer
Date: Wed, 25 Mar 2015 22:57:31 +0100
Message-Id: <1427320651-21356-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Add myself as an RTC subsystem maintainer.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Hi,

I've noticed that most of the patches for the RTC subsystem are currently either
taken directly by Andrew or going through another maintainer's tree, quite often
without an Acked-by or Reviewed-by tag.
I'd like to propose myself as the RTC susbsystem co-maintainer, to mainly help
Alessandro reviewing incoming patches and maintain a subsystem tree to avoid
having the RTC patches going through trees when they have no particular
dependencies.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 358eb0105e00..117dab06bab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8134,6 +8134,7 @@ X:	kernel/torture.c
 
 REAL TIME CLOCK (RTC) SUBSYSTEM
 M:	Alessandro Zummo <a.zummo@towertech.it>
+M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
 L:	rtc-linux@googlegroups.com
 Q:	http://patchwork.ozlabs.org/project/rtc-linux/list/
 S:	Maintained
-- 
2.1.0

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
