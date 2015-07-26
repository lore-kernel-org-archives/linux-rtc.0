Return-Path: <rtc-linux+bncBCAMRWGQV4CRBPNL2WWQKGQEYN7ZSUA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.mleia.com (li271-223.members.linode.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id c3si255330wiz.2.2015.07.26.14.48.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2015 14:48:45 -0700 (PDT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] [PATCH 02/11] rtc: ds1305: clean up ds1305_nvram_read()/ds1305_nvram_write()
Date: Mon, 27 Jul 2015 00:48:27 +0300
Message-Id: <1437947316-5652-3-git-send-email-vz@mleia.com>
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
this task is already done on caller size in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/rtc/rtc-ds1305.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 12b0715..baa5d04 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -538,15 +538,6 @@ ds1305_nvram_read(struct file *filp, struct kobject *kobj,
 
 	spi = container_of(kobj, struct spi_device, dev.kobj);
 
-	if (unlikely(off >= DS1305_NVRAM_LEN))
-		return 0;
-	if (count >= DS1305_NVRAM_LEN)
-		count = DS1305_NVRAM_LEN;
-	if ((off + count) > DS1305_NVRAM_LEN)
-		count = DS1305_NVRAM_LEN - off;
-	if (unlikely(!count))
-		return count;
-
 	addr = DS1305_NVRAM + off;
 	msg_init(&m, x, &addr, count, NULL, buf);
 
@@ -569,15 +560,6 @@ ds1305_nvram_write(struct file *filp, struct kobject *kobj,
 
 	spi = container_of(kobj, struct spi_device, dev.kobj);
 
-	if (unlikely(off >= DS1305_NVRAM_LEN))
-		return -EFBIG;
-	if (count >= DS1305_NVRAM_LEN)
-		count = DS1305_NVRAM_LEN;
-	if ((off + count) > DS1305_NVRAM_LEN)
-		count = DS1305_NVRAM_LEN - off;
-	if (unlikely(!count))
-		return count;
-
 	addr = (DS1305_WRITE | DS1305_NVRAM) + off;
 	msg_init(&m, x, &addr, count, buf, NULL);
 
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
