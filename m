Return-Path: <rtc-linux+bncBCL4FNGB7UHBBXGCTW7AKGQEHRNUO3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id r74si2641179wme.3.2016.08.31.15.59.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 15:59:40 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id d196so5847112wmd.1
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 15:59:40 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH] rtc-cmos: Reject unsupported alarm values
Date: Thu,  1 Sep 2016 00:59:29 +0200
Message-Id: <20160831225929.20336-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Return an error if the user tries to set an alarm that isn't
supported by the hardware.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 4cdb335..b3f9298 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -336,6 +336,26 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
+	if (!cmos->mon_alrm || !cmos->day_alrm) {
+		struct rtc_time now;
+		time64_t t_now;
+		time64_t t_alrm;
+
+		cmos_read_time(dev, &now);
+		t_now = rtc_tm_to_time64(&now);
+		t_alrm = rtc_tm_to_time64(&t->time);
+		if (!cmos->day_alrm && (t_alrm - t_now) > (24 * 60 * 60)) {
+			dev_err(dev,
+				"Alarms can be up to one day in the future\n");
+			return -EINVAL;
+		}
+		if (!cmos->mon_alrm && (t_alrm - t_now) > (31 * 24 * 60 * 60)) {
+			dev_err(dev,
+				"Alarms can be up to 31 days in the future\n");
+			return -EINVAL;
+		}
+	}
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
