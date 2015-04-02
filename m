Return-Path: <rtc-linux+bncBAABBX6G6SUAKGQEFM7KW3I@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id c19si118243igm.1.2015.04.02.04.09.19
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 04:09:19 -0700 (PDT)
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>
CC: <t-kristo@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>,
        <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 0/3] rtc: omap: Fix misc bugs
Date: Thu, 2 Apr 2015 16:39:08 +0530
Message-ID: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
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

This patch series fixes miscellaneous bugs in OMAP RTC driver.

Tested on BeagleBone-Black.
Logs: http://pastebin.ubuntu.com/10723287/

V1 patches can be seen here: http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg115839.html

Lokesh Vutla (3):
  rtc: omap: Unlock and Lock rtc registers before and after register
    writes
  rtc: omap: Update Kconfig for OMAP RTC
  rtc: omap: use module_platform_driver

 drivers/rtc/Kconfig    |  6 ++---
 drivers/rtc/rtc-omap.c | 68 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 16 deletions(-)

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
