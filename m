Return-Path: <rtc-linux+bncBAABBOMQ52UAKGQEZGKMGXA@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id b12si740110igv.0.2015.03.31.22.55.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 22:55:04 -0700 (PDT)
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>
CC: <t-kristo@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>
Subject: [rtc-linux] [PATCH 0/3] rtc: omap: Fix misc bugs
Date: Wed, 1 Apr 2015 11:24:55 +0530
Message-ID: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com>
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

Tested on DRA72-evm with an out of tree patch for RTC hwmod.
Logs: http://pastebin.ubuntu.com/10716566/

Lokesh Vutla (3):
  rtc: omap: Unlock and Lock rtc registers before and after register
    writes
  rtc: omap: Update Kconfig for OMAP RTC
  rtc: omap: use module_platform_driver

 drivers/rtc/Kconfig    |  6 +++---
 drivers/rtc/rtc-omap.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 13 deletions(-)

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
