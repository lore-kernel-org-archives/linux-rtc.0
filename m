Return-Path: <rtc-linux+bncBDKZNNNLXAHBBNPU26YQKGQEIYKXLRA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com. [2607:f8b0:400e:c03::22f])
        by gmr-mx.google.com with ESMTPS id el2si1512848pbb.0.2015.11.01.03.40.37
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2015 03:40:37 -0800 (PST)
Received: by mail-pa0-x22f.google.com with SMTP id hy1so112612523pad.0
        for <rtc-linux@googlegroups.com>; Sun, 01 Nov 2015 03:40:37 -0800 (PST)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Donggeun Kim <dg77.kim@samsung.com>,
	MyungJoo Ham <myungjoo.kim@samsung.com>,
	KyungMin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [rtc-linux] [PATCH v2] rtc: rtc-s3c: Set year, month, day value for
 setting alarm
Date: Sun,  1 Nov 2015 20:40:02 +0900
Message-Id: <1446378002-8343-1-git-send-email-k.kozlowski.k@gmail.com>
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

From: Donggeun Kim <dg77.kim@samsung.com>

This patch sets year, month, day value for set_alarm function.
The current driver omits to set the values.

This fixes setting wake alarm for dates different than current day.
Without the patch the alarm scheduled for tomorrow would fire today on
chosen time.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.kim@samsung.com>
Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
[k.kozlowski: Rebase and test the patch, update commit message]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/rtc/rtc-s3c.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 7cc8f73a3fe8..5604ebbef222 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -149,6 +149,7 @@ static int s3c_rtc_setfreq(struct s3c_rtc *info, int freq)
 	if (!is_power_of_2(freq))
 		return -EINVAL;
 
+	WARN_ON(1);
 	spin_lock_irq(&info->pie_lock);
 
 	if (info->data->set_freq)
@@ -302,6 +303,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct s3c_rtc *info = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
 	unsigned int alrm_en;
+	int year = tm->tm_year - 100;
 
 	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
 		 alrm->enabled,
@@ -328,6 +330,21 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		writeb(bin2bcd(tm->tm_hour), info->base + S3C2410_ALMHOUR);
 	}
 
+	if (year < 100 && year >= 0) {
+		alrm_en |= S3C2410_RTCALM_YEAREN;
+		writeb(bin2bcd(year), info->base + S3C2410_ALMYEAR);
+	}
+
+	if (tm->tm_mon < 12 && tm->tm_mon >= 0) {
+		alrm_en |= S3C2410_RTCALM_MONEN;
+		writeb(bin2bcd(tm->tm_mon + 1), info->base + S3C2410_ALMMON);
+	}
+
+	if (tm->tm_mday <= 31 && tm->tm_mday >= 1) {
+		alrm_en |= S3C2410_RTCALM_DAYEN;
+		writeb(bin2bcd(tm->tm_mday), info->base + S3C2410_ALMDATE);
+	}
+
 	dev_dbg(dev, "setting S3C2410_RTCALM to %08x\n", alrm_en);
 
 	writeb(alrm_en, info->base + S3C2410_RTCALM);
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
