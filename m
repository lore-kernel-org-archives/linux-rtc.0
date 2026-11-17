Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900811;
	b=M210hMcl20elSiJJ6rFJQsvlt8oeusgE8KSgfye1usVC7XFZ2lfd62kdXPCHg5Uu2yPG
	 xEWgTkjR8+nUism445aVVc1IFU6gUuhtzf7+uy3l58d9BfwXcfAr8ALfuxtV66Ns7M9q+
	 Ix13b7T3evfMfajc3XY8NNiRZT06ID9bhFArg/71B0fhNrsP0xSySwD6k//SOy0/FekYi
	 nTEU/u2vwG542jLbB2wREMJH8ZaMIAk7iuK1FHQfa+MHM2BogyOCTPMzEPHiR6e9izG34
	 YXpZlNZz8W35nWoYYvzlVGI85hRuq1bPQTx2io+XWvW9Oo7U7Zt49kNLGWp1tujWdwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900811;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6lqiPizOFwpBbqQmfMhfgOsgcohl+dtQSwF1zRN1cTU=;
	b=tlAWPLgZkyB3qYQ6dwR99bm7MBgYl99oFUOsFgiedA5V0Ymx0LJhJ72l4Sbjqpx8z+6k
	 L+aIMe4aVn+ciJRZSQNm/meTaM193JL2IJ18gQNlpQ81nS8ORuf6O4mZbYc0/mXaBsVo7
	 VVwzVMaXsywF33WhShQ3tCqf/f0eSecxUuTjqjMGh94jH3A1QiE0qrYUAzAnGrbWYQ4Fa
	 AVUthwD9+55/jFXS5DmPixVQzc6VdzGWYrC58idYOa3TbocAVzqAdJa4HLpN5eyc/IMqj
	 oHuDQt1uUkmYIzglxf3ZkTdIekw9+ZI0/Z21XQ1kMav8HW+4i36hMEAMvbIkHvz93LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="A/sesj9Z";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K0QafmyF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78718606A332
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78718606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A/sesj9Z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K0QafmyF
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aoQ72935699
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6lqiPizOFwpBbqQmfMhfgOsgcohl+dtQSwF1zRN1cTU=; b=A/sesj9ZvP2Z7pN8
	YU2VWVC9FIdoerqMPORNArx1krx8mQkHj0ovZdQaY8QKFjENEkefys74b1S4kI3l
	vK5FA8q448HAY6Xktc5oES0HVekc1p9q4SEhWKeh1Jeg6Lzp6odNRtCzl4IKo+f9
	fu5vr7KpCOFGdlmYPPwEliusuQ46gvPu11xr9kvJW/NipAXYEX6gkD5X96aifPCj
	uhjrwMF8PMDNyQyFyIq4TzCRiYQ4EZQw1Cu4Dh8GFkEPanyBydqhgOrOeKi/jdqF
	YnOzdIJF4dfYohh92aqMssKLGu0MkFxWew+xDdL5acClvLaPJk8vt4vV6DiusbNf
	OLDAbA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m09wh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:33:29 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-46617932071so2173413fac.0
        for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 23:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794900809; x=1795505609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lqiPizOFwpBbqQmfMhfgOsgcohl+dtQSwF1zRN1cTU=;
        b=K0QafmyFk1eyrswJaru3WbBdXAoZhhPCazwyshaKs1t3rBItXSVojj7l/Fuw4Jjo6+
         /jcr1iUQ82UAw3uNQDgumvhMWfL4yfemFpkPNAAxaaaq3o0lunRr24uCqfEhs1tf8zow
         AutlmTGj5AyxnVh7g+b405OiEvUkwxRpZi3TajPHH65ekW7TAtqYI7NJKciEz9ggERVR
         Q8VCeE3kXY+GPOmGxEQINoJYWnOEJpUBjGu8ys7WKVvmVamix7pUZrZMWVouu+Y6ls1y
         o6m6E5d7qbd9JdJmS+qSdB//hNNtB/UiWYTBkQo+1zX6k6Y6K5LpsmsdnGXlFUPjnSch
         svFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794900809; x=1795505609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lqiPizOFwpBbqQmfMhfgOsgcohl+dtQSwF1zRN1cTU=;
        b=NHembab4TXVHhhs/Fu5absuozvgZlyp2P0uuNPX1yhoTtFySlYy9ejRAh8xcQhcupZ
         xbsuILZkBMUBRfvehtaYjIEdz1dYOV2nQ7wRD/ANHXIPbntD1ce8rZfjF9ARBsa59Idz
         9o4HrUP+AB8F1ESmKvKQfUMP00t2o9cJHmGSnHTs45k/MaxJ1SA5M+8uGvR9sjx0p7sy
         nRYhmNzSrn5H8flj92wToO1Zu+SbCkIyzkV4Lzd7pdjpNAAeH9uOsNDuaCshFfXuQzTl
         Dp8suEIa2XDwlVwq4/NhAQ1jMgYlQnARRZWwtCvxxAlRdR8oSSk8YEiw8LKP/R8vStAY
         0zlQ==
X-Forwarded-Encrypted: i=1; AL+hErHMQ/BF7gdRfrjPykQ6NyzLEhmNYP6+pPfFlxlBlfMmzqxW0yCaL5IGyfaqqel//upJkI1CDNhNx8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HJ0H0EDJdWBU5qnrrS82dRjIhSwl/AOQpPlWfg6AW4OxmpAxQ
	mLHFwlREeMYRxhqJWLh6KdgifeZAtQh+I9d6vgkfGYkunkT0wcK7+cse2K3kAiwPxqTZTl39+hY
	kWj8sfUZMMvk9PqnwWsCIwhGUau9htMNP87+bHcJ2fA4sgqIaW/1qhYIeCilMAMI=
X-Gm-Gg: AYBFou2zp8IX8MMS6ccqLehVTVe2tmIksJPSM1MnXoxEdhOTOcGREqZGUeWpPN2sjO8
	6UF2K84DO9FxhN0FKOaR81R9n23CD++UWNYezCZNc58yxEtbrL4neTzRFtvBxtLOyaTuIn7GiXb
	HDPLBLz95xkB0VsRLUHoC6tPplaU3ksvDB2x/fay688y99Q78RROPQcgXhQ/ZzG3xNAal/udqUb
	SCZXp5722exzRn/CMbxU+0bg33gJIfwtk8AsdJmNOIk2WCp7DBmqt5BA+vh1y6FrVXMeUsOs82D
	AjBcjn0aa1IPSKzFWtwrtq3+33NsUS7SB4A4EamIyUi1hKi/JjDPMb5Knpe/1HewjgzUN/OjLAb
	fXZiBToQazrsZSx8Eus2rLmAwdHWRbEwVQc2IL4oBoDYafdTaoQ290viMlJ52DYVZMtVsrKx6mx
	AK4i1UOHVSWeR9DiJEcUS7Onv0yw==
X-Received: by 2002:a05:6871:54b:b0:4ad:8800:b277 with SMTP id 586e51a60fabf-4afdf4ee198mr10616999fac.24.1794900808189;
        Mon, 16 Nov 2026 23:33:28 -0800 (PST)
X-Received: by 2002:a05:6871:54b:b0:4ad:8800:b277 with SMTP id 586e51a60fabf-4afdf4ee198mr10616979fac.24.1794900807476;
        Mon, 16 Nov 2026 23:33:27 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe228982bsm8593875fac.10.2026.11.16.23.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:33:25 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:33:17 -0800
Subject: [PATCH v2 1/3] soc: qcom: Add pmic-gio GIO framework driver
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
Message-Id: <20261116-gio-framework-rtc-driver-2026-10-12-v2-1-b60e6fe33831@oss.qualcomm.com>
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
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794900802; l=40241;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=/6l+9InIRlh6czwryGYQBfh5TwhT+gAPzRzA7+UtvMU=;
 b=Ixi+GRUHB6UiUYNzAbTNt3/sajKHS7zglsCzktrZuRkepVsJck5WED2C0lVBl2O7oPn9uGomD
 1xPNeaKh1ZsB7fHScdUrl59qAzQ7dK48E7bdLk1vBQNjIhCbctlsoAK
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfXzdUjmr7Di8go
 Pqq3q6U1zBEJL7j8PkTLSg9j9e6XqtLlUmXRrF6bwoBtQeQ+nZn/U2nt1haQF0UM1Rx/U682/6V
 K6B7GgHIxv92lCBPMnEh0HYFUlznN54=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyOSBTYWx0ZWRfX2U5mHYhGdFAP
 Ep3vpsdQTBXMdz6oQi0rznin7nbvCgtB10wt/zJUktDtunTuFVmaKUje2V4Q9Hmx7a66X+UAGHZ
 XzOkL55K8MyEG2S4WddPi2LLVbcSDRBlLSybX9nEkoTthTBtO8TJUSeG9L3YzQh55ea/EOMCMZu
 7MAsHIvfK25VAapoF70zPBESrfiEhVv6qBafzJLB0og79hGdBthTgqEYn+nA8kM1ZT4QJpSHTvC
 arEQ1Q2y5dYeYdeuEjxkf6lkO2h29Kjub4YC+dnkpH/TDHYaKR1I2+Ld6sUiykKBUnB2NcOtfmw
 Y5GPY0v3fWMY3IVUw5dUXZpDTqk3esPiTSXYFj5qzTQTPLPx67GR4lg++2U7DR3q5JlCgOKin/2
 w7axCvzgHHEvYzkk1sUAeo9mj1Y0KSDIceT263L1PHIPpc4ai4F7lLZk5bMC0DIiWgR71uj24GG
 MAY+i74byLnsqezq2rg==
X-Proofpoint-GUID: zm73shpIOn6M0t1iRIz0dv6K11-f2dd_
X-Proofpoint-ORIG-GUID: zm73shpIOn6M0t1iRIz0dv6K11-f2dd_
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afc0349 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gODgIEoSDgxgNiEkC8QA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170029

Qualcomm SoCCP battery-management firmware on Glymur platform
introduces a new interface which is called General I/O (GIO).
It exposes functions through fixed-size register blocks grouped
into virtual peripherals such as core, battery, USB-C, service,
settings, debug, and OEM, etc. The data blocks must be accessed
using block-aligned transactions. It also generates alert
notifications which could be identified by a pair of peripheral
and alert ID.

Add a transport-agnostic PMIC GIO framework that validates register
accesses against the common GIO register definitions, and exposes the
firmware register space through regmap using transport-provided read
and write operations. The framework tracks transport availability
and notify consumers when its state changes, and route alerts through
a virtual IRQ domain while retaining their payload data. It also
provides a group of managed helpers for registering GIO transports,
state notifiers, IRQ mappings, and auxiliary consumer devices required
by the transport and the consumer drivers.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig               |  16 +
 drivers/soc/qcom/Makefile              |   1 +
 drivers/soc/qcom/pmic_gio.c            | 672 +++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/pmic_gio.h      | 153 ++++++++
 include/linux/soc/qcom/pmic_gio_regs.h | 239 ++++++++++++
 5 files changed, 1081 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 535c8619197b..266a1babc108 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -121,6 +121,22 @@ config QCOM_PMIC_GLINK
 	  Say yes here to support USB-C and battery status on modern Qualcomm
 	  platforms.
 
+config QCOM_PMIC_GIO
+	tristate "Qualcomm PMIC GIO framework"
+	depends on ARM64 || COMPILE_TEST
+	select AUXILIARY_BUS
+	select IRQ_DOMAIN
+	select REGMAP
+	help
+	  A generic framework driver for Qualcomm's General I/O (GIO) interface
+	  that is used to access SoCCP battery-managed firmware. It provides a
+	  register-space abstraction built on top of transport-supplied
+	  read/write operations, along with a virtual irqchip that distributes
+	  async alert messages to the consumers.
+
+	  Say yes here to enable the GIO interface on a SoCCP based battery
+	  management firmware platform.
+
 config QCOM_RAMP_CTRL
 	tristate "Qualcomm Ramp Controller driver"
 	help
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index bddd6f0a5836..c3170757b012 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PD_MAPPER)	+= qcom_pd_mapper.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
 obj-$(CONFIG_QCOM_PDR_MSG)	+= qcom_pdr_msg.o
+obj-$(CONFIG_QCOM_PMIC_GIO)	+= pmic_gio.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
 obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
diff --git a/drivers/soc/qcom/pmic_gio.c b/drivers/soc/qcom/pmic_gio.c
new file mode 100644
index 000000000000..6eab97720164
--- /dev/null
+++ b/drivers/soc/qcom/pmic_gio.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/soc/qcom/pmic_gio.h>
+#include <linux/soc/qcom/pmic_gio_regs.h>
+#include <linux/unaligned.h>
+
+#define PMIC_GIO_REG_ADDR_BYTES		4
+#define PMIC_GIO_MAX_XFER_SIZE		1024
+
+struct pmic_gio_reg_block {
+	u32 base;
+	u16 size;
+	bool writeable;
+};
+
+/*
+ * Every register block defined for the GIO peripherals. The firmware
+ * requires all registers of a block to be fetched/stored in a single
+ * block-aligned transaction.
+ */
+static const struct pmic_gio_reg_block pmic_gio_reg_blocks[] = {
+	/* CORE */
+	{ GIO_CORE_IF_VERSION_ADDR, GIO_CORE_IF_VERSION_SIZE, false },
+	{ GIO_CORE_ALERT_STATUS_ADDR, GIO_CORE_ALERT_STATUS_SIZE, false },
+	{ GIO_CORE_LAST_ALERT_ADDR, GIO_CORE_LAST_ALERT_SIZE, false },
+	{ GIO_CORE_GLOBAL_ALERT_CTRL_ADDR, GIO_CORE_GLOBAL_ALERT_CTRL_SIZE, true },
+	{ GIO_CORE_HOST_STATE_ADDR, GIO_CORE_HOST_STATE_SIZE, true },
+	{ GIO_CORE_SYSTEM_STATE_ADDR, GIO_CORE_SYSTEM_STATE_SIZE, true },
+	{ GIO_CORE_LAST_ERROR_ADDR, GIO_CORE_LAST_ERROR_SIZE, true },
+
+	/* BATT */
+	{ GIO_BATT_IF_VERSION_ADDR, GIO_BATT_IF_VERSION_SIZE, false },
+	{ GIO_BATT_ALERT_STATUS_ADDR, GIO_BATT_ALERT_STATUS_SIZE, false },
+	{ GIO_BATT_LAST_ALERT_ADDR, GIO_BATT_LAST_ALERT_SIZE, false },
+	{ GIO_BATT_BPRT_ADDR, GIO_BATT_BPRT_SIZE, false },
+	{ GIO_BATT_BCTI_ADDR, GIO_BATT_BCTI_SIZE, true },
+	{ GIO_BATT_BCT_ADDR, GIO_BATT_BCT_SIZE, false },
+	{ GIO_BATT_BIX_ADDR, GIO_BATT_BIX_SIZE, false },
+	{ GIO_BATT_BPC_ADDR, GIO_BATT_BPC_SIZE, false },
+	{ GIO_BATT_BPS_ADDR, GIO_BATT_BPS_SIZE, false },
+	{ GIO_BATT_BPT_ADDR, GIO_BATT_BPT_SIZE, true },
+	{ GIO_BATT_BPTS_ADDR, GIO_BATT_BPTS_SIZE, false },
+	{ GIO_BATT_BST_ADDR, GIO_BATT_BST_SIZE, false },
+	{ GIO_BATT_BATTERY_PRESENT_OCV_ADDR, GIO_BATT_BATTERY_PRESENT_OCV_SIZE, false },
+	{ GIO_BATT_BTH_ADDR, GIO_BATT_BTH_SIZE, true },
+	{ GIO_BATT_BTMI_ADDR, GIO_BATT_BTMI_SIZE, true },
+	{ GIO_BATT_BTM_ADDR, GIO_BATT_BTM_SIZE, false },
+	{ GIO_BATT_BTP_ADDR, GIO_BATT_BTP_SIZE, true },
+	{ GIO_BATT_PSR_ADDR, GIO_BATT_PSR_SIZE, false },
+	{ GIO_BATT_PIF_ADDR, GIO_BATT_PIF_SIZE, false },
+	{ GIO_BATT_SHIP_MODE_EN_ADDR, GIO_BATT_SHIP_MODE_EN_SIZE, true },
+	{ GIO_BATT_PCS_ADDR, GIO_BATT_PCS_SIZE, false },
+	{ GIO_BATT_MNO_ADDR, GIO_BATT_MNO_SIZE, false },
+	{ GIO_BATT_SNO_ADDR, GIO_BATT_SNO_SIZE, false },
+	{ GIO_BATT_OTY_ADDR, GIO_BATT_OTY_SIZE, false },
+	{ GIO_BATT_OIF_ADDR, GIO_BATT_OIF_SIZE, false },
+	{ GIO_BATT_PORTABLE_BATTERY_INFO_ADDR, GIO_BATT_PORTABLE_BATTERY_INFO_SIZE, false },
+	{ GIO_BATT_BMD_ADDR, GIO_BATT_BMD_SIZE, false },
+	{ GIO_BATT_BMC_ADDR, GIO_BATT_BMC_SIZE, true },
+	{ GIO_BATT_MISC_CONFIG_ADDR, GIO_BATT_MISC_CONFIG_SIZE, true },
+
+	/* USBC */
+	{ GIO_USBC_IF_VERSION_ADDR, GIO_USBC_IF_VERSION_SIZE, false },
+	{ GIO_USBC_ALERT_STATUS_ADDR, GIO_USBC_ALERT_STATUS_SIZE, false },
+	{ GIO_USBC_LAST_ALERT_ADDR, GIO_USBC_LAST_ALERT_SIZE, false },
+	{ GIO_USBC_UCSI_VERSION_REG, GIO_USBC_UCSI_VERSION_SIZE, false },
+	{ GIO_USBC_UCSI_CCI_REG, GIO_USBC_UCSI_CCI_SIZE, false },
+	{ GIO_USBC_UCSI_CONTROL_REG, GIO_USBC_UCSI_CONTROL_SIZE, true },
+	{ GIO_USBC_UCSI_MESSAGE_IN_REG, GIO_USBC_UCSI_MESSAGE_IN_SIZE, false },
+	{ GIO_USBC_UCSI_MSGINX_REG, GIO_USBC_UCSI_MSGINX_SIZE, false },
+	{ GIO_USBC_UCSI_MESSAGE_OUT_REG, GIO_USBC_UCSI_MESSAGE_OUT_SIZE, true },
+	{ GIO_USBC_UCSI_MSGOUTX_ADDR, GIO_USBC_UCSI_MSGOUTX_SIZE, true },
+	{ GIO_USBC_UCSI_PAN_ADDR, GIO_USBC_UCSI_PAN_SIZE, false },
+	{ GIO_USBC_PAN_CMD_ADDR, GIO_USBC_PAN_CMD_SIZE, true },
+	{ GIO_USBC_RTMR_INFO_ADDR, GIO_USBC_RTMR_INFO_SIZE, false },
+	{ GIO_USBC_RTMR_FW_UPDATE_ADDR, GIO_USBC_RTMR_FW_UPDATE_SIZE, true },
+	{ GIO_USBC_USBCFG_ADDR, GIO_USBC_USBCFG_SIZE, true },
+	{ GIO_USBC_DAM_CTRL_ADDR, GIO_USBC_DAM_CTRL_SIZE, true },
+	{ GIO_USBC_DAM_CTRL_CFG_ADDR, GIO_USBC_DAM_CTRL_CFG_SIZE, false },
+
+	/* SVC */
+	{ GIO_SVC_IF_VERSION_ADDR, GIO_SVC_IF_VERSION_SIZE, false },
+	{ GIO_SVC_ALERT_STATUS_ADDR, GIO_SVC_ALERT_STATUS_SIZE, false },
+	{ GIO_SVC_LAST_ALERT_ADDR, GIO_SVC_LAST_ALERT_SIZE, false },
+	{ GIO_SVC_UEFI_ACTION_ADDR, GIO_SVC_UEFI_ACTION_SIZE, false },
+	{ GIO_SVC_POWER_OK_ADDR, GIO_SVC_POWER_OK_SIZE, false },
+	{ GIO_SVC_OOB_REQUEST_ACTION_ADDR, GIO_SVC_OOB_REQUEST_ACTION_SIZE, true },
+	{ GIO_SVC_OOB_RTCTMR_VOTE_ADDR, GIO_SVC_OOB_RTCTMR_VOTE_SIZE, true },
+	{ GIO_SVC_CLT0_REQUEST_ACTION_ADDR, GIO_SVC_CLT0_REQUEST_ACTION_SIZE, true },
+	{ GIO_SVC_CLT0_RTCTMR_VOTE_ADDR, GIO_SVC_CLT0_RTCTMR_VOTE_SIZE, true },
+	{ GIO_SVC_SYS_SET_POWER_STATE_ADDR, GIO_SVC_SYS_SET_POWER_STATE_SIZE, true },
+	{ GIO_SVC_TAD_RT_ADDR, GIO_SVC_TAD_RT_SIZE, true },
+	{ GIO_SVC_TAD_GWS_ADDR, GIO_SVC_TAD_GWS_SIZE, false },
+	{ GIO_SVC_TAD_CWS_ADDR, GIO_SVC_TAD_CWS_SIZE, true },
+	{ GIO_SVC_TAD_TPA_ADDR, GIO_SVC_TAD_TPA_SIZE, true },
+	{ GIO_SVC_TAD_TPD_ADDR, GIO_SVC_TAD_TPD_SIZE, true },
+	{ GIO_SVC_TAD_TVA_ADDR, GIO_SVC_TAD_TVA_SIZE, true },
+	{ GIO_SVC_TAD_TVD_ADDR, GIO_SVC_TAD_TVD_SIZE, true },
+	{ GIO_SVC_LID_SETTING_ADDR, GIO_SVC_LID_SETTING_SIZE, true },
+
+	/* SETTING */
+	{ GIO_SETTING_IF_VERSION_ADDR, GIO_SETTING_IF_VERSION_SIZE, false },
+	{ GIO_SETTING_ALERT_STATUS_ADDR, GIO_SETTING_ALERT_STATUS_SIZE, false },
+	{ GIO_SETTING_LAST_ALERT_ADDR, GIO_SETTING_LAST_ALERT_SIZE, false },
+	{ GIO_SETTING_SYS_PWR_CFG_ADDR, GIO_SETTING_SYS_PWR_CFG_SIZE, true },
+	{ GIO_SETTING_BATT_AUTH_ADDR, GIO_SETTING_BATT_AUTH_SIZE, true },
+	{ GIO_SETTING_CHG_LIMIT_ADDR, GIO_SETTING_CHG_LIMIT_SIZE, true },
+	{ GIO_SETTING_BOOT_ADDR, GIO_SETTING_BOOT_SIZE, true },
+	{ GIO_SETTING_USBC_ADDR, GIO_SETTING_USBC_SIZE, true },
+	{ GIO_SETTING_HOST_MAC_ADDR_ADDR, GIO_SETTING_HOST_MAC_ADDR_SIZE, true },
+	{ GIO_SETTING_AOU_ADDR, GIO_SETTING_AOU_SIZE, true },
+	{ GIO_SETTING_PSM_ADDR, GIO_SETTING_PSM_SIZE, true },
+	{ GIO_SETTING_USB_WAKE_ON_LAN_ADDR, GIO_SETTING_USB_WAKE_ON_LAN_SIZE, true },
+	{ GIO_SETTING_EPM_USBC_ADDR, GIO_SETTING_EPM_USBC_SIZE, true },
+	{ GIO_SETTING_OFFMODE_SHIPMODE_ADDR, GIO_SETTING_OFFMODE_SHIPMODE_SIZE, true },
+	{ GIO_SETTING_RTC_TIMER_FOR_EOC_ADDR, GIO_SETTING_RTC_TIMER_FOR_EOC_SIZE, true },
+	{ GIO_SETTING_INTL_CHG_ADDR, GIO_SETTING_INTL_CHG_SIZE, true },
+	{ GIO_SETTING_CMD_ADDR, GIO_SETTING_CMD_SIZE, true },
+
+	/* DBG */
+	{ GIO_DBG_IF_VERSION_ADDR, GIO_DBG_IF_VERSION_SIZE, false },
+	{ GIO_DBG_ALERT_STATUS_ADDR, GIO_DBG_ALERT_STATUS_SIZE, false },
+	{ GIO_DBG_LAST_ALERT_ADDR, GIO_DBG_LAST_ALERT_SIZE, false },
+	{ GIO_DBG_BCLIBAT_ADDR, GIO_DBG_BCLIBAT_SIZE, true },
+	{ GIO_DBG_BCLVBAT_ADDR, GIO_DBG_BCLVBAT_SIZE, true },
+	{ GIO_DBG_BCLIBAT_DGL_TIMER_ADDR, GIO_DBG_BCLIBAT_DGL_TIMER_SIZE, true },
+	{ GIO_DBG_BCLVBAT_DGL_TIMER_ADDR, GIO_DBG_BCLVBAT_DGL_TIMER_SIZE, true },
+	{ GIO_DBG_BCL_CLR_TIMER_ADDR, GIO_DBG_BCL_CLR_TIMER_SIZE, true },
+	{ GIO_DBG_CHG_DIE_TEMP_TH_ADDR, GIO_DBG_CHG_DIE_TEMP_TH_SIZE, true },
+	{ GIO_DBG_CHG_CONN_TEMP_TH_ADDR, GIO_DBG_CHG_CONN_TEMP_TH_SIZE, true },
+	{ GIO_DBG_SPMI_WRITE_ADDR, GIO_DBG_SPMI_WRITE_SIZE, true },
+	{ GIO_DBG_LOG_LEVEL_ADDR, GIO_DBG_LOG_LEVEL_SIZE, true },
+	{ GIO_DBG_LOG_CAT_ADDR, GIO_DBG_LOG_CAT_SIZE, true },
+
+	/* OEM */
+	{ GIO_OEM_IF_VERSION_ADDR, GIO_OEM_IF_VERSION_SIZE, false },
+	{ GIO_OEM_ALERT_STATUS_ADDR, GIO_OEM_ALERT_STATUS_SIZE, false },
+	{ GIO_OEM_LAST_ALERT_ADDR, GIO_OEM_LAST_ALERT_SIZE, false },
+	{ GIO_OEM_OP_RW_ADDR, GIO_OEM_OP_RW_SIZE, true },
+	{ GIO_OEM_I2C_PROXY_CONFIG_ADDR, GIO_OEM_I2C_PROXY_CONFIG_SIZE, true },
+	{ GIO_OEM_I2C_PROXY_DATA_ADDR, GIO_OEM_I2C_PROXY_DATA_SIZE, true },
+};
+
+static const struct pmic_gio_reg_block *pmic_gio_find_reg_block(unsigned int reg)
+{
+	const struct pmic_gio_reg_block *block;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmic_gio_reg_blocks); i++) {
+		block = &pmic_gio_reg_blocks[i];
+		if (reg == block->base)
+			return block;
+	}
+
+	return NULL;
+}
+
+static const struct pmic_gio_reg_block *pmic_gio_validate_access(unsigned int reg,
+								 size_t len)
+{
+	const struct pmic_gio_reg_block *block = pmic_gio_find_reg_block(reg);
+
+	if (!block || !len)
+		return NULL;
+
+	if (reg != block->base || len != block->size)
+		return NULL;
+
+	return block;
+}
+
+static bool pmic_gio_readable_reg(struct device *dev, unsigned int reg)
+{
+	const struct pmic_gio_reg_block *block = pmic_gio_find_reg_block(reg);
+
+	return block ? true : false;
+}
+
+static bool pmic_gio_writeable_reg(struct device *dev, unsigned int reg)
+{
+	const struct pmic_gio_reg_block *block = pmic_gio_find_reg_block(reg);
+
+	return block && block->writeable;
+}
+
+/*
+ * For registers in a block whose size exceeds 4 bytes, mark them as
+ * precious registers to prevent regmap debugfs from accessing a torn
+ * register one at a time.
+ */
+static bool pmic_gio_precious_reg(struct device *dev, unsigned int reg)
+{
+	const struct pmic_gio_reg_block *block = pmic_gio_find_reg_block(reg);
+
+	return block && block->size > PMIC_GIO_REG_GRANULARITY;
+}
+
+static const struct regmap_config pmic_gio_default_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= PMIC_GIO_REG_GRANULARITY * 8,
+	.reg_stride	= PMIC_GIO_REG_GRANULARITY,
+	.max_register	= GIO_MAX_REG_ADDR,
+	.readable_reg	= pmic_gio_readable_reg,
+	.writeable_reg	= pmic_gio_writeable_reg,
+	.precious_reg	= pmic_gio_precious_reg,
+	.name		= "pmic-gio",
+};
+
+static const struct pmic_gio_irq pmic_gio_default_irqs[] = {
+	{ GIO_BATT_PERIPHERAL_ID, GIO_ALERT_BATT_STATUS_CHANGE },
+	{ GIO_BATT_PERIPHERAL_ID, GIO_ALERT_BATT_INFO_CHANGE },
+	{ GIO_BATT_PERIPHERAL_ID, GIO_ALERT_BATT_MAINTENANCE_STATUS_CHANGE },
+	{ GIO_BATT_PERIPHERAL_ID, GIO_ALERT_BATT_POWER_STATE_CHANGE },
+	{ GIO_BATT_PERIPHERAL_ID, GIO_ALERT_BATT_POWER_SOURCE_INFO_CHANGE },
+	{ GIO_USBC_PERIPHERAL_ID, GIO_ALERT_USBC_UCSI_CCI },
+	{ GIO_USBC_PERIPHERAL_ID, GIO_ALERT_USBC_PAN },
+	{ GIO_SVC_PERIPHERAL_ID, GIO_ALERT_SVC_POWER_OK_CHANGED },
+	{ GIO_SVC_PERIPHERAL_ID, GIO_ALERT_SVC_SHUTDOWN },
+	{ GIO_SVC_PERIPHERAL_ID, GIO_ALERT_SVC_RESET },
+	{ GIO_OEM_PERIPHERAL_ID, GIO_ALERT_OEM_OP_NOTIFY },
+};
+
+static const struct pmic_gio_irq_chip pmic_gio_default_irq_chip = {
+	.irqs = pmic_gio_default_irqs,
+	.num_irqs = ARRAY_SIZE(pmic_gio_default_irqs),
+};
+
+static int pmic_gio_regmap_bus_read(void *context, const void *reg, size_t reg_size,
+				    void *val, size_t val_size)
+{
+	const struct pmic_gio_reg_block *block;
+	struct pmic_gio_device *gio = context;
+	u32 addr;
+
+	if (!READ_ONCE(gio->online))
+		return -ENOTCONN;
+
+	if (reg_size != PMIC_GIO_REG_ADDR_BYTES)
+		return -EINVAL;
+
+	addr = get_unaligned_le32(reg);
+	block = pmic_gio_validate_access(addr, val_size);
+	if (!block)
+		return -EINVAL;
+
+	return gio->ops->read(gio, addr, val, val_size);
+}
+
+static int pmic_gio_regmap_bus_gather_write(void *context, const void *reg, size_t reg_size,
+					    const void *val, size_t val_size)
+{
+	const struct pmic_gio_reg_block *block;
+	struct pmic_gio_device *gio = context;
+	u32 addr;
+
+	if (!READ_ONCE(gio->online))
+		return -ENOTCONN;
+
+	if (reg_size != PMIC_GIO_REG_ADDR_BYTES)
+		return -EINVAL;
+
+	addr = get_unaligned_le32(reg);
+	block = pmic_gio_validate_access(addr, val_size);
+	if (!block || !block->writeable)
+		return -EINVAL;
+
+	return gio->ops->write(gio, addr, val, val_size);
+}
+
+static int pmic_gio_regmap_bus_write(void *context, const void *data, size_t count)
+{
+	const u8 *val;
+
+	if (count < PMIC_GIO_REG_ADDR_BYTES)
+		return -EINVAL;
+
+	val = (const u8 *)data + PMIC_GIO_REG_ADDR_BYTES;
+
+	return pmic_gio_regmap_bus_gather_write(context, data, PMIC_GIO_REG_ADDR_BYTES,
+						val, count - PMIC_GIO_REG_ADDR_BYTES);
+}
+
+static const struct regmap_bus pmic_gio_regmap_bus = {
+	.read = pmic_gio_regmap_bus_read,
+	.write = pmic_gio_regmap_bus_write,
+	.gather_write = pmic_gio_regmap_bus_gather_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.max_raw_read = PMIC_GIO_MAX_XFER_SIZE,
+	.max_raw_write = PMIC_GIO_MAX_XFER_SIZE,
+};
+
+struct pmic_gio_alert_data {
+	struct mutex dispatch_lock; /* Serialize alert publication and dispatch */
+	struct mutex data_lock; /* Protect alert data payload */
+	u8 payload[PMIC_GIO_ALERT_PAYLOAD_SIZE];
+};
+
+struct pmic_gio_irq_chip_data {
+	const struct pmic_gio_irq_chip	*chip;
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
+	unsigned int *virqs;
+	struct pmic_gio_alert_data *alerts;
+};
+
+struct pmic_gio_notifier {
+	struct pmic_gio_device *gio;
+	struct notifier_block *nb;
+};
+
+/* The alert IRQ couldn't be masked/unmasked separately */
+static void pmic_gio_irq_dummy(struct irq_data *data)
+{
+}
+
+static const struct irq_chip pmic_gio_irq_chip_ops = {
+	.name = "pmic-gio",
+	.irq_mask = pmic_gio_irq_dummy,
+	.irq_unmask = pmic_gio_irq_dummy,
+};
+
+static int pmic_gio_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				   irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(virq, d->host_data);
+	irq_set_chip_and_handler(virq, &pmic_gio_irq_chip_ops, handle_simple_irq);
+	irq_set_nested_thread(virq, true);
+	irq_set_noprobe(virq);
+
+	return 0;
+}
+
+static int pmic_gio_irq_to_hwirq(const struct pmic_gio_irq_chip *chip, u8 peripheral_id,
+				 u8 alert_id, irq_hw_number_t *hwirq)
+{
+	int i;
+
+	for (i = 0; i < chip->num_irqs; i++) {
+		if (chip->irqs[i].peripheral_id == peripheral_id &&
+		    chip->irqs[i].alert_id == alert_id) {
+			*hwirq = i;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int pmic_gio_irq_domain_xlate(struct irq_domain *d, struct device_node *node,
+				     const u32 *intspec, unsigned int intsize,
+				     unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct pmic_gio_irq_chip_data *chip_data = d->host_data;
+
+	if (intsize != 2 || intspec[0] > 0xff || intspec[1] > 0xff)
+		return -EINVAL;
+
+	*out_type = IRQ_TYPE_NONE;
+
+	return pmic_gio_irq_to_hwirq(chip_data->chip, intspec[0], intspec[1], out_hwirq);
+}
+
+static const struct irq_domain_ops pmic_gio_irq_domain_ops = {
+	.map = pmic_gio_irq_domain_map,
+	.xlate = pmic_gio_irq_domain_xlate,
+};
+
+static int pmic_gio_add_irq_chip(struct pmic_gio_device *gio,
+				 struct pmic_gio_irq_chip_data **data)
+{
+	const struct pmic_gio_irq_chip *chip = &pmic_gio_default_irq_chip;
+	int virq;
+
+	struct pmic_gio_irq_chip_data *chip_data __free(kfree) =
+				kzalloc_obj(*chip_data, GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	unsigned int *virqs __free(kfree) =
+		kcalloc(chip->num_irqs, sizeof(*virqs), GFP_KERNEL);
+	if (!virqs)
+		return -ENOMEM;
+
+	struct pmic_gio_alert_data *alerts __free(kfree) =
+		kcalloc(chip->num_irqs, sizeof(*alerts), GFP_KERNEL);
+	if (!alerts)
+		return -ENOMEM;
+
+	chip_data->chip = chip;
+
+	chip_data->fwnode = dev_fwnode(gio->dev);
+	if (!chip_data->fwnode)
+		return -ENODEV;
+
+	chip_data->domain = irq_domain_create_linear(chip_data->fwnode, chip->num_irqs,
+						     &pmic_gio_irq_domain_ops, chip_data);
+	if (!chip_data->domain)
+		return -ENOMEM;
+
+	for (int i = 0; i < chip->num_irqs; i++) {
+		mutex_init(&alerts[i].dispatch_lock);
+		mutex_init(&alerts[i].data_lock);
+
+		virq = irq_create_mapping(chip_data->domain, i);
+		if (!virq) {
+			while (i--)
+				irq_dispose_mapping(virqs[i]);
+			irq_domain_remove(chip_data->domain);
+			return -EINVAL;
+		}
+		virqs[i] = virq;
+	}
+
+	chip_data->virqs = no_free_ptr(virqs);
+	chip_data->alerts = no_free_ptr(alerts);
+	*data = chip_data;
+	gio->chip_data = no_free_ptr(chip_data);
+
+	return 0;
+}
+
+static void pmic_gio_irq_chip_devm_release(void *data)
+{
+	struct pmic_gio_irq_chip_data *chip_data = data;
+
+	for (int i = 0; i < chip_data->chip->num_irqs; i++)
+		irq_dispose_mapping(chip_data->virqs[i]);
+
+	irq_domain_remove(chip_data->domain);
+	kfree(chip_data->alerts);
+	kfree(chip_data->virqs);
+	kfree(chip_data);
+}
+
+struct pmic_gio_device *devm_pmic_gio_register(struct device *dev,
+					       const struct pmic_gio_device_ops *ops,
+					       void *drvdata)
+{
+	struct pmic_gio_irq_chip_data *chip_data;
+	struct pmic_gio_device *gio;
+	int ret;
+
+	if (!ops || !ops->read || !ops->write)
+		return ERR_PTR(-EINVAL);
+
+	gio = devm_kzalloc(dev, sizeof(*gio), GFP_KERNEL);
+	if (!gio)
+		return ERR_PTR(-ENOMEM);
+
+	gio->dev = dev;
+	gio->ops = ops;
+	gio->drvdata = drvdata;
+	ATOMIC_INIT_NOTIFIER_HEAD(&gio->state_notifiers);
+
+	gio->regmap = devm_regmap_init(gio->dev, &pmic_gio_regmap_bus, gio,
+				       &pmic_gio_default_regmap_config);
+	if (IS_ERR(gio->regmap))
+		return ERR_CAST(gio->regmap);
+
+	ret = pmic_gio_add_irq_chip(gio, &chip_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_add_action_or_reset(dev, pmic_gio_irq_chip_devm_release, chip_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return gio;
+}
+EXPORT_SYMBOL_GPL(devm_pmic_gio_register);
+
+void pmic_gio_set_state(struct pmic_gio_device *gio, enum pmic_gio_state state)
+{
+	bool online;
+
+	if (!gio)
+		return;
+
+	online = state == PMIC_GIO_STATE_UP;
+	if (READ_ONCE(gio->online) == online)
+		return;
+
+	WRITE_ONCE(gio->online, online);
+	atomic_notifier_call_chain(&gio->state_notifiers, state, gio);
+}
+EXPORT_SYMBOL_GPL(pmic_gio_set_state);
+
+bool pmic_gio_is_online(struct device *dev)
+{
+	struct pmic_gio_device *gio;
+
+	if (!dev)
+		return false;
+
+	gio = dev_get_platdata(dev);
+
+	return gio && READ_ONCE(gio->online);
+}
+EXPORT_SYMBOL_GPL(pmic_gio_is_online);
+
+static void pmic_gio_unregister_notifier(void *data)
+{
+	struct pmic_gio_notifier *notifier = data;
+
+	atomic_notifier_chain_unregister(&notifier->gio->state_notifiers, notifier->nb);
+}
+
+/**
+ * devm_pmic_gio_register_notifier - register a GIO state notifier
+ * @dev: GIO consumer device
+ * @nb: notifier block to register
+ *
+ * State notifier callbacks may run in atomic context and must not sleep.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int devm_pmic_gio_register_notifier(struct device *dev, struct notifier_block *nb)
+{
+	struct pmic_gio_notifier *notifier;
+	struct pmic_gio_device *gio;
+	int ret;
+
+	if (!dev || !nb)
+		return -EINVAL;
+
+	gio = dev_get_platdata(dev);
+	if (!gio)
+		return -ENODEV;
+
+	notifier = devm_kzalloc(dev, sizeof(*notifier), GFP_KERNEL);
+	if (!notifier)
+		return -ENOMEM;
+
+	notifier->gio = gio;
+	notifier->nb = nb;
+
+	ret = atomic_notifier_chain_register(&gio->state_notifiers, nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, pmic_gio_unregister_notifier, notifier);
+}
+EXPORT_SYMBOL_GPL(devm_pmic_gio_register_notifier);
+
+/**
+ * pmic_gio_irq_find - map a GIO alert to a Linux IRQ
+ * @dev: GIO consumer device
+ * @peripheral_id: GIO peripheral identifier
+ * @alert_id: alert identifier within the peripheral
+ *
+ * Maps a given (@peripheral_id, @alert_id) pair to the Linux IRQ associated
+ * with the consumer's GIO auxiliary parent, for example:
+ *
+ *	virq = pmic_gio_irq_find(dev, GIO_USBC_PERIPHERAL_ID,
+ *				 GIO_ALERT_USBC_UCSI_CCI);
+ *
+ * Return: A Linux IRQ number on success or a negative error code on failure.
+ */
+int pmic_gio_irq_find(struct device *dev, u8 peripheral_id, u8 alert_id)
+{
+	struct irq_fwspec fwspec = {};
+	int virq;
+
+	if (!dev || !dev->parent)
+		return -EINVAL;
+
+	fwspec.fwnode = dev_fwnode(dev->parent);
+	if (!fwspec.fwnode)
+		return -ENODEV;
+
+	fwspec.param_count = 2;
+	fwspec.param[0] = peripheral_id;
+	fwspec.param[1] = alert_id;
+
+	virq = irq_create_fwspec_mapping(&fwspec);
+
+	return virq ?: -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pmic_gio_irq_find);
+
+int pmic_gio_irq_get_payload(unsigned int irq, void *payload, size_t payload_size)
+{
+	struct irq_data *irq_data = irq_get_irq_data(irq);
+	struct pmic_gio_irq_chip_data *data;
+	irq_hw_number_t hwirq;
+
+	if (!irq_data || irq_data->chip != &pmic_gio_irq_chip_ops || !payload)
+		return -EINVAL;
+
+	if (payload_size < PMIC_GIO_ALERT_PAYLOAD_SIZE)
+		return -EMSGSIZE;
+
+	data = irq_data->chip_data;
+	hwirq = irqd_to_hwirq(irq_data);
+	if (hwirq >= data->chip->num_irqs)
+		return -EINVAL;
+
+	guard(mutex)(&data->alerts[hwirq].data_lock);
+	memcpy(payload, data->alerts[hwirq].payload, PMIC_GIO_ALERT_PAYLOAD_SIZE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmic_gio_irq_get_payload);
+
+struct auxiliary_device *
+devm_pmic_gio_add_consumer(struct pmic_gio_device *gio, const char *name)
+{
+	return devm_auxiliary_device_create(gio->dev, name, gio);
+}
+EXPORT_SYMBOL_GPL(devm_pmic_gio_add_consumer);
+
+/**
+ * pmic_gio_handle_alert - dispatch a GIO alert to its IRQ handler
+ * @gio: GIO device receiving the alert
+ * @peripheral_id: GIO peripheral identifier
+ * @alert_id: alert identifier within the peripheral
+ * @payload: alert payload
+ *
+ * The transport layer calls this function when a GIO alert arrives. This
+ * function may sleep and must be called from sleepable context.
+ */
+void pmic_gio_handle_alert(struct pmic_gio_device *gio,
+			   u8 peripheral_id, u8 alert_id,
+			   const void *payload)
+{
+	struct pmic_gio_irq_chip_data *data = gio->chip_data;
+	struct pmic_gio_alert_data *alert;
+	irq_hw_number_t hwirq;
+	int virq;
+
+	if (!payload || !READ_ONCE(gio->online))
+		return;
+
+	if (gio->ops->handle_alert &&
+	    gio->ops->handle_alert(gio, peripheral_id, alert_id, payload))
+		return;
+
+	if (pmic_gio_irq_to_hwirq(data->chip, peripheral_id, alert_id, &hwirq))
+		return;
+
+	virq = irq_find_mapping(data->domain, hwirq);
+	if (!virq)
+		return;
+
+	alert = &data->alerts[hwirq];
+	guard(mutex)(&alert->dispatch_lock);
+
+	scoped_guard(mutex, &alert->data_lock)
+		memcpy(alert->payload, payload, PMIC_GIO_ALERT_PAYLOAD_SIZE);
+
+	handle_nested_irq(virq);
+}
+EXPORT_SYMBOL_GPL(pmic_gio_handle_alert);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GIO common driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/pmic_gio.h b/include/linux/soc/qcom/pmic_gio.h
new file mode 100644
index 000000000000..e62fa6a9ccc7
--- /dev/null
+++ b/include/linux/soc/qcom/pmic_gio.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef __SOC_QCOM_PMIC_GIO_H__
+#define __SOC_QCOM_PMIC_GIO_H__
+
+#include <linux/auxiliary_bus.h>
+#include <linux/err.h>
+#include <linux/kconfig.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+/* Native access granularity of the GIO regmap: bytes per register. */
+#define PMIC_GIO_REG_GRANULARITY	4
+#define PMIC_GIO_ALERT_PAYLOAD_SIZE	16
+
+/* GIO peripherals id */
+#define GIO_CORE_PERIPHERAL_ID	0x00
+#define GIO_BATT_PERIPHERAL_ID	0x01
+#define GIO_USBC_PERIPHERAL_ID	0x02
+#define GIO_SVC_PERIPHERAL_ID	0x03
+#define GIO_OEM_PERIPHERAL_ID	0x0C
+
+/* GIO Alert IDs in each peripherals */
+#define GIO_ALERT_BATT_STATUS_CHANGE			0x80
+#define GIO_ALERT_BATT_INFO_CHANGE			0x81
+#define GIO_ALERT_BATT_MAINTENANCE_STATUS_CHANGE	0x82
+#define GIO_ALERT_BATT_POWER_STATE_CHANGE		0x83
+#define GIO_ALERT_BATT_POWER_SOURCE_INFO_CHANGE		0x90
+
+#define GIO_ALERT_USBC_UCSI_CCI				0x80
+#define GIO_ALERT_USBC_PAN				0x40
+
+#define GIO_ALERT_SVC_POWER_OK_CHANGED			0x01
+#define GIO_ALERT_SVC_SHUTDOWN				0x02
+#define GIO_ALERT_SVC_RESET				0x03
+
+#define GIO_ALERT_OEM_OP_NOTIFY				0x80
+
+struct device;
+struct regmap;
+
+struct pmic_gio_device;
+
+enum pmic_gio_state {
+	PMIC_GIO_STATE_DOWN,
+	PMIC_GIO_STATE_UP,
+};
+
+/*
+ * struct pmic_gio_device_ops - transport callbacks for a GIO device
+ * @read: read @val_size bytes starting at @reg
+ * @write: write @val_size bytes starting at @reg
+ * @handle_alert: optional hook letting the transport intercept an alert
+ *	before it is dispatched through the irqchip, with direct access to
+ *	the transport-defined alert @payload. Returns true if the alert was
+ *	fully handled and no further (irqchip) dispatch is wanted.
+ */
+struct pmic_gio_device_ops {
+	int (*read)(struct pmic_gio_device *gio, unsigned int reg, void *val, size_t val_size);
+	int (*write)(struct pmic_gio_device *gio, unsigned int reg, const void *val,
+		     size_t val_size);
+	bool (*handle_alert)(struct pmic_gio_device *gio, u8 peripheral_id, u8 alert_id,
+			     const void *payload);
+};
+
+struct pmic_gio_irq_chip_data;
+
+struct pmic_gio_device {
+	struct device *dev;
+	const struct pmic_gio_device_ops *ops;
+	void *drvdata;
+
+	struct regmap *regmap;
+	struct pmic_gio_irq_chip_data *chip_data;
+	struct atomic_notifier_head state_notifiers;
+	bool online;
+};
+
+struct pmic_gio_irq {
+	u8 peripheral_id;
+	u8 alert_id;
+};
+
+struct pmic_gio_irq_chip {
+	const struct pmic_gio_irq *irqs;
+	int num_irqs;
+};
+
+#if IS_REACHABLE(CONFIG_QCOM_PMIC_GIO)
+struct pmic_gio_device *devm_pmic_gio_register(struct device *dev,
+					       const struct pmic_gio_device_ops *ops,
+					       void *drvdata);
+struct auxiliary_device *
+devm_pmic_gio_add_consumer(struct pmic_gio_device *gio, const char *name);
+void pmic_gio_set_state(struct pmic_gio_device *gio, enum pmic_gio_state state);
+bool pmic_gio_is_online(struct device *dev);
+int devm_pmic_gio_register_notifier(struct device *dev, struct notifier_block *nb);
+int pmic_gio_irq_find(struct device *dev, u8 peripheral_id, u8 alert_id);
+void pmic_gio_handle_alert(struct pmic_gio_device *gio, u8 peripheral_id, u8 alert_id,
+			   const void *payload);
+int pmic_gio_irq_get_payload(unsigned int irq, void *payload,
+			     size_t payload_size);
+#else
+static inline struct pmic_gio_device *devm_pmic_gio_register(struct device *dev,
+							     const struct pmic_gio_device_ops *ops,
+							     void *drvdata)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct auxiliary_device *
+devm_pmic_gio_add_consumer(struct pmic_gio_device *gio, const char *name)
+{
+	return NULL;
+}
+
+static inline void pmic_gio_set_state(struct pmic_gio_device *gio,
+				      enum pmic_gio_state state)
+{
+}
+
+static inline bool pmic_gio_is_online(struct device *dev)
+{
+	return false;
+}
+
+static inline int devm_pmic_gio_register_notifier(struct device *dev,
+						  struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pmic_gio_irq_find(struct device *dev, u8 peripheral_id,
+				    u8 alert_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pmic_gio_irq_get_payload(unsigned int irq, void *payload,
+					   size_t payload_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pmic_gio_handle_alert(struct pmic_gio_device *gio, u8 peripheral_id,
+					 u8 alert_id, const void *payload)
+{
+}
+#endif
+
+#endif
diff --git a/include/linux/soc/qcom/pmic_gio_regs.h b/include/linux/soc/qcom/pmic_gio_regs.h
new file mode 100644
index 000000000000..7081d5a5abda
--- /dev/null
+++ b/include/linux/soc/qcom/pmic_gio_regs.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef __SOC_QCOM_PMIC_GIO_REGS_H__
+#define __SOC_QCOM_PMIC_GIO_REGS_H__
+
+/* Register block base addresses and sizes for the GIO PMIC peripherals. */
+/* CORE */
+#define GIO_CORE_IF_VERSION_ADDR		0x00000
+#define GIO_CORE_IF_VERSION_SIZE		4
+#define GIO_CORE_ALERT_STATUS_ADDR		0x00010
+#define GIO_CORE_ALERT_STATUS_SIZE		4
+#define GIO_CORE_LAST_ALERT_ADDR		0x00014
+#define GIO_CORE_LAST_ALERT_SIZE		20
+#define GIO_CORE_GLOBAL_ALERT_CTRL_ADDR		0x00100
+#define GIO_CORE_GLOBAL_ALERT_CTRL_SIZE		4
+#define GIO_CORE_HOST_STATE_ADDR		0x00180
+#define GIO_CORE_HOST_STATE_SIZE		4
+#define GIO_CORE_SYSTEM_STATE_ADDR		0x00184
+#define GIO_CORE_SYSTEM_STATE_SIZE		4
+#define GIO_CORE_LAST_ERROR_ADDR		0x00200
+#define GIO_CORE_LAST_ERROR_SIZE		4
+
+/* BATT */
+#define GIO_BATT_IF_VERSION_ADDR		0x10000
+#define GIO_BATT_IF_VERSION_SIZE		4
+#define GIO_BATT_ALERT_STATUS_ADDR		0x10010
+#define GIO_BATT_ALERT_STATUS_SIZE		4
+#define GIO_BATT_LAST_ALERT_ADDR		0x10014
+#define GIO_BATT_LAST_ALERT_SIZE		20
+#define GIO_BATT_BPRT_ADDR			0x10100
+#define GIO_BATT_BPRT_SIZE			4
+#define GIO_BATT_BCTI_ADDR			0x10104
+#define GIO_BATT_BCTI_SIZE			4
+#define GIO_BATT_BCT_ADDR			0x10108
+#define GIO_BATT_BCT_SIZE			4
+#define GIO_BATT_BIX_ADDR			0x10110
+#define GIO_BATT_BIX_SIZE			68
+#define GIO_BATT_BPC_ADDR			0x10160
+#define GIO_BATT_BPC_SIZE			16
+#define GIO_BATT_BPS_ADDR			0x10178
+#define GIO_BATT_BPS_SIZE			20
+#define GIO_BATT_BPT_ADDR			0x10190
+#define GIO_BATT_BPT_SIZE			12
+#define GIO_BATT_BPTS_ADDR			0x1019c
+#define GIO_BATT_BPTS_SIZE			4
+#define GIO_BATT_BST_ADDR			0x101a8
+#define GIO_BATT_BST_SIZE			16
+#define GIO_BATT_BATTERY_PRESENT_OCV_ADDR	0x101b8
+#define GIO_BATT_BATTERY_PRESENT_OCV_SIZE	4
+#define GIO_BATT_BTH_ADDR			0x101c0
+#define GIO_BATT_BTH_SIZE			4
+#define GIO_BATT_BTMI_ADDR			0x101c8
+#define GIO_BATT_BTMI_SIZE			4
+#define GIO_BATT_BTM_ADDR			0x101cc
+#define GIO_BATT_BTM_SIZE			4
+#define GIO_BATT_BTP_ADDR			0x101d0
+#define GIO_BATT_BTP_SIZE			4
+#define GIO_BATT_PSR_ADDR			0x101d8
+#define GIO_BATT_PSR_SIZE			4
+#define GIO_BATT_PIF_ADDR			0x101dc
+#define GIO_BATT_PIF_SIZE			12
+#define GIO_BATT_SHIP_MODE_EN_ADDR		0x101e8
+#define GIO_BATT_SHIP_MODE_EN_SIZE		4
+#define GIO_BATT_PCS_ADDR			0x101ec
+#define GIO_BATT_PCS_SIZE			12
+#define GIO_BATT_MNO_ADDR			0x10200
+#define GIO_BATT_MNO_SIZE			128
+#define GIO_BATT_SNO_ADDR			0x10280
+#define GIO_BATT_SNO_SIZE			128
+#define GIO_BATT_OTY_ADDR			0x10300
+#define GIO_BATT_OTY_SIZE			128
+#define GIO_BATT_OIF_ADDR			0x10380
+#define GIO_BATT_OIF_SIZE			128
+#define GIO_BATT_PORTABLE_BATTERY_INFO_ADDR	0x10400
+#define GIO_BATT_PORTABLE_BATTERY_INFO_SIZE	128
+#define GIO_BATT_BMD_ADDR			0x10480
+#define GIO_BATT_BMD_SIZE			20
+#define GIO_BATT_BMC_ADDR			0x10494
+#define GIO_BATT_BMC_SIZE			4
+#define GIO_BATT_MISC_CONFIG_ADDR		0x104a0
+#define GIO_BATT_MISC_CONFIG_SIZE		4
+
+/* USBC */
+#define GIO_USBC_IF_VERSION_ADDR		0x20000
+#define GIO_USBC_IF_VERSION_SIZE		4
+#define GIO_USBC_ALERT_STATUS_ADDR		0x20010
+#define GIO_USBC_ALERT_STATUS_SIZE		4
+#define GIO_USBC_LAST_ALERT_ADDR		0x20014
+#define GIO_USBC_LAST_ALERT_SIZE		20
+#define GIO_USBC_UCSI_VERSION_REG		0x20100
+#define GIO_USBC_UCSI_VERSION_SIZE		4
+#define GIO_USBC_UCSI_CCI_REG			0x20104
+#define GIO_USBC_UCSI_CCI_SIZE			4
+#define GIO_USBC_UCSI_CONTROL_REG		0x20108
+#define GIO_USBC_UCSI_CONTROL_SIZE		8
+#define GIO_USBC_UCSI_MESSAGE_IN_REG		0x20200
+#define GIO_USBC_UCSI_MESSAGE_IN_SIZE		64
+#define GIO_USBC_UCSI_MSGINX_REG		0x20240
+#define GIO_USBC_UCSI_MSGINX_SIZE		192
+#define GIO_USBC_UCSI_MESSAGE_OUT_REG		0x20300
+#define GIO_USBC_UCSI_MESSAGE_OUT_SIZE		64
+#define GIO_USBC_UCSI_MSGOUTX_ADDR		0x20340
+#define GIO_USBC_UCSI_MSGOUTX_SIZE		192
+#define GIO_USBC_UCSI_PAN_ADDR			0x20400
+#define GIO_USBC_UCSI_PAN_SIZE			64
+#define GIO_USBC_PAN_CMD_ADDR			0x20440
+#define GIO_USBC_PAN_CMD_SIZE			0x08
+#define GIO_USBC_RTMR_INFO_ADDR			0x20600
+#define GIO_USBC_RTMR_INFO_SIZE			64
+#define GIO_USBC_RTMR_FW_UPDATE_ADDR		0x20640
+#define GIO_USBC_RTMR_FW_UPDATE_SIZE		4
+#define GIO_USBC_USBCFG_ADDR			0x20700
+#define GIO_USBC_USBCFG_SIZE			4
+#define GIO_USBC_DAM_CTRL_ADDR			0x20708
+#define GIO_USBC_DAM_CTRL_SIZE			4
+#define GIO_USBC_DAM_CTRL_CFG_ADDR		0x2070c
+#define GIO_USBC_DAM_CTRL_CFG_SIZE		4
+
+/* SVC */
+#define GIO_SVC_IF_VERSION_ADDR			0x30000
+#define GIO_SVC_IF_VERSION_SIZE			4
+#define GIO_SVC_ALERT_STATUS_ADDR		0x30010
+#define GIO_SVC_ALERT_STATUS_SIZE		4
+#define GIO_SVC_LAST_ALERT_ADDR			0x30014
+#define GIO_SVC_LAST_ALERT_SIZE			20
+#define GIO_SVC_UEFI_ACTION_ADDR		0x30100
+#define GIO_SVC_UEFI_ACTION_SIZE		4
+#define GIO_SVC_POWER_OK_ADDR			0x30104
+#define GIO_SVC_POWER_OK_SIZE			4
+#define GIO_SVC_OOB_REQUEST_ACTION_ADDR		0x30110
+#define GIO_SVC_OOB_REQUEST_ACTION_SIZE		4
+#define GIO_SVC_OOB_RTCTMR_VOTE_ADDR		0x30114
+#define GIO_SVC_OOB_RTCTMR_VOTE_SIZE		8
+#define GIO_SVC_CLT0_REQUEST_ACTION_ADDR	0x30120
+#define GIO_SVC_CLT0_REQUEST_ACTION_SIZE	4
+#define GIO_SVC_CLT0_RTCTMR_VOTE_ADDR		0x30124
+#define GIO_SVC_CLT0_RTCTMR_VOTE_SIZE		8
+#define GIO_SVC_SYS_SET_POWER_STATE_ADDR	0x30150
+#define GIO_SVC_SYS_SET_POWER_STATE_SIZE	4
+#define GIO_SVC_TAD_RT_ADDR			0x30200
+#define GIO_SVC_TAD_RT_SIZE			16
+#define GIO_SVC_TAD_GWS_ADDR			0x30210
+#define GIO_SVC_TAD_GWS_SIZE			8
+#define GIO_SVC_TAD_CWS_ADDR			0x30218
+#define GIO_SVC_TAD_CWS_SIZE			4
+#define GIO_SVC_TAD_TPA_ADDR			0x3021c
+#define GIO_SVC_TAD_TPA_SIZE			4
+#define GIO_SVC_TAD_TPD_ADDR			0x30220
+#define GIO_SVC_TAD_TPD_SIZE			4
+#define GIO_SVC_TAD_TVA_ADDR			0x30224
+#define GIO_SVC_TAD_TVA_SIZE			4
+#define GIO_SVC_TAD_TVD_ADDR			0x30228
+#define GIO_SVC_TAD_TVD_SIZE			4
+#define GIO_SVC_LID_SETTING_ADDR		0x3022c
+#define GIO_SVC_LID_SETTING_SIZE		4
+
+/* SETTING */
+#define GIO_SETTING_IF_VERSION_ADDR		0x40000
+#define GIO_SETTING_IF_VERSION_SIZE		4
+#define GIO_SETTING_ALERT_STATUS_ADDR		0x40010
+#define GIO_SETTING_ALERT_STATUS_SIZE		4
+#define GIO_SETTING_LAST_ALERT_ADDR		0x40014
+#define GIO_SETTING_LAST_ALERT_SIZE		20
+#define GIO_SETTING_SYS_PWR_CFG_ADDR		0x40100
+#define GIO_SETTING_SYS_PWR_CFG_SIZE		4
+#define GIO_SETTING_BATT_AUTH_ADDR		0x40104
+#define GIO_SETTING_BATT_AUTH_SIZE		4
+#define GIO_SETTING_CHG_LIMIT_ADDR		0x40108
+#define GIO_SETTING_CHG_LIMIT_SIZE		4
+#define GIO_SETTING_BOOT_ADDR			0x4010c
+#define GIO_SETTING_BOOT_SIZE			4
+#define GIO_SETTING_USBC_ADDR			0x40110
+#define GIO_SETTING_USBC_SIZE			4
+#define GIO_SETTING_HOST_MAC_ADDR_ADDR		0x40114
+#define GIO_SETTING_HOST_MAC_ADDR_SIZE		8
+#define GIO_SETTING_AOU_ADDR			0x4011c
+#define GIO_SETTING_AOU_SIZE			4
+#define GIO_SETTING_PSM_ADDR			0x40120
+#define GIO_SETTING_PSM_SIZE			4
+#define GIO_SETTING_USB_WAKE_ON_LAN_ADDR	0x40124
+#define GIO_SETTING_USB_WAKE_ON_LAN_SIZE	4
+#define GIO_SETTING_EPM_USBC_ADDR		0x40128
+#define GIO_SETTING_EPM_USBC_SIZE		4
+#define GIO_SETTING_OFFMODE_SHIPMODE_ADDR	0x4012c
+#define GIO_SETTING_OFFMODE_SHIPMODE_SIZE	4
+#define GIO_SETTING_RTC_TIMER_FOR_EOC_ADDR	0x40130
+#define GIO_SETTING_RTC_TIMER_FOR_EOC_SIZE	4
+#define GIO_SETTING_INTL_CHG_ADDR		0x40134
+#define GIO_SETTING_INTL_CHG_SIZE		32
+#define GIO_SETTING_CMD_ADDR			0x40800
+#define GIO_SETTING_CMD_SIZE			4
+
+/* DBG */
+#define GIO_DBG_IF_VERSION_ADDR			0x70000
+#define GIO_DBG_IF_VERSION_SIZE			4
+#define GIO_DBG_ALERT_STATUS_ADDR		0x70010
+#define GIO_DBG_ALERT_STATUS_SIZE		4
+#define GIO_DBG_LAST_ALERT_ADDR			0x70014
+#define GIO_DBG_LAST_ALERT_SIZE			20
+#define GIO_DBG_BCLIBAT_ADDR			0x70100
+#define GIO_DBG_BCLIBAT_SIZE			8
+#define GIO_DBG_BCLVBAT_ADDR			0x70110
+#define GIO_DBG_BCLVBAT_SIZE			12
+#define GIO_DBG_BCLIBAT_DGL_TIMER_ADDR		0x70120
+#define GIO_DBG_BCLIBAT_DGL_TIMER_SIZE		12
+#define GIO_DBG_BCLVBAT_DGL_TIMER_ADDR		0x70130
+#define GIO_DBG_BCLVBAT_DGL_TIMER_SIZE		12
+#define GIO_DBG_BCL_CLR_TIMER_ADDR		0x70140
+#define GIO_DBG_BCL_CLR_TIMER_SIZE		12
+#define GIO_DBG_CHG_DIE_TEMP_TH_ADDR		0x70150
+#define GIO_DBG_CHG_DIE_TEMP_TH_SIZE		4
+#define GIO_DBG_CHG_CONN_TEMP_TH_ADDR		0x70154
+#define GIO_DBG_CHG_CONN_TEMP_TH_SIZE		4
+#define GIO_DBG_SPMI_WRITE_ADDR			0x70160
+#define GIO_DBG_SPMI_WRITE_SIZE			8
+#define GIO_DBG_LOG_LEVEL_ADDR			0x70170
+#define GIO_DBG_LOG_LEVEL_SIZE			4
+#define GIO_DBG_LOG_CAT_ADDR			0x70174
+#define GIO_DBG_LOG_CAT_SIZE			8
+
+/* OEM */
+#define GIO_OEM_IF_VERSION_ADDR			0xc0000
+#define GIO_OEM_IF_VERSION_SIZE			4
+#define GIO_OEM_ALERT_STATUS_ADDR		0xc0010
+#define GIO_OEM_ALERT_STATUS_SIZE		4
+#define GIO_OEM_LAST_ALERT_ADDR			0xc0014
+#define GIO_OEM_LAST_ALERT_SIZE			20
+#define GIO_OEM_OP_RW_ADDR			0xc0100
+#define GIO_OEM_OP_RW_SIZE			64
+#define GIO_OEM_I2C_PROXY_CONFIG_ADDR		0xc0200
+#define GIO_OEM_I2C_PROXY_CONFIG_SIZE		4
+#define GIO_OEM_I2C_PROXY_DATA_ADDR		0xc0204
+#define GIO_OEM_I2C_PROXY_DATA_SIZE		72
+
+#define GIO_MAX_REG_ADDR			0xcffff
+
+#endif

-- 
2.43.0

