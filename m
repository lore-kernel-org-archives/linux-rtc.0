Return-Path: <rtc-linux+bncBCAMRWGQV4CRBP5L2WWQKGQETZ6Q34Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail.mleia.com (li271-223.members.linode.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id cj6si259422wib.1.2015.07.26.14.48.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2015 14:48:46 -0700 (PDT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] [PATCH 07/11] rtc: ds1742: clean up ds1742_nvram_read()/ds1742_nvram_write()
Date: Mon, 27 Jul 2015 00:48:32 +0300
Message-Id: <1437947316-5652-8-git-send-email-vz@mleia.com>
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
 drivers/rtc/rtc-ds1742.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 0f8d8ac..c5168b3 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -134,7 +134,7 @@ static ssize_t ds1742_nvram_read(struct file *filp, struct kobject *kobj,
 	void __iomem *ioaddr = pdata->ioaddr_nvram;
 	ssize_t count;
 
-	for (count = 0; size > 0 && pos < pdata->size_nvram; count++, size--)
+	for (count = 0; count < size; count++)
 		*buf++ = readb(ioaddr + pos++);
 	return count;
 }
@@ -149,7 +149,7 @@ static ssize_t ds1742_nvram_write(struct file *filp, struct kobject *kobj,
 	void __iomem *ioaddr = pdata->ioaddr_nvram;
 	ssize_t count;
 
-	for (count = 0; size > 0 && pos < pdata->size_nvram; count++, size--)
+	for (count = 0; count < size; count++)
 		writeb(*buf++, ioaddr + pos++);
 	return count;
 }
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
