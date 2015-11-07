Return-Path: <rtc-linux+bncBC4PNG5H2MBBBWHP6WYQKGQEXCEJSXI@googlegroups.com>
MIME-Version: 1.0
Received: from m50-133.163.com (m50-133.163.com. [123.125.50.133])
        by gmr-mx.google.com with ESMTP id xk4si325952pbc.2.2015.11.06.20.02.31
        for <rtc-linux@googlegroups.com>;
        Fri, 06 Nov 2015 20:02:32 -0800 (PST)
From: Geliang Tang <geliangtang@163.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Geliang Tang <geliangtang@163.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 2/2] rtc: efi: add efi_procfs in efi_rtc_ops
Date: Sat,  7 Nov 2015 12:00:22 +0800
Message-Id: <92f29256c04397cde0a3572982702dca359392b6.1446868545.git.geliangtang@163.com>
In-Reply-To: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
References: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
In-Reply-To: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
References: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
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

Add efi_procfs in efi_rtc_ops to show rtc-efi info in /proc/driver/rtc.
Most of the code comes from efi_rtc_proc_show() in efirtc.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/rtc/rtc-efi.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index 3806961..96d3860 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -191,11 +191,69 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
 	return status == EFI_SUCCESS ? 0 : -EINVAL;
 }
 
+static int efi_procfs(struct device *dev, struct seq_file *seq)
+{
+	efi_time_t      eft, alm;
+	efi_time_cap_t  cap;
+	efi_bool_t      enabled, pending;
+
+	memset(&eft, 0, sizeof(eft));
+	memset(&alm, 0, sizeof(alm));
+	memset(&cap, 0, sizeof(cap));
+
+	efi.get_time(&eft, &cap);
+	efi.get_wakeup_time(&enabled, &pending, &alm);
+
+	seq_printf(seq,
+		   "Time\t\t: %u:%u:%u.%09u\n"
+		   "Date\t\t: %u-%u-%u\n"
+		   "Daylight\t: %u\n",
+		   eft.hour, eft.minute, eft.second, eft.nanosecond,
+		   eft.year, eft.month, eft.day,
+		   eft.daylight);
+
+	if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
+		seq_puts(seq, "Timezone\t: unspecified\n");
+	else
+		/* XXX fixme: convert to string? */
+		seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
+
+	seq_printf(seq,
+		   "Alarm Time\t: %u:%u:%u.%09u\n"
+		   "Alarm Date\t: %u-%u-%u\n"
+		   "Alarm Daylight\t: %u\n"
+		   "Enabled\t\t: %s\n"
+		   "Pending\t\t: %s\n",
+		   alm.hour, alm.minute, alm.second, alm.nanosecond,
+		   alm.year, alm.month, alm.day,
+		   alm.daylight,
+		   enabled == 1 ? "yes" : "no",
+		   pending == 1 ? "yes" : "no");
+
+	if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
+		seq_puts(seq, "Timezone\t: unspecified\n");
+	else
+		/* XXX fixme: convert to string? */
+		seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
+
+	/*
+	 * now prints the capabilities
+	 */
+	seq_printf(seq,
+		   "Resolution\t: %u\n"
+		   "Accuracy\t: %u\n"
+		   "SetstoZero\t: %u\n",
+		   cap.resolution, cap.accuracy, cap.sets_to_zero);
+
+	return 0;
+}
+
 static const struct rtc_class_ops efi_rtc_ops = {
-	.read_time = efi_read_time,
-	.set_time = efi_set_time,
-	.read_alarm = efi_read_alarm,
-	.set_alarm = efi_set_alarm,
+	.read_time	= efi_read_time,
+	.set_time	= efi_set_time,
+	.read_alarm	= efi_read_alarm,
+	.set_alarm	= efi_set_alarm,
+	.proc		= efi_procfs,
 };
 
 static int __init efi_rtc_probe(struct platform_device *dev)
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
