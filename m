Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775965;
	b=fw4pYXFkmle1Cau2qTkFEXl9vt7q5vQmNO7vn8zxjqdg9lUCB9+ynHO21pXo/m+uYJ84
	 Wte5nkiMg/3TA0efh+QP4ucQUX+DTfR4QcRogcWpCjbAIbS4+CB0d4Dz/X7YB2d37vFuu
	 aktp4MOKpqxJLiowWsP2SZR6umkkfM6krArf+z3t7KloWlPmB0m/OGZ0F8Rm/IbhYcAwD
	 CBz5mWKyCucy0n0MJhsm/vuGuHtCA5/Aw6OVQGDTVRC2DYynuhk3vxrbbIeedYJxtIbWA
	 lYFIMqoqYrcS9HjWBzf8c/rbNC2BEjQNdf62KiDvbcwt2ypmVGARWjESWOFiyVKxdtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775965;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O4s+EhwbikmitcBwtvaK2nWWDlS5IjTnGOVxRj5axnA=;
	b=Pasa1Mq5eQy9AdgQzu0V2wTDnuIRuC2rdb0d4w5WLSFcEKQkwe6btzGVpcNX76X+q5Q6
	 2ol5PwjbYVHveA0ojZ02joLWcKFVg3Tm6a55dg7LNSl9nmBR+RpTdkF84sbhjEZyf24sx
	 goHeNc8m7NVWMHk1cSJ5h/J1mtNOpqQhwE7vAzw+hFP6puQ/5GrcB/t6AZYAU/OJZgLBL
	 93+6fHyHya3KetIAaXRedRb9GLmMiLQQMKjdWiPg8T64CEgr5MsWMrypYEOlGAlp/R0qD
	 2es5PHS1q4QuESljHxUtFkOLPcMEsfa+fOyox3wiA9P4DPY5C5zXCCeNHN6dESlZj/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=hOe5EEux;
	arc=none smtp.remote-ip=95.215.58.117
Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A38606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=hOe5EEux
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CQru9P9q47Kx5STBo5ffycljRxiD1FuZ+bafX8rql98=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793775962; v=1; x=1794380762;
 b=hOe5EEuxpDGR+sbI8uD0i5VZCQYfjo//oicy4SiJ4iIy7iyWHrU1n3cVUtBQ+ZreHyYMfEiP
 MrCGpb44d5LsIOOOqPd9/1zI5OPUWWsnX4YgXE5cy7kru+KlNQIOdtixJWHx058oCOrVk/DwRkc
 OwXy66CWsrL8m/K4Zd8egt0xsGrVocC1Xttzem2e4uzMZja6SyV2eiBsysFPKGf5Kq9ceJspW0p
 11ZUM+qlAi1ge5dqq1xsVWkovDaoldevRIoHw8cIwERyiamZ6LxtlPQssV493F7iwliBrKmU6UV
 9CEhtLDbtUix6Pl+fAmLabEuv//04iz9C9YrWN4wStv4Q==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 94ca4bed4724cb0d;
	Wed, 04 Nov 2026 07:06:02 +0000
X-Mizu-Trace-ID: 94ca4bed4724cb0d
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Val Packett <val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 4/5] rtc: Add basic support for RTC via Surface System Aggregator Module
Date: Wed,  4 Nov 2026 04:04:35 -0300
Message-ID: <20261104070441.74127-5-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104070441.74127-1-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maximilian Luz <luzmaximilian@gmail.com>

The Surface Pro X uses an RTC provided by the SSAM. Add a driver for it.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
---
 MAINTAINERS               |   8 +++
 drivers/rtc/Kconfig       |   9 +++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-surface.c | 129 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/rtc/rtc-surface.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d23f7d8c4c17..36b3abad50f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18585,6 +18585,14 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/surface/surfacepro3_button.c
 
+MICROSOFT SURFACE PRO X RTC DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+M:	Val Packett <val@packett.cool>
+L:	linux-rtc@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/rtc/rtc-surface.c
+
 MICROSOFT SURFACE SYSTEM AGGREGATOR HUB DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230edfd..6af1aa18724f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1451,6 +1451,15 @@ config RTC_DRV_NTXEC
 	  embedded controller found in certain e-book readers designed by the
 	  original design manufacturer Netronix.
 
+config RTC_DRV_SURFACE
+	tristate "Microsoft Surface Aggregator RTC"
+	depends on SURFACE_AGGREGATOR
+	depends on SURFACE_AGGREGATOR_BUS
+	help
+	  Say yes here if you want to support the RTC functionality of the
+	  Surface Aggregator Module (embedded controller) found in the
+	  Microsoft Surface Pro X tablet.
+
 comment "on-CPU RTC drivers"
 
 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 46f1a0fc2416..f86e827c14e0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -186,6 +186,7 @@ obj-$(CONFIG_RTC_DRV_SUN4V)	+= rtc-sun4v.o
 obj-$(CONFIG_RTC_DRV_SUN6I)	+= rtc-sun6i.o
 obj-$(CONFIG_RTC_DRV_SUNPLUS)	+= rtc-sunplus.o
 obj-$(CONFIG_RTC_DRV_SUNXI)	+= rtc-sunxi.o
+obj-$(CONFIG_RTC_DRV_SURFACE)	+= rtc-surface.o
 obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
diff --git a/drivers/rtc/rtc-surface.c b/drivers/rtc/rtc-surface.c
new file mode 100644
index 000000000000..f6c17c4e98d5
--- /dev/null
+++ b/drivers/rtc/rtc-surface.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AC driver for 7th-generation Microsoft Surface devices via Surface System
+ * Aggregator Module (SSAM).
+ *
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/device.h>
+
+struct surface_rtc {
+	struct ssam_device *sdev;
+	struct rtc_device *rtc;
+};
+
+SSAM_DEFINE_SYNC_REQUEST_R(__ssam_rtc_get_unix_time, __le32, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = SSAM_SSH_TID_SAM,
+	.instance_id     = 0x00,
+	.command_id      = 0x10,
+});
+
+SSAM_DEFINE_SYNC_REQUEST_W(__ssam_rtc_set_unix_time, __le32, {
+	.target_category = SSAM_SSH_TC_SAM,
+	.target_id       = SSAM_SSH_TID_SAM,
+	.instance_id     = 0x00,
+	.command_id      = 0x0f,
+});
+
+static int ssam_rtc_get_unix_time(struct surface_rtc *srtc, u32 *time)
+{
+	__le32 time_le;
+	int status;
+
+	status = __ssam_rtc_get_unix_time(srtc->sdev->ctrl, &time_le);
+	if (status)
+		return status;
+
+	*time = le32_to_cpu(time_le);
+	return 0;
+}
+
+static int ssam_rtc_set_unix_time(struct surface_rtc *srtc, u32 time)
+{
+	__le32 time_le = cpu_to_le32(time);
+
+	return __ssam_rtc_set_unix_time(srtc->sdev->ctrl, &time_le);
+}
+
+static int surface_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct surface_rtc *srtc = dev_get_drvdata(dev);
+	int status;
+	u32 time;
+
+	status = ssam_rtc_get_unix_time(srtc, &time);
+	if (status)
+		return status;
+
+	rtc_time64_to_tm(time, tm);
+	return 0;
+}
+
+static int surface_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct surface_rtc *srtc = dev_get_drvdata(dev);
+	time64_t time = rtc_tm_to_time64(tm);
+
+	return ssam_rtc_set_unix_time(srtc, (u32)time);
+}
+
+static const struct rtc_class_ops surface_rtc_ops = {
+	.read_time = surface_rtc_read_time,
+	.set_time = surface_rtc_set_time,
+};
+
+static int surface_rtc_probe(struct ssam_device *sdev)
+{
+	struct surface_rtc *srtc;
+
+	srtc = devm_kzalloc(&sdev->dev, sizeof(*srtc), GFP_KERNEL);
+	if (!srtc)
+		return -ENOMEM;
+
+	srtc->sdev = sdev;
+
+	srtc->rtc = devm_rtc_allocate_device(&sdev->dev);
+	if (IS_ERR(srtc->rtc))
+		return PTR_ERR(srtc->rtc);
+
+	srtc->rtc->ops = &surface_rtc_ops;
+	srtc->rtc->range_max = U32_MAX;
+
+	ssam_device_set_drvdata(sdev, srtc);
+
+	return devm_rtc_register_device(srtc->rtc);
+}
+
+static void surface_rtc_remove(struct ssam_device *sdev)
+{
+	/* Device-managed allocations take care of everything... */
+}
+
+static const struct ssam_device_id surface_rtc_match[] = {
+	{ SSAM_SDEV(SAM, SAM, 0x00, 0x00) },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, surface_rtc_match);
+
+static struct ssam_device_driver surface_rtc_driver = {
+	.probe = surface_rtc_probe,
+	.remove = surface_rtc_remove,
+	.match_table = surface_rtc_match,
+	.driver = {
+		.name = "surface_rtc",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(surface_rtc_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("RTC driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.56.0

