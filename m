Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071357;
	b=wrPZvwF2muKD0nyj/fSw0j1I/yt4IDZWNv96KCvxvIy1khb8KGI9i/UrOYLL9SxL2fxU
	 /4tF/PChX3kCtCsyzMkgIo426v5zQuXUs5Uq5FFwobVzUG5NOQtNs4ZSCYjDgbFJzQ2Ak
	 z+KfOJ2twj9pnUfS+fhUJb5Bzx5RT8KT9xJk/qNyIj3wP8XR8QDzNQlrdKSZrPVwADJl5
	 CcMlAuMOydOiXLcIzLf0zscmCmk/TURvNgHfdDM4Zf6B//yuecPLQ3eydLrYcZsjREgzx
	 L6OjSiYG7u7B5eeFq2/13paClRpJXduVXM/oEQdOV8LkOrsvcLIPKHYreLTjQN/8ObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nIhm6c5LlEzFS6EsTuNhvLH7k1N5BAu48dQqmpioTP4=;
	b=xuMeqhMNZ0BRjiGcPPsfzNjQmYChE9BxLWzA8HTo3xxSzqxc6r3bYRE2bWCHkeM8/z4Q
	 qmByAFxkhfqQ2eKF/06JSqeKLrD62jatVfUr84zWRELo8g5WTbpH2/yVaj4QaEBQuagy2
	 Mkm5E8VGPWLrlWON+/sokOZR+R+S++V/oZSHe0n1oxtZmE8m2mvwmHbM9lh+NrCcuSUyl
	 V7SiOqmFldtpu7el43IUom6wPMNZ273EIQZ3nOJNCzbkclp/5FGC+y4VfgkXyysQhzTqB
	 etsTKMq7CSA4DI4xYMmpeESGQozJNyXGfjhdUYtPgAlv9sV2SQS+RLgQTklfBH2pAvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTvM2YjZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GlcemQlx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CA60A2600
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 06:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 571CA60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTvM2YjZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GlcemQlx
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ1B8Tv3490671
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 06:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nIhm6c5LlEzFS6EsTuNhvLH7k1N5BAu48dQqmpioTP4=; b=XTvM2YjZXOSqRkPQ
	MyvPadYdG8wPzQwPiMockJfHVPpUvYue2kBXArIvDSLRICbk7Mog3EXyQOmmKEfy
	lN8kBgPyLSptoHYwBkfIkHsWuizBfduQdmWiflozfDVkXUV9Phx7UBz8CJDgijJ3
	L0aPyEH44NMo6Bax79NpshwS0KfQ11gR2sq4OqiENWipJ1fcSI8JVi1v2Q/8Pafr
	VlqhEUrOVSNE6m/BtVwikpfUSyp946o+P//gOPtD9mO8lEVixZijYPp3wFekZWsD
	fOM5OwrMplHFfuAcZBbQA204jcCOhzt9qUcDn/nCIUoUwmLTjWRv6z+Ew19nJhVI
	t+oyeQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3bb3e8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 06:55:54 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-86156035839so2253147a34.1
        for <linux-rtc@vger.kernel.org>; Wed, 18 Nov 2026 22:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795071354; x=1795676154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIhm6c5LlEzFS6EsTuNhvLH7k1N5BAu48dQqmpioTP4=;
        b=GlcemQlxvjDaevfeIpaZ/hdiBYGi7W/HYXJkhun2Ao6oRbmSMBYSFfyZ6Cglrb8goT
         Cm3gzc10hhXns21gdWPdQzItBuJvngZxSUdXZG+T5/wzIpNWUd1kVLiET3s+F4Fq7ppN
         xF62SPK/SYXOuqL8rhcSQvKY4us8r2e9lgCuwUGLY2LIstG5LQ6hxXfMhkz+3LFIUsf5
         aquPvhXiQVEOfciCTz6slC9eo459l+wJXNNY8YRM8v+WI3OXrLa7EXbLG9rHMKQiGiPz
         WqcQ0Jc4uJ75kr2W/z57IXCDkf1EndHkXSZViXauR/aNcTK06/fCuJXOPj/LUOd9RPJ9
         9ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071354; x=1795676154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIhm6c5LlEzFS6EsTuNhvLH7k1N5BAu48dQqmpioTP4=;
        b=c4WTdDKINIcLemrhh7rKGQSDd6cMZm7rNUVCWenpR99QfZXdUpQyIqgWWTNY1le96g
         GZsodTFpZvrxOFInUPeZaF8s1EbCRu99HmJk1TmWihgnsAU/lWMoOCxjSk6auUqcZ3NR
         6gFlh2Od2zfYBF9ft5b/9S0rH4jNDhytAkV7xax83C3nf8x3jzIu6seDUodJnlS97e/k
         FCEyPAK6acFL64Tz+9JZ2tzT+PznSjYa2t5kS87nbex5n4ZvgNtPF58vhPchvUfXTlL3
         uwGmshTg+U9DXK45uR0DIs+orsDDvpAiZ2Qq93RsQWng+hYz0wC3dlwDLmSwZm6LJSjX
         5ZKw==
X-Forwarded-Encrypted: i=1; AL+hErFAy+FCodJSevHlwOZRL26dzKnF/mueauuVjJhfatQuMfDByQeiE0MUWWCHFt6PgXqPZ6o3ZdRjh78=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dUQvBm8tGLqQA7IdqnH4liSGoylAcuqjXFQTv8HbCa/fOp+fG
	wMqzLjQi3MuXRP42K4OpjD+4wU0XXyaO5PX6lpx5WtTABXCj6bymKge8+XMfBsuFF8dHBzdy0cj
	oqZ7uSNs7IigHFQ7nLqCtOm0SvvSeZgGfUB012XvSkLPanQp4jPLB371r31/ZokA=
X-Gm-Gg: AYBFou1NemQrexTWsKKAy7pfCsXDNoJv5i+Ku48qdU46RX6R4dXDxSEnWEHK3o1MaTH
	8N0KngTUhdpDmCUB/Utim8G4Co3k07EM2ZZ4Ou9DB9yDLRbuonrl5WP3qWGNxGQvhsf9yPPMo47
	Kj4UWt5cHXFIcoeUO4fDkmvnU2bLYiK4VfzZubbRuCwvL9ymJbx5L4WxU+tAXXe3D4n6sNHmFnN
	QYkHKByi2CNrSlehkErvHzYGfqMm5KDPyqYXh6tLzNAOSFD6oUYWRIRHETIaeNgxfEfOs6CPVnc
	KkG8lOICcxNXnYHIcif7qBXvcjCzUQeUHe7f4mRtshnvANWd61Xf1xFNs/Z19TK/6tMSNNYG2CJ
	PAOOMsHuuJequa9qg6cV/loaM5ALlg8DXnpZE00cB2QU+vTpMxOGSKKm8BqR9HKnIOynpAmtsMF
	MtRn7r2EDMfLL5qO10lKFICPXgRQ==
X-Received: by 2002:a05:6830:4390:b0:81a:9522:f00f with SMTP id 46e09a7af769-862f08ed4ecmr5285983a34.6.1795071354015;
        Wed, 18 Nov 2026 22:55:54 -0800 (PST)
X-Received: by 2002:a05:6830:4390:b0:81a:9522:f00f with SMTP id 46e09a7af769-862f08ed4ecmr5285964a34.6.1795071353443;
        Wed, 18 Nov 2026 22:55:53 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f00891e6sm3753070a34.0.2026.11.18.22.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:55:52 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 22:55:46 -0800
Subject: [PATCH v3 3/3] rtc: Add Qualcomm GIO RTC driver
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
Message-Id: <20261118-gio-framework-rtc-driver-2026-10-12-v3-3-52d78a8f43ee@oss.qualcomm.com>
References: <20261118-gio-framework-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com>
In-Reply-To: <20261118-gio-framework-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795071348; l=8209;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=/Xn8z7Wn9hnGXfczv1+n0XGcQmRX2Er3VAu7dVTnDNA=;
 b=L+L0Z7cbzu4IOzUGtYrEkw8dDjY4tHp3MM/4j7UJRy04s7Wxe4JotGwk7HSPAgMXnto0kngiH
 X5KkNJcn+bIAOL7Ss7ASVZBCvvwSQGbr78KP0z7pW657WxTY7Op0trQ
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-ORIG-GUID: Vo7l1cBV1YLxSKnFBrhDL13FXfU-hxCX
X-Proofpoint-GUID: Vo7l1cBV1YLxSKnFBrhDL13FXfU-hxCX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNyBTYWx0ZWRfXzT8+PuMa3eGi
 u6/BVV+Aol6ZCpYeLlS253pkshHA6pcqEyhHUzSN8ay2iTc5B4nyYAVqXmAYtZxepi9fbEP8/L9
 HI7yEPr6K/Z2MumPJHNtbIi/+fxCLZ8=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afe9d7b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PQbxmwGiin7G8qBTPywA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNyBTYWx0ZWRfX8QtCylVitWfi
 V8quk/phXj5yOI6u/gLJ3w4nOw/aOCJWycBCtfewWQz8g0uId53BI+s7xcyB0a+YrdErEsWqPey
 HjvDQs9ewkT1a3vh2iRg0YzslSTgoWEIAWTNprdlHLGe1nw6IUHJhhmONIW8v4I+z+YWMqn6+J0
 8f8esDf6oeGAoBFzgcJZWMMK6GDbRTfYgw72r50TmwgGpW18tWc6YHuGhp2MJX5QnWN5ZsPS/Uy
 Y+C1I2On/ucboYebacHRoAxbV7/cdSiTTLNkSgGkYeVsWEzSZ+HWuIcJz7fbXM4Q+FG7cpnp6hc
 Ui0ASyg8HdbrAVC04TyXZlEmPPwTFVfRaMXTV5//zJQnxEWfazwuPVt8mHOuyW936oV79crKLlv
 pfEN+CntBX86UUOsDAXuLVoX91Y/gNt3tvekPF+jZgozd0XDwGI7XoV9QJnJ3u9v4ZLcLy8OpPN
 r5zZiuXz/NRd4vOC85w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190027

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
index 0ea338518873..d00588a943d9 100644
--- a/drivers/soc/qcom/pmic_glink_gio.c
+++ b/drivers/soc/qcom/pmic_glink_gio.c
@@ -113,6 +113,8 @@ struct pmic_glink_gio {
 	bool service_up;
 
 	struct gio_write_req write_req;
+
+	struct auxiliary_device *rtc_aux;
 };
 
 /* Must be called with pgio->lock held. */
@@ -338,6 +340,18 @@ static void pmic_glink_gio_init_work(struct work_struct *work)
 
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

