Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F63D967A
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963202; cv=none; b=rCBE+E1Kbd0rnZFihPoEXyJdoTZFbMAV6KQ27ahKoxrMku3/pUhFTGquWWcDdQxaXglFjehr9GnwZrINu2maklJhQYMtx5U9Vf2E4p+MhilUm3S66BB0M3ViithLm2VlFPrvoQ9GTn890t6iujOusQnvDSqYsP5Xmf2hoexRNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963202; c=relaxed/simple;
	bh=vbznnE/bJ5DXSUgov+9xagPRDM1Ymwg/65pTuopRG+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkbNOLvvb025OMjpFC16uQKY3V+qTCrUFqqw9qpT6OmVPhTwPzUZlamX+I7tlZK2xT1RE2nIsh+l1zOt/J4mA5YHwmQNYnZrjq559/2haiLRK46iJDfBYgD4ctkiit8+YPYSU1kgrOubFAXU2L3ug1CjdZLxWQCf+BaRdarhzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7aUbvX2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7aUbvX2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso72832585e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 09 Sep 2026 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788963199; x=1789567999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BM+FXnkXLBUNE7UFVxinUiuh2gclbtUdB/nqDCPUVQM=;
        b=A7aUbvX2HU63zc/DhjCnUUxgI7+sxGKtYaUwuOcZ63Mxa3w3uURwjgwgT8wbi9trU4
         ljgRxhW61QxiIuYpw9m+U1AoZv4ockA836sgP5PEFQPBvCea2ROGtfSsWmpaSaTOX27o
         igyXHnWx/wvNOC1voebzESfk7Zq2vZpZfpnr2aaTyO8PjCstT4Vd3umvijaJMs1YC81n
         K436jSS6Genfxi3Wp0EVMRZkT2SMyO2uDklShjJu0VWsKlMx7Q65qCnGZ76hw1JIc1ZD
         CkcwGM4/gacSk9R3KGslpu9O2/EoaLhaUHiVA9oi4muvNsdacxDygElWjAxOEkK15jbR
         EDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963199; x=1789567999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BM+FXnkXLBUNE7UFVxinUiuh2gclbtUdB/nqDCPUVQM=;
        b=rhJ8MuIw49BxM1YYDDMNoGQbxtUKrN9IhzGfihk+qYu6JR7BYCxwbJHpjzOX8Dhznl
         pTTbq6/jGtuxUFWdlDtQRKiByJP10UFQsVRmrZ1tTPHeR2xMbZlVowuNTzZWyer7rqFJ
         Q2LUwU0xCKZyVlo9/DcxsgO3QQnpy9xgGN31C6o+HcobQ3CzEVsg2iUWx3fCgQR8tATA
         XRSHjaGkrM3G1/q7nmP00n+uko9diwyOUdmaBolzd3VKOxDHLmeV4CyN/k0ew3uxgnJu
         YmxvHrpMBH7dDZofvvirVe1hRMKJ2a6/dgwHaQPdACDThkw5a2slXZZ+7ajlYHEzxk7L
         RONg==
X-Forwarded-Encrypted: i=1; AKwUvBxnglonKOgSLRYBk4J51tXJ1eVrJyLvxF+oD/G9U8+56vHurUfmCmxKyC8suCLEAAGXn26zyAhPElY=@vger.kernel.org
X-Gm-Message-State: AFuF++lnzXV5su8SBYlpl/hZxcRXxcUN4TZdvMhuoYn8O7yWZ+BvmHVZ
	3s9o7jpckwtIOdVdtEVkTE9CK0dbXtLt9qs3vnZTbZoYw37pDA60r9S2bVN0QOy0
X-Gm-Gg: AYBFou2pkqVkxuNS9oCKO7ZEXBllq36xoG00B8MXEHMEQix8p37fZOdv1rZfNNulZnJ
	hoJ45V+++VbHeN1iSqiREKuUxDfJVsXcTCozjW0XJDfeMj9L/2J5SyxIQMUIKz4THQgLPQ/k2fl
	fZvxE5zDBE92L3Wz23ZihbyEHvODUIMKjkX2RU1lpJhBbMtZCrSMnvLXlmqulyOIKA8Jt0Q9Rvc
	d2/SQFi+cD07F3zBhrGXG6bJSxNgaU/71TYqlPndKhq3KBioUtmRqpcavL/uD73t0pVK1FQVcfd
	6bvyu8DG8hKNC4+6Lvgb16Z6h4cUkTsHpBrILmqRqNBVQsuYeDtezbL/it4GEgfFAqbUsOZ1IzZ
	MLfNLp+H+DAOgTCpc8iCo1AA2aNItIg9OOLEyP64ZpjN22Vxljby1RwQ9C0dVfX4K830BOxdlfR
	ZR1YZWZMv4JJttVL+S90IR6WaiXuYbznvGx6KdhrA2fJlD8MCXXyjkNQoiyq9NbTgL8R7od2OBV
	GEzWTb8LcOQbWnsJOdNYIc1k7PHUKhyH3oyQ1f2Vt5xaQ==
X-Received: by 2002:a05:600c:3f19:b0:49c:fc6c:be13 with SMTP id 5b1f17b1804b1-49cfc6cc0f4mr320969475e9.25.1788963198564;
        Wed, 09 Sep 2026 07:13:18 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm43273521f8f.23.2026.09.09.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:13:18 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com
Subject: [PATCH 1/3] dt-bindings: rtc: Add Raspberry Pi 5 RTC binding
Date: Wed,  9 Sep 2026 16:12:58 +0200
Message-ID: <20260909141300.1368790-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909141300.1368790-1-sander.speetjens@gmail.com>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Raspberry Pi 5 RTC.
Located in a custom DA9091 PMIC and accesed trough the firmware mailbox.

Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
Assisted-by: Grok
---
 .../bindings/rtc/raspberrypi,rtc-rpi.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml

diff --git a/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
new file mode 100644
index 000000000000..e9bade7f8c91
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/raspberrypi,rtc-rpi.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/raspberrypi,rtc-rpi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi firmware RTC
+
+maintainers:
+  - Jonathan Bell <jonathan@raspberrypi.com>
+
+description: |
+  Raspberry Pi RTC from the DA9091 accessed through the Raspberry Pi firmware
+  property interface.
+
+properties:
+  compatible:
+    const: raspberrypi,rpi-rtc
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the Raspberry Pi firmware device.
+
+  trickle-charge-microvolt:
+    description:
+      RTC backup battery trickle-charge voltage. A value of 0 disables
+      trickle charging.
+    anyOf:
+      - const: 0
+      - minimum: 1300000
+        maximum: 4400000
+
+required:
+  - compatible
+  - firmware
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc {
+        compatible = "raspberrypi,rpi-rtc";
+        firmware = <&firmware>;
+        status = "okay";
+        trickle-charge-microvolt = <0>;
+    };
-- 
2.55.0

