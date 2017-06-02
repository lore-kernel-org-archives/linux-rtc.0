Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6FQYXEQKGQECTPZR3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 196si202585wma.3.2017.06.02.05.22.15
        for <rtc-linux@googlegroups.com>;
        Fri, 02 Jun 2017 05:22:15 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/5] rtc: sysfs: make name uniform
Date: Fri,  2 Jun 2017 14:21:53 +0200
Message-Id: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The name sysfs attribute is not useful in its current form because of all
the drivers:
 - 3 are using the feature correctly
 - 2 are clearly misusing it
 - 60 are using driver.name, either directly or indirectly
 - 46 are using pdev->name
 - 8 are using client->name
 - 31 are using a variation of driver.name (addition or removal of rtc-,
   -rtc, _rtc, rtc_)

Make it uniform and use the driver name and the device name.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 1218d5d4224d..e364550eb9a7 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -27,7 +27,8 @@
 static ssize_t
 name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n", to_rtc_device(dev)->name);
+	return sprintf(buf, "%s %s\n", dev_driver_string(dev->parent),
+		       dev_name(dev->parent));
 }
 static DEVICE_ATTR_RO(name);
 
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
