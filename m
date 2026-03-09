Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6E36F40E;
	Mon,  9 Mar 2026 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046732; cv=none; b=H0jtncNrpcLyAjt1Ew7lt661rej1MPbP/ScadntPnbYUK+SqMSjk/c6OTrBJbJcjR52MNVEHYG7N9M3us9hORMpb7jIth4NFs/v8wjJX8IyKPwvA7+9iKVB858wiumONQO7eonKOK24ze0AKPhFfA2oqagp8oYDMNIVaUyI5OuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046732; c=relaxed/simple;
	bh=eCONjMsAgxgvPoZCScOH/hRofDA6ahKRJHWeoxdyoJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSTt7iLkgrGALgdj0rCWg/KmHZjPpCW0x/AuXejrQlIHQrpS0DR1bYR8VVT+xxPCmsGmZaz+/V971uJWE48e5k4/IwO13iwpdH2unppP1bFKxQy+FvKjWTIXem79/i4igjG25thTtZADcUPj1QTc9JwKLyf3G5VVsGEjE2hDXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=OMeGQgsO; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="OMeGQgsO"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1773046717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y99r0w3uvANePHf5fQI+vO5duMCpkElUfeZ9uqmXL/A=;
	b=OMeGQgsOMQfKeYMepAkcSFK6Pmo3P2OnR9lElVhTasV7aPzEeAHNVeu+oMmENaTUo6Y2MY
	7DYqHW85Zd6YGRXVYHHFyq61o38AhxF7LYfFJ7Ly29AYf2epva9H0piiUSsi844nmyJ5+z
	Lw3QXwoE46Q0vmU08fw/Z7+z/ru94w6Wv8F+Ja5bgfI7Kmihm53barnTFuPiQe3dsZjSfF
	SMY0IoI7lGhqNHl049lBGsrMd27FxZCoBNmfXghy37eZRn8ZzVnSFn/+ILrA2C1wdJiUJ8
	k1fWTYwdDauIoag9Iz2Zey8yT7LLqAhcs/KTWoUQhn5ucoKd6JrknKkqD6cHHQ==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Annette Kobou <annette.kobou@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 0/2] Kontron i.MX8MP OSM Devicetree Fixups
Date: Mon,  9 Mar 2026 09:57:41 +0100
Message-ID: <20260309085749.25747-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This contains three fixes and one cosmetic change for
the Kontron i.MX8MP OSM devices.

Changes for v3:
* Drop applied patches
* Add missing bindings patch for RV3028 RTC

Changes for v2:
* Add Frank's R-b tags (thanks)
* Enhance commit message of patch 2

Annette Kobou (1):
  arm64: dts: imx8mp-kontron: Fix boot order for PMIC and RTC

Frieder Schrempf (1):
  dt-bindings: rtc: microcrystal,rv3028: Allow to specify vdd-supply

 .../devicetree/bindings/rtc/microcrystal,rv3028.yaml        | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi     | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
2.53.0

