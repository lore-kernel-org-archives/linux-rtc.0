Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FB496D34
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966638; cv=none; b=FZ3jjiTCYxs9HbBL5GAaciK5ou6KdJ4grDLdPO5IkzuBsTHz1k/VVfP8z/MZoPkh72lsK4VL+HxtqR78DlxJ7YzyomgPxh0J5/rtD5Y1DVb/xO+8kUaIR+onfulkw6R8/cnGRB1wr8hMwV8rjzuOt4leCyKQbJ//9mmQcwsGq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966638; c=relaxed/simple;
	bh=OcahIjz+tK6zZ4B8IavL6oi9IaQ0giE4aDQYX8NwevY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4NvBVIoe9DxGnejC4fhzjk0lPV3Gtp8wcitgEsWsiphd9KoTBSTx/qzNzjMpu+GeUDtlP9orPtlYjoSXudgNvyFXkVP1dBqRSGgf6H7sh1LSrw8vsB+O2GCMjaScylgv+r8lAKXKA4kunPfJ33KwZz9+o9QMIS2PgNjgfyDa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8yYqTQ4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8yYqTQ4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a01933b584so33392315e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966634; x=1792571434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4uyorJjU4yw9ZxRXCkaVYEh792OjjBS20MYURFIG1U=;
        b=N8yYqTQ4I9N2IC38sWhuVc5ApIY/fiqWqhk7xTh05JtEJdZjbj4sPWeFbGAPmT4WK4
         14YKXXSGUIX9OIcQCd/c6Ypvs5y36wMmP6GvWExI6669u5vMsY5SewgEOr3nGi5jCsGP
         ZKX/6WPBNN8SOAuLXSi0DIq1tEZiDFbofUOKbVwlvdz+ZJqFl2djbyJqHeeSfQuXNQyH
         bcYkUXkWAmZroGJuoTOJ2a46Zoeu05gRAjBA/67er6T5yN28A0rzBh8tvApz18UXhBaH
         Qgk5nYqDKHUk+5MzPo+ybe5LP8iPeHaEx+y55ohtbCRdluV2gtCZGRNverSg//XlRXiH
         M1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966634; x=1792571434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O4uyorJjU4yw9ZxRXCkaVYEh792OjjBS20MYURFIG1U=;
        b=mZstfopOlXdlPqAFEO65ZdaSN5myUgeBudx0SODhwuk/3Tprvli5sYQC8JrEjabgEi
         VMckl4gl5cO61xMNai7rFvrllpCDQ2xjBZ7cAEy5kJ8OR6PKMfjt11tHmh3ezFe5Pe0p
         cVqht4Desp7H3nB85jlZrSbv/cLCS3JYK4P/iud0F5OxRI9vh2a3L+vKckwVCGwvwfYY
         RKH5SKr4pl3EjCo5DAr6ie9M/mqTiYhyu6rR4XsdZCmz9B/7AtSwoI25R1NGiObbf7JU
         sK5+dyfwhFxTNl5mWO5qdJ4r/C/n5Y+V/JrE6OsUHiIef51EkArB4fQ3/IbXTNiYPM2W
         UdNg==
X-Forwarded-Encrypted: i=1; AKwUvBzhWelWyTvrQesKCo4kE3QFa49WnBfw7V8nRmKu5wczvT9mSm4w55seL2iWwgStv5NjXaN4YPNsvAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAdGMLAHnOwkfZ6Axhl8UwMmnZsTWTYOEelLpKXTg5lUOU3Wpt
	yJOJuJbrVyGolEqsiEQOKBDmDpeYMcl2LQR00rOuHMpgHOAps1UnFSYV
X-Gm-Gg: AYBFou0/3Ng1wf1bcZPo6nM5FOOqcdhpRkA1ATpNqcUCY6G1CU49phYRYUUItsMVdq1
	ajuZd/KtzJv9y5M37dHGs+ljeCAVU8ob77fp7vwkoRuU9QbXLHTTZoEtCB+VJLISKtV0BnIwIPN
	cmRdxPM183KCAY6BK4F2xC75KPs3+WfNBbDbI3rwOs+ZIeWeOQ31twV+TBxlLoHZblrI8Bij/+Z
	wUbDB2XJgt4iNtR0Yz5SOFYzoP9H+F99hRfyiUG/4N1S5pizAPGwSSkcamVEK+U6NJy6a/9g/2S
	FId4JEptugCYqhnJAQOxw1Q13+HyXumx8Yk368FEeTwCaNsRmxpuQJoWmpmUcHPz32b6hBXnXQr
	WrZUWhNz4e1aGSOtscJ30ghv7rsncN9GtmzHoVCDV//3BpBknS35kGQA/ne4Vo2hV/B9ijnTSCJ
	OScJurGPGw0M36k79EiDNgu/ymZH37yS/ldUljk9LU5hhlRCRacFs5BgEpZ8p/x4ic6/NNQOIv9
	9WaWXPuqblUA8PxjIOtwX1HogYOWgrrQGQnnvuOCic9Yw==
X-Received: by 2002:a05:600c:1e0f:b0:4a0:1f51:ba2d with SMTP id 5b1f17b1804b1-4a18e4adcbamr292830765e9.22.1791966634221;
        Wed, 14 Oct 2026 01:30:34 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c198134sm431809745e9.15.2026.10.14.01.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:30:33 -0700 (PDT)
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
Subject: [PATCH v11 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Wed, 14 Oct 2026 10:30:15 +0200
Message-ID: <20261014083016.332338-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014083016.332338-1-sander.speetjens@gmail.com>
References: <20261014083016.332338-1-sander.speetjens@gmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V10 -> V11: No changes

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
2.56.0

