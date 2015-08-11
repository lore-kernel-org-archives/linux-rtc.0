Return-Path: <rtc-linux+bncBCGP7DNSRUMRBZEBVCXAKGQEGPQWBRA@googlegroups.com>
Received: from mail1.windriver.com (mail1.windriver.com. [147.11.146.13])
        by gmr-mx.google.com with ESMTPS id ys2si219664pac.0.2015.08.11.07.04.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 07:04:20 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Adrian Huang
	<ahuang12@lenovo.com>, Egbert Eich <eich@suse.de>,
        Diego Ercolani
	<diego.ercolani@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>, <rtc-linux@googlegroups.com>
Subject: [rtc-linux] [PATCH] drivers/rtc: fix compile warning introduced by 1s
 reboot fix
Date: Tue, 11 Aug 2015 10:04:04 -0400
Message-ID: <1439301844-22710-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

We currently see this warning:

drivers/rtc/rtc-cmos.c:851:7: warning: unused variable 'err'

introduced by commit 7b4a008088a28ea936fffbbfa770d0184468a0ce ("rtc-cmos:
Cancel alarm timer if alarm time is equal to now+1 seconds").

Presumably some WIP version of the commit was doing error checking
but then the variable was not removed prior to submission, and the
pending commits weren't on kernel.org for kbuild bot to spot the new
warning created.

Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Egbert Eich <eich@suse.de>
Cc: Diego Ercolani <diego.ercolani@gmail.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Note: patch is against linux-next, so if the rtc tree is rebased,
 then the above commit ID reference will be stale.  Feel free to
 adjust the commit log appropriately, if need be, or even squash
 this into the original offending patch, if rebasing back that far.
 Also ensuring your tree is on kernel.org will allow kbuild bot
 to spot these on your behalf via the zero day builds.]

 drivers/rtc/rtc-cmos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 916bd1f555e5..c2e90c62a59c 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -848,7 +848,6 @@ static int cmos_aie_poweroff(struct device *dev)
 	 */
 	if (cmos->alarm_expires == t_now + 1) {
 		struct rtc_wkalrm alarm;
-		int err;
 
 		/* Cancel the AIE timer by configuring the past time. */
 		rtc_time64_to_tm(t_now - 1, &alarm.time);
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
