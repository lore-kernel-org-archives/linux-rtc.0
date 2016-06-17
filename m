Return-Path: <rtc-linux+bncBDAYD2P3QYGRBWU6R65QKGQE3FNURII@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id a6si637962wma.1.2016.06.17.03.22.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2016 03:22:18 -0700 (PDT)
Received: by mail-wm0-x22a.google.com with SMTP id m124so105918525wme.1
        for <rtc-linux@googlegroups.com>; Fri, 17 Jun 2016 03:22:18 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: dmitry.torokhov@gmail.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	lee.jones@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 4/5] mfd: qcom-rpm: Add support for pm8018 RPM Regulator
Date: Fri, 17 Jun 2016 12:22:08 +0200
Message-Id: <1466158929-19524-5-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In order to support the Qualcomm MDM9615 SoC, add support for the
RPM regulator entries in the qcom-rpm driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  1 +
 drivers/mfd/qcom_rpm.c                             | 45 ++++++++++++++++++++++
 include/dt-bindings/mfd/qcom-rpm.h                 | 23 +++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index b98b291..72d68d4 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -13,6 +13,7 @@ frequencies.
 		    "qcom,rpm-msm8660"
 		    "qcom,rpm-msm8960"
 		    "qcom,rpm-ipq8064"
+		    "qcom,rpm-mdm9615"
 
 - reg:
 	Usage: required
diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 1be47ad..81d78fb 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -364,11 +364,56 @@ static const struct qcom_rpm_data ipq806x_template = {
 	.n_resources = ARRAY_SIZE(ipq806x_rpm_resource_table),
 };
 
+static const struct qcom_rpm_resource mdm9615_rpm_resource_table[] = {
+	[QCOM_RPM_CXO_CLK] =			{ 25, 9, 5, 1 },
+	[QCOM_RPM_SYS_FABRIC_CLK] =		{ 26, 10, 9, 1 },
+	[QCOM_RPM_DAYTONA_FABRIC_CLK] =		{ 27, 11, 11, 1 },
+	[QCOM_RPM_SFPB_CLK] =			{ 28, 12, 12, 1 },
+	[QCOM_RPM_CFPB_CLK] =			{ 29, 13, 13, 1 },
+	[QCOM_RPM_EBI1_CLK] =			{ 30, 14, 16, 1 },
+	[QCOM_RPM_APPS_FABRIC_HALT] =		{ 31, 15, 22, 2 },
+	[QCOM_RPM_APPS_FABRIC_MODE] =		{ 33, 16, 23, 3 },
+	[QCOM_RPM_APPS_FABRIC_IOCTL] =		{ 36, 17, 24, 1 },
+	[QCOM_RPM_APPS_FABRIC_ARB] =		{ 37, 18, 25, 27 },
+	[QCOM_RPM_PM8018_SMPS1] =		{ 64, 19, 30, 2 },
+	[QCOM_RPM_PM8018_SMPS2] =		{ 66, 21, 31, 2 },
+	[QCOM_RPM_PM8018_SMPS3] =		{ 68, 23, 32, 2 },
+	[QCOM_RPM_PM8018_SMPS4] =		{ 70, 25, 33, 2 },
+	[QCOM_RPM_PM8018_SMPS5] =		{ 72, 27, 34, 2 },
+	[QCOM_RPM_PM8018_LDO1] =		{ 74, 29, 35, 2 },
+	[QCOM_RPM_PM8018_LDO2] =		{ 76, 31, 36, 2 },
+	[QCOM_RPM_PM8018_LDO3] =		{ 78, 33, 37, 2 },
+	[QCOM_RPM_PM8018_LDO4] =		{ 80, 35, 38, 2 },
+	[QCOM_RPM_PM8018_LDO5] =		{ 82, 37, 39, 2 },
+	[QCOM_RPM_PM8018_LDO6] =		{ 84, 39, 40, 2 },
+	[QCOM_RPM_PM8018_LDO7] =		{ 86, 41, 41, 2 },
+	[QCOM_RPM_PM8018_LDO8] =		{ 88, 43, 42, 2 },
+	[QCOM_RPM_PM8018_LDO9] =		{ 90, 45, 43, 2 },
+	[QCOM_RPM_PM8018_LDO10] =		{ 92, 47, 44, 2 },
+	[QCOM_RPM_PM8018_LDO11] =		{ 94, 49, 45, 2 },
+	[QCOM_RPM_PM8018_LDO12] =		{ 96, 51, 46, 2 },
+	[QCOM_RPM_PM8018_LDO13] =		{ 98, 53, 47, 2 },
+	[QCOM_RPM_PM8018_LDO14] =		{ 100, 55, 48, 2 },
+	[QCOM_RPM_PM8018_LVS1] =		{ 102, 57, 49, 1 },
+	[QCOM_RPM_NCP] =			{ 103, 58, 80, 2 },
+	[QCOM_RPM_CXO_BUFFERS] =		{ 105, 60, 81, 1 },
+	[QCOM_RPM_USB_OTG_SWITCH] =		{ 106, 61, 82, 1 },
+	[QCOM_RPM_HDMI_SWITCH] =		{ 107, 62, 83, 1 },
+	[QCOM_RPM_VOLTAGE_CORNER] =		{ 109, 64, 87, 1 },
+};
+
+static const struct qcom_rpm_data mdm9615_template = {
+	.version = 3,
+	.resource_table = mdm9615_rpm_resource_table,
+	.n_resources = ARRAY_SIZE(mdm9615_rpm_resource_table),
+};
+
 static const struct of_device_id qcom_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-apq8064", .data = &apq8064_template },
 	{ .compatible = "qcom,rpm-msm8660", .data = &msm8660_template },
 	{ .compatible = "qcom,rpm-msm8960", .data = &msm8960_template },
 	{ .compatible = "qcom,rpm-ipq8064", .data = &ipq806x_template },
+	{ .compatible = "qcom,rpm-mdm9615", .data = &mdm9615_template },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_rpm_of_match);
diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd/qcom-rpm.h
index 13a9d4b..db85912 100644
--- a/include/dt-bindings/mfd/qcom-rpm.h
+++ b/include/dt-bindings/mfd/qcom-rpm.h
@@ -148,6 +148,29 @@
 #define QCOM_RPM_SMB208_S2a			138
 #define QCOM_RPM_SMB208_S2b			139
 
+#define QCOM_RPM_PM8018_SMPS1			200
+#define QCOM_RPM_PM8018_SMPS2			201
+#define QCOM_RPM_PM8018_SMPS3			202
+#define QCOM_RPM_PM8018_SMPS4			203
+#define QCOM_RPM_PM8018_SMPS5			204
+#define QCOM_RPM_PM8018_LDO1			205
+#define QCOM_RPM_PM8018_LDO2			206
+#define QCOM_RPM_PM8018_LDO3			207
+#define QCOM_RPM_PM8018_LDO4			208
+#define QCOM_RPM_PM8018_LDO5			209
+#define QCOM_RPM_PM8018_LDO6			210
+#define QCOM_RPM_PM8018_LDO7			211
+#define QCOM_RPM_PM8018_LDO8			212
+#define QCOM_RPM_PM8018_LDO9			213
+#define QCOM_RPM_PM8018_LDO10			214
+#define QCOM_RPM_PM8018_LDO11			215
+#define QCOM_RPM_PM8018_LDO12			216
+#define QCOM_RPM_PM8018_LDO13			217
+#define QCOM_RPM_PM8018_LDO14			218
+#define QCOM_RPM_PM8018_LVS1			219
+#define QCOM_RPM_NCP				220
+#define QCOM_RPM_VOLTAGE_CORNER			221
+
 /*
  * Constants used to select force mode for regulators.
  */
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
