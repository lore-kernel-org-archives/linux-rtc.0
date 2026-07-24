Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A63E558E
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884616; cv=none; b=OrgwPEBHrX6BIArWbdJEBfG0NEaRZL8Ov0Co+RVR2EkCHQydcayMyLybuCOdz53bWRfLeCYCblBCJvPGVSBOqVjRfKHuhqpRlh8sBgfumQWXmp3ia8DiZaiEECfy9pBu4WviZ1tGIdXkJ6zHq5EfjyRRL7Xc0I0fDmx1AtmDYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884616; c=relaxed/simple;
	bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvuLHg92cRGZWkAuGksSlqA8XuxaRCbUlkrgR3bj3lGtst3UuSX9MjWObb6lrWPCnRpP36MGlcghDjL+czfXUmJ2Yj21UcLaUQigR5h5KGJf3M4NH3fDqld3tOdxKGjZ60HF8xw/uXfzVF09d1ioF+NjOUUkQYfNCIXEXFpVUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiHKqu4E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiHKqu4E"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceeee8c46bso704195ad.2
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884612; x=1785489412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=fiHKqu4EJGgMHXnXp6L184mZxNrGM529+npVMBSwneTqJs3z5ODgKim4QbW3zL/J+Q
         fLu5DSa/BY1tYyp4/ewjN7zLbhNefqQAoeVT0YaA6Y5z2qa0J1D2teCn6ugkHO8IGibn
         XfVKtQTQc/Zw4oVuE/DA1OpZHcaxo0anDP7rjPOu4rx4+AsvYiMecd5uGHYfmvwRM/Bt
         gW8QJJaxe3b2qbIKJ1JUH7HiD2tpSOkkNC+mPOWX9k6jEqi0LFrLhznGhEwAUFncWAJp
         6g5eap/lOkveQyAZXo8K3O03onKmCwjBR3bhVbR0324oSeO5YAh/5kbGlsnhJ1VsDVQ3
         a5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884612; x=1785489412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=QpoRQEq2iU+wTKGrGFbzCI2oJdblhqvuZ5MW+PMXB3DFIlQSUsF/0hBWTfQpyYMGOZ
         dsUfhOpZg/N4Wk3nio9U+qHfMQDwKMFDafMMCeQ5fa2JW7rwhV4RoT06qBdrTXPpXNXC
         F8hxv88EU2o13xVF7TcPmf/FE1Tb+hAP3nIEl1uvuHsgannjiAUOXGHi6fK8NxNBMA7w
         wZzhY6sdsDidisPIZKVL1DMX2wGOwYnMBBNLZ4U9JLLp8P5txw+SQUYbfX7QKDrXXymz
         6bLmjN4TwaXtM3xnCwOTSG/7CztjcT80dOiFrJFl2MfKBzJqiU/X8v6LaSsKFFa5fYz0
         5cQw==
X-Forwarded-Encrypted: i=1; AHgh+RowCYu1Lpcda4Ya5PaKekU3RKNC9KAG2bdO+hccS/kPkHypcn66UoV/jBAeIIahNRSFCQGaog4GERI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VwF2dMedax1qQE14s9Bh/sDfZgQ0X7uuvil4LQaICfqL0fOQ
	z6kpyr0Hw0FNVUBr1Is0+2o6ZCqbEqLYeVbfglBYj+XunfASfQLcRqrb
X-Gm-Gg: AR+sD10afAy/tAQsgVZZaqXJ/HIcf81rl43GRY5uJOCgGikoVBDP58u3cz7zJMgy9Lb
	dWiSsm0a/epnFeb9+uvLnEhRwImg36BnvBDMZYNcTPtOuv1rkS2s1yPXGhWAhPrhHgcJaZrC55/
	XWQ3fAiX5arfr+iYh8U+Kr+C3Z8hz71xwbSAkSIokmgRKjpzk0gZACRXTq+JUh2yTDHaZbsZ9B3
	5zPQB2PBb0gTCBcvAMy2wiGETh5a63FObx/hCy5z2xJLleDzBhjZlUgUQ3Wwa/9s8BqjVoQ4Vd0
	G7DE9mZJKwGRZ8eIo+rIkdcaipdLTUE8waBSmG+usiYwMtO451DTmr4qMszSJ/rfzAWYiRTxD14
	jVd+uuI8h/Z1G2mlAiEizwdw7gzHOsPqm6owyF9udZShuYlbfuW1g62PTmJ4NBhDFiCFQC7xF27
	QT4wSCz6q6DCs7R88=
X-Received: by 2002:a17:902:c407:b0:2cc:9d9:b8df with SMTP id d9443c01a7336-2cfbd6c2190mr26012725ad.5.1784884612321;
        Fri, 24 Jul 2026 02:16:52 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:5420:f772:24a9:f23f:ed43:a5ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm29005610eec.17.2026.07.24.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:16:51 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 24 Jul 2026 14:45:53 +0530
Subject: [PATCH 2/3] ARM: dts: ti: am335x-shc: Remove unused ti,no-init
 property
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ti-omap-rtc-v1-2-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
In-Reply-To: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784884567; l=689;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
 b=qgIljkvJo8Pw538QpYi38SdB2bfoEKRFcMhduFDIDBZgFEnXbar8/uhoB9qVZXaWC4gEZQ4bS
 9/A5kB5cGYjCb4pI0AgRPXoaGYRJCRcr/1P7JoTKap1wx1zm0tqUH62
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

