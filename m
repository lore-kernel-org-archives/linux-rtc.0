Return-Path: <rtc-linux+bncBAABBANXXGYAKGQEOH6UG5Y@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.141])
        by gmr-mx.google.com with ESMTPS id bj4si226626wib.1.2015.10.02.03.25.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2015 03:25:05 -0700 (PDT)
Message-ID: <201510021025.t92AP2Bn026715@swsrvapps-01.diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Fri, 2 Oct 2015 11:21:11 +0100
Subject: [rtc-linux] [PATCH V1] rtc: GPL copyright inconsistency fix
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Allessandro
 Zummo <a.zummo@towertech.it>
CC: David Dajun Chen <david.chen@diasemi.com>, LKML
	<linux-kernel@vger.kernel.org>, RTC <rtc-linux@googlegroups.com>, Support
 Opensource <support.opensource@diasemi.com>
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

From: Steve Twiss <stwiss.opensource@diasemi.com>

Fix misleading and inconsistent copyright header wording.

Alter the copyright header text and MODULE_LICENSE macro to ensure the
GPL v2 licence description is correctly represented.

It will remove the incorrectly LGPL worded text. Words such as "Library"
from the line "GNU Library General Public License"; and replace the word
"library" with "program" in several other places.

The copyright should match the GPL v2 description as specified in the GNU
license found here: http://www.gnu.org/licenses/gpl-2.0.html

It should also match this copyright text with the correct MODULE_LICENSE
macro text as found in the kernel: include/linux/module.h
In this case "GNU Public License v2 or later" is linked with "GPL".


Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---

This patch applies against linux-next and v4.3-rc3 



 drivers/rtc/rtc-da9063.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 00a8f7f..284b587 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -1,15 +1,15 @@
 /* rtc-da9063.c - Real time clock device driver for DA9063
- * Copyright (C) 2013-14  Dialog Semiconductor Ltd.
+ * Copyright (C) 2013-2015  Dialog Semiconductor Ltd.
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
  *
- * This library is distributed in the hope that it will be useful,
+ * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #include <linux/delay.h>
@@ -516,5 +516,5 @@ module_platform_driver(da9063_rtc_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
 MODULE_DESCRIPTION("Real time clock device driver for Dialog DA9063");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DA9063_DRVNAME_RTC);
-- 
end-of-patch for PATCH V1

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
