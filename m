Return-Path: <rtc-linux+bncBD7ZDTFR7QFRBI6JTWYQKGQECIMIVKI@googlegroups.com>
MIME-Version: 1.0
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id pe1si939423pac.2.2015.10.21.03.10.43
        for <rtc-linux@googlegroups.com>;
        Wed, 21 Oct 2015 03:10:43 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 03/19] rtc: opal: enable support for the stardard
 "wakeup-source" property
Date: Wed, 21 Oct 2015 11:10:00 +0100
Message-Id: <1445422216-29375-4-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
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

Though the opal rtc driver should and will continue to support the legacy
"has-tpo" property to enable RTC as the wakeup source, we need to add
support for the new standard property "wakeup-source"

This patch adds support for "wakeup-source" property in addition to the
existing "has-tpo" property.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/rtc/rtc-opal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 6fbf9e617151..4087d53ecd73 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -199,8 +199,9 @@ static int opal_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
-	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
-						 NULL)) {
+	if (pdev->dev.of_node &&
+	    (of_property_read_bool(pdev->dev.of_node, "wakeup-source") ||
+	     of_property_read_bool(pdev->dev.of_node, "has-tpo")/* legacy */)) {
 		device_set_wakeup_capable(&pdev->dev, true);
 		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
 		opal_rtc_ops.set_alarm = opal_set_tpo_time;
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
