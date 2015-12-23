Return-Path: <rtc-linux+bncBC4PNG5H2MBBBLFT5KZQKGQEXRDB6EI@googlegroups.com>
MIME-Version: 1.0
Received: from m50-133.163.com (m50-133.163.com. [123.125.50.133])
        by gmr-mx.google.com with ESMTP id f7si1405576igc.0.2015.12.23.04.55.06
        for <rtc-linux@googlegroups.com>;
        Wed, 23 Dec 2015 04:55:07 -0800 (PST)
From: Geliang Tang <geliangtang@163.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Geliang Tang <geliangtang@163.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: ds1305: use to_spi_device and kobj_to_dev
Date: Wed, 23 Dec 2015 20:54:33 +0800
Message-Id: <69d9b6de4c0a2c10544f9982bce92d3132bf6d21.1450875144.git.geliangtang@163.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

For better readability, use to_spi_device() and kobj_to_dev() instead
of container_of().

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/rtc/rtc-ds1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index f39691e..8e41c46 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -532,7 +532,7 @@ ds1305_nvram_read(struct file *filp, struct kobject *kobj,
 	struct spi_transfer	x[2];
 	int			status;
 
-	spi = container_of(kobj, struct spi_device, dev.kobj);
+	spi = to_spi_device(kobj_to_dev(kobj));
 
 	addr = DS1305_NVRAM + off;
 	msg_init(&m, x, &addr, count, NULL, buf);
@@ -554,7 +554,7 @@ ds1305_nvram_write(struct file *filp, struct kobject *kobj,
 	struct spi_transfer	x[2];
 	int			status;
 
-	spi = container_of(kobj, struct spi_device, dev.kobj);
+	spi = to_spi_device(kobj_to_dev(kobj));
 
 	addr = (DS1305_WRITE | DS1305_NVRAM) + off;
 	msg_init(&m, x, &addr, count, buf, NULL);
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
