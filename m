Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900814;
	b=bI23DuyOrMpZI5s2Lye6HhM9J/U1+798PxKyb8/HAcYzbdQ25bGCYF5auGBFBdWfT+pJ
	 7tUhKbCJ6jLaEmzL/4C6uUWgOm+O0/cz4AaCYol7rzSlpInDvrvrM8QdkwIQkOKXobvty
	 JxMgQeI7wMs5pVN3rZbIxbywpsZzO19ei/20rMp/aLre9LOebtt1VNJvY9VnBNLVpHC5c
	 43amEzcYGPmr1cEpZAnXzMxacIUqmsoNEJWkHE0G44oF6qGzQ61ku34S2zcKgpDquB9K5
	 n86GPjh8X+qXt+BDZOwbtYYZmdhqnLK5O5NlMdRnH0Lh9CK4vaMU1s2U7jB95gk7zkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900814;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ljr3p7bWWmksZNtse/bv/k+6EcSlJjIABS0byFl3p0I=;
	b=UCWvGt6kEvP8wwleOfpsUOWKSJA8Pac5Cd14DWoDpd7Gp/Hd1ZDr/+0IOGLUeMOJPAg4
	 C+XVeEZtm5GY5OCKfgXLQqZTbldRTFKfQ/gFB7iu6FhHKOGzUmqAy8YUEP5fc6YCfJ7PI
	 CLXb/onSWU8lj3qhhRAs+jbjA4E0GbyHBwVpH274diXgGO6uKaAdf71i2WJmzF7cezkMf
	 Xux6A6dgAiW9QibQf0wqGbS95/QqvJT/YT5Rf0p83yjLiLxTDOP1AAYZfYDA+zWyC82Rt
	 Ise0jvnYjvXXE+5z8wRgTu+BB9EJqYmX8YI8rlnD845Ge05Iqmqu8FHqIMwQ+dHS0wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EovQJRz7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bIyrBoer;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B8606A323
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9B8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EovQJRz7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bIyrBoer
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aH8q1800719
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ljr3p7bWWmksZNtse/bv/k+6EcSlJjIABS0byFl3p0I=; b=EovQJRz75Lccah9V
	hwXP4PYo7WCNeGceo5484oq6csllYc/jKaqdek8CP1FBcsRni+9MrE08+9DBHTON
	h2OXfIWDNk4Njm10rTxoKC6luJP7UR0r/8cbHmX2kkeMlrHu+MzvGxFYnti5LViw
	/YAIxb+zIEURtsX2C+Ai/P67TCBj7s6cp8w85lqcubLuTPvPdh9qOM0jtsybuNN2
	3JaKDPezM0Ow7ZXv21ZrkC6m2Yeo4tKWjR26Hw9DNTYf/LDhwj3Z/U8m1YEKrlVf
	1o1ioOZOeuxjemwxofmOzcN6S7xoEMqJsrYM/S24G0ct9AlMjU19hwnsuhY0CfE8
	WXCe2A==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y3nd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:32 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-46509ab0149so3814379fac.2
        for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 23:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794900812; x=1795505612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljr3p7bWWmksZNtse/bv/k+6EcSlJjIABS0byFl3p0I=;
        b=bIyrBoerXwTbAQ9BwTd6MC9ycKA/I3NeExw1ibvSA+mpbDAaTfhO098Y0H484qOOK+
         e/cpfbR4xKfyvscY2IKo6lzdIZcX3zxwJUhkC63wVKNWDtIEJ4jmUYaUG89Rj2Zgillk
         mkLf6SBcgfnpvNIEM+JsSWICrMauDV2lb8XZfmSwH1p7dsuuiXCTE/t94IBfhbCNUt8O
         Ea/tFtqKF8Gr+/Jsj2AR9F1yuj3lb223TQPeQBd3O7q/SAA9SJvw0LO01bMH+5IKPFDe
         B0pffnrfZyYD2lEC7FDfN/+8CrsRodsrCRK27yX3nikBDlsuA2IMD3ovsEtdhKlv/Vjp
         LpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794900812; x=1795505612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljr3p7bWWmksZNtse/bv/k+6EcSlJjIABS0byFl3p0I=;
        b=lwmbxO22bWLiFhnK5vvaoy27XWSkjRNYIiqBKf3ooYp9t0Bnz+hVJNjLE3vgrLB/8L
         +Z2e0HdjFbUbNtf3je1EupkpgwzForLcBuen6URCwcgUly3FndthZnOchMO08zoTHZei
         EIipGOVYjqsfEDQwcmGVLGqIJqFDQ6Sq+ZcpzzcZHcdB7kuGe+qGtsXVM6TlymOBq3eI
         IiBID5/Bp+XXB1KaxHF8zxiC1vem+VB8ryLGGZH62s2pRtwYQEndVc07LhgrVS762sCg
         SnF40hMr2POcsZtxP2ioLFy/giDdLVyT/cKq4CANMSAl7bmYSpQwoe/pp5peWi4m2Ofw
         EsMg==
X-Forwarded-Encrypted: i=1; AL+hErFP7HDCTUmYRqgTQdKzOTge2vfl0TjiM77yMylPuTayfLnWXlw6182SyAv9OXghEnopcxCjr4qV/tU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FRjH/rVxaLT0jR9r4cqe5UTL84QwtxTztx1M6DPu2+amlQuNZ
	4K3Mg4O9t2465756n77iPwVF94v2W6i9YVNv98QAjLAASzVwRmZirLuVdbD9qhtS6sJKJNRdf1u
	+sFw4y+4/H2xZJqkJ73+PCbEE395BcKcmDVBCWTP09szj+gLrU+jt49GW5aqcwVc=
X-Gm-Gg: AYBFou2Z/RZPM+tsXDZp4Z2Xy0IlAtO+KVTo6c4fGGZd9QV392E0+3Hf/2/MGvpVT/J
	zLkC1xXRkkiq0p2rQUPB0O/8wtfJCx8ZHjd3JKwylRj0xkJCKZ+pdHbBtFQ4MXT1EDvsKvzHidW
	W7NzFmqlLmpbQ8YQD+z6gOWWiKazkYDNQoE3+aJMDzy/PlwqFFuGcTRTTp5Nd3CE9V0rMmtD586
	1isiYhoF02qZUwUBrjzCHO6MWryjdd67SZB5ZyiCOqQkKrxK2Tmd9oF9bnvyqm5TRo5RCwTcj9k
	G5y9xZVFLDrHydUeh7pvcOsLBpCWaaVf6KrZYQmRwPpQax+wu9B3clqXzrO7liow+hgBdbSlEtW
	g/j2OTpXrOTSN3PwPEwxMMS00rl3/Y8LtnyI1isLCCX2erx/knaQ1Jjc25XW+44OB4SFA27/DNe
	/t8tS6IXh+6MXkoNILhu4Rk15UMw==
X-Received: by 2002:a05:6870:f627:b0:4a8:407d:4076 with SMTP id 586e51a60fabf-4afdf71a881mr11465706fac.34.1794900811854;
        Mon, 16 Nov 2026 23:33:31 -0800 (PST)
X-Received: by 2002:a05:6870:f627:b0:4a8:407d:4076 with SMTP id 586e51a60fabf-4afdf71a881mr11465681fac.34.1794900811324;
        Mon, 16 Nov 2026 23:33:31 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe228982bsm8593875fac.10.2026.11.16.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:33:30 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:33:19 -0800
Subject: [PATCH v2 3/3] rtc: Add Qualcomm GIO RTC driver
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
Message-Id: <20261116-gio-framework-rtc-driver-2026-10-12-v2-3-b60e6fe33831@oss.qualcomm.com>
References: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
In-Reply-To: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794900802; l=8209;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=9pSSayOZld+8+2ZtoJm1a47VtEYByZ4Mwtri1xjlJJ0=;
 b=+9wMJQN8Fg5qHtM9J7rMJOZkwnol/zWY0bVcHoHy9ecnJrOgt2tlIr6JgjNvKDlXmU17SK5YM
 +IN/RUZ6j5dAL1EAFHwbXtT7DeM7VO4kuctn1N9GeyDO1NwPE0T5e2q
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: WbtBbL45b6RRZskPVwtif4-YfQI1QJj3
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afc034c cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PQbxmwGiin7G8qBTPywA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: WbtBbL45b6RRZskPVwtif4-YfQI1QJj3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX7oxXpBGDypZG
 jD5g3IpjMGIpiOruhRUR7y6My8N5k21/6oPdgkeLP6XOp6OFMAVnlo7GiRTzn4QB7O3yP0e76cs
 OJ6xjGIIrR108SEmmyDtpMp4Gibm92g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX1pGd7ihfd5j7
 IJz9l48EBL0OYOXGgo/INNLNAeTR9ConAuFkO+gsBW+PA2PluJOodLNAo8tjgxB9P5Fn0YaysMQ
 vgvTGKFrIV6ksFDlrARld3mmjH0OlEyR30/Qvzv8zO9nVCxDkAcZpxgJNEDgkCXlwEgmqVM/UFv
 IOlGxUk4b2vLFlHN0wWEIpOLtPdrwLTk6o1hMh7uVShSwt1xAqnJRrTcYXoTf78Rx8EsG+LIdJe
 VZYOh2KRc9ooukXDpBPOgSnNkzopERbfXpelosQmQMB6SXhTYAnarl7UNSrriWVYKGxQJjpgKXw
 UZJ8ptW+u05LkUVcBL8VCDa5eN/XiDIzohXopdKm/E2c0FyHzsVssOa9k6zBkUCIuoNyhi9tljc
 gzzFclzN+ExAqRaYFn+kJBz+52mqQnh0S+1ttSZ0Eyz60ERjrWnMPy3ry54iyceppSeWCtkD5m6
 yCgEb0f2snosOkw/D7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170029

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
 drivers/soc/qcom/pmic_glink_gio.c |  14 ++++
 4 files changed, 179 insertions(+)

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
index 9a28f88152b2..1f58a8fcada3 100644
--- a/drivers/soc/qcom/pmic_glink_gio.c
+++ b/drivers/soc/qcom/pmic_glink_gio.c
@@ -113,6 +113,8 @@ struct pmic_glink_gio {
 	bool service_up;
 
 	struct gio_write_req write_req;
+
+	struct auxiliary_device *rtc_aux;
 };
 
 /* Must be called with pgio->lock held. */
@@ -339,6 +341,18 @@ static void pmic_glink_gio_init_work(struct work_struct *work)
 
 		pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_UP);
 	}
+
+	/*
+	 * Create GIO consumers after PDR to ensure the transport
+	 * is up before consumers use the GIO regmap device.
+	 */
+	if (!pgio->rtc_aux) {
+		pgio->rtc_aux = devm_pmic_gio_add_consumer(pgio->gio, "rtc");
+		if (!pgio->rtc_aux) {
+			dev_err(pgio->dev, "failed to add RTC consumer\n");
+			return;
+		}
+	}
 }
 
 static void pmic_glink_gio_alert_work(struct work_struct *work)

-- 
2.43.0

