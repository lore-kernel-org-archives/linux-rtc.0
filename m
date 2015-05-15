Return-Path: <rtc-linux+bncBCN6JTVP2IEBBJ7222VAKGQERCLLNYI@googlegroups.com>
MIME-Version: 1.0
Received: from m50-111.126.com (m50-111.126.com. [123.125.50.111])
        by gmr-mx.google.com with ESMTP id zr2si138222pbb.0.2015.05.15.02.32.22
        for <rtc-linux@googlegroups.com>;
        Fri, 15 May 2015 02:32:23 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] [PATCH 1/2] drivers/rtc/interface.c: Change
 rtc_set_mmss() to use time64_t
Date: Fri, 15 May 2015 17:31:31 +0800
Message-Id: <1431682292-29732-1-git-send-email-xlpang@126.com>
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

From: Xunlei Pang <pang.xunlei@linaro.org>

rtc_set_mmss() uses "unsigned long" as its second parameter which
may have y2038 problem on 32-bit systems.

Change it to use time64_t.

All its call sites will be changed later(there are no problems
leaving these call sites untouched).

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/interface.c | 2 +-
 include/linux/rtc.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index d43ee40..480ee3c 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -90,7 +90,7 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
 
-int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs)
+int rtc_set_mmss(struct rtc_device *rtc, time64_t secs)
 {
 	int err;
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..9c3180e 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -161,7 +161,7 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs);
+extern int rtc_set_mmss(struct rtc_device *rtc, time64_t secs);
 extern int rtc_set_ntp_time(struct timespec64 now);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
-- 
1.9.1


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
