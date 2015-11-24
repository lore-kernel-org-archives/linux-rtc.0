Return-Path: <rtc-linux+bncBD7I3CGX5IPRBZWW2GZAKGQEAMJCUKI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lf0-x22a.google.com (mail-lf0-x22a.google.com. [2a00:1450:4010:c07::22a])
        by gmr-mx.google.com with ESMTPS id r4si625534lbj.1.2015.11.24.05.51.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 05:51:34 -0800 (PST)
Received: by mail-lf0-x22a.google.com with SMTP id l133so20778318lfd.2
        for <rtc-linux@googlegroups.com>; Tue, 24 Nov 2015 05:51:34 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Joshua Kinard <kumba@gentoo.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 1/2] drivers/rtc: use %ph for short hex dumps
Date: Tue, 24 Nov 2015 14:51:23 +0100
Message-Id: <1448373085-6353-1-git-send-email-linux@rasmusvillemoes.dk>
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

This makes the generated code slightly smaller.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-ds1305.c |  8 ++------
 drivers/rtc/rtc-ds1307.c | 17 ++++-------------
 drivers/rtc/rtc-ds1685.c | 12 +++++-------
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 85706a9f82c9..f39691eea736 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -186,9 +186,7 @@ static int ds1305_get_time(struct device *dev, struct rtc_time *time)
 	if (status < 0)
 		return status;
 
-	dev_vdbg(dev, "%s: %02x %02x %02x, %02x %02x %02x %02x\n",
-		"read", buf[0], buf[1], buf[2], buf[3],
-		buf[4], buf[5], buf[6]);
+	dev_vdbg(dev, "%s: %3ph, %4ph\n", "read", &buf[0], &buf[3]);
 
 	/* Decode the registers */
 	time->tm_sec = bcd2bin(buf[DS1305_SEC]);
@@ -232,9 +230,7 @@ static int ds1305_set_time(struct device *dev, struct rtc_time *time)
 	*bp++ = bin2bcd(time->tm_mon + 1);
 	*bp++ = bin2bcd(time->tm_year - 100);
 
-	dev_dbg(dev, "%s: %02x %02x %02x, %02x %02x %02x %02x\n",
-		"write", buf[1], buf[2], buf[3],
-		buf[4], buf[5], buf[6], buf[7]);
+	dev_dbg(dev, "%s: %3ph, %4ph\n", "write", &buf[1], &buf[4]);
 
 	/* use write-then-read since dma from stack is nonportable */
 	return spi_write_then_read(ds1305->spi, buf, sizeof(buf),
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 188006c55ce0..b72e782fbf44 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -464,13 +464,8 @@ static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		return -EIO;
 	}
 
-	dev_dbg(dev, "%s: %02x %02x %02x %02x, %02x %02x %02x, %02x %02x\n",
-			"alarm read",
-			ds1307->regs[0], ds1307->regs[1],
-			ds1307->regs[2], ds1307->regs[3],
-			ds1307->regs[4], ds1307->regs[5],
-			ds1307->regs[6], ds1307->regs[7],
-			ds1307->regs[8]);
+	dev_dbg(dev, "%s: %4ph, %3ph, %2ph\n", "alarm read",
+		&ds1307->regs[0], &ds1307->regs[4], &ds1307->regs[7]);
 
 	/*
 	 * report alarm time (ALARM1); assume 24 hour and day-of-month modes,
@@ -526,12 +521,8 @@ static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	control = ds1307->regs[7];
 	status = ds1307->regs[8];
 
-	dev_dbg(dev, "%s: %02x %02x %02x %02x, %02x %02x %02x, %02x %02x\n",
-			"alarm set (old status)",
-			ds1307->regs[0], ds1307->regs[1],
-			ds1307->regs[2], ds1307->regs[3],
-			ds1307->regs[4], ds1307->regs[5],
-			ds1307->regs[6], control, status);
+	dev_dbg(dev, "%s: %4ph, %3ph, %02x %02x\n", "alarm set (old status)",
+		&ds1307->regs[0], &ds1307->regs[4], control, status);
 
 	/* set ALARM1, using 24 hour and day-of-month modes */
 	buf[0] = bin2bcd(t->time.tm_sec);
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 05a51ef52703..5038122aa8de 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -853,7 +853,7 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	   "Periodic Rate\t: %s\n"
 	   "SQW Freq\t: %s\n"
 #ifdef CONFIG_RTC_DS1685_PROC_REGS
-	   "Serial #\t: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n"
+	   "Serial #\t: %8phC\n"
 	   "Register Status\t:\n"
 	   "   Ctrl A\t: UIP  DV2  DV1  DV0  RS3  RS2  RS1  RS0\n"
 	   "\t\t:  %s\n"
@@ -872,7 +872,7 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	   "   Ctrl 4B\t: ABE  E32k  CS  RCE  PRS  RIE  WIE  KSE\n"
 	   "\t\t:  %s\n",
 #else
-	   "Serial #\t: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+	   "Serial #\t: %8phC\n",
 #endif
 	   model,
 	   ((ctrla & RTC_CTRL_A_DV1) ? "enabled" : "disabled"),
@@ -888,7 +888,7 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	   (!((ctrl4b & RTC_CTRL_4B_E32K)) ?
 	    ds1685_rtc_sqw_freq[(ctrla & RTC_CTRL_A_RS_MASK)] : "32768Hz"),
 #ifdef CONFIG_RTC_DS1685_PROC_REGS
-	   ssn[0], ssn[1], ssn[2], ssn[3], ssn[4], ssn[5], ssn[6], ssn[7],
+	   ssn,
 	   ds1685_rtc_print_regs(ctrla, bits[0]),
 	   ds1685_rtc_print_regs(ctrlb, bits[1]),
 	   ds1685_rtc_print_regs(ctrlc, bits[2]),
@@ -896,7 +896,7 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	   ds1685_rtc_print_regs(ctrl4a, bits[4]),
 	   ds1685_rtc_print_regs(ctrl4b, bits[5]));
 #else
-	   ssn[0], ssn[1], ssn[2], ssn[3], ssn[4], ssn[5], ssn[6], ssn[7]);
+	   ssn);
 #endif
 	return 0;
 }
@@ -1160,9 +1160,7 @@ ds1685_rtc_sysfs_serial_show(struct device *dev,
 	ds1685_rtc_get_ssn(rtc, ssn);
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	return snprintf(buf, 24, "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
-			ssn[0], ssn[1], ssn[2], ssn[3], ssn[4], ssn[5],
-			ssn[6], ssn[7]);
+	return snprintf(buf, 24, "%8phC\n", ssn);
 
 	return 0;
 }
-- 
2.6.1

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
