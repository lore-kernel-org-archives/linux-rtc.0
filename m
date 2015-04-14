Return-Path: <rtc-linux+bncBCC6ZWOPXENRBYNTWOUQKGQEQFN3WQI@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id m3si685709wia.1.2015.04.14.02.12.00
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 02:12:00 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org,
	Robert Schwebel <rsc@pengutronix.de>
Subject: [rtc-linux] [PATCH 1/5] RTC/i.MX/DryIce: add some background info
 about the states the machine can be in
Date: Tue, 14 Apr 2015 11:11:52 +0200
Message-Id: <1429002716-19821-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
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

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index c666eab..8750477 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -129,6 +129,49 @@ struct imxdi_dev {
 	struct work_struct work;
 };
 
+/* Some background:
+ *
+ * The DryIce unit is a complex security/tamper monitor device. To be able do
+ * its job in a useful manner it runs a bigger statemachine to bring it into
+ * security/tamper failure state and once again to bring it out of this state.
+ *
+ * This unit can be in one of three states:
+ *
+ * - "NON-VALID STATE"
+ *   always after the battery power was removed
+ * - "FAILURE STATE"
+ *   if one of the enabled security events have happend
+ * - "VALID STATE"
+ *   if the unit works as expected
+ *
+ * Everything stops when the unit enters the failure state including the RTC
+ * counter (to be able to detect the time the security event happend).
+ *
+ * The following events (when enabled) let the DryIce unit enter the failure
+ * state:
+ *
+ * - wire-mesh-tamper detect
+ * - external tamper B detect
+ * - external tamper A detect
+ * - temperature tamper detect
+ * - clock tamper detect
+ * - voltage tamper detect
+ * - RTC counter overflow
+ * - monotonic counter overflow
+ * - external boot
+ *
+ * If we find the DryIce unit in "FAILURE STATE" and the TDCHL cleared, we
+ * can only detect this state. In this case the unit is completely locked and
+ * must force a second "SYSTEM POR" to bring the DryIce into the
+ * "NON-VALID STATE" + "FAILURE STATE" where a recovery is possible.
+ * If the TDCHL is set in the "FAILURE STATE" we are out of luck. In this case
+ * a battery power cycle is required.
+ *
+ * In the "NON-VALID STATE" + "FAILURE STATE" we can clear the "FAILURE STATE"
+ * and recover the DryIce unit. By clearing the "NON-VALID STATE" as the last
+ * task, we bring back this unit into life.
+ */
+
 /*
  * enable a dryice interrupt
  */
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
