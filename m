Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869B49E5D0
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966636; cv=none; b=Ey/dFIibL3AGabmxCMkn/oDefyxtbD2iyoAEITDPF1hRj5Jn3sBC/qoU9wxSpSE5EIiGxesIjmdzwe4YoA3H4T86/swe3IGewpiRupd520fCYR8UDcVNs+YchvylUSRslJxm8k+qne5y63RWk4fuQ12XdL8CAw8q5O4u1RAOl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966636; c=relaxed/simple;
	bh=sbxJIjfMPwOx2on3+UyWC5RWChgJP51qCvyPHjSCijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL4BMPrrcqNLRUX+0V3YHsfCZogY9XEPgmupLsNRzWTrVkvMUSyQHsROg7zbr9lMgEPslSJpjHg8RoMJwUkE8GXsHkl3PFdb/mJjyS3kjw8673lPyJ7/N+7kMPx3KVDaF2/9VxgrdVoWMmA7GEkKSBG0tJopFbwIn6+ueNriIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPmCJQgg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPmCJQgg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a17baef589so5925415e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966633; x=1792571433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QK4mu7evKVOV2GEU9FhgXywXMUX46qDQRJW8ekwQ4SQ=;
        b=lPmCJQgguy0qxTr8JOHJESGl9KuUXALVzY5X5/ZE2ltQ5tc3ByYUqXcEY4TpaKdzua
         6RUM/8FD8OqKhS1op57Wqt/ZqcO75NHBW6LxfEh4qiPhy7g5s3LhZix4BvowBsvLg9NK
         zfXCMKr/J1sXx1CUamfwjKlfGDKCPLm4KHMD1shH34SbS9+VCgd+rF4nXEDNMZxfqwQC
         XJiLPdYaM5MC7adcutywV1m+zla59RRW4FcwHhmJuev0O9f2o6DdsbhiS0VxNAVZt12g
         yUWIAqoBpLiywJOqwZg7FqSc+LPNVvBcb/louPcW9xnnqWOBeg2lAp3nd5VI3kiNBvRh
         Nx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966633; x=1792571433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QK4mu7evKVOV2GEU9FhgXywXMUX46qDQRJW8ekwQ4SQ=;
        b=Ix9plrH3tw7yX1mQGYEzSOWtS+OJFkIzaFQYvXDnyllySWzr89kBjbG4X1E1inihDT
         Xt1kIajJVcSUDhkRPGU0fsTr03vAMj8dVwsf1+e51Ty3/EWcibAQTBmSreTz3Dt5wmOV
         T6OiJWs9ssBrmRN2VlP7XaTjSAydyQenqmFhm7YuVDOmX+f/GBbG3T7pVJ+Sgx/qDFJv
         cPae9n3EqeGbdQ57KSo7ahfAXRq/jvaGEddgP88FujYI6GO5eh+s71drz4jYVXL3cxhI
         znFNPTHnCQ2UHI80l5W6SgNTONq526NjKD6YrlWO1lE99/MESr+lpE2E/C9lmFNMFPN/
         YGkg==
X-Forwarded-Encrypted: i=1; AKwUvBwTZRHTCLvaXI9q7TL5P3tFUrfEdMNlcQ+thAz+w12ZeP18vwigDFak6lcMIuCWRtCjciyBdeUS3zI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj3asAA5t4O105+oUeduhOEcek9dXhCA/wLgMWtt2HgAvuzBBJ
	7n7mUA3ttjPcSRRVekH13P6AXf75MMQd8s3ipjtcSZx70PtSGZVrDSEy
X-Gm-Gg: AYBFou3Xfv4qXyBYhXwU5kktodwZjU4c2sqVYVdKlv1aE7CFi+gBxN/ukkb80EJ3mAJ
	4WiLPgpJLH3lDFrz1ndNF7MPiCi20aGhBnWEkp3sHyL8mpNdq1nyd535TxyP0YftkFeYEn1hCwy
	iQKrKHhCX6oupo8P9kTEgtL0RNkQfUKilvqIEP+reY2HT75lCN/KFFmtzj4FIEGXZb3LYJlmWlQ
	smMcMnUA4RHdzPQ3lOVGedGTRv+QiV5fMgYqVUu88CDrsjm/KXFB0AL2gup9W1YAoChS9btYJla
	pJaFpBEpsZC4AHRh1OepaWm11mZ4SciidiuEBrYGs5fY9msw3QBwn2OgyXS1cumw3MF4VlRj4C6
	Vo5Wl7VAPUv/hWHJ8fxaE2ymxqsghIcfY9+6lKji2fbcPh5fkLlvCTCELOwL2qToM/70igM9Ey8
	FzvBAGmihcjCvod+Rb69rJOmInxgZs7fV2rJWUmD2UA6OiKjOthTaBDpiET5tuDPmFKHIwTo23n
	0bX35/jrrK81L87wFEF19NSHs0vvtrftDCh0ntUYnkzQw==
X-Received: by 2002:a05:600c:1549:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a18e491051mr334974655e9.17.1791966632877;
        Wed, 14 Oct 2026 01:30:32 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c198134sm431809745e9.15.2026.10.14.01.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:30:31 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v11 1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
Date: Wed, 14 Oct 2026 10:30:14 +0200
Message-ID: <20261014083016.332338-2-sander.speetjens@gmail.com>
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

The trickle-voltage-millivolt property had no associated type.
-millivolt is not a default property unit suffix, so the schema does
not automatically infer uint32. Explicitly reference the uint32
definition so the type is correctly declared.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V10 -> V11: No changes

V9 -> V10: No changes

 Documentation/devicetree/bindings/rtc/rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index efb66df82782..e46d50b1063e 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -51,6 +51,7 @@ properties:
       if trickle charger should be enabled.
 
   trickle-voltage-millivolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Selected voltage for trickle charger. Should be given
       if trickle charger should be enabled and the trickle voltage is different
-- 
2.56.0

