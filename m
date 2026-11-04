Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775972;
	b=eI0nb1NCwyuHrouhiNhSQN5spho8J0qa4YNSQxUP1bhnB9W7JZ3ANEyuNcuv1bhHwr5l
	 nXsjxw+T3N0v+TwHVmrGr0dwhmt6CFI7/yhe1y2cs0SkWsqK3GBJudifl6k0ufjVyWPGN
	 fgwMY4eu3XCudKNf99h1W348WqDHku5jAohAWi+1qm9sTqInyN7YANxUs9bkOZYPi88IG
	 80njrmKB1DGZSvqq+CaQzHbZGWz0WIPZLQ75WmHv743RZwvKCkusWTmiVGthZAxlv5TuC
	 +TENugoL8b3HVDVXCkMbKdMf/bnpG1DHIKsYBQFWvDE/2qqk0Y0qJFP8uh1skKdgp9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775972;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WokjOK4qUKpaWUewt5ne3nHyD3RlNEsjQzStQ+c1XNE=;
	b=DJp744Mk1xePmWNQ6ALLFs2lFg1vZcSWKylLlepP3SJE6BtEQwuinP9GQ3yimOLTf7D2
	 Wfv86KJOZxHehsdcPwjKO3yFoltpX/CGCrW4BRjldJbAsbZBdRr1eL91fwPeL9xIhCnkh
	 +S2iQoYZXmZodZUCB+ceouFkJ9cto1+iIF0ifiLaidlbqDvc48aLP+or2wvgxMYrI1j9y
	 pnMcBo9ZqiH6JqhOttusQlK+Czq7T2K9UlXmP6AzT0nXj3t/ZvVMG1pTAMwvCBpCbPA7B
	 trYQ5/xsP2j/TFY/ew1XwkfqFn9aYEO+oj18pROKUmIDspqGxIf3066HGqViTEWzp+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=B88Yhe8a;
	arc=none smtp.remote-ip=95.215.58.132
Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92F606A32C
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA92F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=B88Yhe8a
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sN6eycwIKu/qE35PSu5sRh3YS6d8qIr8WXShRM/F29s=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793775969; v=1; x=1794380769;
 b=B88Yhe8aXbPotwPXS5mSp7q9WTisv3lU8edmv+yeUfUElnMVx+W199HXIe33849cJX0b2Pw/
 wAkTPyH2vUZI62vArFzpgbv0zKyNyjsp3i/yE1Rs6yeixslCXDENmaZamV2R5Co0F481foPyI9Y
 x57EOvQqvy5fStSms+7SVykevbLmYLjfWLwdD+noYCdGWW3pjP0bEsb25wP0gOUs9B4yYUii/B3
 aYT6G+EDqC1VSa+Cld2VMUH/FfChob4dmCWnDFa/187hnKwLgv/ElGS9msqhVqQXkAWnIRsSUXD
 93RK2RKyDdiTeDbCqa4+2nj7zRs13o4rTaPDSSVQhGwGQ==
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5fa99feb5128d1f;
	Wed, 04 Nov 2026 07:06:09 +0000
X-Mizu-Trace-ID: e5fa99feb5128d1f
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Val Packett <val@packett.cool>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 5/5] platform/surface: aggregator_registry: Add support for Surface Pro X
Date: Wed,  4 Nov 2026 04:04:36 -0300
Message-ID: <20261104070441.74127-6-val@packett.cool>
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

Add SAM client device nodes for the Surface Pro X.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
---
 .../surface/surface_aggregator_registry.c     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index cf3ae252b1c4..bec0a87a2a95 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -51,6 +51,12 @@ static const struct software_node ssam_node_hub_base = {
 	.parent = &ssam_node_root,
 };
 
+/* Real-Time Clock. */
+static const struct software_node ssam_node_rtc = {
+	.name = "ssam:01:01:01:00:00",
+	.parent = &ssam_node_root,
+};
+
 /* AC adapter. */
 static const struct software_node ssam_node_bat_ac = {
 	.name = "ssam:01:02:01:01:01",
@@ -352,6 +358,22 @@ static const struct software_node *ssam_node_group_sp7[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro X */
+static const struct software_node *ssam_node_group_spx[] = {
+	&ssam_node_root,
+	&ssam_node_hub_kip,
+	&ssam_node_rtc,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_sensors,
+	&ssam_node_kip_tablet_switch,
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_kip_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_fwupd,
+	NULL,
+};
+
 /* Devices for Surface Pro 8 */
 static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_root,
@@ -508,6 +530,10 @@ static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);
 
 static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
+	/* Surface Pro X */
+	{ .compatible = "microsoft,cambria", (void *)ssam_node_group_spx },
+	{ .compatible = "microsoft,carina", (void *)ssam_node_group_spx },
+	{ .compatible = "microsoft,caspar", (void *)ssam_node_group_spx },
 	/* Surface Pro 9 5G (ARM/QCOM) */
 	{ .compatible = "microsoft,arcata", (void *)ssam_node_group_sp9_5g },
 	/* Surface Pro 11 (ARM/QCOM) */
-- 
2.56.0

