Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF63490C1E
	for <linux-rtc@vger.kernel.org>; Thu,  6 Aug 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049860; cv=none; b=bVuWTC8ZH4o+dw9q0STt6ZRjWEC3nDW7uIO8TaTAr8ujNO7KFmrvDQK50Emq7xr/Hlgln8uxUtXjvfTemGNSagI2agnzhwBwg0FaSTSl71VWGuCvUng0WxDjnbnjTUoP1jmkG9i+04MOz2CVksDQfeP/ARxOE1pSC3NI5W5w4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049860; c=relaxed/simple;
	bh=x+MRZH90hm65VMG3ngwkdI5VIRnbua7WatjVs6iBRyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTg7Tz/tcYz92bj6tb4eWj6AgbS7fDv9EJInlBXZILhUjvlQpETyYtHT/e0YaVcQBLUKjabjCJrMBkRzVN8DEGcF4bmMEoWgYLYsPQ3AIEeSWjPY2P3avMztB5e2v+A8d4EbggzBYSNpoZ9yA0+uSuv6vfdHas/HwdEzY6ONJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JSR7VIbz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OwUsBD+v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JSR7VIbz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OwUsBD+v"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHm7C2027999
	for <linux-rtc@vger.kernel.org>; Thu, 6 Aug 2026 20:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y+8TrZkpEFnhn5F2E3bQ04hIXxyfTiO/aiemUcJ2Jhc=; b=JSR7VIbzRzT15uBK
	S383/jyHn8yH40NEGN9pZ/arTZd2bXwCgQsYi29JzpT1h3Sa7BV5uGj/2DzLrJs5
	LD8i+Vk4gHU3l0U2rXQkHaxIiFHBbzCXxjZ15bOg3m9xN5tNjFnUkylukbkH4mxe
	gmRGZNJzwWFqFtaH4S7zyQSgt8SG2O9iFdWgqT4Axy07g12y1sek3/xQ0XwQjKPA
	UhNwMkwRtbIvG0xrRCGQbGUW7SKB5CYEZiY3Xs+Y0uaFN+dh0bxh39LiESX6Tdtb
	pVX1Pg+yTdWtm6LCcPxjJLZEMkl+e1GxJM7yDVcNI7uHv3OJ8Y1XFjq4drpJCwS5
	PFINWw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hrpuv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 20:57:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so2686568a12.2
        for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786049837; x=1786654637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y+8TrZkpEFnhn5F2E3bQ04hIXxyfTiO/aiemUcJ2Jhc=;
        b=OwUsBD+vV39AXNi0IBuKsOfkyZrS6CPKqZQRKiKLl/9i5T9x8ir07RPW/UOJvg8Raq
         JX1aIVIQDdqTKOTfgdjPWZxTP784fpabfp+G2Wpv46D0Nhch3Ligb5SNnG4N0fMjTFCx
         F95WvEhLNsmTmX/ZvYUKHxMuC/E8jCIknCEXnTsO6kfRNjNZ72+vvHCyUTmiy3+kL9VY
         Bld0PKG5AWcHIBljBi0sx4no4Icl2O83lNZLAyrSLHb1qWYRpTGjlezARw0hItx3gyHN
         Yd5ZXrIKNQyzgr+US8UFriw8eskSbEEAQpjpFUU8mgmElUIXc1pPxpPmSDQMLOzldi3d
         NxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786049837; x=1786654637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y+8TrZkpEFnhn5F2E3bQ04hIXxyfTiO/aiemUcJ2Jhc=;
        b=Cpzq8PLNH7GDAsUfEchNwzXn81aM9QfBfHz/PglYAu1/kSlXbJscB+h2Hhdb9yZ4Lo
         +8euhtdP/y47UcnRsU9ryVCdovwFOq3XsouUYNrvJg6FahnsOGhJHgmF3YpzYrPbsxJJ
         OfTgGKCk40E5qD6Xpl8v6cAhoXUV+w0NVza8lMHkXbRe0yVGTkUeY3t7iZ+nCdoP4UZC
         9Va5dPb+guxc0hOFR6WSARBNNiCO2wvgkflUdqdnyfHQDMyIjQmF+3fbM1hB+EGHRUZW
         vJxVIIcuQ55UstIf/5pFgs41gnsRTIBg7xHaYNw0F8ZBb9rUM15nM1+3m7a33/V+SUb7
         8F/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQWK4AAERewEAzFMwM5E2a5BfjjyKr20UPCH5VGwzfa8M+Hov28kf6FvElp4SZZpjtOCyotI4Rj8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMN+fmKwf465Bc8I5u4sk7dzvRHAvMDdsCVsj+CetWc+ipVVc/
	DWOqiWVwXL1kgpArlPIkRuEarcDStNUNMRWShadPicWsrqJbN3AZoaUywmHNZIMwYbLbdjV12eS
	3BUb90r2KUe/kyLVLnMlyFKxCt2BQ6ncWNmwyxbEOkM4qM8ihIpYV/DrAfm0ddms=
X-Gm-Gg: AR+sD11/o9Qy7aOgkpwkeb7rup9tZIiNCLZoJwyOD+c0DXjGV5ortun3ylfwiNl7PzV
	EYVNRNznxYBNB/gYpWc36KXU5onCuOTgHS5TSQDXZe/CPY05oYhqgqk27ZZOQ9AJbyDqJ09RqoN
	6T5xXk9bdsoH33SWhdEGabozG8U+xBCO9vYc7QiP4x5KkycOECjC/Y3Im0Amy0AH1s8iv8yn4Iy
	kzJZj7mjWGtSgwmEH7aTsH/T50ejMlm25Qsn/VyoAdKJg4jOw1axOsPtJ4iJ4pK7S76f2pQ7SRO
	/4dZdRrqoy26TEsOUS3Dg1lP7v7C49S2qOnRYl/irfUCsTguNnC2Or44sMpjm88riyDVCP6ips1
	w/rmmYbuU9UpaU4eXACsReVIBen6Xig==
X-Received: by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3cb85ef91f7mr22475891637.20.1786049836743;
        Thu, 06 Aug 2026 13:57:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3cb85ef91f7mr22475844637.20.1786049836235;
        Thu, 06 Aug 2026 13:57:16 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bc667f1csm116641eec.12.2026.08.06.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:57:15 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 02:26:31 +0530
Subject: [PATCH 2/2] rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver and
 extend pmic_glink
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-rtc-glink-cleanup-v1-2-7801e4d69c4f@oss.qualcomm.com>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
In-Reply-To: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Raj Aryan <raryan@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786049822; l=27044;
 i=kamal.wadhwa@oss.qualcomm.com; s=20260406; h=from:subject:message-id;
 bh=x+MRZH90hm65VMG3ngwkdI5VIRnbua7WatjVs6iBRyA=;
 b=b26gKlvoKWedxgtbnzFyDLsh8w6B6PLbRXDTIk++NukeEvlVhsfKVVlTglRiBQbYyeUuK6l2y
 2fUC9bRLUeKAPkVGz26vAVfhFFTeSJmn5wR3wrxjKz/by5JYOcTr0ZE
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=ylH1NxUZkBpYsmww89g6zVxpS0q8qthtzcORkYxn/Ag=
X-Proofpoint-GUID: _0g0JmTqcVFEl28GilZlyZpUlGgY48dK
X-Proofpoint-ORIG-GUID: _0g0JmTqcVFEl28GilZlyZpUlGgY48dK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfXzKRVXMuNOPVe
 wzpHHfIofqnT7C//MQmy1oRkSoFcCI5Fpi8gauqrFFuvkPqcwwk1XRkIHYMSXEuqNphq04EnrW2
 qOwNQea2iMtGcYFF2WmoQWVAuWGvprM0cK+GmKUjwQfpyYcahxwVR9AVBeTtVd4T6UiRCNtxQ6Q
 sOXhffdfJzz+M3WE5AshU/u8VTGxosLBVUjDjCBTBKk8FDgAeFrlIe8o0WgI7AEbO1e8VDqGn73
 MEoU+G7y2wEzMmre/bqf2fZ/bOlu5zkXkn1EKjiuNx3SEDASr8Hb+p3Sx4crPGFmDStUmYDQFNS
 Mwf8VN6JYywa/Z1gq0e2U+n70pauH7odIssnkZu1BHU/O9vJc+6zCQE/8xQl56HUQG9/CzdDdjI
 A0hAe2kHS1tQgXrsBYjFIz+OOSfTEnQxTAh7Ar2c99XNT/jkJaVAaaiZ7Wvx6Egx4egGRfuR6zY
 6HChhxIF5jSjuaql1Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX7o8fKa/SVoLd
 HAOAAh00rIJlDyqrzzn2pgsRYgkYtgmeztZrZ0T8wnWFk4YsZTlSzCh7O6m13thxPGtnoCJ3r3G
 HnePJkFaZaIl8/RTqIv58RzZjPV2yxU=
X-Authority-Analysis: v=2.4 cv=bot8wkai c=1 sm=1 tr=0 ts=6a74f53d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=aiWOJFc-Rkiic33xYCEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060163

Add a new RTC driver that communicates with the PMIC firmware over
the GLINK transport layer. The driver supports reading time and
alarm functionality via GET_PROPERTY and SET_PROPERTY opcodes.

Time is read via GET_PROPERTY (opcode 0x62) using QCOM_RTC_GLINK_TIME
property (0x00). Alarm set and enable are handled via SET_PROPERTY
(opcode 0x63) using QCOM_RTC_GLINK_ALARM and QCOM_RTC_GLINK_ALARM_ENABLE
properties respectively.

GET_PROPERTY and SET_PROPERTY responses share the same firmware message
layout, with the firmware echoing back the property value. Both opcodes
are handled by a common callback path accordingly.

Also extend pmic_glink to register the RTC as a PMIC GLINK client and
add PMIC GLINK RTC client support for glymur.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 MAINTAINERS                         |   7 +
 drivers/rtc/Kconfig                 |  10 +
 drivers/rtc/Makefile                |   1 +
 drivers/rtc/rtc-qcom-glink.c        | 690 ++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/pmic_glink.c       |  22 +-
 include/linux/soc/qcom/pmic_glink.h |   1 +
 6 files changed, 730 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f178a5ff026..752cf667b8ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22505,6 +22505,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 F:	drivers/power/supply/qcom_smbx.c
 
+QUALCOMM PMIC GLINK RTC DRIVER
+M:	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
+L:	linux-rtc@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/rtc/rtc-qcom-glink.c
+
 QUALCOMM PPE DRIVER
 M:	Luo Jie <jie.luo@oss.qualcomm.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..3ac39704b2e1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1836,6 +1836,16 @@ config RTC_DRV_PM8XXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-pm8xxx.
 
+config RTC_DRV_QCOM_GLINK
+	tristate "Qualcomm PMIC GLINK RTC"
+	depends on QCOM_PMIC_GLINK
+	help
+	  Say Y here to enable support for the RTC exposed by the PMIC
+	  over the GLINK transport on Qualcomm platforms.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-qcom-glink.
+
 config RTC_DRV_TEGRA
 	tristate "NVIDIA Tegra Internal RTC driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0347645b021f..8215a1fc29fb 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
 obj-$(CONFIG_RTC_DRV_FSL_FTM_ALARM)	+= rtc-fsl-ftm-alarm.o
 obj-$(CONFIG_RTC_DRV_FTRTC010)	+= rtc-ftrtc010.o
 obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
+obj-$(CONFIG_RTC_DRV_QCOM_GLINK) += rtc-qcom-glink.o
 obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
 obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
diff --git a/drivers/rtc/rtc-qcom-glink.c b/drivers/rtc/rtc-qcom-glink.c
new file mode 100644
index 000000000000..611f06a3cc5c
--- /dev/null
+++ b/drivers/rtc/rtc-qcom-glink.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/soc/qcom/pmic_glink.h>
+#include <linux/timekeeping.h>
+#include <linux/workqueue.h>
+
+#define RTC_GLINK_SET_PROPERTY		0x63
+#define RTC_GLINK_GET_PROPERTY		0x65
+#define RTC_GLINK_GET_RTC_TICKS		0x67
+#define RTC_GLINK_GET_REAL_TIME		0x68
+#define RTC_GLINK_SET_REAL_TIME		0x69
+#define RTC_GLINK_ALARM_EXPIRED		0x6A
+
+enum qcom_rtc_glink_properties {
+	QCOM_RTC_GLINK_TIME = 0,
+	QCOM_RTC_GLINK_ALARM_TIME,
+	QCOM_RTC_GLINK_ALARM_ENABLE,
+};
+
+struct qcom_rtc_glink_msg {
+	struct pmic_glink_hdr	hdr;
+	__le32			property;
+	__le32			value;
+};
+
+struct qcom_rtc_glink_generic_req {
+	struct pmic_glink_hdr	hdr;
+};
+
+struct qcom_rtc_glink_status_resp {
+	struct pmic_glink_hdr	hdr;
+	__le32			return_status;
+};
+
+struct qcom_rtc_glink_ticks_resp {
+	struct pmic_glink_hdr	hdr;
+	__le32			return_status;
+	__le32			rtc_ticks;
+};
+
+struct qcom_rtc_glink_real_time_resp {
+	struct pmic_glink_hdr	hdr;
+	__le32			return_status;
+	__le32			real_time_data[4];
+};
+
+struct qcom_rtc_glink_set_real_time_req {
+	struct pmic_glink_hdr	hdr;
+	__le32			real_time_data[4];
+};
+
+struct qcom_rtc_glink {
+	struct device		*dev;
+	struct pmic_glink_client *client;
+	struct rtc_device	*rtc;
+
+	/* Serializes requests: only one may be in flight at a time */
+	struct mutex		lock;
+	struct completion	ack;
+	struct work_struct	alarm_work;
+
+	/* Protects service_up and request_pending across callback contexts */
+	spinlock_t		state_lock;
+	bool			service_up;
+	bool			request_pending;
+
+	int			error;
+	u32			resp_value;
+	u32			offset;
+	struct rtc_time		resp_tm;
+	bool			resp_valid;
+	bool			allow_set_time;
+};
+
+static int qcom_rtc_glink_request(struct qcom_rtc_glink *rtc_glink,
+				  void *data, size_t len)
+{
+	unsigned long flags;
+	unsigned long left;
+	int ret;
+
+	/*
+	 * Reinit the completion before request_pending becomes visible to
+	 * qcom_rtc_glink_pdr_tify(), so a concurrent SSR down-transition
+	 * can't complete() a stale completion that gets wiped out by
+	 * reinit_completion() right after.
+	 */
+	reinit_completion(&rtc_glink->ack);
+	rtc_glink->error = 0;
+	rtc_glink->resp_valid = false;
+
+	spin_lock_irqsave(&rtc_glink->state_lock, flags);
+	if (!rtc_glink->service_up) {
+		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+		return -ECONNRESET;
+	}
+	rtc_glink->request_pending = true;
+	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+
+	ret = pmic_glink_send(rtc_glink->client, data, len);
+	if (ret < 0) {
+		spin_lock_irqsave(&rtc_glink->state_lock, flags);
+		rtc_glink->request_pending = false;
+		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+		return ret;
+	}
+
+	left = wait_for_completion_timeout(&rtc_glink->ack, HZ);
+	spin_lock_irqsave(&rtc_glink->state_lock, flags);
+	rtc_glink->request_pending = false;
+	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+	if (!left)
+		return -ETIMEDOUT;
+
+	return rtc_glink->error;
+}
+
+static int qcom_rtc_glink_set_property(struct qcom_rtc_glink *rtc_glink,
+				       u32 property, u32 value)
+{
+	struct qcom_rtc_glink_msg msg = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(RTC_GLINK_SET_PROPERTY),
+		.property = cpu_to_le32(property),
+		.value = cpu_to_le32(value),
+	};
+	int ret;
+
+	dev_dbg(rtc_glink->dev,
+		"TX opcode=0x%x property=%u value=%u\n",
+		RTC_GLINK_SET_PROPERTY, property, value);
+	mutex_lock(&rtc_glink->lock);
+	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
+	mutex_unlock(&rtc_glink->lock);
+	return ret;
+}
+
+static int qcom_rtc_glink_get_property(struct qcom_rtc_glink *rtc_glink,
+				       u32 property, u32 *value)
+{
+	struct qcom_rtc_glink_msg msg = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_PROPERTY),
+		.property = cpu_to_le32(property),
+	};
+	int ret;
+
+	dev_dbg(rtc_glink->dev,
+		"TX opcode=0x%x property=%u\n",
+		RTC_GLINK_GET_PROPERTY, property);
+	mutex_lock(&rtc_glink->lock);
+	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
+	if (!ret) {
+		if (!rtc_glink->resp_valid)
+			ret = -EIO;
+		else
+			*value = rtc_glink->resp_value;
+	}
+	mutex_unlock(&rtc_glink->lock);
+	return ret;
+}
+
+static int qcom_rtc_glink_get_ticks(struct qcom_rtc_glink *rtc_glink,
+				    u32 *ticks)
+{
+	struct qcom_rtc_glink_generic_req msg = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_RTC_TICKS),
+	};
+	int ret;
+
+	dev_dbg(rtc_glink->dev, "TX opcode=0x%x\n", RTC_GLINK_GET_RTC_TICKS);
+	mutex_lock(&rtc_glink->lock);
+	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
+	if (!ret) {
+		if (!rtc_glink->resp_valid)
+			ret = -EIO;
+		else
+			*ticks = rtc_glink->resp_value;
+	}
+	mutex_unlock(&rtc_glink->lock);
+	return ret;
+}
+
+static int qcom_rtc_glink_get_real_time(struct qcom_rtc_glink *rtc_glink,
+					struct rtc_time *tm)
+{
+	struct qcom_rtc_glink_generic_req msg = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_REAL_TIME),
+	};
+	int ret;
+
+	dev_dbg(rtc_glink->dev, "TX opcode=0x%x\n", RTC_GLINK_GET_REAL_TIME);
+	mutex_lock(&rtc_glink->lock);
+	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
+	if (!ret) {
+		if (!rtc_glink->resp_valid)
+			ret = -EIO;
+		else
+			*tm = rtc_glink->resp_tm;
+	}
+	mutex_unlock(&rtc_glink->lock);
+	return ret;
+}
+
+static int qcom_rtc_glink_set_real_time(struct qcom_rtc_glink *rtc_glink,
+					struct rtc_time *tm)
+{
+	struct qcom_rtc_glink_set_real_time_req msg = {};
+	u32 w0, w1;
+	int ret;
+
+	w0 = ((tm->tm_year + 1900) & 0xffff) |
+	     (((tm->tm_mon + 1) & 0xff) << 16) |
+	     ((tm->tm_mday & 0xff) << 24);
+	w1 = (tm->tm_hour & 0xff) |
+	     ((tm->tm_min & 0xff) << 8) |
+	     ((tm->tm_sec & 0xff) << 16) |
+	     (1U << 24);
+	msg.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC);
+	msg.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
+	msg.hdr.opcode = cpu_to_le32(RTC_GLINK_SET_REAL_TIME);
+	msg.real_time_data[0] = cpu_to_le32(w0);
+	msg.real_time_data[1] = cpu_to_le32(w1);
+	msg.real_time_data[2] = 0;
+	msg.real_time_data[3] = 0;
+	dev_dbg(rtc_glink->dev,
+		"TX opcode=0x%x data=%08x %08x\n",
+		RTC_GLINK_SET_REAL_TIME, w0, w1);
+	mutex_lock(&rtc_glink->lock);
+	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
+	mutex_unlock(&rtc_glink->lock);
+	return ret;
+}
+
+static int qcom_rtc_glink_get_time(struct qcom_rtc_glink *rtc_glink,
+				   struct rtc_time *time)
+{
+	u32 ticks;
+	int ret;
+
+	ret = qcom_rtc_glink_get_real_time(rtc_glink, time);
+	if (!ret)
+		return 0;
+	dev_warn(rtc_glink->dev, "0x68 failed (%d), falling back\n", ret);
+
+	ret = qcom_rtc_glink_get_ticks(rtc_glink, &ticks);
+	if (!ret) {
+		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);
+		return 0;
+	}
+
+	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
+					  &ticks);
+	if (!ret && ticks != U32_MAX) {
+		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);
+		return 0;
+	}
+
+	dev_err(rtc_glink->dev, "all time sources failed\n");
+	return -EIO;
+}
+
+static int qcom_rtc_glink_set_time(struct qcom_rtc_glink *rtc_glink,
+				   struct rtc_time *time)
+{
+	time64_t t = rtc_tm_to_time64(time);
+	u32 ticks;
+	int ret;
+
+	if (!rtc_glink->allow_set_time)
+		return -EOPNOTSUPP;
+
+	ret = qcom_rtc_glink_set_real_time(rtc_glink, time);
+	if (ret)
+		dev_warn(rtc_glink->dev, "0x69 failed (%d)\n", ret);
+
+	ret = qcom_rtc_glink_set_property(rtc_glink, QCOM_RTC_GLINK_TIME, (u32)t);
+	if (ret)
+		return ret;
+
+	ret = qcom_rtc_glink_get_ticks(rtc_glink, &ticks);
+	if (!ret && ticks != U32_MAX) {
+		rtc_glink->offset = (u32)t - ticks;
+	} else {
+		dev_warn(rtc_glink->dev, "no tick source for offset\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int qcom_rtc_glink_set_alarm_en(struct qcom_rtc_glink *rtc_glink,
+				       int enabled)
+{
+	return qcom_rtc_glink_set_property(rtc_glink,
+					   QCOM_RTC_GLINK_ALARM_ENABLE,
+					   enabled);
+}
+
+static int qcom_rtc_glink_set_alarm(struct qcom_rtc_glink *rtc_glink,
+				    struct rtc_wkalrm *alarm)
+{
+	time64_t alarm_t = rtc_tm_to_time64(&alarm->time);
+	struct rtc_time now_tm;
+	time64_t now_real, secs_until_alarm;
+	u32 fw_current, fw_alarm;
+	int ret;
+
+	ret = qcom_rtc_glink_get_time(rtc_glink, &now_tm);
+	if (ret)
+		return ret;
+	now_real = rtc_tm_to_time64(&now_tm);
+	secs_until_alarm = alarm_t - now_real;
+	dev_dbg(rtc_glink->dev,
+		"set_alarm: now_real=%lld alarm_t=%lld delta=%lld\n",
+		now_real, alarm_t, secs_until_alarm);
+	if (secs_until_alarm < 0)
+		return -EINVAL;
+	if (secs_until_alarm > U32_MAX)
+		return -ERANGE;
+
+	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
+					  &fw_current);
+	if (ret)
+		return ret;
+	if (fw_current == U32_MAX)
+		fw_current = 0;
+	fw_alarm = fw_current + (u32)secs_until_alarm;
+	dev_dbg(rtc_glink->dev,
+		"set_alarm: fw_current=%u fw_alarm=%u\n",
+		fw_current, fw_alarm);
+
+	ret = qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
+	if (ret)
+		return ret;
+
+	ret = qcom_rtc_glink_set_property(rtc_glink,
+					  QCOM_RTC_GLINK_ALARM_TIME, fw_alarm);
+	if (ret)
+		return ret;
+
+	return qcom_rtc_glink_set_alarm_en(rtc_glink, alarm->enabled);
+}
+
+static int qcom_rtc_glink_get_alarm(struct qcom_rtc_glink *rtc_glink,
+				    struct rtc_wkalrm *alarm)
+{
+	u32 fw_alarm_time, fw_current, alarm_en;
+	struct rtc_time now_tm;
+	time64_t now_real, secs_until_alarm, alarm_real;
+	int ret;
+
+	ret = qcom_rtc_glink_get_property(rtc_glink,
+					  QCOM_RTC_GLINK_ALARM_TIME,
+					  &fw_alarm_time);
+	if (ret)
+		return ret;
+
+	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
+					  &fw_current);
+	if (ret)
+		return ret;
+
+	ret = qcom_rtc_glink_get_property(rtc_glink,
+					  QCOM_RTC_GLINK_ALARM_ENABLE,
+					  &alarm_en);
+	if (ret)
+		return ret;
+	if (fw_current == U32_MAX)
+		fw_current = 0;
+
+	ret = qcom_rtc_glink_get_time(rtc_glink, &now_tm);
+	if (ret)
+		return ret;
+	now_real = rtc_tm_to_time64(&now_tm);
+	secs_until_alarm = (time64_t)fw_alarm_time - (time64_t)fw_current;
+	alarm_real = now_real + secs_until_alarm;
+	dev_dbg(rtc_glink->dev,
+		"get_alarm: now_real=%lld fw_current=%u fw_alarm=%u delta=%lld\n",
+		now_real, fw_current, fw_alarm_time, secs_until_alarm);
+	rtc_time64_to_tm(alarm_real, &alarm->time);
+	alarm->enabled = !!alarm_en;
+	return 0;
+}
+
+static void qcom_rtc_glink_alarm_work(struct work_struct *work)
+{
+	struct qcom_rtc_glink *rtc_glink =
+		container_of(work, struct qcom_rtc_glink, alarm_work);
+	int ret;
+
+	ret = qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
+	if (ret)
+		dev_err(rtc_glink->dev,
+			"failed to disable alarm after expiry (%d)\n", ret);
+	rtc_update_irq(rtc_glink->rtc, 1, RTC_IRQF | RTC_AF);
+}
+
+static void qcom_rtc_glink_callback(const void *data, size_t len, void *priv)
+{
+	struct qcom_rtc_glink *rtc_glink = priv;
+	const struct pmic_glink_hdr *hdr = data;
+	unsigned long flags;
+	bool pending;
+
+	if (len < sizeof(*hdr))
+		return;
+
+	dev_dbg(rtc_glink->dev,
+		"RX opcode=0x%x type=0x%x owner=0x%x len=%zu\n",
+		le32_to_cpu(hdr->opcode), le32_to_cpu(hdr->type),
+		le32_to_cpu(hdr->owner), len);
+
+	if (le32_to_cpu(hdr->opcode) == RTC_GLINK_ALARM_EXPIRED) {
+		dev_info(rtc_glink->dev, "alarm expired\n");
+		schedule_work(&rtc_glink->alarm_work);
+		return;
+	}
+
+	/*
+	 * Hold state_lock across the pending check and the response fields
+	 * below: qcom_rtc_glink_pdr_notify() writes the same error/resp_*
+	 * fields under this lock when it force-completes a request on an
+	 * SSR down-transition, and the two must not race. Dropping the
+	 * response here if !pending also covers requests that already
+	 * timed out or were aborted; qcom_rtc_glink_request() will call
+	 * reinit_completion() again before this response could be mistaken
+	 * for a later request's.
+	 */
+	spin_lock_irqsave(&rtc_glink->state_lock, flags);
+	pending = rtc_glink->request_pending;
+
+	if (!pending) {
+		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+		dev_dbg(rtc_glink->dev,
+			"dropping stale response opcode=0x%x\n",
+			le32_to_cpu(hdr->opcode));
+		return;
+	}
+
+	switch (le32_to_cpu(hdr->opcode)) {
+	case RTC_GLINK_GET_PROPERTY:
+		fallthrough;
+	case RTC_GLINK_SET_PROPERTY: {
+		const struct qcom_rtc_glink_msg *msg = data;
+
+		if (len < sizeof(struct pmic_glink_hdr) + sizeof(__le32)) {
+			rtc_glink->error = -EINVAL;
+			break;
+		}
+		rtc_glink->resp_value = le32_to_cpu(msg->property);
+		rtc_glink->resp_valid = true;
+		rtc_glink->error = 0;
+		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x resp_value=%u\n",
+			le32_to_cpu(hdr->opcode), rtc_glink->resp_value);
+		break;
+	}
+
+	case RTC_GLINK_GET_RTC_TICKS: {
+		const struct qcom_rtc_glink_ticks_resp *resp = data;
+
+		if (len < sizeof(*resp)) {
+			rtc_glink->error = -EINVAL;
+			break;
+		}
+		if (le32_to_cpu(resp->return_status)) {
+			rtc_glink->error = -EIO;
+			break;
+		}
+		rtc_glink->resp_value = le32_to_cpu(resp->rtc_ticks);
+		rtc_glink->resp_valid = true;
+		rtc_glink->error = 0;
+		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x ticks=%u\n",
+			RTC_GLINK_GET_RTC_TICKS, rtc_glink->resp_value);
+		break;
+	}
+
+	case RTC_GLINK_GET_REAL_TIME: {
+		const struct qcom_rtc_glink_real_time_resp *resp = data;
+		u32 w0, w1;
+
+		if (len < sizeof(*resp)) {
+			rtc_glink->error = -EINVAL;
+			break;
+		}
+		if (le32_to_cpu(resp->return_status)) {
+			rtc_glink->error = -EIO;
+			break;
+		}
+		w0 = le32_to_cpu(resp->real_time_data[0]);
+		w1 = le32_to_cpu(resp->real_time_data[1]);
+		rtc_glink->resp_tm.tm_year = (w0 & 0xffff) - 1900;
+		rtc_glink->resp_tm.tm_mon = ((w0 >> 16) & 0xff) - 1;
+		rtc_glink->resp_tm.tm_mday = (w0 >> 24) & 0xff;
+		rtc_glink->resp_tm.tm_hour = w1 & 0xff;
+		rtc_glink->resp_tm.tm_min = (w1 >> 8) & 0xff;
+		rtc_glink->resp_tm.tm_sec = (w1 >> 16) & 0xff;
+		rtc_glink->resp_valid = true;
+		rtc_glink->error = 0;
+		dev_dbg(rtc_glink->dev,
+			"ACK opcode=0x%x %04d-%02d-%02d %02d:%02d:%02d\n",
+			RTC_GLINK_GET_REAL_TIME,
+			rtc_glink->resp_tm.tm_year + 1900,
+			rtc_glink->resp_tm.tm_mon + 1,
+			rtc_glink->resp_tm.tm_mday,
+			rtc_glink->resp_tm.tm_hour,
+			rtc_glink->resp_tm.tm_min,
+			rtc_glink->resp_tm.tm_sec);
+		break;
+	}
+
+	case RTC_GLINK_SET_REAL_TIME: {
+		const struct qcom_rtc_glink_status_resp *resp = data;
+
+		if (len < sizeof(*resp)) {
+			rtc_glink->error = -EINVAL;
+			break;
+		}
+		rtc_glink->error = le32_to_cpu(resp->return_status) ? -EIO : 0;
+		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x status=%u\n",
+			RTC_GLINK_SET_REAL_TIME,
+			le32_to_cpu(resp->return_status));
+		break;
+	}
+
+	default:
+		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+		dev_warn(rtc_glink->dev,
+			 "unhandled RX opcode=0x%x len=%zu\n",
+			 le32_to_cpu(hdr->opcode), len);
+		return;
+	}
+
+	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+	complete(&rtc_glink->ack);
+}
+
+static void qcom_rtc_glink_pdr_notify(void *priv, int state)
+{
+	struct qcom_rtc_glink *rtc_glink = priv;
+	unsigned long flags;
+	bool up = (state == SERVREG_SERVICE_STATE_UP);
+
+	spin_lock_irqsave(&rtc_glink->state_lock, flags);
+	rtc_glink->service_up = up;
+	if (!up && rtc_glink->request_pending) {
+		rtc_glink->error = -ECONNRESET;
+		rtc_glink->resp_valid = false;
+		complete(&rtc_glink->ack);
+	}
+	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
+}
+
+static int qcom_rtc_glink_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return qcom_rtc_glink_get_time(dev_get_drvdata(dev), tm);
+}
+
+static int qcom_rtc_glink_set_time_dev(struct device *dev, struct rtc_time *tm)
+{
+	return qcom_rtc_glink_set_time(dev_get_drvdata(dev), tm);
+}
+
+static int qcom_rtc_glink_read_alarm(struct device *dev,
+				     struct rtc_wkalrm *alrm)
+{
+	return qcom_rtc_glink_get_alarm(dev_get_drvdata(dev), alrm);
+}
+
+static int qcom_rtc_glink_set_alarm_dev(struct device *dev,
+					struct rtc_wkalrm *alrm)
+{
+	return qcom_rtc_glink_set_alarm(dev_get_drvdata(dev), alrm);
+}
+
+static int qcom_rtc_glink_alarm_irq_enable(struct device *dev,
+					   unsigned int enabled)
+{
+	return qcom_rtc_glink_set_alarm_en(dev_get_drvdata(dev), enabled);
+}
+
+static const struct rtc_class_ops qcom_rtc_glink_rtc_ops = {
+	.read_time = qcom_rtc_glink_read_time,
+	.set_time = qcom_rtc_glink_set_time_dev,
+	.read_alarm = qcom_rtc_glink_read_alarm,
+	.set_alarm = qcom_rtc_glink_set_alarm_dev,
+	.alarm_irq_enable = qcom_rtc_glink_alarm_irq_enable,
+};
+
+static const struct of_device_id qcom_rtc_glink_of_variants[] = {
+	{ .compatible = "qcom,glymur-pmic-glink" },
+	{}
+};
+
+static int qcom_rtc_glink_probe(struct auxiliary_device *adev,
+				const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct qcom_rtc_glink *rtc_glink;
+
+	if (!of_match_device(qcom_rtc_glink_of_variants, dev->parent))
+		return -ENXIO;
+
+	rtc_glink = devm_kzalloc(dev, sizeof(*rtc_glink), GFP_KERNEL);
+	if (!rtc_glink)
+		return -ENOMEM;
+
+	rtc_glink->dev            = dev;
+	rtc_glink->allow_set_time = device_property_read_bool(dev->parent,
+							      "allow-set-time");
+
+	mutex_init(&rtc_glink->lock);
+	spin_lock_init(&rtc_glink->state_lock);
+	init_completion(&rtc_glink->ack);
+	INIT_WORK(&rtc_glink->alarm_work, qcom_rtc_glink_alarm_work);
+	dev_set_drvdata(dev, rtc_glink);
+
+	rtc_glink->client = devm_pmic_glink_client_alloc(dev,
+							 PMIC_GLINK_OWNER_RTC,
+							 qcom_rtc_glink_callback,
+							 qcom_rtc_glink_pdr_notify,
+							 rtc_glink);
+	if (IS_ERR(rtc_glink->client))
+		return dev_err_probe(dev, PTR_ERR(rtc_glink->client),
+				     "failed to allocate glink client\n");
+
+	pmic_glink_client_register(rtc_glink->client);
+
+	device_init_wakeup(dev, true);
+
+	rtc_glink->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc_glink->rtc))
+		return dev_err_probe(dev, PTR_ERR(rtc_glink->rtc),
+				     "failed to allocate RTC device\n");
+
+	rtc_glink->rtc->ops      = &qcom_rtc_glink_rtc_ops;
+	rtc_glink->rtc->range_min = 0;
+	rtc_glink->rtc->range_max = U32_MAX;
+
+	return devm_rtc_register_device(rtc_glink->rtc);
+}
+
+static void qcom_rtc_glink_remove(struct auxiliary_device *adev)
+{
+	struct qcom_rtc_glink *rtc_glink = dev_get_drvdata(&adev->dev);
+	/*
+	 * Nothing left to arm alarm_work after this returns: the glink
+	 * client (and its callback/pdr_notify) is torn down by devm after
+	 * .remove() returns, and rtc_update_irq() below still targets a
+	 * live devm-managed rtc device.
+	 */
+	cancel_work_sync(&rtc_glink->alarm_work);
+}
+
+static const struct auxiliary_device_id qcom_rtc_glink_id_table[] = {
+	{ .name = "pmic_glink.rtc-glink" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(auxiliary, qcom_rtc_glink_id_table);
+
+static struct auxiliary_driver qcom_rtc_glink_driver = {
+	.name = "qcom_pmic_rtc_glink",
+	.id_table = qcom_rtc_glink_id_table,
+	.probe = qcom_rtc_glink_probe,
+	.remove = qcom_rtc_glink_remove,
+};
+
+module_auxiliary_driver(qcom_rtc_glink_driver);
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK RTC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 3042261578aa..7ee70a31ba15 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -21,6 +21,7 @@ enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
 	PMIC_GLINK_CLIENT_ALTMODE,
 	PMIC_GLINK_CLIENT_UCSI,
+	PMIC_GLINK_CLIENT_RTC,
 };
 
 struct pmic_glink_data {
@@ -40,6 +41,7 @@ struct pmic_glink {
 	struct auxiliary_device altmode_aux;
 	struct auxiliary_device ps_aux;
 	struct auxiliary_device ucsi_aux;
+	struct auxiliary_device rtc_aux;
 
 	/* serializing client_state and pdr_state updates */
 	struct mutex state_lock;
@@ -341,6 +343,12 @@ static int pmic_glink_probe(struct platform_device *pdev)
 			goto out_release_altmode_aux;
 	}
 
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC)) {
+		ret = pmic_glink_add_aux_device(pg, &pg->rtc_aux, "rtc-glink");
+		if (ret)
+			goto out_release_ps_aux;
+	}
+
 	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
 		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
 					 pg->data->charger_pdr_service_path);
@@ -358,6 +366,9 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_aux_devices:
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC))
+		pmic_glink_del_aux_device(pg, &pg->rtc_aux);
+out_release_ps_aux:
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
 out_release_altmode_aux:
@@ -384,11 +395,20 @@ static void pmic_glink_remove(struct platform_device *pdev)
 		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC))
+		pmic_glink_del_aux_device(pg, &pg->rtc_aux);
 
 	guard(mutex)(&__pmic_glink_lock);
 	__pmic_glink = NULL;
 }
 
+static const struct pmic_glink_data pmic_glink_glymur_data = {
+	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+		       BIT(PMIC_GLINK_CLIENT_UCSI) |
+		       BIT(PMIC_GLINK_CLIENT_RTC),
+};
+
 static const struct pmic_glink_data pmic_glink_adsp_data = {
 	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
 		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
@@ -404,7 +424,7 @@ static const struct pmic_glink_data pmic_glink_soccp_data = {
 };
 
 static const struct of_device_id pmic_glink_of_match[] = {
-	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_soccp_data },
+	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_glymur_data },
 	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_soccp_data },
 	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
 	{}
diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
index 7cddf1027752..11031b06b810 100644
--- a/include/linux/soc/qcom/pmic_glink.h
+++ b/include/linux/soc/qcom/pmic_glink.h
@@ -11,6 +11,7 @@ struct pmic_glink_client;
 #define PMIC_GLINK_OWNER_BATTMGR	32778
 #define PMIC_GLINK_OWNER_USBC		32779
 #define PMIC_GLINK_OWNER_USBC_PAN	32780
+#define PMIC_GLINK_OWNER_RTC		32784
 
 #define PMIC_GLINK_REQ_RESP		1
 #define PMIC_GLINK_NOTIFY		2

-- 
2.43.0

