Return-Path: <rtc-linux+bncBC4PNG5H2MBBBFHP6WYQKGQEKBG2UTQ@googlegroups.com>
MIME-Version: 1.0
Received: from m50-134.163.com (m50-134.163.com. [123.125.50.134])
        by gmr-mx.google.com with ESMTP id sm2si369980pab.0.2015.11.06.20.01.23
        for <rtc-linux@googlegroups.com>;
        Fri, 06 Nov 2015 20:01:24 -0800 (PST)
From: Geliang Tang <geliangtang@163.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Geliang Tang <geliangtang@163.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 1/2] rtc: fix module reference count in rtc-proc
Date: Sat,  7 Nov 2015 12:00:21 +0800
Message-Id: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
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

rtc-proc.c is not built as a module. Thus, rather than dealing with
THIS_MODULE's reference count, we should deal with rtc->owner's
reference count.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/rtc/rtc-proc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index ffa69e1..31e7e23 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -112,19 +112,21 @@ static int rtc_proc_open(struct inode *inode, struct file *file)
 	int ret;
 	struct rtc_device *rtc = PDE_DATA(inode);
 
-	if (!try_module_get(THIS_MODULE))
+	if (!try_module_get(rtc->owner))
 		return -ENODEV;
 
 	ret = single_open(file, rtc_proc_show, rtc);
 	if (ret)
-		module_put(THIS_MODULE);
+		module_put(rtc->owner);
 	return ret;
 }
 
 static int rtc_proc_release(struct inode *inode, struct file *file)
 {
 	int res = single_release(inode, file);
-	module_put(THIS_MODULE);
+	struct rtc_device *rtc = PDE_DATA(inode);
+
+	module_put(rtc->owner);
 	return res;
 }
 
-- 
2.5.0


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
