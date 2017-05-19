Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60816 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755001AbdESTDh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 19 May 2017 15:03:37 -0400
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9FDAD20780
        for <linux-rtc@vger.kernel.org>; Fri, 19 May 2017 21:02:24 +0200 (CEST)
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, rtc-linux@googlegroups.com
Subject: [PATCH] rtc/tpo: Handle disabled TPO in opal_get_tpo_time()
Date: Fri, 19 May 2017 15:35:09 +0530
Message-Id: <20170519100509.7807-1-vaibhav@linux.vnet.ibm.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170519100509.2TRK_Cdr9MQLaTbQmmAcXFWdocAHSuhMhwdJnnxG7us@z>

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
