Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AB4B99D9
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336263; cv=none; b=QumPPzEbn6Vg9I5M74vasetTEkFAhqyO8HxVMIfLvHSbkfDS1pad9s4S8tFU1HbzlfPakX4E8UcCJ79lbkWZZQRWoYesUQ17Us18Pw7VrD0FIke4Lz2t+l7lg3EQ7X9JljKDGZ2VpCGRpGU1txrflzEbHyEZx88dgSAKmGLRCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336263; c=relaxed/simple;
	bh=LaOk07jUXRLvQxxlSNQa1LeLyPvp5vXhNFiwjv8oi1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4MCNOER08QDg7GsJt4wJO6JuUqEY5+Ak0+tl/DSm4D8K+X00wnPGdwmMqth/fRZ9yHBn6X7qQAEuWkCT2rPLGYKOO+Smaf69FQ+PYsoGkGnggm4bbV/86Tg4l9cw80AbqTZSRtf0HLrDbje04h1l2mwN2KzxaMPotjr3kJxrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqwUdv9l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqwUdv9l"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e09aa5264so608140f8f.2
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336260; x=1792941060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLnsA4VhF3nXLzHXAj8TbQUk22UVhlTcKUM9tYUUKXk=;
        b=SqwUdv9lOcryvZo+iTQHMxd9ml0+NCCXjXD4cpK8VkBIgPkIduUBmDQOqLl5T27oEO
         WaEB9X80ezjEf4v8NwqxPQRdgsZGwooe3MO/ZR8pEAG2/22YbklyDi1vIXHBA5TGuF2V
         U349m6ZI1TLPuBy4t0YW8W/9HHZpwRl1UyyGO08bSXk7pF113w3r/XbPb5XWwngWulOO
         BeJCEeMb3saKlfkJwothFUWolIbZujZD0+zFoZy9zor2d09tKcSeKGYrZZH4m5RGsSeg
         k0OdNzLKSMNzk7ujIdrsZhNkg7Yh3MEOMwlgm+foUFaw7pRb+wyFhLuca6xJ1sWHMrZ9
         VXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336260; x=1792941060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLnsA4VhF3nXLzHXAj8TbQUk22UVhlTcKUM9tYUUKXk=;
        b=jJF/MGmMvYu31VFQIiFSNtQOTxL5K/TnBYqXu9pOrzUBk2fW51tjQt3mZDw1L10VGZ
         AJAq9RbNj8IUpstGPOWZPSeUw4SFXdOV32m7EtYm8ut0JPW4cmhRm8Qi0xoTpyViJPlH
         /+pK2M/RosU1J8q3WfzGoIOo/Rv4RTX0FBBmVBHP4s7cS87hOuq6tCie4MsbPzMYLaPI
         8HFNXg0Z5CsSKCFmqLjlzw+40hIOMuKCvvJIkTPbLCkicE7aAsShFC4DoZzTVSuW2fTC
         2wsoy06OnH5fHAHX8hiE+fArzZdstwZ6RjPabb9imMF1owYM8aT544WEnPuW6dwjllvm
         VnQA==
X-Forwarded-Encrypted: i=1; AKwUvBxEPoWjLigxM473GxRnqru0WVO+zwSVnNfZKqlwgTjTqalLZ3ZR+UqaB11szAc7O+x/oxwoBc5sBdM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6A5ohf39VtNPI2tY+d1DWEQANBJ07gO9wCx6cXWAdi860ZPQS
	X9e1kRddlMUkt3uDPtevvjygelif7cv45xk656tKdXl+HxFLCYxQfzcG
X-Gm-Gg: AYBFou3bskXV79XIlyOBGzCr19e5IF71kYhP3JWOBd93BcHV8Csdh8gin7pqN3MLdnb
	K/oJdFwgAbf3UrcI3aJOvHVBjoCNCK6H8CbSPNuZpZ42U2O7jV+yNv0B2VbTs3YKBSgJiOXZe4X
	cLDKYu3TRms2jsP1bdWnAcMtsVeKJqwldKK3SwlvSOWxOnjGTBRlrMB/XJA4en75vV49lhRbj9v
	CmGWpqoVMTLgzQmrSXVaE77k53lDMw2SOQGDQ5j/0qLDogI3PimbgmJfAXsxXxkg+CcmdoubRk1
	jdkbNWbVJ96uHyIfOVqi2XCsGC426x7C1zW+NxtPbCh1cCGsQ8449DeupflRJpgn1OoIe+kMydb
	jrLLrRh2cOPu7cf/NV6+lZdBBSSmmuXWUVYDZZGc9BxOScw5L6rSEabstDEpDbJXjqHd0tGOvvK
	wrgXaGbrYcgxSxm7G8birZ0oEjszDdHxTJ0r0/BZkZ7DCCKDCpht7cPbWQY07vUtbMndIwWVf/l
	VxHZrY6e1JHQdfUHnJu6EyX1d9DhWypXIl9E5y28TgytQ==
X-Received: by 2002:a5d:634e:0:b0:48d:f541:a6e7 with SMTP id ffacd0b85a97d-48e07f99c8fmr6899851f8f.40.1792336260253;
        Sun, 18 Oct 2026 08:11:00 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503a0dsm17743957f8f.47.2026.10.18.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:10:59 -0700 (PDT)
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
Subject: [PATCH v14 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Sun, 18 Oct 2026 17:10:55 +0200
Message-ID: <20261018151056.1051330-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018151056.1051330-1-sander.speetjens@gmail.com>
References: <20261018151056.1051330-1-sander.speetjens@gmail.com>
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
V13 -> V14: No changes

V13: https://lore.kernel.org/linux-rtc/20261018150028.1047172-1-sander.speetjens@gmail.com

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

