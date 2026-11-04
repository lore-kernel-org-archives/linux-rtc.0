Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775952;
	b=iThUvWyKR1gW5vhxaxEt+SrQOSeFfvLuIaW4571N61h9cRJRfvRyb8rBFz6eOyWgee7K
	 2z0FwLX73nY5LVqp93vqpXwc4vhRqq9454wtG6tTAa175f4fuVKSoJtohWu0lu3UX9m8F
	 bnuuOFTScfAnokyhstKZ1RMV8F6+bcZYtYsj5ynt79HvF5OW8HagcuBTRH/JGLVfgGasD
	 PrqymQmm6QVWPhGi4pYwirv1L2ReFnwVpjYJUm8ea2w0DdDWC4AoQXuu2dQwh1W5Hgpu8
	 VFSZmXbDCLeq+ucwbHzVHL2MsGwOCUsaeJxaL9Nvq3NO6Yar4YtH5e/7/CDMMWLUSEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775952;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H/x9AMTxuCkroonzpnjEsDSzesjiwKlA3PgsVxhWzNc=;
	b=UIrhPDsFguKvnYWKgM1uJMKJT80HuPFZp+IGo4iIh85FaOCJEs1hwEmHYBRQAB7EzW9L
	 +83hQzntdjVFFZsIExFmYrHhTT4dEPjJs3cjl2iBfAozV799K9S76ucAWaEuluT8DvTwa
	 kJPNhBivv9NH3F5jsWWsjRR1mPBY6cdLYIiIJlNhegROPTFrnAM97tVY48hBxNxWmINGZ
	 4AD0uB/MmvtVLM3uWZynaMRWpRWasQmmS0C8HuXmPAf4Ar3ci6x6AW4gJ8V7OW8N0T7t8
	 PdrLPGYm4EztzHbokM3nPEbNAbyqG40hF8xbSVe6g5AbrmXaDXp/n9CX5UYpJIzPo0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=uN+ESb8V;
	arc=none smtp.remote-ip=91.218.175.130
Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1745606A32E
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1745606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=uN+ESb8V
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q+f1c7KDiOJHvORS3s+IHqJ8g38eLG6+y05ihOaWhpM=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793775949; v=1; x=1794380749;
 b=uN+ESb8VgEloGXh/ZOO6SJHMWxNLbNN4tYGGYKtiXIETAWjSIEUpj+JhOIr6AUHrjuSdkKSF
 Lxc8rt7nQb5025sfr9PNnVTh77VPJKrqdfNBGgQjIsAF9238lHY5KskAhVcpqVkeqdGStJiCZor
 8j7sC1vR1PDjLb5uIoPp+HRZLYzCbhHr/uA3itBU4YcpKaHI9xlj/eOe4Jg59bgK83uo79WXvar
 9lYUynwyb35v3z5TJZRT3DN+0j0MaBHyAGhE76RctIeZ8sGlBjgAXfMLyCLU90gD5/FtxDydK1r
 MO1bvisiNt1WAW65Yctprlh6sjaYdtrHUBWQNyA+3fOiA==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b585b5fb8e6dfa8b;
	Wed, 04 Nov 2026 07:05:49 +0000
X-Mizu-Trace-ID: b585b5fb8e6dfa8b
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Val Packett <val@packett.cool>
Subject: [PATCH 2/5] arm64: dts: qcom: sc8180x: Add Microsoft Surface Pro X
Date: Wed,  4 Nov 2026 04:04:33 -0300
Message-ID: <20261104070441.74127-3-val@packett.cool>
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

Introduce a device tree for the Surface Pro X tablet in all 3 variants
(SQ1 with cellular, SQ1 Wi-Fi only, SQ2 with cellular).

Currently working:

* Display, backlight (eDP panel)
* USB 2.0
* Wi-Fi and Bluetooth (WCN3998)
* NVMe on PCIe2
* Embedded controller (Surface SAM over UART)
* All remoteprocs (ADSP, CDSP, MPSS, SLPI)
* Volume and power buttons

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
---
 arch/arm64/boot/dts/qcom/Makefile             |   3 +
 .../dts/qcom/sc8180x-microsoft-cambria.dts    |  38 +
 .../dts/qcom/sc8180x-microsoft-carina.dts     |  50 +
 .../dts/qcom/sc8180x-microsoft-caspar.dts     |  38 +
 .../qcom/sc8180x-microsoft-surface-pro-x.dtsi | 853 ++++++++++++++++++
 5 files changed, 982 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-cambria.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-caspar.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d6e440cd252b..dcaf74dc876b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -324,6 +324,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-microsoft-cambria.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-microsoft-carina.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-microsoft-caspar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
 sc8280xp-crd-el2-dtbs	:= sc8280xp-crd.dtb sc8280xp-el2.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb sc8280xp-crd-el2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-cambria.dts b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-cambria.dts
new file mode 100644
index 000000000000..fcf7e49b3ae4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-cambria.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include "sc8180x-microsoft-surface-pro-x.dtsi"
+
+/ {
+	model = "Microsoft Surface Pro X (SQ1)";
+	compatible = "microsoft,cambria", "qcom,sc8180x";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sc8180x/microsoft/cambria/qcdxkmsuc8180.mbn";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sc8180x/microsoft/cambria/qcadsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sc8180x/microsoft/cambria/qccdsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sc8180x/microsoft/cambria/qcmpss8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_slpi {
+	firmware-name = "qcom/sc8180x/microsoft/cambria/qcslpi8180.mbn";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
new file mode 100644
index 000000000000..5d155c69907a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-carina.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include "sc8180x-microsoft-surface-pro-x.dtsi"
+
+/ {
+	model = "Microsoft Surface Pro X (SQ2)";
+	compatible = "microsoft,carina", "qcom,sc8180x";
+};
+
+&cpu4_opp_table {
+	opp-3072000000 {
+		opp-hz = /bits/ 64 <3072000000>;
+		opp-peak-kBps = <8368000 51609600>;
+	};
+
+	opp-3148800000 {
+		opp-hz = /bits/ 64 <3148800000>;
+		opp-peak-kBps = <8368000 51609600>;
+	};
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sc8180x/microsoft/carina/qcdxkmsuc8180.mbn";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sc8180x/microsoft/carina/qcadsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sc8180x/microsoft/carina/qccdsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sc8180x/microsoft/carina/qcmpss8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_slpi {
+	firmware-name = "qcom/sc8180x/microsoft/carina/qcslpi8180.mbn";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-caspar.dts b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-caspar.dts
new file mode 100644
index 000000000000..df42020ff81a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-caspar.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include "sc8180x-microsoft-surface-pro-x.dtsi"
+
+/ {
+	model = "Microsoft Surface Pro X (Wi-Fi)";
+	compatible = "microsoft,caspar", "qcom,sc8180x";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sc8180x/microsoft/caspar/qcdxkmsuc8180.mbn";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sc8180x/microsoft/caspar/qcadsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sc8180x/microsoft/caspar/qccdsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sc8180x/microsoft/caspar/qcmpss8180_nm.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_slpi {
+	firmware-name = "qcom/sc8180x/microsoft/caspar/qcslpi8180.mbn";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
new file mode 100644
index 000000000000..17fb01c6b164
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
@@ -0,0 +1,853 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Based on:
+ % - sc8180x-primus.dts
+ % - sc8180x-lenovo-flex-5g.dts
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include "sc8180x.dtsi"
+#include "sc8180x-pmics.dtsi"
+
+/delete-node/ &gpu_mem;
+
+/ {
+	chassis-type = "tablet";
+
+	aliases {
+		serial0 = &uart13;
+		serial1 = &uart15;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		pwms = <&pmc8180c_lpg 4 5000000>;
+		enable-gpios = <&pmc8180_2_gpios 1 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_pwm_default_state &bl_en_default_state>;
+	};
+
+	gpio-keys-volume {
+		compatible = "gpio-keys";
+		label = "Volume Buttons";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_down_gpio &volume_up_gpio>;
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&pmc8180_1_gpios 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&pmc8180_1_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	chosen {
+	};
+
+	reserved-memory {
+		rmtfs_mem: memory@85500000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x85500000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		wlan_mem: memory@8bc00000 {
+			reg = <0x0 0x8bc00000 0x0 0x180000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8d800000 { /* non-relocatable */
+			reg = <0x0 0x8d800000 0x0 0x9600000>;
+			no-map;
+		};
+
+		adsp_mem: memory@96e00000 {
+			reg = <0x0 0x96e00000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@98a00000 {
+			reg = <0x0 0x98a00000 0x0 0x800000>;
+			no-map;
+		};
+
+		slpi_mem: memory@99200000 {
+			reg = <0x0 0x99200000 0x0 0x1400000>;
+			no-map;
+		};
+
+		venus_mem: memory@9a600000 {
+			reg = <0x0 0x9a600000 0x0 0x500000>;
+			no-map;
+		};
+
+		gfxsuc_mem: memory@9ab00000 {
+			reg = <0x0 0x9ab00000 0x0 0x5000>;
+			no-map;
+		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	thermal-zones {
+		pmc8180a-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmc8180_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		pmc8180c-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmc8180c_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		pmc8180e-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmc8180e_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_s4a_1p8: pm8150-s4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	pmc8180-a-rpmh-regulators {
+		compatible = "qcom,pmc8180-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6c_1p37>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s7c_0p96>;
+		vdd-l6-l9-supply = <&vreg_s6c_1p37>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s5a_2p04: smps5 {
+			regulator-min-microvolt = <2040000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a_1p3: ldo9 {
+			regulator-min-microvolt = <1296000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmc8180-e-rpmh-regulators {
+		compatible = "qcom,pmc8180-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s4e_0p99>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s4e_0p99>;
+		vdd-l6-l9-supply = <&vreg_s4e_0p99>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5e_2p04>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s4e_0p99: smps4 {
+			regulator-min-microvolt = <992000>;
+			regulator-max-microvolt = <992000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5e_2p04: smps5 {
+			regulator-min-microvolt = <2040000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1e_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5e_0p88: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9e_0p88: ldo9 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16e_3p1: ldo16 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmc8180c-rpmh-regulators {
+		compatible = "qcom,pmc8180c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s6c_1p37>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_s6c_1p37: smps6 {
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1372000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s7c_0p96: smps7 {
+			regulator-min-microvolt = <960000>;
+			regulator-max-microvolt = <960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3350000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&dispcc {
+	status = "okay";
+};
+
+&gcc {
+	protected-clocks = <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+};
+
+&smb2351_2 {
+	status = "disabled";
+};
+
+&smb2351_a {
+	status = "disabled";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <47 4>;
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-n-pins {
+			pins = "gpio176";
+			function = "pci_e2";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio102";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio104";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	uart13_state: uart13-state {
+		cts {
+			pins = "gpio43";
+			function = "qup13";
+			bias-pull-down;
+		};
+
+		rts-tx {
+			pins = "gpio44", "gpio45";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx {
+			pins = "gpio46";
+			function = "qup13";
+			bias-pull-up;
+		};
+	};
+
+	uart15_state: uart15-state {
+		cts {
+			pins = "gpio27";
+			function = "qup15";
+			bias-pull-down;
+		};
+
+		rts-tx {
+			pins = "gpio28", "gpio29";
+			function = "qup15";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx {
+			pins = "gpio30";
+			function = "qup15";
+			bias-pull-up;
+		};
+	};
+
+	ssam_state: ssam-state {
+		wake-int {
+			pins = "gpio180";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	panel_vdd_en_default_state: panel-vdd-en-default-state {
+		pins = "gpio130";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	edp_hpd_active: epd-hpd-active-state {
+		pins = "gpio10";
+		function = "edp_hot";
+	};
+};
+
+&pmc8180_1_gpios {
+	volume_down_gpio: pmc8180a_gpio1 {
+		pins = "gpio1";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <0>;
+	};
+
+	volume_up_gpio: pmc8180a_gpio6 {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <0>;
+	};
+};
+
+&pmc8180_2 {
+	pmc8180e_temp: temp-alarm@2400 {
+		compatible = "qcom,spmi-temp-alarm";
+		reg = <0x2400>;
+		interrupts = <0x8 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+		io-channels = <&pmc8180e_adc ADC5_DIE_TEMP>;
+		io-channel-names = "thermal";
+		#thermal-sensor-cells = <0>;
+	};
+
+	pmc8180e_adc: adc@3100 {
+		compatible = "qcom,spmi-adc5";
+		reg = <0x3100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#io-channel-cells = <1>;
+		interrupts = <0x8 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+		ref-gnd@0 {
+			reg = <ADC5_REF_GND>;
+			qcom,pre-scaling = <1 1>;
+			label = "ref_gnd";
+		};
+
+		vref-1p25@1 {
+			reg = <ADC5_1P25VREF>;
+			qcom,pre-scaling = <1 1>;
+			label = "vref_1p25";
+		};
+
+		die-temp@6 {
+			reg = <ADC5_DIE_TEMP>;
+			qcom,pre-scaling = <1 1>;
+			label = "die_temp";
+		};
+	};
+};
+
+&pmc8180_adc {
+	xo-therm@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,pre-scaling = <1 1>;
+		qcom,hw-settle-time = <200>;
+		label = "xo_therm";
+	};
+
+	vph-pwr@83 {
+		reg = <ADC5_VPH_PWR>;
+		qcom,pre-scaling = <1 3>;
+		label = "vph_pwr";
+	};
+
+	vcoin@85 {
+		reg = <ADC5_VCOIN>;
+		qcom,pre-scaling = <1 3>;
+		label = "vcoin";
+	};
+};
+
+&pmc8180_pwrkey {
+	status = "okay";
+};
+
+&pmc8180c_gpios {
+	bl_pwm_default_state: bl-pwm-default-state {
+		pins = "gpio10";
+		function = "func1";
+	};
+};
+
+&pmc8180c_lpg {
+	status = "okay";
+};
+
+&pmc8180_2_gpios {
+	bl_en_default_state: bl-pwm-default-state {
+		pins = "gpio1";
+		function = "normal";
+	};
+};
+
+&spmi_bus {
+	pmc8180e_1: pmic@9 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x9 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	memory-region = <&gfxsuc_mem>;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_edp {
+	pinctrl-0 = <&edp_hpd_active>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			enable-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
+			no-hpd;
+
+			pinctrl-0 = <&panel_vdd_en_default_state>;
+			pinctrl-names = "default";
+
+			backlight = <&backlight>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss_edp_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_edp_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&edp_phy {
+	vdda-pll-supply = <&vreg_l5e_0p88>;
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+};
+
+&usb_prim_hsphy {
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l16e_3p1>;
+
+	status = "okay";
+};
+
+&usb_prim_qmpphy {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_prim {
+	status = "okay";
+};
+
+&usb_prim_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_sec_hsphy {
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l16e_3p1>;
+
+	status = "okay";
+};
+
+&usb_sec_qmpphy {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_sec {
+	status = "okay";
+};
+
+&usb_sec_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_mp_hsphy0 {
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l16e_3p1>;
+
+	status = "okay";
+};
+
+&usb_mp_hsphy1 {
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l16e_3p1>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l9e_0p88>;
+
+	status = "okay";
+};
+
+&usb_mp {
+	status = "okay";
+};
+
+&usb_mp_dwc3 {
+	dr_mode = "host";
+};
+
+&pcie2 {
+	// XXX: pcie1 and pcie2 are multi'd together, for now use just one
+	num-lanes = <2>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	// HACK: Remove "global" interrupt
+	interrupts = <GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi0",
+			  "msi1",
+			  "msi2",
+			  "msi3",
+			  "msi4",
+			  "msi5",
+			  "msi6",
+			  "msi7";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5e_0p88>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+
+	status = "okay";
+};
+
+&pcie2_phy {
+	vdda-phy-supply = <&vreg_l5e_0p88>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+
+	status = "okay";
+};
+
+&pcie2_port0 {
+	reset-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 104 GPIO_ACTIVE_LOW>;
+};
+
+&remoteproc_adsp {
+	memory-region = <&adsp_mem>;
+};
+
+&remoteproc_cdsp {
+	memory-region = <&cdsp_mem>;
+};
+
+&remoteproc_mpss {
+	memory-region = <&mpss_mem>;
+};
+
+&remoteproc_slpi {
+	memory-region = <&slpi_mem>;
+};
+
+&uart13 {
+	pinctrl-0 = <&uart13_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3998-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l9a_1p3>;
+		vddch0-supply = <&vreg_l11c_3p3>;
+
+		max-speed = <3200000>;
+	};
+};
+
+&uart15 {
+	pinctrl-0 = <&uart15_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	embedded-controller {
+		compatible = "microsoft,surface-sam";
+
+		interrupts-extended = <&tlmm 180 IRQ_TYPE_EDGE_RISING>;
+
+		current-speed = <4000000>;
+
+		pinctrl-0 = <&ssam_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&wifi {
+	memory-region = <&wlan_mem>;
+
+	vdd-0.8-cx-mx-supply = <&vreg_l1e_0p75>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l9a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l10c_3p3>;
+
+	status = "okay";
+};
-- 
2.56.0

