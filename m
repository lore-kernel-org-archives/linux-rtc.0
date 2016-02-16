Return-Path: <rtc-linux+bncBDKZNNNLXAHBBTMHRK3AKGQERW2NYIA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id yd9si439805pab.1.2016.02.15.18.05.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 18:05:01 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2M0006DB49SU00@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 16 Feb 2016 02:04:57 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com
Cc: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [rtc-linux] [PATCH] rtc: s5m: De-inline large functions to save space
Date: Tue, 16 Feb 2016 11:04:42 +0900
Message-id: <1455588282-7251-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Few functions were marked inline even though they were relatively large
and sometimes used in multiple places. De-inline them to let the
compiler decide whether optimization makes sense. This fixes inline_hunt
report:
drivers/rtc/rtc-s5m.c: Deinline s5m8767_rtc_set_alarm_reg, save 704 bytes
drivers/rtc/rtc-s5m.c: Deinline s5m8767_wait_for_udr_update, save 192 bytes

Reported-by: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Denys Vlasenko <vda.linux@googlemail.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-s5m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 7407d7394bb4..0477678d968f 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -216,7 +216,7 @@ static int s5m8767_tm_to_data(struct rtc_time *tm, u8 *data)
  * Read RTC_UDR_CON register and wait till UDR field is cleared.
  * This indicates that time/alarm update ended.
  */
-static inline int s5m8767_wait_for_udr_update(struct s5m_rtc_info *info)
+static int s5m8767_wait_for_udr_update(struct s5m_rtc_info *info)
 {
 	int ret, retry = UDR_READ_RETRY_CNT;
 	unsigned int data;
@@ -231,7 +231,7 @@ static inline int s5m8767_wait_for_udr_update(struct s5m_rtc_info *info)
 	return ret;
 }
 
-static inline int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
+static int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
 		struct rtc_wkalrm *alarm)
 {
 	int ret;
@@ -264,7 +264,7 @@ static inline int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
 	return 0;
 }
 
-static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
+static int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
 {
 	int ret;
 	unsigned int data;
@@ -288,7 +288,7 @@ static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
 	return ret;
 }
 
-static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
+static int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 {
 	int ret;
 	unsigned int data;
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
