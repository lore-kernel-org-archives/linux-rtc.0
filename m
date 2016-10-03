Return-Path: <rtc-linux+bncBCL4FNGB7UHBBSOBZO7QKGQEIQ3AIIQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id u64si928757wmf.0.2016.10.03.15.50.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2016 15:50:49 -0700 (PDT)
Received: by mail-wm0-x243.google.com with SMTP id f193so12277916wmg.2
        for <rtc-linux@googlegroups.com>; Mon, 03 Oct 2016 15:50:49 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH v3] rtc-cmos: Reject unsupported alarm values
Date: Tue,  4 Oct 2016 00:50:28 +0200
Message-Id: <20161003225028.3529-1-gabriele.mzt@gmail.com>
In-Reply-To: <20160902195516.7068-1-gabriele.mzt@gmail.com>
References: <20160902195516.7068-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Some platforms allows to specify the month and day of the month in
which an alarm should go off, some others the day of the month and
some others just the time.

Currently any given value is accepted by the driver and only the
supported fields are used to program the hardware. As consequence,
alarms are potentially programmed to go off in the wrong moment.

Fix this by rejecting any unsupported value.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 9bb14eb..2655432 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -328,14 +328,86 @@ static void cmos_irq_disable(struct cmos_rtc *cmos, unsigned char mask)
 	cmos_checkintr(cmos, rtc_control);
 }
 
+static int cmos_validate_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	struct rtc_time now;
+
+	cmos_read_time(dev, &now);
+
+	if (!cmos->day_alrm) {
+		time64_t t_max_date;
+		time64_t t_alrm;
+
+		t_max_date = rtc_tm_to_time64(&now);
+		t_max_date += 24 * 60 * 60 - 1;
+		t_alrm = rtc_tm_to_time64(&t->time);
+		if (t_alrm > t_max_date) {
+			dev_err(dev,
+				"Alarms can be up to one day in the future\n");
+			return -EINVAL;
+		}
+	} else if (!cmos->mon_alrm) {
+		struct rtc_time max_date = now;
+		time64_t t_max_date;
+		time64_t t_alrm;
+		int max_mday;
+
+		if (max_date.tm_mon == 11) {
+			max_date.tm_mon = 0;
+			max_date.tm_year += 1;
+		} else {
+			max_date.tm_mon += 1;
+		}
+		max_mday = rtc_month_days(max_date.tm_mon, max_date.tm_year);
+		if (max_date.tm_mday > max_mday)
+			max_date.tm_mday = max_mday;
+
+		t_max_date = rtc_tm_to_time64(&max_date);
+		t_max_date -= 1;
+		t_alrm = rtc_tm_to_time64(&t->time);
+		if (t_alrm > t_max_date) {
+			dev_err(dev,
+				"Alarms can be up to one month in the future\n");
+			return -EINVAL;
+		}
+	} else {
+		struct rtc_time max_date = now;
+		time64_t t_max_date;
+		time64_t t_alrm;
+		int max_mday;
+
+		max_date.tm_year += 1;
+		max_mday = rtc_month_days(max_date.tm_mon, max_date.tm_year);
+		if (max_date.tm_mday > max_mday)
+			max_date.tm_mday = max_mday;
+
+		t_max_date = rtc_tm_to_time64(&max_date);
+		t_max_date -= 1;
+		t_alrm = rtc_tm_to_time64(&t->time);
+		if (t_alrm > t_max_date) {
+			dev_err(dev,
+				"Alarms can be up to one year in the future\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char mon, mday, hrs, min, sec, rtc_control;
+	int ret;
 
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
+	ret = cmos_validate_alarm(dev, t);
+	if (ret < 0)
+		return ret;
+
 	mon = t->time.tm_mon + 1;
 	mday = t->time.tm_mday;
 	hrs = t->time.tm_hour;
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
