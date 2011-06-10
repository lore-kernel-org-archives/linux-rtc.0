Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: rtc: rtc-s3c: Set year, month, day value for setting alarm
From: Donggeun Kim <dg77.kim@samsung.com>
Message-Id: <1307694592-20949-1-git-send-email-dg77.kim@samsung.com>
To: a.zummo@towertech.it, ben-linux@fluff.org
Cc: rtc-linux@googlegroups.com, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, dg77.kim@samsung.com
Date: Fri, 10 Jun 2011 17:29:52 +0900
List-ID: <rtc-linux.googlegroups.com>

This patch sets year, month, day value for set_alarm function.
The current driver omits to set the values.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.kim@samsung.com>
Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
---
 drivers/rtc/rtc-s3c.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 16512ec..18e648b 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -251,6 +251,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time *tm = &alrm->time;
 	void __iomem *base = s3c_rtc_base;
 	unsigned int alrm_en;
+	int year = tm->tm_year - 100;
 
 	pr_debug("s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
 		 alrm->enabled,
@@ -276,6 +277,21 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		writeb(bin2bcd(tm->tm_hour), base + S3C2410_ALMHOUR);
 	}
 
+	if (year < 100 && year >= 0) {
+		alrm_en |= S3C2410_RTCALM_YEAREN;
+		writeb(bin2bcd(year), base + S3C2410_ALMYEAR);
+	}
+
+	if (tm->tm_mon < 12 && tm->tm_mon >= 0) {
+		alrm_en |= S3C2410_RTCALM_MONEN;
+		writeb(bin2bcd(tm->tm_mon + 1), base + S3C2410_ALMMON);
+	}
+
+	if (tm->tm_mday <= 31 && tm->tm_mday >= 1) {
+		alrm_en |= S3C2410_RTCALM_DAYEN;
+		writeb(bin2bcd(tm->tm_mday), base + S3C2410_ALMDATE);
+	}
+
 	pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
 
 	writeb(alrm_en, base + S3C2410_RTCALM);
