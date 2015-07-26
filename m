Return-Path: <rtc-linux+bncBCAMRWGQV4CRBPFL2WWQKGQEECGUTQY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.mleia.com (li271-223.members.linode.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id c3si255328wiz.2.2015.07.26.14.48.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2015 14:48:44 -0700 (PDT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] [PATCH 01/11] rtc: cmos: clean up cmos_nvram_read()/cmos_nvram_write()
Date: Mon, 27 Jul 2015 00:48:26 +0300
Message-Id: <1437947316-5652-2-git-send-email-vz@mleia.com>
In-Reply-To: <1437947316-5652-1-git-send-email-vz@mleia.com>
References: <1437947316-5652-1-git-send-email-vz@mleia.com>
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

The change removes redundant sysfs binary file boundary checks, since
this task is already done on caller side in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/rtc/rtc-cmos.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index a82556a..1ecd374 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -512,13 +512,6 @@ cmos_nvram_read(struct file *filp, struct kobject *kobj,
 {
 	int	retval;
 
-	if (unlikely(off >= attr->size))
-		return 0;
-	if (unlikely(off < 0))
-		return -EINVAL;
-	if ((off + count) > attr->size)
-		count = attr->size - off;
-
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
 	for (retval = 0; count; count--, off++, retval++) {
@@ -543,12 +536,6 @@ cmos_nvram_write(struct file *filp, struct kobject *kobj,
 	int		retval;
 
 	cmos = dev_get_drvdata(container_of(kobj, struct device, kobj));
-	if (unlikely(off >= attr->size))
-		return -EFBIG;
-	if (unlikely(off < 0))
-		return -EINVAL;
-	if ((off + count) > attr->size)
-		count = attr->size - off;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
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
