Return-Path: <rtc-linux+bncBCXZV36EUMNBBJ4H7PEAKGQEOURJMBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com. [148.163.156.1])
        by gmr-mx.google.com with ESMTPS id 22si1102669pfj.0.2017.05.19.03.06.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2017 03:06:30 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4JA3kEu045569
	for <rtc-linux@googlegroups.com>; Fri, 19 May 2017 06:06:30 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahvrs5nhb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <rtc-linux@googlegroups.com>; Fri, 19 May 2017 06:06:30 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <rtc-linux@googlegroups.com> from <vaibhav@linux.vnet.ibm.com>;
	Fri, 19 May 2017 20:06:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v4JA6GOO8781926
	for <rtc-linux@googlegroups.com>; Fri, 19 May 2017 20:06:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v4JA5i65028964
	for <rtc-linux@googlegroups.com>; Fri, 19 May 2017 20:05:44 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc/tpo: Handle disabled TPO in opal_get_tpo_time()
Date: Fri, 19 May 2017 15:35:09 +0530
Message-Id: <20170519100509.7807-1-vaibhav@linux.vnet.ibm.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On PowerNV platform when Timed-Power-On(TPO) is disabled, read of
stored TPO yields value with all date components set to '0' inside
opal_get_tpo_time(). The function opal_to_tm() then converts it to an
offset from year 1900 yielding alarm-time == "1900-00-01
00:00:00". This causes problems with __rtc_read_alarm() that
expecting an offset from "1970-00-01 00:00:00" and returned alarm-time
results in a -ve value for time64_t. Which ultimately results in this
error reported in kernel logs with a seemingly garbage value:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

We fix this by explicitly handling the case of all alarm date-time
components being '0' inside opal_get_tpo_time() and returning -ENOENT
in such a case. This signals generic rtc that no alarm is set and it
bails out from the alarm initialization flow without reporting the
above error.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reported-by: Steve Best <sbest@redhat.com>
---
 drivers/rtc/rtc-opal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index ea20f62..2d84e2a 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -142,6 +142,16 @@ static int opal_get_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = ((u64)be32_to_cpu(__h_m) << 32);
+
+	/* check if no alarm is set */
+	if (y_m_d == 0 && h_m_s_ms == 0) {
+		pr_debug("No alarm is set\n");
+		rc = -ENOENT;
+		goto exit;
+	} else {
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+	}
+
 	opal_to_tm(y_m_d, h_m_s_ms, &alarm->time);
 
 exit:
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
