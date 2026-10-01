Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4B404882
	for <linux-rtc@vger.kernel.org>; Thu,  1 Oct 2026 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883434; cv=none; b=UbHuB1ZOECFhbh6mUt/HB6Ia1icWOzbjfbQe78zdWSVCm7zJbAFKj9ZX1Gt1S3fxYJ5oLRkhoeno+pFhjiqcNDeEMouPBJKiuNBusiH3U+ts/9PUa5VV1TCUy8K6PZECIXSGQIWvuDTyq2oLhqw2944HodyCfHXBfyraGsq7lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883434; c=relaxed/simple;
	bh=rS6c717NbtnG0l1+5GpH4ytvlZFDwR+VAyuHQIHKXB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI4F6PTTVjhKq4xwWseMULGfIIsPuNALz3GcKu2jLS+DnLZolekx2ltrX7ClvXhj0WoE8NyjyUyi6EwUsdujIfZVI5Ba3Q4mj5RRxMK8kBWew4wdHlypnObGfuEiOOBziyQmxf96+TKjJo1FD/WJqshO/YdEZ+84YKWypqcKktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0YuNn0P; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0YuNn0P"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so43423215e9.1
        for <linux-rtc@vger.kernel.org>; Thu, 01 Oct 2026 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790883429; x=1791488229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWKotutjFYkP/VqxUCwmViQ7yB9g4hE1fzeaiZxfDjc=;
        b=f0YuNn0Pwp8D8D3J7DRKel+KutpcJfFSSEXB+QHbmNxmcsZmhxq7+Ql7sdTX20Fc8F
         oS7qvYWh0quYn9hVBECLFAO5sUQjkIxRtclXHwt5Aa3Y39B5m3vWPXBF43IoLHZ3iaX1
         1S6QKCpZfUsBL/J694zgqTGqhcH8N6pYCYqWvbZfsmzDDz9dOydyM3zc8k3iWxKPOTMS
         zpBBt45gCXpEAcjoFv85eP3gppolQ83ebyiqYPpqKg3O2QlE5ch3CYowQcltmnMkrnm6
         0LTUKT0Mq2rh6dLyaCMkD1LSTlOgmpxfPGy6GeksCtAbMPXO2WjM3mUBzSAMxuOZreWQ
         jJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883429; x=1791488229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PWKotutjFYkP/VqxUCwmViQ7yB9g4hE1fzeaiZxfDjc=;
        b=OGCiEGRxTDb6MQTWds0JsuMjyiS3EFFIyudw4rKcHVYiVxr9GQd93wOhp0UCjtCYSK
         y2BG4TFOcGM6qM06vB7e3Whe/x/2Q0WdZQxlEBSdkz9R2ybs0dDk7E+F3txoUTAh41kB
         D7RgLa0o1wxn6M8lW+oz72b4VEvb4s2spGNNKKcZeWdzfBPnlzlypLSRSfAUKMqg9zOX
         lxny2Vd7gJbg8Lzge/Wk8Y/E8rBD7yYijXNiCVysfovsvgPTMKtFMEtTcYwOy8lcbFk2
         VTnlBxp2ARbKts9R8wyw2H+zqrztTbc5EWQR7CjTa1+0pLCGEhBWLfPqx/EBnppUCdgf
         Wl4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLPrW2Chv6HlWLsMTLSVef4EFSV0CZl46kpr+XyILZ4iuAhtVyzZM8zpJV7pcJ4LgvHn0WZro7TWY=@vger.kernel.org
X-Gm-Message-State: AFuF++lBSAxs3vstbaQ3nEX0vkw/NFonldll8tU5TDy70DxZ/AYIkV57
	6qxCDTz+sqzQWiQuLTcKzYiHmkKMNCa03RoQDcH4W06vIdYGfUxOIkFL
X-Gm-Gg: AYBFou38JSCLAAyKoo1sgdCdrhjgORZpvp10WoeOlaHS/bt8pyEPv80XY3mXA4CDCdz
	BLIGnQNMDWPKkFKsa5bJQkXUpZofKpQtUP9qpSjEiZ/r0M2vG6QcqYtXKIMENh0estVIWVUP75I
	OYWr/eq/2qJYyqImgR0zuNaY+f7Uu1Wz/fz3fPBIv0Znwdw1P+MhRkGcTbT8S8u98NX1cSCt07j
	Dk8uwUfJIlup8k0w5AfnIjgbkqgIUSrxNkqWxK9PfdzwaZz6+DQsevuFS/tWkEANjm9Zmp1yLYV
	y9JUA28h7kg87qPU+bDxzffSD1Zq1F5ztIWmihlZlpPDXPk1GhILhwrQbO+hy+ljzMaVUCdECGU
	8CFrGs6XELvdpxDze6W3m3Lg092Q71jSt0wIQi7EK+witfIeQcP9zPMpHwMiGb8Ix13SFrefFVT
	BAXzo/84CKCy8bRuXObqXAjn8AhFLUexPSDXWMkttcbZ0M0bAp1ZPFLam3kU4qOeMKHuZBN+W0P
	jBU2CzxyePq9thBTfiEB2JS4R50Mnxi/2ZOBKmlwVNJKHlYJbQVLRx8
X-Received: by 2002:a05:600c:620c:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4a027583fb0mr9480755e9.20.1790883428472;
        Thu, 01 Oct 2026 12:37:08 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02770e8f2sm12312315e9.6.2026.10.01.12.37.07
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
	pbrobinson@gmail.com
Subject: [PATCH v9 1/3] dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
Date: Thu,  1 Oct 2026 21:37:01 +0200
Message-ID: <20261001193703.734323-2-sander.speetjens@gmail.com>
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

The property uses a non-standard unit suffix (-millivolt) that is not
recognised by the schema tools, so the type is not inferred. Add an
explicit uint32 reference.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
---
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
2.55.0

