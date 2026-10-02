Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099F47ACD7
	for <linux-rtc@vger.kernel.org>; Fri,  2 Oct 2026 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936671; cv=none; b=FC6l2m3LFdYvtFPvHMHBLg0yoor0PE8fldcLus9auATednwI7DEhq5bQ7f7qJaqgmxLK/+bGLOQ5SfNMncLJnye8bO9rw0U7fkWTe2IUv8+Kvs96lZ2T4WzkfTxr+fA6UqOKuC/DJchK04wDtk5P204l2UqIEYhjXl9jccFstr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936671; c=relaxed/simple;
	bh=w7OmkhtpQbSbKhpjB/7ILodpiKMPLVSfjJ/LipsnHA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5fTGGDP3cvuaC96urpmluQsYqmHW8iRH75HshF3ueJoCr4q2JgH1xHNDczohm0cYKIJHC86Q9on9bOHMTSKAUQysldcG9eUpTkFD4V7kU1GFf8+z3Nih/WwXGbTypdm6aC4Kaf/fiilpotsPTAX1c2Qo8PR2uEGCp8dg3EAlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv6sdqxB; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv6sdqxB"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so7829935e9.2
        for <linux-rtc@vger.kernel.org>; Fri, 02 Oct 2026 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936668; x=1791541468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXvq0gg0+t23z7kZpF5ZlYYsh93CZVLrZlTbiFH00UI=;
        b=Hv6sdqxBYyi3ca7KJUSLMr0OOfVoTCke+p/FViViAuksUE97O77KIOPiiOuE7pBlxy
         whAmCU8iiJPCrLvCubO2cX53uxz+msvZdCV0VtdoYdx6QwvoS5yn5AB8poa11RHKUc2S
         EoWdpldwd5xWzlEbd6Y9LwJHRfTR16tO8g7tholiuFUaRgX+yVOEg8176KHdLNp2UoG/
         1cc0C5IQpHq/1CYIqlO2rG1mUKgOfq3bDAB5RuD2/klTNXkppB17R+XCko3ELY0AD6BB
         vj8Piz3XQxiXgaBH2Vvk7cGpDp/psOlDrC1EZXf+9CMQhzIfuvOiKvnQw8JxfJ996Y0N
         SG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936668; x=1791541468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXvq0gg0+t23z7kZpF5ZlYYsh93CZVLrZlTbiFH00UI=;
        b=OQfKtDEBZkINu2eEpwkWoLRSoEu9GBHUzQQTRPrKmX2zeHWqegSoJOips4czAwH/3J
         94tjJ810qdgoec7O06SuzA9RT1oonmGtbawAN5qzj675txlyZ9aLSt2COgZPDpAtjDvz
         m/rQtHOa8HQGVRQ0s7bPCLA752MlRAp6sQFmo0IL5qgV+u60XtSv716iNUwckMokAKNl
         8bQJuYJwSX0XPRp/hZLvM4rIZC2hEK3Sv/M7zgw+tne2pXrQLu4NduSGSoYt1JeysCwl
         Z9CX57o6HGuFojya87M8v7bSG7+IGQNXWplKpP9QfdvzenfcAFS2hSt+dboRa/OWnryE
         ykAg==
X-Forwarded-Encrypted: i=1; AKwUvBzppRRK02XnOcIm13SPMUmfTiOheqNfEgaEP2wBjylzdfuHxwgUx8a0r11MnW91GbQu7BAmADxV3Jg=@vger.kernel.org
X-Gm-Message-State: AFuF++kixBeFPPDbeeyu3s+5D9Brv/ObqYkjQNQ0el5E6Y18hSbsu32f
	JEr023bxwTncvFQj40ZuzGYWN+O5PP02x8i1Bs78rwJMjkiifRTskwBK
X-Gm-Gg: AYBFou0ectsPQFKByTy8xDx1UyB+FD4K5Gnvr+54XV5c9IMcLted5ulIrLiB5VpwSHv
	knOkd+BURq2KcjYsBqFEdQyegH7q3168zcTXccOvN+jb9RrDPUAfJeXgfPH++LFL3ZX3ouuGoZr
	1/VI1reoT6IFf4j6NHA9eT/mLjOZZ9iEHFale/d9R7xeVEYrgk0lyGSEJx/F/6FuEkb3yC6h6i9
	Erqf4+eZkiCaOZfub7CsYjleutwFSRGQWmsGJXNuCuYTeQ/sQ4GeOuD/B+kP65d61W3VoIksrad
	XiqUCFBbcCXBfePCkDx1L9i+hPGHq9VH1B9/95MVnSl2TFlur6iiZShkKYkKWv7QrkkESDrK1WY
	THh+vG9l5BldLMZni3617QXBSE+n1PV9pgWyEWtpqAppjC38atvd4liE9/asN74jEzex8ilmg9M
	S7FURUEKlcNTG0GG2s3EHctgviKbOIeOqh/93qokImXAolIb4aJS57jGIaPfGgKYuPaDfmdqsUA
	CjXrDe2ejpF/B2HqQAgm+RXtTbBL3LnbBldsBlJ5pa90Q==
X-Received: by 2002:a05:600c:1546:b0:4a0:1c43:3c04 with SMTP id 5b1f17b1804b1-4a02756e5edmr41676685e9.13.1790936667497;
        Fri, 02 Oct 2026 03:24:27 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm99557875e9.11.2026.10.02.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:24:27 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Fri,  2 Oct 2026 12:24:18 +0200
Message-ID: <20261002102419.830595-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002102419.830595-1-sander.speetjens@gmail.com>
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
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

The property is added to the existing raspberrypi,bcm2835-firmware
binding (rather than creating a new RTC node) because the RTC is
accessed exclusively through the firmware mailbox interface.
We only $ref the individual property from rtc.yaml and do not
reference the full schema, because the firmware node name does not
match the $nodename pattern required by rtc.yaml.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V9 -> V10: No changes

V8 -> V9: No changes

V7 -> V8: No changes

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

