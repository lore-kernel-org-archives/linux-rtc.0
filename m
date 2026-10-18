Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D37377A92
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335635; cv=none; b=Kn2tPx3qUntJaKeTnEjcUTYZ6AlDvU1RjNGxzGePUOvt7WDWHIeIMmnnvUhl3O9RIMD6usyMeJf2KOJ1+HLHNudkikZlaNCVrf9G9md5tNjqX+JIRy+quZ1+pQmfAbc6nRHRVBzoCZPWqV2CtDD/lK71reTGxBLfVxk1LT/Urz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335635; c=relaxed/simple;
	bh=ORYIe/QxPViQ/7ybfElXZkv9izz1FVsJ4GctpV5r41k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKIMqB9a8uhVASXQ5OY8lHuRgpPNdAQL8VkshRc/H0BExJce6SdPlYOypfcp3b9uhRCv/Ll8cnuN/VUcKeXDFFrMjZNjHPTNBzd8bWBehpEuCr5E7QOUjhS+eRTEW6+IWVAXN67B8EV3CPuqgaNS+5V6lrJyR98EboaPodP4LF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IROAdDmq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IROAdDmq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso14694915e9.0
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335632; x=1792940432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IibueGhEEmNd2+d81oLiHRI9L7xBk11xjq6MNbG7ers=;
        b=IROAdDmq2vTbFHvoLxt+T8c4XlsxhMaYDAmPF07EdowMHs9jKzn8j81PQEN4nkhap/
         rrbrP360Sdl2DT0CW15dhBTSzCWSQeBbhO/smFbeYnOkpNfk64enoubybHLcwYn7+/T/
         31Br2DtBA7C/6OkoAijuyRPm3A21y4i0XhhdSRo4OiYzqai6D/C6YYz0p2yhYOJAy32N
         yFyY8yUSMSPMi8eGmY967spoi4SlSnylyApusM0uypbToNFd0qyV+5jQlAfdc1/b+Cbf
         yVcVJfQpWY5Egq+OkqrWAnXJJgWno1ArPtJwl+YL0u6KH+z2OSsCyKQVPaU7z7+lFDxl
         GxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335632; x=1792940432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IibueGhEEmNd2+d81oLiHRI9L7xBk11xjq6MNbG7ers=;
        b=KCqUEohbtHZys89WUyUdOhkMjaNGeSCnoCovIq9PuKpBfTioG09qH7iPuGTVrqduvC
         BFK6RuJ2ylORzXYusdIJBXm/qqsB+nMTY6bOABTgxgFTU3oON1QtviF6T2osQVlVbdLA
         dDpebLDII0nLiT8HhU2+MyzU0NAGtTtgglo76SO6hDQRLfTM5W6ICG97KCx8gvRCqH8A
         kL/1xKm2H5nDjLv2stOPeJniZPJMd9l/17tnQ1YnTnjEvkKcxcFpebOPGjAmnBjLqnvC
         +MdKpR4yZalQre2BHO51AY6BrRUgCzw3Af2EhZOWUCDrvpNA1++fbR6x4IEyOi7lD0vl
         QD9w==
X-Forwarded-Encrypted: i=1; AKwUvByH8SE2bPVGRt8nMJWrCLkAxlerJDVborIesnKoRPwD1ERHQNMeMoG9+J3eBIZxpGm3CVmAuQW231U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmbf6+H82rxUBQAbZExSBEG8eUXB4NukP6M++AoSed/3yDdGvi
	g315lXPFqgzuqeY3yxTjVAW25no62f0QY3dcD5WIK2clLxZGZswvPDQO
X-Gm-Gg: AYBFou1aTJNA2U95hfVsdRlKJ17cZguCmHlua97ISExxt2Am/nv+1Ozqclsu1+z80X5
	dORnfvyAK1kS+DrEVVLPzp0l3R385FOKnyUkAO7+Lxs7cwJWTRXFblZpMKHWMrmLQBvhgysrKmx
	neU8cQ1LT3Di49KcBaEgoLULdmMevtUmgEl/WJRnPDgkL+0UYr5JG78G+asTW8YJjTfbAtwOqUp
	+JoJHW6gL2wmxgEHmmG/Qt/K+OhW2H23YHZOflljhqu+7Zok7fTcjaHz1wBb7V7CMs8BneyDTA3
	LiN8pDciuvHa6noPXH1VXOAi2gpzBR7prW7ZUlPItpqkg1YWo5SGn+qQV29uvXhKFUfq5JKOCqs
	g2q27Uj51AUrKI94pPqWQ1vFGVLLQbBp505bRi/A8mFyNR2MuFAPhG/Hw6zoISWbbIS1T2GUqeU
	N1tM3Dgj5N3swF/eBHevmzxIdccKXzp/4KSGAgWnN/EQc7xiMeVCXLOvPHTHngf5U+oorjdbLjI
	kgzW6Cn19h8/tbdDOAnX6fbg/Es9MHpfXDtHmApcqHjWg==
X-Received: by 2002:a05:600c:5254:b0:4a1:e57b:667e with SMTP id 5b1f17b1804b1-4a1e57b68c7mr27470435e9.4.1792335631733;
        Sun, 18 Oct 2026 08:00:31 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6245sm212868925e9.3.2026.10.18.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:00:30 -0700 (PDT)
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
Subject: [PATCH v13 1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
Date: Sun, 18 Oct 2026 17:00:26 +0200
Message-ID: <20261018150028.1047172-2-sander.speetjens@gmail.com>
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

The trickle-voltage-millivolt property had no associated type.
-millivolt is not a default property unit suffix, so the schema does
not automatically infer uint32. Explicitly reference the uint32
definition so the type is correctly declared.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
V12 -> V13: No changes

V12: https://lore.kernel.org/linux-rtc/20261018143712.1040152-1-sander.speetjens@gmail.com

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

