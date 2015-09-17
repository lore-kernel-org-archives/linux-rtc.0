Return-Path: <rtc-linux+bncBCZ7NMHQ3YLRBG7F5SXQKGQECX3CRCA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com. [2a00:1450:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id bn1si147921wib.0.2015.09.17.14.37.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2015 14:37:31 -0700 (PDT)
Received: by mail-wi0-x22c.google.com with SMTP id fx3so40879684wic.1
        for <rtc-linux@googlegroups.com>; Thu, 17 Sep 2015 14:37:31 -0700 (PDT)
From: Ivan Grimaldi <grimaldi.ivan@gmail.com>
To: a.zummo@towertech.it,
	mpfj@mimc.co.uk
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] Fixed ds1390_get_reg returned value
Date: Thu, 17 Sep 2015 23:34:27 +0200
Message-Id: <1442525667-8561-1-git-send-email-grimaldi.ivan@gmail.com>
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

spi_write_then_read puts in rx_buf the received data starting from
the first byte of the rx_buf

Signed-off-by: Ivan Grimaldi <grimaldi.ivan@gmail.com>
---
 drivers/rtc/rtc-ds1390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index e67bfcb..a4303b4 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -62,7 +62,7 @@ static int ds1390_get_reg(struct device *dev, unsigned char address,
 	if (status != 0)
 		return status;
 
-	*data = chip->txrx_buf[1];
+	*data = chip->txrx_buf[0];
 
 	return 0;
 }
-- 
2.5.2

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
