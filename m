Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:61856
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752896AbeCPSMf (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Mar 2018 14:12:35 -0400
From: Trent Piepho <tpiepho@impinj.com>
Cc: Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] rtc-snvs: Add timeouts to avoid kernel lockups
Date: Fri, 16 Mar 2018 11:12:02 -0700
Message-Id: <20180316181202.14896-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

In order to read correctly from asynchronously updated RTC registers, it's
necessary to read repeatedly until their values do not change from read to
read.  There is no timeout in this code and it could possibly loop
forever.

It's also necessary to wait for three RTC clock ticks for certain
operations to take effect and the driver might wait forever for this to
happen.

To avoid kernel hangs, put in timeouts.

These hangs will happen when running under qemu, which doesn't emulate the
SNVS RTC.  It could also happen if the RTC block where somehow placed into
reset or the slow speed clock that drives the RTC counter (but not the
CPU) were to stop.

The symptoms are a work queue hang on rtc_timer_do_work(), which
eventually blocks a systemd fsnotify operation that triggers a work queue
flush, causing systemd to hang and thus causing all services that should
be started by systemd, like a console getty, to fail to start or stop.

Also optimize the wait code to wait less.  It only needs to wait for the
clock to advance three ticks, not to see it change three times.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>

---
 drivers/rtc/rtc-snvs.c | 105 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index d8ef9e052c4f..0e7564b9d6f2 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -47,49 +47,83 @@ struct snvs_rtc_data {
 	struct clk *clk;
 };
 
+/* Read 64 bit timer register, which could be in inconsistent state */
+static u64 rtc_read_lpsrt(struct snvs_rtc_data *data)
+{
+	u32 msb, lsb;
+
+	regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &msb);
+	regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &lsb);
+	return (u64)msb << 32 | lsb;
+}
+
+/* Read the secure real time counter, taking care to deal with the cases of the
+ * counter updating while being read.
+ */
 static u32 rtc_read_lp_counter(struct snvs_rtc_data *data)
 {
 	u64 read1, read2;
-	u32 val;
+	unsigned int timeout = 100;
 
+	/* As expected, the registers might update between the read of the LSB
+	 * reg and the MSB reg.  It's also possible that one register might be
+	 * in partially modified state as well.
+	 */
+	read1 = rtc_read_lpsrt(data);
 	do {
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &val);
-		read1 = val;
-		read1 <<= 32;
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &val);
-		read1 |= val;
-
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &val);
-		read2 = val;
-		read2 <<= 32;
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &val);
-		read2 |= val;
-	} while (read1 != read2);
+		read2 = read1;
+		read1 = rtc_read_lpsrt(data);
+	} while (read1 != read2 && --timeout);
+	if (!timeout)
+		dev_err(&data->rtc->dev, "Timeout trying to get valid LPSRT Counter read\n");
 
 	/* Convert 47-bit counter to 32-bit raw second count */
 	return (u32) (read1 >> CNTR_TO_SECS_SH);
 }
 
-static void rtc_write_sync_lp(struct snvs_rtc_data *data)
+/* Just read the lsb from the counter, dealing with inconsistent state */
+static int rtc_read_lp_counter_lsb(struct snvs_rtc_data *data, u32 *lsb)
 {
-	u32 count1, count2, count3;
-	int i;
-
-	/* Wait for 3 CKIL cycles */
-	for (i = 0; i < 3; i++) {
-		do {
-			regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
-			regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count2);
-		} while (count1 != count2);
-
-		/* Now wait until counter value changes */
-		do {
-			do {
-				regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count2);
-				regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count3);
-			} while (count2 != count3);
-		} while (count3 == count1);
+	u32 count1, count2;
+	unsigned int timeout = 100;
+
+	regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
+	do {
+		count2 = count1;
+		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
+	} while (count1 != count2 && --timeout);
+	if (!timeout) {
+		dev_err(&data->rtc->dev, "Timeout trying to get valid LPSRT Counter read\n");
+		return -ETIMEDOUT;
 	}
+
+	*lsb = count1;
+	return 0;
+}
+
+static int rtc_write_sync_lp(struct snvs_rtc_data *data)
+{
+	u32 count1, count2;
+	u32 elapsed;
+	unsigned int timeout = 1000;
+	int ret;
+
+	ret = rtc_read_lp_counter_lsb(data, &count1);
+	if (ret)
+		return ret;
+
+	/* Wait for 3 CKIL cycles, about 61.0-91.5 µs */
+	do {
+		ret = rtc_read_lp_counter_lsb(data, &count2);
+		if (ret)
+			return ret;
+		elapsed = count2 - count1; /* wrap around _is_ handled! */
+	} while (elapsed < 3 && --timeout);
+	if (!timeout) {
+		dev_err(&data->rtc->dev, "Timeout waiting for LPSRT Counter to change\n");
+		return -ETIMEDOUT;
+	}
+	return 0;
 }
 
 static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
@@ -170,9 +204,7 @@ static int snvs_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 			   (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
 			   enable ? (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN) : 0);
 
-	rtc_write_sync_lp(data);
-
-	return 0;
+	return rtc_write_sync_lp(data);
 }
 
 static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -180,11 +212,14 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &alrm->time;
 	unsigned long time;
+	int ret;
 
 	rtc_tm_to_time(alrm_tm, &time);
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
-	rtc_write_sync_lp(data);
+	ret = rtc_write_sync_lp(data);
+	if (ret)
+		return ret;
 	regmap_write(data->regmap, data->offset + SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-- 
2.14.3
