Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4803264DF
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926956; cv=none; b=V2eFDEe/zA7VsRXpKXZHsf94aQga8XqISEpvv5EPKfOVrj1ud5WKdXMQrjOU3lmrqXP+aEUSj7bp+K8qM1a4FF6bB38TR97lilMbLpOK3KuPD6vxjEF2m03h8POhGlj4uYE0MnI5I5EFj0APULymoBKTUERXL1qwwcrHeqgSpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926956; c=relaxed/simple;
	bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8gS4v8UAYOWvoGnYJPmeRfjuBcIl6poZh55ulPbqucAXprsl0lKYcbkH7dU7oHXWa+wlH7bdbxNDfybPp5W826IIuj0tD03ShT1PU1XvPDzHTKiRso3YDmp9nEeIFvkCDao78LDzKT9/efayzy6GcYj25ROe5jSz6VFhUdzWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfiW1P8Z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfiW1P8Z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso57439a91.2
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784926955; x=1785531755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=LfiW1P8ZS/ZESMgWDvDXF3Du/XRUg/2lLHGnWeOlRofkS4hRgKu+cxSLluflt3CyjT
         PXEclwGiL4+4AVUbaYv5kki/OrDEpiJD/w0kCGb7hJ8dtg4v892MImyvSLMPqmvyxYPK
         FzK4225qvhL3X+hAOmorqfWQX3XPm+Go6HMNPTYexVtQNVU22ESeqttjRo+f7C9TcRmE
         hBb6CDcLJqTrO4eOaer+XVYz5+LXZwIzeeoiXX7JbTy8XiRRTe3u0ujrMVraUgxcNVMU
         U/uCV86Pgjtux2Jit/Op/es9t5iPWBTk2U7ti+zWjx8d0YGvkFVF+iAlfhldN/EfGSKk
         vYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926955; x=1785531755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=KW93v0hC6flOTyo37trgkBE6ziZlPlXWMSy3PnegUpb5kFbf3gAXFZwQ3+CCCi94RD
         I0aWD6YAnLzlU6MYHI12UElJBlXFNjbhC7HPGtRQ6E8NWca1OGuxi4mJlHf+fKT2vNb/
         6a92jOLvuiDmYwdMO6/5Pa7hu9aJNEtVnskal2jHo6h57wUuj4mGUel8qrVVJ0FZt2Fe
         sSyKQc+OvJtQTPsBPKWDMtLYkwN8DzWipyshtGCf/ZPj/ET7A4VWG2TiriopClgqNWFS
         ZWLymPiyifxPwyrE4rv35uOESFPx8/Ja3RSvUjjvMlaop5WLp8w4TwJRhtRYxfEhs/qF
         raDA==
X-Forwarded-Encrypted: i=1; AHgh+Rqgh+Q2u9ThPUwUzVrV38j602XbBe2D8kp8Pn9YIFiY5/HcEMVM/At2JAskOCY4T8NDVJ6FXzv89to=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNbdZQKNahj2puwFE800/Z9jp0N0O8w9SUhDKaL1UUTLXPq6z
	ruoTVV2YNCDHVvqEVbajqDeJAKaC8Cio4Ghc8YmqN11dQp0b1hDzIsY/
X-Gm-Gg: AR+sD11Ge5L5+lO0mVYu/LuFOBp9M/UFSeUCVgpM8S/53tn6I1UEgIRPMa+k00/uwix
	raaWELocUcFqhr8L8Sdmv5TagjO+n8a+Jb3OqbLwwT5uKqyWzHZIn3OLqT6WpiXIXBOGabuuTbk
	IrV2cbFtHxM9YGtI/4KIM0wXc02QXOBl0A/MJCEyNvHJvS90GyN3aqCnUsSFjVHwxd6K2N9i0Bq
	eha9GGk3UKmRAbQ4zOlWScCz4neqBOcY6fd0AYsDlP8205ySTw80Hxxgh/SXl8TsmnbOuxaImax
	PPZq/gXthEj79wLt3jHd5kS7d0dB7twf4h9LTinHkEjkvkeqY8ZzeMu8Wgk8xCjsc7j+qb7kKfu
	SQ3fxNBi7+QslxldT0beXIs1u2eqgBCQq7fzsrvhpWZ83JNw6/NjqyGz6XX3w0gqxt9f29Pr9pw
	i3alT9Xf7cEJb6/AE=
X-Received: by 2002:a17:90b:2f05:b0:36d:b30b:14ed with SMTP id 98e67ed59e1d1-38f293c6044mr58730a91.2.1784926954876;
        Fri, 24 Jul 2026 14:02:34 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:505f:3320:3d54:c6f0:368a:d94b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm2485324eec.19.2026.07.24.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:02:34 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 25 Jul 2026 02:31:57 +0530
Subject: [PATCH v2 2/3] ARM: dts: ti: am335x-shc: Remove unused ti,no-init
 property
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-ti-omap-rtc-v2-2-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
In-Reply-To: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784926923; l=689;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
 b=KOMlrWJBSgCQ58z4hGD0KndOSJu3JPpG7wvEFOkTt91LKenGQVK+yI1DudVtQt05AbabXzjN4
 cdp+7KH6ldtCOOP0anv94T/cqy3gRDKiyAvuwTZrReIeYmz0DMLGIfy
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The 'ti,no-init' property is a legacy, undocumented boolean property
that is entirely unhandled by the rtc-omap driver.
Remove this unnecessary property from dts.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-shc.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-shc.dts b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
index 597482822608..2b946823928f 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-shc.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
@@ -241,10 +241,6 @@ &mmc3 {
 	status = "okay";
 };
 
-&rtc {
-	ti,no-init;
-};
-
 &sham {
 	status = "okay";
 };

-- 
2.55.0

