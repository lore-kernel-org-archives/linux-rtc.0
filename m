Return-Path: <rtc-linux+bncBDS7HNEFSALRBUEV2SVAKGQERFZZXHY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g5si2015wix.1.2015.05.14.13.51.28
        for <rtc-linux@googlegroups.com>;
        Thu, 14 May 2015 13:51:28 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: mt6397: fix build on some 32bits platforms
Date: Thu, 14 May 2015 22:51:18 +0200
Message-Id: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
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

On some !ARM 32bits platforms, the following compilation error happens
because of the division on a 64bits value in mtk_rtc_read_time():

drivers/built-in.o: In function `mtk_rtc_read_time':
rtc-mt6397.c:(.text+0x265d13f): undefined reference to `__divdi3'
rtc-mt6397.c:(.text+0x265d150): undefined reference to `__moddi3'

Use div_s64() as done in rtc_time64_to_tm() to solve that.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-mt6397.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 8bed852e4961..c0090b698ff3 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -150,7 +150,7 @@ static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	time64_t time;
 	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
-	int sec, ret;
+	int days, sec, ret;
 
 	do {
 		ret = __mtk_rtc_read_time(rtc, tm, &sec);
@@ -171,7 +171,8 @@ static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* rtc_tm_to_time64 covert Gregorian date to seconds since
 	 * 01-01-1970 00:00:00, and this date is Thursday.
 	 */
-	tm->tm_wday = (time / 86400 + 4) % 7;
+	days = div_s64(time, 86400);
+	tm->tm_wday = (days + 4) % 7;
 
 exit:
 	return ret;
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
