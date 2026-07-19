Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0D242D88
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470234; cv=none; b=UbDvwqcCdrF5IQYcMSnYY4ssAm8X4DaMRUOgjEiE4rFmI9GpQMlAEySKI1B5P70/kSCaxIDpauxYFJHYTT9JYuk+z9XxYvAp9Ws1otiSx81rws1eS0s1gwReTo6Eco37pPWdTFzqjsg8EDscs9AtOJ1TNvSIwZvcW/AvAMhoMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470234; c=relaxed/simple;
	bh=1v4jx88eOjwpIxo/vM0L6nRfw2ufOcyZeERWgwj/FXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCNu+cRFCkhQcUtODqWsE3IrzmcT1M4pr05r9/UJWUsQr5+0ZX5QemynUIePW2eyWLv5OIa53O0OhwdsIzjCz8FNnuLHnCq7YsaPSbmHYg8znX82qumZHVzn0yRNA55u5yINcPoqSkeKJA9Lozx26ZusY75GSJ3PrpMFl2ei/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V232Nd3M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V232Nd3M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49553515a8bso9756085e9.1
        for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470232; x=1785075032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Rq18KrwyxmENy5nVsOEr+/h8xbbEY9JxM7ic+yQE3Y=;
        b=V232Nd3M3Gk7hihm9YOwxSFUmSCFZvJ2gKWr4X7/n2cw4s4BYirzmPqpnX5KJc0pDp
         CnWP0ulUosIbNmggxOafG6chUTyELA/YAMDfpijVQBADZ+X+RSGiFMTCC5RrufXJhDb3
         4l56jBhjGVNov1HWyi8ZxkXzfwb/CShIUuZ6M3CAQmvhNe6Gtto/icFdo5yELg87dCiL
         CH9Pw6p2W4wAOMM4pP9pVwhazJqggu3r1Cx8rTnCeangItC3MAiN1fhAmiC9HIzJi0Jh
         mVLIM+ARup4S/5/fTeEwXycGULnsOtGxvSfTBuFpPv6+otT5bX9/qaytir7iIP2m9M18
         nWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470232; x=1785075032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Rq18KrwyxmENy5nVsOEr+/h8xbbEY9JxM7ic+yQE3Y=;
        b=BPlovsjHvP94aTB9evJSagiwkYwjId/K+/Ez1pPBVbDR6BZFb3Lcxi54PnSoHxOJVd
         u/L/DqdFiFOIueGrpcwTZErjARQluhjcQKLMZkqmw5q4DzTt/mrJjHyN1htvovi4x5Ot
         B2Dg863UchouEDdgYzNTbmp6tsow1KDvrbCczYjoqORxDiUH33U07003/xPf3B8vIIVO
         TAO0xHpOCjf/PUBErAxP+usKxGLj5FZHyTFun+gKHKWYbY5T8MZ/Qq/dARXrGwsCrfsr
         5khk/ytdNxHqViN6YLErgp34CuygKeaUdz5VjJ39WI/z2kZIAHiENacp0NHTCpVcRkNC
         Sxbg==
X-Forwarded-Encrypted: i=1; AHgh+RrLEPkp/WdV5qYvFRbNWSYClm2gyd6V9wCzZbLbzf86FCWr2VBkV3PMEUauzLmnyxNvaDqd9dzoX1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgHZg+mbxsxwzetUmfx24Xtfa7s5MZu+TDw9YmTRcLKpyBM6f
	KlNht2HrKUvUs+/fdJMAFfUB2fGWbMvxZDTsuLJXOqRhPdVfPrLAm28H
X-Gm-Gg: AfdE7clGNeUkrGcEl+Hss/glcYVlSzV6yEpXsvVzcgLqt3k4bGilO/Zma9dUNSErZQC
	YMKlw/bbH0v0sCVsgYJFsfMOcJkmU5N/gZ1+UyJWTPpgcdoSbMMnmtOyko5Wqm4J42iR2EPz7U6
	9Dv53kSneE6FZAHCNkkAaCDVLjzZ+ZfHbi328kiWIhi+odOFY0mw7CsfHfbCVu4Xozcs1trjPNJ
	7MfOyoLs4+yD+oXkKbWiBlpTYzaI1wOtcyQA3h1OO44HcJKGUPhjg3IeNFMffzZLmrRPAQG6unu
	L+abBIBGu9MZifjeJGKCxbesBIBj40ydAxzQPfAsXrVDRaaz63njoK7qRDNay7aIUSP49bHYn2+
	0Foeaq0Uw7QyrWJBlCFZG2m97lqciheobH5csTiRYrDaefTXnb9ObCuaM+qGIPohCFwSc+XyBzJ
	aVykMhYqvaOWxhtoQiInqny8S49yfOaPwW/jHP/H0/tVkK
X-Received: by 2002:a05:600c:4505:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-4954a413087mr105760505e9.37.1784470231540;
        Sun, 19 Jul 2026 07:10:31 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm21264859f8f.29.2026.07.19.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:10:31 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH 0/2] dt-bindings: rtc: Convert to DT schema
Date: Sun, 19 Jul 2026 14:10:06 +0000
Message-ID: <20260719141008.3562347-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Texas Instruments Palmas RTC bindings to DT schema
and resolves a node name compliance issue.

Patch 1 converts the text binding to DT schema.

Patch 2 updates the tps659038_rtc nodes across the AM57xx device trees 
to use the generic 'rtc' node name.

Eduard Bostina (2):
  dt-bindings: rtc: Convert TI Palmas RTC to DT schema
  ARM: dts: ti: omap: Fix Palmas RTC node names

 .../devicetree/bindings/rtc/rtc-palmas.txt    | 32 -----------
 .../bindings/rtc/ti,palmas-rtc.yaml           | 57 +++++++++++++++++++
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |  2 +-
 .../dts/ti/omap/am57xx-beagle-x15-common.dtsi |  2 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  2 +-
 5 files changed, 60 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml

-- 
2.43.0

