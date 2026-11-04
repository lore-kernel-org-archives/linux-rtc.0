Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776942;
	b=Uud7tnMW8HgMfQCQ8i4fGxl4sxDsk97LH/6j8HpGONL86tVheSzSu+A0c6TRoJO4643G
	 AM5O1RY3udX3TghpgIz/qQM6e05U+0/YsT7h2p+12kCk0i/BtaXGdoQEmzJw/l/SZ+jGw
	 moPMzC2nZawpvcul7HHlwO81RTomghxrE35pYWkAT2pb5XnohauTtOyoyIXNwKC1Gz0mI
	 FKXUYDmL515gZtMxbdfc9enRwiMVNmCSzjs4CtC48jjECAnikgi5ViAc/3VDT4eGMMCm1
	 gRn9v9eXwz0YdUObbX8cm+1/4W3JZe1NXXf+VsZku+RnYIJWdKVWqLhd6oXkTc6zfrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z/+9leIVb/2PzxEAQcuH4PKWNspk64wC1k5hc509Agg=;
	b=znZXgXvfacZNGDFKKoaP4HmowOy6uWtJvUAt1uPUnpY8J2qmYzaDQLZo3SUetWtYX28B
	 39V/HCTrmmLGmKEsnQ+kUMY/qQl/pK4JppvRlV5ecmPjNQIST0YKcGu/25BS8G7GnVBMT
	 3NhLQZO9Rku55zznscfyTQUEVhVA62XQkDYpaIUj0AhdRV18r3201JP8ubG4FHcRkOp29
	 Ww7BBMgTBeLszg6pWWNPgpZa0MB9NJ4piPKdG6pSh/nHAUwT0oA8EYI9XBb5zXRh5ZLhm
	 TrMcq3enLLmkFc5YoxdzHNC8Df6N3I0zHze/E1MfsgRwoMoi+xJy2+Fj/pw3JrYzovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BXO5e8T/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A6606EE9D;
	Wed,  4 Nov 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXO5e8T/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389231F00A23;
	Wed,  4 Nov 2026 07:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776941;
	bh=Z/+9leIVb/2PzxEAQcuH4PKWNspk64wC1k5hc509Agg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXO5e8T/TksIg99y1eM7yic50K7T0wITT1L4pXAMHkI2uVzghOgPZEfsOFI5IudT6
	 I4J1zNbxQ7sq9a5BWfa4aa/eq4b2j9JZJf1F5PgAWj/P71Mgl8yXVwUlcwuk4ya+GU
	 bMkKjcnCjZ1Zfu8r4ON4VNeIFg8t2fPGEPv78sw78CNuVH10r6/YEUe0GW6Kuew41L
	 lfAfV6qegpcgE0QrYFE/T4iZNhDwCV+ZQDZTmZ+scVZCXVRAowngfNwdfngnNyPaA1
	 8Xyqhi9HXmlmkror8q7fcA+CAoJ8STk+F/9ixI8FjP3sR69/QH+AWVXk56yl1gqekE
	 lA1AcwmDxD8ig==
Message-ID: <sashiko-outbox-196783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc8180x: Add Microsoft Surface
 Pro X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@packett.cool>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104070441.74127-3-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-3-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:22:20 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: disabled qupv3_id_2 prevents uart13 and uart15 f=
rom probing
- [Medium] arm64: dts: qcom: build failure from undefined smb2351_2 and smb=
2351_a labels
- [Medium] arm64: dts: qcom: build failure from undefined remoteproc_slpi l=
abel
- [Medium] arm64: dts: qcom: vdda-phy-supply and vdda-pll-supply swapped on=
 USB QMP PHYs
- [Medium] arm64: dts: qcom: missing power-supply and broken power sequenci=
ng on edp-panel
- [Low] arm64: dts: qcom: duplicate pmc8180a-thermal zone for pmc8180_temp =
sensor
- [Low] arm64: dts: qcom: child node names violate RSC, TLMM, PMIC GPIO, an=
d ADC schemas
--

commit 5309d200eb0928bd90998981b5c8364f2e0ed95e
Author: Maximilian Luz <luzmaximilian@gmail.com>

arm64: dts: qcom: sc8180x: Add Microsoft Surface Pro X

This commit adds a common device tree include and three board device trees
for the Microsoft Surface Pro X tablet variants (Cambria, Carina, and
Caspar) based on the Qualcomm SC8180X platform.

> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dts=
i b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
> new file mode 100644
> index 0000000000000..17fb01c6b164f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-microsoft-surface-pro-x.dtsi
> @@ -0,0 +1,853 @@

[ ... ]

> +	thermal-zones {
> +		pmc8180a-thermal {
> +			polling-delay-passive =3D <100>;
> +			polling-delay =3D <0>;
> +
> +			thermal-sensors =3D <&pmc8180_temp>;

[Severity: Low]
Should this node be named pmc8180-thermal instead of pmc8180a-thermal?

Because sc8180x-pmics.dtsi already defines /thermal-zones/pmc8180-thermal
with thermal-sensors =3D <&pmc8180_temp>, using the name pmc8180a-thermal
creates a second thermal zone node in the DTB for the same 0-cell sensor
rather than overriding the existing pmc8180-thermal node. When
qpnp_tm_probe() registers pmc8180_temp via devm_thermal_of_zone_register(),
thermal_of_zone_register() only binds the first matching zone
(pmc8180-thermal) and leaves pmc8180a-thermal unused.

[ ... ]

> +&apps_rsc {
> +	pmc8180-a-rpmh-regulators {
> +		compatible =3D "qcom,pmc8180-rpmh-regulators";
> +		qcom,pmic-id =3D "a";

[Severity: Low]
This isn't a runtime bug, but several child node names in this file do not
match the patternProperties required by their respective DT bindings
(which set additionalProperties: false) and will cause dtbs_check
validation failures:

1. Under &apps_rsc, pmc8180-a-rpmh-regulators, pmc8180-e-rpmh-regulators,
   and pmc8180c-rpmh-regulators do not match ^regulators(-[0-9])?$ in
   Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml.

2. Under &tlmm, the subnodes of uart13-state, uart15-state, and ssam-state
   (cts, rts-tx, rx, and wake-int) do not end with -pins as required by
   Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml.

3. Under &pmc8180_1_gpios, pmc8180a_gpio1 and pmc8180a_gpio6 do not end
   with -state as required by
   Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml.

4. Under pmc8180e_adc and &pmc8180_adc, the channel child nodes
   (ref-gnd@0, vref-1p25@1, die-temp@6, xo-therm@4c, vph-pwr@83, and
   vcoin@85) do not match ^channel@[0-9a-f]+$ as required by
   Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml.

Could these node names be updated to match the binding schemas?

[ ... ]

> +&smb2351_2 {
> +	status =3D "disabled";
> +};
> +
> +&smb2351_a {
> +	status =3D "disabled";
> +};

[Severity: Medium]
Does this compile cleanly with dtc?

In arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi, the two qcom,smb2351 PMIC
nodes under &spmi_bus are defined without labels:

	pmic@2 {
		compatible =3D "qcom,smb2351", "qcom,spmi-pmic";
		reg =3D <0x2 SPMI_USID>;
		...
	};
	...
	pmic@a {
		compatible =3D "qcom,smb2351", "qcom,spmi-pmic";
		reg =3D <0xa SPMI_USID>;
		...
	};

Because neither smb2351_2 nor smb2351_a is defined anywhere in the tree,
building the new Surface Pro X DTB targets under CONFIG_ARCH_QCOM fails
with unresolved label errors.

[ ... ]

> +&mdss_edp {
> +	pinctrl-0 =3D <&edp_hpd_active>;
> +	pinctrl-names =3D "default";
> +
> +	status =3D "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible =3D "edp-panel";
> +			enable-gpios =3D <&tlmm 130 GPIO_ACTIVE_HIGH>;
> +			no-hpd;
> +
> +			pinctrl-0 =3D <&panel_vdd_en_default_state>;
> +			pinctrl-names =3D "default";

[Severity: Medium]
Should GPIO 130 be modeled as a fixed regulator connected to power-supply
on the panel node rather than enable-gpios?

Documentation/devicetree/bindings/display/panel/panel-edp.yaml requires
power-supply on compatible =3D "edp-panel" nodes. In addition, GPIO 130 is
the panel VDD regulator enable pin (panel-vdd-en-default-state). In
drivers/gpu/drm/panel/panel-edp.c, panel_edp_probe() requests enable-gpios
with GPIOD_OUT_LOW, which drives GPIO 130 low and cuts panel power, and
generic_edp_panel_probe() -> panel_edp_prepare_once() then re-asserts
enable_gpio and immediately attempts DP AUX EDID reads with zero delay
because no-hpd is set without hpd-absent-delay-ms.

[ ... ]

> +&usb_prim_qmpphy {
> +	vdda-phy-supply =3D <&vreg_l3c_1p2>;
> +	vdda-pll-supply =3D <&vreg_l9e_0p88>;
> +
> +	orientation-switch;
> +
> +	status =3D "okay";
> +};

[ ... ]

> +&usb_sec_qmpphy {
> +	vdda-phy-supply =3D <&vreg_l3c_1p2>;
> +	vdda-pll-supply =3D <&vreg_l9e_0p88>;
> +
> +	orientation-switch;
> +
> +	status =3D "okay";
> +};

[ ... ]

> +&usb_mp_qmpphy0 {
> +	vdda-phy-supply =3D <&vreg_l3c_1p2>;
> +	vdda-pll-supply =3D <&vreg_l9e_0p88>;
> +
> +	status =3D "okay";
> +};
> +
> +&usb_mp_qmpphy1 {
> +	vdda-phy-supply =3D <&vreg_l3c_1p2>;
> +	vdda-pll-supply =3D <&vreg_l9e_0p88>;
> +
> +	status =3D "okay";
> +};

[Severity: Medium]
Are vdda-phy-supply and vdda-pll-supply swapped on usb_prim_qmpphy,
usb_sec_qmpphy, usb_mp_qmpphy0, and usb_mp_qmpphy1?

On SC8180X QMP PHYs (including pcie1_phy and pcie2_phy below, as well as
sc8180x-primus.dts and sc8180x-lenovo-flex-5g.dts), vdda-phy-supply is the
0.88V rail and vdda-pll-supply is the 1.2V rail (&vreg_l3c_1p2). In
drivers/phy/qualcomm/phy-qcom-qmp-combo.c and
drivers/phy/qualcomm/phy-qcom-qmp-usb.c, qmp_phy_vreg_l sets a 21800 uA
load on vdda-phy and a 36000 uA load on vdda-pll, so swapping them applies
the wrong current load votes to the two LDOs.

[ ... ]

> +&remoteproc_slpi {
> +	memory-region =3D <&slpi_mem>;
> +};

[Severity: Medium]
Where is the remoteproc_slpi label defined?

Both sc8180x-microsoft-surface-pro-x.dtsi and the three board DTS files
(sc8180x-microsoft-cambria.dts, sc8180x-microsoft-carina.dts, and
sc8180x-microsoft-caspar.dts) reference &remoteproc_slpi, but
arch/arm64/boot/dts/qcom/sc8180x.dtsi only defines remoteproc_mpss,
remoteproc_cdsp, and remoteproc_adsp. Because remoteproc_slpi does not
exist in sc8180x.dtsi, dtc fails to build all three DTB targets.

> +
> +&uart13 {
> +	pinctrl-0 =3D <&uart13_state>;
> +	pinctrl-names =3D "default";
> +
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "qcom,wcn3998-bt";
> +
> +		vddio-supply =3D <&vreg_s4a_1p8>;
> +		vddxo-supply =3D <&vreg_l7a_1p8>;
> +		vddrf-supply =3D <&vreg_l9a_1p3>;
> +		vddch0-supply =3D <&vreg_l11c_3p3>;
> +
> +		max-speed =3D <3200000>;
> +	};
> +};
> +
> +&uart15 {
> +	pinctrl-0 =3D <&uart15_state>;
> +	pinctrl-names =3D "default";
> +
> +	status =3D "okay";
> +
> +	embedded-controller {
> +		compatible =3D "microsoft,surface-sam";
> +
> +		interrupts-extended =3D <&tlmm 180 IRQ_TYPE_EDGE_RISING>;
> +
> +		current-speed =3D <4000000>;
> +
> +		pinctrl-0 =3D <&ssam_state>;
> +		pinctrl-names =3D "default";
> +	};
> +};

[Severity: High]
Don't we also need to enable &qupv3_id_2 for uart13 and uart15 to probe?

In arch/arm64/boot/dts/qcom/sc8180x.dtsi, uart13 and uart15 are children
of qupv3_id_2 (geniqup@cc0000), which defaults to status =3D "disabled":

		qupv3_id_2: geniqup@cc0000 {
			compatible =3D "qcom,geni-se-qup";
			...
			status =3D "disabled";

Child serial engines under qcom,geni-se-qup are populated when
geni_se_probe() calls devm_of_platform_populate(). Without setting
status =3D "okay" on &qupv3_id_2, the parent QUPv3 wrapper never probes and
neither uart13 (Bluetooth) nor uart15 (the Surface SAM embedded
controller) is instantiated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104070441.7412=
7-1-val@packett.cool?part=3D2
