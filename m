Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14393054E4
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757598; cv=none; b=G8WDwJad9pAZUnPMNHUDEFU/qZE8l9cGpAGUwIGkLDb5du6a1sK+x5L31Dk5rl5TPryXkTv/rSG+SUV5x1RWMtOXca1+pk2sV2szwHuWFjLkNLUy/Gu/R7u0+1NgLoTpGxdhhyPkeBr5numBAm38sYGN3G7Z97/QH0KcuKVbxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757598; c=relaxed/simple;
	bh=f6CO7bbIh3+VC1p9XTgdX3LNbHLG8iA1il5O3WFLmGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtxkPVcm44Y23MGewQUG4daYzPwHzMsANXFlBmTfkyd0wTKVkPEH5+X6DxoMelaiM+1+Am0fHWj8pNbgawRvQO6VAJ4Ix/BThKF4SU+xJ9JI8aiQThXv0I2rkNIrOBWkNrMJq+iEpfHUdhDiWRuzsH/6rnzB/UjTyoO06+J1URw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq27GpYM; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq27GpYM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so3065059f8f.3
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757592; x=1791362392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFNVuEQ/EQx3uyZQsi7HoiI6kBWQboC2hCL0w1PP23M=;
        b=Wq27GpYM+Ub7JOBtCN/wxWfwW0VLfFniigDP8Eq99jDrnsSeqXbyT13ZazYx4AYyt9
         183irWIy4mxOBqaSRsyXMipA7XKdI3ReygG0qN9rbidjVJJH1hBnUFp0rq2HhuT41X/Q
         p15alsrRpJhva3Us+LX+W0eKCcHuW/MKvMJiNa2RZF6JGFWqLsKF/zf+iuN4DwwsBGVS
         jU2dr/a25Kfh+7cxwNS4xGMw6dxi5GQrSlL8FGaDIANy2vBC/hw46xJDoLq/oNOBLMgK
         x3xW5zqtzFsFBxhZqfgEb5WiLKCtg7GFPqXf9BIQ5RkfBY8BnJFGGp5ij7Tyy4/4vEQh
         1S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757592; x=1791362392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFNVuEQ/EQx3uyZQsi7HoiI6kBWQboC2hCL0w1PP23M=;
        b=yhX8iJa8fxGzJstbalgQK16zl+eyCPwp2uFtogyVlp78w/hhWN3icsb/XUPoHcZ2kx
         D6TdKybMw6OaI1Y5LRWEkptvkQyltESZioqj8AdWYR2f0p03WbUMuIZrbK6IG0DYTha+
         acJXvPrdTh1xiO9lbVPPgpf4L2gZ/fqL7/5acDwMWSC4HtUjwUUQej+jeJYgN5+vH32o
         PZ/E9CdIyz5EKGpQ+O7COlcOgoqvhTRY5+eziBk4BB5vn2yq+KkwxpV4Ol9u8++BpXiS
         4NqB2zD4BuzwtMCwsOKQikC2PmHfqq0I9Fmrz7i0Ra6gy0luyrQIQpRAYF5OuQ6AVs0F
         eItQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+ofK3D7a1yEo5amm/DkIFSndGDpTBFkxhG1bGVVHLfBNLhBnv9ynaM7ukgGR6JqFB4LzLoDi08tk=@vger.kernel.org
X-Gm-Message-State: AFuF++lLxw/+UCRDLHF0Qzq5aOD4fDHRZpL27efoqAq9Yn6wHW6FoY+j
	RA0ZXf6hbZt7WpuOOKpMhCoF9HiNuKDu52kx3WIKw4xnScVDg6xoXljU
X-Gm-Gg: AYBFou3ZoPbw8uM5Z+iiOrT9gIioaXccZeoYkZoAcwjFo6siApqZzE2HGqpmbu4vmWD
	WGHnwzLopgA9H3UUUOzobgRl1Hse0qSOGzzYY/0yuyYKTyBMQKxWv8eUXE+HU2gRAbaPwLL2/Ek
	pWN/nFPnHBW//x3KS5GF7oeyIx2deYZ2gGui7i5iciFCXi2MRO6FPA1IrL+H0HiNCpyCoyHtiks
	dy5ryKAnXs7Fskuq2o+HH61p8PvCpPTsPJI5fmRXmjn+bSaAKJHCx5luguwUxCkGcpYlWluB47e
	WlbVckzHvw2XzJ203m2uQJvudtITarJrbJE1Q2JMCPyElB9E9brW0nTwr0TIWsoiaWNoQRo5WHt
	/vR9pKh3btPtRvG+winTxmG9VlIsoiMQXrrs0KhCaAwgvLO4w50IS1OyT+Z9yK6/RtZKoZZzdmp
	mNoJZpSTgY2Ci4Gxwu7lvXTgLe+fLqwFJLNw72OzmchsOxqjaMZWpguYAVa5ux+yYJkqO51bylv
	elFbCuCinFGj9yOVVpKEqaEPlOn4a8RQy8bToXxE7c+Kw==
X-Received: by 2002:a05:600c:5391:b0:4a0:1559:bafd with SMTP id 5b1f17b1804b1-4a01aff068emr9727185e9.8.1790757592383;
        Wed, 30 Sep 2026 01:39:52 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029bfd2bsm1757325f8f.11.2026.09.30.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:39:52 -0700 (PDT)
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
	sander.speetjens@gmail.com,
	pbrobinson@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Wed, 30 Sep 2026 10:39:21 +0200
Message-ID: <20260930083922.484885-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930083922.484885-1-sander.speetjens@gmail.com>
References: <20260930083922.484885-1-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 has a built-in RTC that can be battery-backed
via the VBAT pin. When a rechargeable coin cell is used, the
hardware requires a trickle-charge voltage to keep the battery
topped up.

Expose the trickle-voltage-millivolt DT property so the driver can
program the correct charge voltage for board specific configurations with
the attached battery.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V6 -> V7: No changes

V5 -> V6: No changes

V4 -> V5: As discussed with Conor Dooley, the reff to uint32 is removed
and a PR is made on dt-schema adding millivolt to property-units.yaml

V3 -> V4: Add a reff to uint32

V2 -> V3: Fixed the firmware property naming

V1 -> V2: As discussed with Krzysztof Kozlowski, this property is folded into
the existing raspberrypi,bcm2835-firmware properties.

 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 983ea80eaec9..dc71fd57834e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -133,6 +133,11 @@ properties:
     required:
       - compatible
 
+  trickle-voltage-millivolt:
+    $ref: /schemas/rtc/rtc.yaml#/properties/trickle-voltage-millivolt
+    minimum: 1300
+    maximum: 5000
+
 required:
   - compatible
   - mboxes
@@ -144,6 +149,7 @@ examples:
     firmware {
         compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
         mboxes = <&mailbox>;
+        trickle-voltage-millivolt = <3300>;
 
         firmware_clocks: clocks {
             compatible = "raspberrypi,firmware-clocks";
-- 
2.55.0

