Return-Path: <rtc-linux+bncBAABBNNR3SUAKGQEQOTA5WY@googlegroups.com>
MIME-Version: 1.0
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi. [213.243.153.188])
        by gmr-mx.google.com with ESMTP id b6si364668lbc.1.2015.03.28.14.10.13
        for <rtc-linux@googlegroups.com>;
        Sat, 28 Mar 2015 14:10:13 -0700 (PDT)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [rtc-linux] [PATCH 2/3] rtc: __rtc_read_time: reduce log level
Date: Sat, 28 Mar 2015 23:09:35 +0200
Message-Id: <1427576976-22353-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
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

__rtc_read_time logs should be debug logs instead of error logs.

For example, when the RTC clock is not set, it's not really useful
to print a kernel error log every time someone tries to read the clock:

	~ # hwclock -r
	[  604.508263] rtc rtc0: read_time: fail to read
	hwclock: RTC_RD_TIME: Invalid argument

If there's a real error, it's likely that lower level or higher level
code will tell it anyway. Make these logs debug logs, and also print
the error code for the read failure.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/rtc/interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 37215cf..c786818 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -31,13 +31,14 @@ static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 		memset(tm, 0, sizeof(struct rtc_time));
 		err = rtc->ops->read_time(rtc->dev.parent, tm);
 		if (err < 0) {
-			dev_err(&rtc->dev, "read_time: fail to read\n");
+			dev_dbg(&rtc->dev, "read_time: fail to read: %d\n",
+				err);
 			return err;
 		}
 
 		err = rtc_valid_tm(tm);
 		if (err < 0)
-			dev_err(&rtc->dev, "read_time: rtc_time isn't valid\n");
+			dev_dbg(&rtc->dev, "read_time: rtc_time isn't valid\n");
 	}
 	return err;
 }
-- 
2.2.0

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
