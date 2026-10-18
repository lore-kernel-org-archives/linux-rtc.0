Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958D377A92
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335637; cv=none; b=DPvSrUkrkib+N7gu9hHS6JciFWKIB2zAuYwIm8NNF5udPgDp+ttc9UAS5PC73pEFyjXS1oyWx+pbSnEzGE6yE9d4xtx93Dwmd7zfDpqBnxEfyXjBy+7oNmaQ97dNTaZHbhLvQautsUpwtTWvKO4vMkfVhqqBsM15Z+6XshVIQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335637; c=relaxed/simple;
	bh=291msLMDeIy082FQ37+n3NeDgGnlW1QFaOd6zHp884k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLC6idEiF1yQfXNL7+qzOB5g11vLTXBFTuq/IFUzdVichoQZzXj1LNKY/YPsuZFqIzJQE40HbuvqZpenGylgjjxOAtvUOx3Q6ZYu4R4+M/GzklCBS5fTsnh5X9GQtH/WxsuoIuuXjtmXRAWJej2JdXXf0BhYrpbKkOzfsnESSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkkxlaHf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkkxlaHf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so16786025e9.0
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335634; x=1792940434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=349qNNoByqVYF++DU+sob8mJAJG0TZ1Jpek+vaeVwCY=;
        b=AkkxlaHfW4LzsPxkKXypX+CfdZE0GD8jPmNGyYGNL77SFpbCzuTrAZc3QNuIDHbUfB
         G0otkiHf1az04xXgbw6tCB1/Qc8DElqKh4f/cb6Q8HhdKiwVqYx/cDQQ7g2yocZDaYOy
         D1+Ss2V5dngaG8OAf0d7fU+ATc/W2FVncQueISB8Hr4okuW8XCVhbCt/V8UqZCxIU/nZ
         u8bJU6oXK4qmG3DC5M9G3i0I+W7YfFz1+4zI72Hy0S4OzydCI7hNpKco1eN7Rngqvlkw
         g6kGu+E42OhnKhJX+LU89ampLTjo9U/Cv7OjZiVaktCu2kjAotK4Ch0Z1yRQdcUyvsIZ
         ZJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335634; x=1792940434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=349qNNoByqVYF++DU+sob8mJAJG0TZ1Jpek+vaeVwCY=;
        b=E0ZjzC2INFIvPq/FwyqE6+nCmfCEL60fS6EVPk1dLX6lkQPTVEcCCOTaNiepeWWeOr
         utVjnDlpR7PQrE/4LiGPdBQ0mh3BxbSCYXmoTCHF206qKfi/tH6tJLlz24FxU7OC6M33
         x4aXZk/KavjJjHIw8+WmVws5CxzbbhwC6KwZkq52VjY7e5n8w+77KUxTc9I5w7Zb49MC
         LrfcBmGP//EVfMdpw65X9FzzNeCioPEWhiE63uwIuXLyadZ+noB/VyPpSFs97fqEzgzM
         ayT6b/eNPDiFh+aQEA3d4QHQh4YrBLF8Xm26SLkwwOpRzvEV2XTtWijxBWvApAhxYTlm
         Sddg==
X-Forwarded-Encrypted: i=1; AKwUvBxOfcgJ6OAB7orewPQootWXm9awJO958X+dyWaFLEu7naGvdJMrdPanfn+sVeIpjnJCkSMU5C7IcAA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfjIHxe+Uws2A+fFeW+fUXbJjYR3dqtcuZCtsF5TdgQxLcyTcl
	bL494XThHYkJ/Bs2EceHCtoe57XJdmphwl2VKNGhGwf9Y9d6hHjrCcl3
X-Gm-Gg: AYBFou3d6psi8kiVO7G+U7t6uUeDPxgbkY8iMaiDDTQ3G/Jc/GQN4jXGwCgZcl979+C
	5fQV0yWNXMzHBlHq3crbxBXJ9+SQ6TjZQxqJicsl+G0ELGkCtTg5A4WPjGvth3rEnMn2Z4+mAWc
	pgS6kFBbJyl9HHpY5xBXEUoCd6FOy3g5UWz16i+gVMR/3GYQ7+yH+YEqzQwSlDTyLL6Hh0vLJtL
	VxVSjZMVRdqF9BiX8xViwUxKPyULYQ8PIr7Zh+GR3PuK5ZBPhBnETYbUuf/czz6tlrMyFGrHgky
	PByOvVaf3RFGb5ZJJ8bzjrv7uCzsSbvj+UpVasITBA1FAZK5v1KIZC5+DfAGGOb954kY5WoPyQ/
	MaliHvqCUdgdRtfNJnRWvChCs3VZQq9YzTVnnMOz+uJXCXkfuJjgQS1/Rflf7XYaWnMH+SfXgV2
	+m/SYip7nNynKD0R+TKf+RVurwmadLsN4LtyfeoFPszG4uGazHYsAKQ465Bj3dkN0hRVtaFQHTa
	07itzgUG4DpFeik6AbvezNbJaP1CMryayyOqCXDEvdrNqRiTzxf05m1
X-Received: by 2002:a05:600c:a05:b0:4a1:813f:2a57 with SMTP id 5b1f17b1804b1-4a1d7608058mr115503175e9.13.1792335634123;
        Sun, 18 Oct 2026 08:00:34 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6245sm212868925e9.3.2026.10.18.08.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:00:33 -0700 (PDT)
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
Subject: [PATCH v13 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Sun, 18 Oct 2026 17:00:27 +0200
Message-ID: <20261018150028.1047172-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018150028.1047172-1-sander.speetjens@gmail.com>
References: <20261018150028.1047172-1-sander.speetjens@gmail.com>
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
V12 -> V13: No changes

V12: https://lore.kernel.org/linux-rtc/20261018143712.1040152-1-sander.speetjens@gmail.com

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

