Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828051C04D
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883435; cv=none; b=VKsDXOd/NirMfQODYWlxatjEuHBYsZXBnoThTUVcHD91fQ3uPvdYwYaTt3X5KHMXIHTRkEfbQWIX6WWSlXDsFU/f8mKm1jgsMtZT3htTE2IKILbWknRtsfxgSh0omSD24eMIwEeQRa94nHxF71jgsjJTqhDU1RVpabVovtqPWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883435; c=relaxed/simple;
	bh=23fUV5uH8hymR3s4fLHnOR2V+sJXZxj9F6roRd4iV08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBrqCbFNhUci+gl7cW0FL5RqaU26xsASjBK2/EUk3H7gybe1r2k6CPJuqu1b3/TFPzllCo9pK1ZITFqEr2anKQ9esaQ99yDYTPy87FbyAjYRwY9Rn1/kWATuT0O8B46MYLY5WKKXAc+buDnL9/ux7QzEOulWClf+ScW6SYs+SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QshqXNRn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QshqXNRn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so41820225e9.3
        for <linux-rtc@vger.kernel.org>; Thu, 01 Oct 2026 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790883429; x=1791488229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGElhAW7KvUaLn/kwKuU16ekRrncolXMHKfCx7Xylfo=;
        b=QshqXNRnIO7r7QXS8pg3WJES4jrFq7rWmHpU2xniqyFvka/N55+pAHd2DPJf6IBYio
         2P5EfTCUjbBXy52+tgVxCaquoVeBteX7arh75X5VF8pQSprz8rmkkUZCLMDrTs7ef2jV
         T/3W/ShBB39taT2WKhdYjA+u13qXahuLACKC9hArvY4CsGyKxsTeNjNdPQshjEeAec3C
         kiEaFmKtVP4k/5ZrU1x0BH7OO0zNzGvePP9v2xHahKuMGP7S9du00JU1kw5hy751e5th
         cCO76If54ZBL2uB4bWKlJ6g7+tq9BBHt0jOD1u2HeNBAbbqywI5j6OYSkJjFz0erL4+1
         3CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883429; x=1791488229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGElhAW7KvUaLn/kwKuU16ekRrncolXMHKfCx7Xylfo=;
        b=UbGIMYYnLIpxD8+obc/VoFEjWC0gbZNkKdiOup92gmSal1prHmdPqnUTyPsn9GPNPn
         NM734bmZJDoCMQ5cH4Mu4U+k8ok8A3EpQ0mIcYhr6Qmv36wK1qbwM+WsBq55AbVjXndn
         VcIShmRkWBxkZ0Dj5yEg9wd+MZw1epEnaoCe2uTKXGzUJKn52gCQ4f0MKHbRsyPmysb6
         hIj+oIYmR9u07tpMIUyKEugd8Zc0Bmg1NwL3xjxLicLAIft4ozM3u1K8TQN7OvcwS0OY
         TZxvb+CKdAtI5CZDOPk2oqupTcngnEzWhYYlqQT1ZiOM71Xelb+jim1PuStgHO1Hu0vH
         3aUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgPrE6AZ4Be8oa+HDzBzjscahKDdmIxYajjDxU6k86cJqSj76GmmmqejoakHzr6slR0x6OEC7HvSI=@vger.kernel.org
X-Gm-Message-State: AFuF++mUHK8hZnUvd1eAs1d88lDetoH+M33nX23jLWkl0NrVqDrVHKLi
	BrYZUiGzgr7urVKwK64u5K/bDgEVaTh3hfyZ/5qttnba9Ck8U65AqFuD
X-Gm-Gg: AYBFou3P2VWP/8EXjNZrsPSldZ1tBsfOFfriD96qkaBq1K5g4UokIefm9PTtj+fjBOw
	wnM+upoGjLCGR2A3MMBN+dUjWd3YxnGJ6iZKUijInPIZ/GQQklo4GbfvZ88xJX4zNyeEQyOA0Bt
	/5ghwKqm74MtPro3qX8Dj8K1+lHi6njN1hM+bt//iWNRv63geYJjRKaYWeu85fI7hDsX446qoF6
	CizzV9xIVcp8QfPNaih7Vp97PiqZwd+j7UDMAJvuJJybPl0Y4ZxDKSqdjBIu8USvjEth1RKG4fx
	urJYWr/ieoSBEhY38K6kt81RBB9vJKL69qgYWL/lJ/C8ZNc1LiBnB8loht89R0+5yPEz1+kI17b
	RSFd2DCJyEVcwqfrOk46+OFDXUttw2gpKKu/76GI+I/NQkA8X8tcNQOeWp/qOf7zlL7SQBdGFjn
	KyXp+0BaJX2ew6ICJxl3S6D8Cuk1TPM1BS37RWPtOckozj67di5+niKtZ4IhjoYycZOeUiWmzTM
	Yw3HUeekm902u4ZfksPRZ6puH+Z1QMjdwCUE/e5ckmq3g==
X-Received: by 2002:a05:600c:1d09:b0:4a0:37d:9e21 with SMTP id 5b1f17b1804b1-4a0276ed19amr10432355e9.29.1790883429210;
        Thu, 01 Oct 2026 12:37:09 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02770e8f2sm12312315e9.6.2026.10.01.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 12:37:08 -0700 (PDT)
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
Subject: [PATCH v9 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
Date: Thu,  1 Oct 2026 21:37:02 +0200
Message-ID: <20261001193703.734323-3-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001193703.734323-1-sander.speetjens@gmail.com>
References: <20261001193703.734323-1-sander.speetjens@gmail.com>
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

