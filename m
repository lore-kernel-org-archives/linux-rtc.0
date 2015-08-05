Return-Path: <rtc-linux+bncBCAMRWGQV4CRBL5ERGXAKGQEGHFEABA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.mleia.com (li271-223.members.linode.com. [178.79.152.223])
        by gmr-mx.google.com with ESMTPS id fj7si282712wib.3.2015.08.05.11.13.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 11:13:03 -0700 (PDT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] [PATCH v2 05/11] rtc: ds1511: clean up ds1511_nvram_read()/ds1511_nvram_write()
Date: Wed,  5 Aug 2015 21:12:58 +0300
Message-Id: <1438798378-11290-1-git-send-email-vz@mleia.com>
In-Reply-To: <1437947316-5652-6-git-send-email-vz@mleia.com>
References: <1437947316-5652-6-git-send-email-vz@mleia.com>
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

The change enables burst mode of access to SRAM for any read()/write()
operations, it is worth to mention that this may influence on
userspace, for instance prior to the change

  read(fd, buf, 1);
  read(fd, buf + 1, 1);

and

  read(fd, buf, 2);

sequences of syscalls over DS1511's sysfs "nvram" fd led to different
DS1511 state changes and/or buf content, if some userspace applications
are written specifically for DS1511 and exploit this strange
"feature", they may be impacted.

Also the change corrects NVRAM size accessible to userspace from 255
bytes to 256 bytes.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* configuration of burst mode access to NVRAM from probe() allows to
  remove another 10 lines of code,
* NVRAM size is set correctly to 256 bytes,
* extended commit message with a warning addressed to any potentially
  impacted userspace applications due to always enabled burst mode

 drivers/rtc/rtc-ds1511.c | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 7415c2b..da3d04c 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -64,7 +64,7 @@ enum ds1511reg {
 #define DS1511_KIE	0x04
 #define DS1511_WDE	0x02
 #define DS1511_WDS	0x01
-#define DS1511_RAM_MAX	0xff
+#define DS1511_RAM_MAX	0x100
 
 #define RTC_CMD		DS1511_CONTROL_B
 #define RTC_CMD1	DS1511_CONTROL_A
@@ -159,7 +159,7 @@ ds1511_wdog_set(unsigned long deciseconds)
 	/*
 	 * set wdog enable and wdog 'steering' bit to issue a reset
 	 */
-	rtc_write(DS1511_WDE | DS1511_WDS, RTC_CMD);
+	rtc_write(rtc_read(RTC_CMD) | DS1511_WDE | DS1511_WDS, RTC_CMD);
 }
 
 void
@@ -407,26 +407,10 @@ ds1511_nvram_read(struct file *filp, struct kobject *kobj,
 {
 	ssize_t count;
 
-	/*
-	 * if count is more than one, turn on "burst" mode
-	 * turn it off when you're done
-	 */
-	if (size > 1)
-		rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
-
-	if (pos > DS1511_RAM_MAX)
-		pos = DS1511_RAM_MAX;
-
-	if (size + pos > DS1511_RAM_MAX + 1)
-		size = DS1511_RAM_MAX - pos + 1;
-
 	rtc_write(pos, DS1511_RAMADDR_LSB);
-	for (count = 0; size > 0; count++, size--)
+	for (count = 0; count < size; count++)
 		*buf++ = rtc_read(DS1511_RAMDATA);
 
-	if (count > 1)
-		rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
-
 	return count;
 }
 
@@ -437,26 +421,10 @@ ds1511_nvram_write(struct file *filp, struct kobject *kobj,
 {
 	ssize_t count;
 
-	/*
-	 * if count is more than one, turn on "burst" mode
-	 * turn it off when you're done
-	 */
-	if (size > 1)
-		rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
-
-	if (pos > DS1511_RAM_MAX)
-		pos = DS1511_RAM_MAX;
-
-	if (size + pos > DS1511_RAM_MAX + 1)
-		size = DS1511_RAM_MAX - pos + 1;
-
 	rtc_write(pos, DS1511_RAMADDR_LSB);
-	for (count = 0; size > 0; count++, size--)
+	for (count = 0; count < size; count++)
 		rtc_write(*buf++, DS1511_RAMDATA);
 
-	if (count > 1)
-		rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
-
 	return count;
 }
 
@@ -490,7 +458,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	/*
 	 * turn on the clock and the crystal, etc.
 	 */
-	rtc_write(0, RTC_CMD);
+	rtc_write(DS1511_BME, RTC_CMD);
 	rtc_write(0, RTC_CMD1);
 	/*
 	 * clear the wdog counter
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
