Return-Path: <rtc-linux+bncBCXZV36EUMNBB2MBXPEQKGQEDFRI62A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com. [148.163.158.5])
        by gmr-mx.google.com with ESMTPS id b67si535410wme.1.2017.05.31.06.11.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 06:11:04 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4VD99WJ054395
	for <rtc-linux@googlegroups.com>; Wed, 31 May 2017 09:11:03 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2asvvuvr11-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <rtc-linux@googlegroups.com>; Wed, 31 May 2017 09:11:03 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <rtc-linux@googlegroups.com> from <vaibhav@linux.vnet.ibm.com>;
	Wed, 31 May 2017 23:11:00 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v4VDAmK162128262
	for <rtc-linux@googlegroups.com>; Wed, 31 May 2017 23:10:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v4VDANsD027367
	for <rtc-linux@googlegroups.com>; Wed, 31 May 2017 23:10:23 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, rtc-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: [rtc-linux] [PATCH] rtc: opal: Implement rtc_class_ops.alarm_irq_enable
 callback
Date: Wed, 31 May 2017 18:39:01 +0530
Message-Id: <20170531130901.31415-1-vaibhav@linux.vnet.ibm.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Provide an implementation of the callback
rtc_class_ops.alarm_irq_enable for rtc-opal driver. This callback is
called when the wake alarm is disabled via the command:

'echo 0 > /sys/class/rtc/rtc0/wakealarm'

Without this the Timed-Power-On(TPO) config remains set even when its
disabled by the above command and FSP will still force machine
boot at previously configured alarm time.

The callback is implemented as function opal_tpo_alarm_irq_enable()
which calls opal_set_tpo_time() with alarm.enabled == 0. A branch is
added to opal_set_tpo_time() to handle this case by passing y_m_d ==
h_m_s_ms == 0 to opal as arguments for opal_tpo_write() call.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/rtc/rtc-opal.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 2d84e2a..e2a946c 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -167,7 +167,14 @@ static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 	u32 y_m_d = 0;
 	int token, rc;
 
-	tm_to_opal(&alarm->time, &y_m_d, &h_m_s_ms);
+	/* if alarm is enabled */
+	if (alarm->enabled) {
+		tm_to_opal(&alarm->time, &y_m_d, &h_m_s_ms);
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+
+	} else {
+		pr_debug("Alarm getting disabled\n");
+	}
 
 	token = opal_async_get_token_interruptible();
 	if (token < 0) {
@@ -200,6 +207,18 @@ static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 	return rc;
 }
 
+int opal_tpo_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct rtc_wkalrm alarm = { .enabled = 0 };
+
+	/*
+	 * TPO is automatically enabled when opal_set_tpo_time() is called with
+	 * non-zero rtc-time. We only handle disable case which needs to be
+	 * explicitly told to opal.
+	 */
+	return enabled ? 0 : opal_set_tpo_time(dev, &alarm);
+}
+
 static struct rtc_class_ops opal_rtc_ops = {
 	.read_time	= opal_get_rtc_time,
 	.set_time	= opal_set_rtc_time,
@@ -215,6 +234,7 @@ static int opal_rtc_probe(struct platform_device *pdev)
 		device_set_wakeup_capable(&pdev->dev, true);
 		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
 		opal_rtc_ops.set_alarm = opal_set_tpo_time;
+		opal_rtc_ops.alarm_irq_enable = opal_tpo_alarm_irq_enable;
 	}
 
 	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
-- 
2.9.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
