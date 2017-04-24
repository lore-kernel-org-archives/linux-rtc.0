Return-Path: <rtc-linux+bncBAABBLPN7HDQKGQEMNSRE5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id m13si1540992itb.2.2017.04.24.15.05.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 15:05:33 -0700 (PDT)
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: moritz.fischer@ettus.com,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@iguana.be,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	alex.williams@ni.com,
	Moritz Fischer <mdf@kernel.org>
Subject: [rtc-linux] [PATCH 1/2] rtc: ds1374: wdt: Fix issue with timeout
 scaling from secs to wdt ticks
Date: Mon, 24 Apr 2017 15:05:11 -0700
Message-Id: <1493071512-5718-2-git-send-email-mdf@kernel.org>
In-Reply-To: <1493071512-5718-1-git-send-email-mdf@kernel.org>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Fix commit 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")

The issue is that the internal counter that triggers the watchdog reset
is actually running at 4096 Hz instead of 1Hz, therefore the value
given by userland (in sec) needs to be multiplied by 4096 to get the
correct behavior.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/rtc/rtc-ds1374.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 4cd115e..2a8b5b3 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -525,6 +525,10 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 
+		/* the hardware's tick rate is 4096 Hz, so
+		 * the counter value needs to be scaled accordingly
+		 */
+		new_margin <<= 12;
 		if (new_margin < 1 || new_margin > 16777216)
 			return -EINVAL;
 
@@ -533,7 +537,8 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
 		ds1374_wdt_ping();
 		/* fallthrough */
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
+		/* when returning ... inverse is true */
+		return put_user((wdt_margin >> 12), (int __user *)arg);
 	case WDIOC_SETOPTIONS:
 		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
 			return -EFAULT;
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
