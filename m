Return-Path: <rtc-linux+bncBCEKJX4XQ4ORBAN3UKXAKGQE7DUHDGQ@googlegroups.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0124.outbound.protection.outlook.com. [207.46.100.124])
        by gmr-mx.google.com with ESMTPS id qa1si690356pdb.1.2015.08.10.05.48.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 05:48:01 -0700 (PDT)
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <alexandre.belloni@free-electrons.com>
CC: <festevam@gmail.com>, <rtc-linux@googlegroups.com>, Fabio Estevam
	<fabio.estevam@freescale.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: rtc-cmos: Remove unused variable
Date: Mon, 10 Aug 2015 09:47:44 -0300
Message-ID: <1439210865-8611-1-git-send-email-fabio.estevam@freescale.com>
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

Remove unused variable 'err' and fix the following build warning:

 drivers/rtc/rtc-cmos.c:851:7: warning: unused variable 'err' [-Wunused-variable]

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-cmos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 916bd1f..c2e90c6 100644
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
