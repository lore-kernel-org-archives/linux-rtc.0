Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367732;
	b=MH3W92y6For17jM4KivvxQWzqxSBHOLj+FJoGhbU/1BYDIuIKJnplCWiAabr8GiZ5Ken
	 M051H33dJxU+2ingtJ3Z7wlR/hdtYlJMD5DC5uG1iLNqNI1N9xnrbNGDJCV4DK5aD3Gt6
	 ZPJPRcPbXCSGom5H+ppLx1XQ3aHyc7nSQy4HJia3C0bhdJ5HNKgN/dq1ujB0CUBCXa8Mv
	 bWhKzW+cJbwkQZk+8/rui0OTMfe/FJixGOWFZN7JhjbUdRSVhBkNje4rGKMVvOcZB1Gy7
	 09zOSnqmMyx3GAd97E++qtRXa1i6EhCWtVINzECWjyn0wNo2DK444tMMppUtXMYRegg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367732;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=seJ/5y5RuaC+sAMVS854uyQsp644CPB81fm8EZeB13w=;
	b=tcLJcMyu4ocWUfLpigH9jKEQrQBsdwha+TOwpQxz2w3cdzKDD8MGYkm67tiBkLoTiPi2
	 +NVPHVxA4xkG3Tt23hrEBwLWe1ydBL7p9wfgSwRY7qjjo0py4AiL7PAJrPiSysRjJCgnK
	 O+iz/N9UJURHrTUoA/HsjHGg5Y+l6/YgztfxKNeFGw2WtyQKYhy+Ca/jCU58IEWZ0FPMj
	 L3SHraTz4+GojjzN8VzXo6D+7x222UjUCHadIdfJI5D1eCUcpHMgp4+4mdCN20114+d+j
	 CvdyyAHNksDbx1pOInwXQD9gd03GrCqKw36LUQ+7A322K/jijAm6uKAvPf+YuYw/8rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hjx6tgUQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SSrMBHXO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569A60A2607
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2569A60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hjx6tgUQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SSrMBHXO
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1t2vS898399
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	seJ/5y5RuaC+sAMVS854uyQsp644CPB81fm8EZeB13w=; b=Hjx6tgUQHHY7jOQq
	GeOG5HmIp/bsko5PReWKWFh7XXl0JsGDwCpgdLfQsSJ/o0nxW2noQv2FpDAt0aij
	ncpgaiTtljTOUTrKmCX7a5XJEysA4t62DpFLcLaC5/lR7zatEefjDvc1UvNPjGt5
	Z0W6XECAFaxJKF+Tf/OsRHnq35myMfDVJRbbblhwznSXLa3kfLuIMWvfRr+96EBg
	vBm3/c0TtGsME1DPFomYBLJPTKr4TchKujV3Y1FX5r4JYJXAGqiJfoFqGZG+hRDK
	MD5yzWf/kpW5rqLurS6cphDoEVL/7Wd3n5bgSE9+B21aBD4lT1N14P+iUCjDa6KQ
	14ZiEA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufv387-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 03:28:51 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso3999234c88.0
        for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 19:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794367731; x=1794972531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seJ/5y5RuaC+sAMVS854uyQsp644CPB81fm8EZeB13w=;
        b=SSrMBHXOVzV20eWbeMURI4K5x7D1hJ64QdvUvVK0Kr9DOO21+p2R8aLYxZiAXip5oP
         7EhD/wmFmkmDzHxDMgVkV9Z3b0jY2t9v19kNW/0SNDuYxHOraOry3hmsZor2RLxp4pBl
         0Lk6sarkCBVSWopLvl22vckDjRTPGF2TSCQdSgtii1cSKv/uDhdfOv9iscLdSynj4yEO
         btOvpO7oa6usd8f4rcVLStP5Ads9qIRNDonXy6wCJizGYjs2LbV/KNRE1vx7hKYE7KRT
         hktc/8z8jMhYWf8o6vnsNzUHIjaABBzSewurLCgBsfB9AVfRp71hHvZ02ISsqqgBm6v4
         PX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367731; x=1794972531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seJ/5y5RuaC+sAMVS854uyQsp644CPB81fm8EZeB13w=;
        b=I99/SxS8QeHZc0cJALk62l/EMRTShRdLO04ZP0aQUU4pd6IxVX6t3nAI0qBOfoVqDv
         NHnU5Uyip/y4/xxOUZoy4C1tDZ/m9lfBaQsP3WkfmuXKn9lKPD7XQhAiICKhpvZSYhJc
         /gTzaxfDo7YtwAwvnDBGGqFJ8XyuZgvL+x/48PDhC7WDKokXm+eVH21WgOVoMPQSi6gA
         LDkC8D7bpiVqhsmwHhCndsnnpPGJ2v+FQe93//sKYjWnaWZumKu7KT66qgx1XchpDHiO
         WoUJWay4/kD3xZS9CPN9rg+V49L5i927bkTDGx+q+UksmFufV57cq+DKCHMYYP6SFYLa
         4DFw==
X-Forwarded-Encrypted: i=1; AL+hErGZFjO80TxnyaIz2tc44TYJM+p9LiWJ2Qtv6MTKaPJ6sGqFL2vFWXDUnhO5S0P9Oy8dq0G1wMW1vh8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x2Ybrexnkl9bPjm5NpWTdiUBVc3qCgheXVlBUVAFZtpzehBKU
	9HY8uV50vbRLBnDBRcJo0F+tnMUYjAw+x4qO2dD9It5Nbou1vttK/HazqoD6LP384Wcz0G/Ua2N
	gZGP/yOVCPnInFrkialkyitN/J1KsrtLaIc1mxN60xkplLCiN8GGUSy+rv0wn04g=
X-Gm-Gg: AYBFou2U+sYXddXbvrRQA1QcnycXHIrRjsQu9KYd/POAQJygxZTauhqUaG8iYnRtdNP
	w4v+GtTheDkmnBg71lUAdnAil35fMFLFpf/6JDu1+vmLZPu3YlaXa9aXnW/pWINPWYMWWbHyrnj
	NOtyoaHhXd3vHRJFZ0OQEC+iUT/0aXZUS1uTzuDI34Jpl9oc6aJdCDFFn29L9KtVmMWaBoMj463
	8r1CRGwBhg2qvByWGI27TBeHPzCqZXM6pDmOkah2NkHXP2vVOnQlh6yqxdPvxzwEkkrTJsjXqj6
	kd3JgkuLdAbRB3orY6Du2gA5Gp11QCpR7xUed5tbx6mykTVNIoui7Coopieg9GHlR5tPEVcE/8e
	C0uk8qVsijMC4lJECTcMB6rcALZl+7DzdQ4l4T0m5x/tRJNW4rlO/84ZfhJeI/lvsAB5Luhy99o
	W4+APzHoK+dzvN56r+dPRlFiRg
X-Received: by 2002:a05:701b:2219:b0:16a:f5cd:365 with SMTP id a92af1059eb24-1b3c023b669mr1064300c88.5.1794367730486;
        Tue, 10 Nov 2026 19:28:50 -0800 (PST)
X-Received: by 2002:a05:701b:2219:b0:16a:f5cd:365 with SMTP id a92af1059eb24-1b3c023b669mr1064277c88.5.1794367729839;
        Tue, 10 Nov 2026 19:28:49 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b56c4e88sm10261800c88.0.2026.11.10.19.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:28:49 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 19:28:18 -0800
Subject: [PATCH 3/3] rtc: Add Qualcomm GIO RTC driver
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-gio-framework-rtc-driver-2026-10-12-v1-3-e4164178183a@oss.qualcomm.com>
References: <20261110-gio-framework-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com>
In-Reply-To: <20261110-gio-framework-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794367724; l=8990;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=0ot5QBIsVs13Ds+ZVBJCzyrGNDcgqL2X7Q4XjFAfTB4=;
 b=CmzNuZOXjhIo2ht8ZAxsj7MEjLxhJCkWYO0Q5v3umv5sE/o7BPS3TgU7XUY+B7VgzZTH1o0ra
 kH9E9xKlp7SBkkGUNx0WZ4JNyY12ov/G7Mz7hA4Z+HqbyuAYVURsx0j
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: 2ug97beXMeCC3jTqETyyywlGXMrD-tgS
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af3e0f3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_4neYXsdY3XM12RIAjQA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 2ug97beXMeCC3jTqETyyywlGXMrD-tgS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfXyoXLWfVwYbT+
 PsF8VJQjGXcQ6I0qdlH/Hhb3jJsnagwl3lwE4CrFh+yvac6JQfsjnLJNOzTlhZbn86R8QK5HJgP
 DCyAsJdBlEG0UEwxPSAFCBO3jp4JdTM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfX0DG/nniQrirF
 P37FGPJQI8ILsQVmxAzyxkGGgLUmiif53B5joat0rqrQxOrsP7VpPwzphVTNzxaRXxoN48fjbSp
 opYo540tam+msnMfpKTzHLRA4hO7rrBSfU4NmRXo8VQmIuo4/RCvDZZE26vsp3CIefuptqmAOmw
 bKiLrY7gT4srjQzWUtDr/tfiDD1ceSZT9TzJHGkNkHOnzEQ//g4e7UK1jwnwyOzMTvi95L4XHjX
 aICug8dsJWS1BmiTQbXcZF/b2eMRTIx+w52O3P/bKVoac/5hsYqcwMxC4FYX+835rJLU6IoGthX
 ndLfIIjqKj14UefEJZE6WSI/XijrHDwOYnS4QC2eV6uvEKji/nwP4yT4BrRinTaut5KhNivoJCp
 nllBgLsjagXYcLVf5nCY6SA9Jl7RxY2CO55RqefCr2YtjRB/TXMeyi76s0z0O4EQc3qvFLPnjSX
 L09pNW6ocgv8NalEuhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110013

On the Glymur platform, the GIO (General I/O) interface communicates
with the SoCCP battery-management firmware and provides a set of TAD
(Time-Alarm-Device) registers for reading and writing RTC time. The
platform also includes registers for configuring an alarm timer and
initiating device boot-up into different power stages, such as:
charging only or fully powered-on system, based on the applied power
source (AC/DC). However, repurposing this alarm timer has very limited
value for an RTC driver because it does not expose an interrupt when
the timer expires.

Add an auxiliary RTC driver that corresponds to the auxiliary device
created by the GIO driver, "pmic_gio.rtc", which manages the RTC timer
by accessing to the TAD real-time register block through the regmap
interface exposed by the GIO device.

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # Zenbook A16
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/rtc/Kconfig               |  11 +++
 drivers/rtc/Makefile              |   1 +
 drivers/rtc/rtc-qcom-gio.c        | 153 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/pmic_glink_gio.c |  36 +++++++++
 4 files changed, 201 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230edfd..a298f7ae68f9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1863,6 +1863,17 @@ config RTC_DRV_PM8XXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-pm8xxx.
 
+config RTC_DRV_QCOM_GIO
+	tristate "Qualcomm GIO RTC driver"
+	depends on QCOM_PMIC_GLINK_GIO
+	help
+	  Say y here to support the real-time clock exposed in Qualcomm
+	  SoCCP battery management firmware through the GIO (General I/O)
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called rtc-qcom-gio.
+
 config RTC_DRV_TEGRA
 	tristate "NVIDIA Tegra Internal RTC driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 46f1a0fc2416..9cb76aac7897 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_RTC_DRV_PM8XXX)	+= rtc-pm8xxx.o
 obj-$(CONFIG_RTC_DRV_POLARFIRE_SOC)	+= rtc-mpfs.o
 obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
 obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
+obj-$(CONFIG_RTC_DRV_QCOM_GIO)	+= rtc-qcom-gio.o
 obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
 obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
 obj-$(CONFIG_RTC_DRV_RPI)	+= rtc-raspberrypi.o
diff --git a/drivers/rtc/rtc-qcom-gio.c b/drivers/rtc/rtc-qcom-gio.c
new file mode 100644
index 000000000000..679b24f2a190
--- /dev/null
+++ b/drivers/rtc/rtc-qcom-gio.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/soc/qcom/pmic_gio.h>
+#include <linux/soc/qcom/pmic_gio_regs.h>
+
+struct tad_rt {
+	u32 ymd;
+#define RT_YMD_DAY		GENMASK(31, 24)
+#define RT_YMD_MONTH		GENMASK(23, 16)
+#define RT_YMD_YEAR		GENMASK(15, 0)
+
+	u32 hms;
+#define RT_HMS_VALID		GENMASK(31, 24)
+#define RT_HMS_SEC		GENMASK(23, 16)
+#define RT_HMS_MINUTE		GENMASK(15, 8)
+#define RT_HMS_HOUR		GENMASK(7, 0)
+
+	u32 ms_tz;
+	u32 daylight;
+} __packed;
+
+static_assert(sizeof(struct tad_rt) == GIO_SVC_TAD_RT_SIZE);
+
+struct rtc_qcom_gio {
+	struct regmap *regmap;
+	struct rtc_device *rtc;
+};
+
+static int rtc_qcom_gio_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rtc_qcom_gio *rtc = dev_get_drvdata(dev);
+	struct tad_rt rt;
+	int ret;
+
+	ret = regmap_bulk_read(rtc->regmap, GIO_SVC_TAD_RT_ADDR, &rt,
+			       sizeof(rt) / PMIC_GIO_REG_GRANULARITY);
+	if (ret)
+		return ret;
+
+	/*
+	 * The firmware may return valid RTC values even when VALID is not set.
+	 * Only print out register values for potential debug if it's needed.
+	 */
+	if (!FIELD_GET(RT_HMS_VALID, rt.hms))
+		dev_dbg(dev, "RTC registers: ymd=%#010x hms=%#010x\n", rt.ymd, rt.hms);
+
+	tm->tm_year = FIELD_GET(RT_YMD_YEAR, rt.ymd) - 1900;
+	tm->tm_mon = FIELD_GET(RT_YMD_MONTH, rt.ymd) - 1;
+	tm->tm_mday = FIELD_GET(RT_YMD_DAY, rt.ymd);
+	tm->tm_hour = FIELD_GET(RT_HMS_HOUR, rt.hms);
+	tm->tm_min = FIELD_GET(RT_HMS_MINUTE, rt.hms);
+	tm->tm_sec = FIELD_GET(RT_HMS_SEC, rt.hms);
+
+	return 0;
+}
+
+static int rtc_qcom_gio_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rtc_qcom_gio *rtc = dev_get_drvdata(dev);
+	struct tad_rt rt;
+	int ret;
+
+	/*
+	 * The firmware requires the whole TAD_RT block to be written in a
+	 * single transaction, so ms_tz/daylight (which this driver never
+	 * changes) have to be read back and carried through unmodified
+	 * rather than writing just the ymd/hms words we care about. This
+	 * leaves a small window where a concurrent firmware-side update to
+	 * ms_tz/daylight between the read and the write below is clobbered
+	 * with a stale value; accepted given the firmware doesn't support
+	 * partial-block writes.
+	 */
+	ret = regmap_bulk_read(rtc->regmap, GIO_SVC_TAD_RT_ADDR, &rt,
+			       sizeof(rt) / PMIC_GIO_REG_GRANULARITY);
+	if (ret)
+		return ret;
+
+	rt.ymd = FIELD_PREP(RT_YMD_DAY, tm->tm_mday) |
+		 FIELD_PREP(RT_YMD_MONTH, tm->tm_mon + 1) |
+		 FIELD_PREP(RT_YMD_YEAR, tm->tm_year + 1900);
+
+	rt.hms = FIELD_PREP(RT_HMS_VALID, 1) |
+		 FIELD_PREP(RT_HMS_SEC, tm->tm_sec) |
+		 FIELD_PREP(RT_HMS_MINUTE, tm->tm_min) |
+		 FIELD_PREP(RT_HMS_HOUR, tm->tm_hour);
+
+	return regmap_bulk_write(rtc->regmap, GIO_SVC_TAD_RT_ADDR, &rt,
+				 sizeof(rt) / PMIC_GIO_REG_GRANULARITY);
+}
+
+static const struct rtc_class_ops rtc_qcom_gio_ops = {
+	.read_time = rtc_qcom_gio_read_time,
+	.set_time = rtc_qcom_gio_set_time,
+};
+
+static int rtc_qcom_gio_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct rtc_qcom_gio *rtc;
+	int ret;
+
+	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!rtc->regmap)
+		return -ENODEV;
+
+	dev_set_drvdata(dev, rtc);
+
+	rtc->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
+
+	rtc->rtc->ops = &rtc_qcom_gio_ops;
+	rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	ret = devm_rtc_register_device(rtc->rtc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct auxiliary_device_id rtc_qcom_gio_id_table[] = {
+	{ .name = "pmic_gio.rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, rtc_qcom_gio_id_table);
+
+static struct auxiliary_driver rtc_qcom_gio_driver = {
+	.name = "rtc_qcom_gio",
+	.probe = rtc_qcom_gio_probe,
+	.id_table = rtc_qcom_gio_id_table,
+};
+
+module_auxiliary_driver(rtc_qcom_gio_driver);
+
+MODULE_DESCRIPTION("Qualcomm GIO RTC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/qcom/pmic_glink_gio.c b/drivers/soc/qcom/pmic_glink_gio.c
index f222c0d59220..83656a5758b8 100644
--- a/drivers/soc/qcom/pmic_glink_gio.c
+++ b/drivers/soc/qcom/pmic_glink_gio.c
@@ -116,6 +116,8 @@ struct pmic_glink_gio {
 	bool service_up;
 
 	struct gio_write_req write_req;
+
+	struct auxiliary_device *rtc_aux;
 };
 
 /* Must be called with pgio->lock held. */
@@ -318,6 +320,28 @@ static void pmic_glink_gio_enable_alerts(struct pmic_glink_gio *pgio)
 		dev_err(pgio->dev, "GIO turn on global alert failed: %d\n", ret);
 }
 
+static int pmic_glink_gio_add_consumer(struct pmic_glink_gio *pgio,
+				       struct auxiliary_device **aux,
+				       const char *name)
+{
+	struct auxiliary_device *new_aux;
+	int ret;
+
+	new_aux = devm_kzalloc(pgio->dev, sizeof(*new_aux), GFP_KERNEL);
+	if (!new_aux)
+		return -ENOMEM;
+
+	ret = devm_pmic_gio_add_consumer(pgio->gio, new_aux, name);
+	if (ret) {
+		devm_kfree(pgio->dev, new_aux);
+		return ret;
+	}
+
+	*aux = new_aux;
+
+	return 0;
+}
+
 static void pmic_glink_gio_init_work(struct work_struct *work)
 {
 	struct pmic_glink_gio *pgio = container_of(work, struct pmic_glink_gio, init_work);
@@ -326,6 +350,18 @@ static void pmic_glink_gio_init_work(struct work_struct *work)
 	if (!READ_ONCE(pgio->service_up))
 		return;
 
+	/*
+	 * Create GIO consumers after PDR to ensure the transport
+	 * is up before consumers use the GIO regmap device.
+	 */
+	if (!pgio->rtc_aux) {
+		ret = pmic_glink_gio_add_consumer(pgio, &pgio->rtc_aux, "rtc");
+		if (ret) {
+			dev_err(pgio->dev, "failed to add RTC consumer: %d\n", ret);
+			return;
+		}
+	}
+
 	pmic_glink_gio_enable_alerts(pgio);
 }
 

-- 
2.43.0

