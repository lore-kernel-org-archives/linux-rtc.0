Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59337 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdKJI7v (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 10 Nov 2017 03:59:51 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] rtc: at91rm9200: stop calculating yday in at91_rtc_readalarm
Date: Fri, 10 Nov 2017 09:59:30 +0100
Message-Id: <20171110085931.32347-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Calculating yday in the read_alarm callback is useless as this value is
never used later. Also, it was buggy anyway because at the time this is
done, tm_year is always 0 as the alarm register doesn't hold the year.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91rm9200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index e221b78b6f10..e84f5ec4faf6 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -208,7 +208,6 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time *tm = &alrm->time;
 
 	at91_rtc_decodetime(AT91_RTC_TIMALR, AT91_RTC_CALALR, tm);
-	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	tm->tm_year = at91_alarm_year - 1900;
 
 	alrm->enabled = (at91_rtc_read_imr() & AT91_RTC_ALARM)
-- 
2.15.0
