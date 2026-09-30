Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E63459ACC
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754375; cv=none; b=YzIs3aH67g+66Oh4I0wiClKLmnOYl2MxAtEGVguZa/WmTeitlyYyPURl2OoIJ4zfUwH/5qNMwaoyTA5ZFo+KHksf++rYYMhmqWGSrcMWOJJJXPJNEObocJnjFuDQu3JBpKUEA2QTmSo4rhse0a0XnXoITi47IXuUu5Rrh/ER/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754375; c=relaxed/simple;
	bh=KpdsnEaU0XUqgnIgultpJNes7Ph66Xh6nK+rdyFLGAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiE9HMcoFdUEqaNRtHkSiuoIIPfAuRwcqbBhqvKPFi5KDtgVhIsTFj96Xknvbgy6N51zoOAKsqgf+U1PWzCxjLwrjgEh8vaQdAHksc1UvJHMplAs/MI7jmFJtexqkSqUco1wzr7JQY2f/ZllBlxPWWs6UztZr+y1KY0UDL/mODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAxyuYYS; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAxyuYYS"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so3581769f8f.1
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754371; x=1791359171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+41Kw8n5nZrYb5TW5ZIYPjdvMg9T8Nts+lEsUDThvXI=;
        b=JAxyuYYShVfSjGoOEGkayTQan24b4o2e2s8H5oIdE7DtGA5LFb+HXbp7K2GEUUWrW0
         TyH2ytNCPzOhxIuZlNbfqaiIPcRvoWNvfdQHwsJ3pYBAxxjruebAlWe5OBzIscZjcipt
         xF3QIb5KQT1P0zv5SejRFS5Pavvhep0ordf9PA0TZGnScHV1O7HHMyamW3LELhvUgI//
         eqmS/5oJ/Djp7jiTJSOiaQ7s5Hiu9CJBzbm7V7Qb07suweof0y2hEQTHN9DyqNKYhuro
         Pdj2o0dTWjRIAAQ99192+Xz2qNDHLhJ32W5lPN3RcZHD1EHV/jY+TvAgCPP6LTj3ZJLJ
         GaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754371; x=1791359171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+41Kw8n5nZrYb5TW5ZIYPjdvMg9T8Nts+lEsUDThvXI=;
        b=OfrX45q9bKFMFOlcvG2BbvjnC9IQHeH39StXnwiai2qqP99cTKNWjYrboH9aREv+s2
         LNwgoH/h6n7KJaysQEZe/t3xP4TFcMpj5ps3MbIzwqCiEUiQ2NuBOTDDuGppLCUvLFG/
         g44w0NARUYGIsNA7gWMFU1yyqucvK0EOZKqoeUh/AMJoR8nK9PM1qmBez/pC8CyOXWiw
         kTFV60pehDZwM4m4R1au7kfgr40G3/2HFDXss4r4Rg/jDmYfY1f4X5gi+ZHAaVqA+1aI
         kJg4zjLdL0+6ZTwacAgJNvdjBUN6A3WE1FV+orHzFpmTDo5Tk5eNoC8+GPpcGdpzAvZ/
         mzzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVFkQBnIygEwQaEbYMeGAcwiHgnz3LMrYiBJzbBuZMu4fI5dnnR2zjIta1Ra5xvedLs87TtCK4DMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAbey6b4m7DC3IpKHD5gG44o7OqwI5tXtC3V4psGmw4/UKrGUp
	/JzoKcyMCOC3HVUzCRm2VBOl8djCzuj7+B5YIzVb3cZ3Q9RAxfPZOVHl
X-Gm-Gg: AYBFou3peRi7TF4alVTixaJAblY6CAtN1J5s+lcydeIRQV30cNw4ZWGXXBhbzOvPs+T
	dqX7y9DkVuHV58KG7q/I/3q+COy1GJQa/0EeEEAdMY8RkGUfqLF7gPlevHWWf8fFWPtffsFbUWL
	AO6ND7KjPWyN/Hr93SlhJ8w4Q/ihGHuZiH6gHvmy5Yur1FJB3CfKHPUyohp5AnyBjkjhpJokUdv
	NZWrVj+G0Y6sJpUg0rN0feJ9xllL4MvllHToQgwzBYnNTx2X1zvPPRWfzrFVNq9MuMGp4jS71Uh
	KtzUfsQ7Z6SIW3hYajmBDsWEEV30tYBMMgFp9h6uu5iNUHe24gh4sBCB2IjWM1le3+5AjKgOZuF
	BWnoK5WYpDZLbZIu5FWCNHoF5W9H/OouhHHIkt4/QLD0sjK7Rif4bvajXM04w0WkcLJXSD6gUI8
	0dVvY+8Q5IudC40TuQ9e5OCJumVByeHUgMfEUU94ju6g6ukiHlPAkUUDtwGu27Bcr2qCU5F2zAh
	fRB2b5az34Q4NR2DMAPYaf7tB5SjXNwGKgtUj+qdz7WIE3rNqdUM/5m
X-Received: by 2002:a05:6000:25c6:b0:48a:faf0:bdee with SMTP id ffacd0b85a97d-48b0252bc90mr1084385f8f.45.1790754371276;
        Wed, 30 Sep 2026 00:46:11 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02a0185asm1487480f8f.32.2026.09.30.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:46:10 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Wed, 30 Sep 2026 09:46:07 +0200
Message-ID: <20260930074608.479089-2-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930074608.479089-1-sander.speetjens@gmail.com>
References: <20260930074608.479089-1-sander.speetjens@gmail.com>
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

