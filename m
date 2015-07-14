Return-Path: <rtc-linux+bncBAABBEMDSOWQKGQECJ5UGOQ@googlegroups.com>
MIME-Version: 1.0
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com. [202.81.31.144])
        by gmr-mx.google.com with ESMTPS id ra16si30930pac.0.2015.07.14.01.00.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Tue, 14 Jul 2015 01:00:16 -0700 (PDT)
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <rtc-linux@googlegroups.com> from <vaibhav@linux.vnet.ibm.com>;
	Tue, 14 Jul 2015 18:00:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id E26B12BB0047
	for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 18:00:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6E7xwju46661652
	for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 18:00:06 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6E7xY2p018889
	for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 17:59:34 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [rtc-linux] [PATCH] rtc/rtc-opal: Enable alarms only when opal
 supports tpo
Date: Tue, 14 Jul 2015 13:28:28 +0530
Message-Id: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
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

rtc-opal driver provides support for rtc alarms via
timed-power-on(tpo). However some Power platforms like BML use a fake
rtc clock and don't support tpo. Such platforms are indicated by the
missing 'has-tpo' property in the device tree.

Current implementation however enables callback for
rtc_class_ops.read/set alarm irrespective of the tpo support from the
platform. This results in a failed opal call when kernel tries to read
an existing alarms via opal_get_tpo_time during rtc device registration.

This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
callback pointers only when tpo is supported.

Acked-by: Michael Neuling <mikey@neuling.org>
Acked-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/rtc/rtc-opal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 7061dca..1125641 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -190,11 +190,9 @@ exit:
 	return rc;
 }
 
-static const struct rtc_class_ops opal_rtc_ops = {
+static struct rtc_class_ops opal_rtc_ops = {
 	.read_time	= opal_get_rtc_time,
 	.set_time	= opal_set_rtc_time,
-	.read_alarm	= opal_get_tpo_time,
-	.set_alarm	= opal_set_tpo_time,
 };
 
 static int opal_rtc_probe(struct platform_device *pdev)
@@ -202,8 +200,11 @@ static int opal_rtc_probe(struct platform_device *pdev)
 	struct rtc_device *rtc;
 
 	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
-						 NULL))
+						 NULL)) {
 		device_set_wakeup_capable(&pdev->dev, true);
+		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
+		opal_rtc_ops.set_alarm = opal_set_tpo_time;
+	}
 
 	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
 				       THIS_MODULE);
-- 
2.2.1

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
