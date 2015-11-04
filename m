Return-Path: <rtc-linux+bncBCNNJWF7RUMRBKOM5CYQKGQEHARRLDA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id el2si190828pbb.0.2015.11.04.07.37.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 07:37:13 -0800 (PST)
Received: by mail-pa0-x22d.google.com with SMTP id z6so57706706pas.2
        for <rtc-linux@googlegroups.com>; Wed, 04 Nov 2015 07:37:13 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH 7/9] rtc-pcf2123: allow sysfs to accept hexidecimal
Date: Wed,  4 Nov 2015 07:36:38 -0800
Message-Id: <986cb8f7ff0ed0584bab543b6cb90655ecd215c4.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1446587705.git.stillcompiling@gmail.com>
References: <cover.1446587705.git.stillcompiling@gmail.com>
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

pcf2123 registers store their values in bcd.
sysfs sensibly displays them in hexidecimal.
Up to now, the sysfs store functions only accept base 10, which
makes no sense.

Add support for hexidecimal without removing base10 support.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/rtc/rtc-pcf2123.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 4964d5c..6701e6d 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -178,7 +178,7 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = kstrtoul(buffer, 10, &val);
+	ret = kstrtoul(buffer, 0, &val);
 	if (ret)
 		return ret;
 
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
