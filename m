Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422630;
	b=Xuo8ucBBsCv9xH7utur4KuSYzsJDaShvuJt4FMoOhfoa4SD/B4rGe4AkyPSHRvrbeSXn
	 BLzH8YJnrvuu3Ul2gy5IGVZPBtszOZMwCcba03ZAKCo/lPAS8adHjoSPfWyFljZz5BxQS
	 HI8iUKrDZdVwTnka4oa+1nXHsQmrLXbWdu0ar2uIr9YfLrpX3UswxnRWt3pTf9DGxYzgl
	 N8yk6l6XWl8EJRJnq0bNU1ec+nEVIbm8ewyroUxWw5d1b6ciuJsra0xnWFbjxAzqZLm8d
	 5w7bYKVppXr1sC1DBWddB1b1j/JzP0KuItujVZPmu5WYOgF9PEkCNh+LVxT5uH88uxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FXba2O0+JLMWs5otkIxip4NSbpwiNVRyJWBXXY257PI=;
	b=PNcTXR8fHDmfP+fZXICEIoUlVUG/F00Q095jINsrtHWWCbMUdMhiCBJ7uaxejFlaA9Yy
	 Zjal3Fp4SzNDeNAwUhEm/BCeBgooActUfSTSQtO8RSBbfCzRns4eo5hT98yOThg1Gccak
	 LifurAiYVtW8XlUa4R8hr6mrAi2dmuW4Dr28z8rstkbZPdhR+rJBvHJm+RQOkSZlmX2YF
	 Oau7pKbbgye9yaO0UwMvuHaOaJFBaFUUTcGyF7p9rCITwySesl+6aMtEz47dA2rDhSKfs
	 ysG6i8S61yT4QVIojJ3kBun+jgsdWpNypkR1kgbOsHhezwsr4WedVfZXqzFvLGcmCqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phj9+v6n;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DD60882A6
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 15:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7DD60882A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phj9+v6n
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e942864693so10138125ad.1
        for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792422629; x=1793027429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXba2O0+JLMWs5otkIxip4NSbpwiNVRyJWBXXY257PI=;
        b=phj9+v6nrHvgpDf33NzYqW5nOaeKOTmPMbT3+sRePhKuR5fEvkMx7NSIFehclo7MeK
         qc3FEKaiId5qtu2KYeH9qIqcGJtISczggcJ4r4vXxZiOOtddH+WBA+cldatKaHCMoNn/
         Pb2O359AkIpm3QyC3xvYsrTZI3BP/Bjt4RvDtg5uH7BqSQH+4ZdkW4aR4lG+6n42OaQp
         dPR6XvyTcfAxKj3/xAlEUL7HSPdlCR2Jvnz1g1LChT32iIVkBojoa6L7DLMviWvUhI/F
         Zon7FmH/iTY6IKi7Om3k8C+P7Bp7B0O3+gGYoph22hjv5MXdgbJVApkUiHSSOFxrQ1Vl
         7CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422629; x=1793027429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXba2O0+JLMWs5otkIxip4NSbpwiNVRyJWBXXY257PI=;
        b=Dj3PffAQcETvE3cWQd2pjZoSY5whSFMtJu0Tg91JorIVKY4jBTwZynKUZzotyW4xHz
         xpDmZs2rFLtKTtH/47jlUDOCsVM5AgHoPBzMVL0gB37meHExAHoZEwFl0f5z2e3UMaqW
         mKsBqrTlfykGmdmbOR66JcI5VmHdRIeUtfLMwXj5yzfDb0f8e0s5mEqThj7Cqp1yRF72
         74orFepWYnErbbXVl/e1+p0XrLj0K8HRICaopwTI9xdNHeCPgVxtJ79wQNhniMXiVhGY
         OKXIwexuUyM9APY651ZEYXAIxCVEsFSMn2RyF4IgA8+dH2VxMhbSLcP2ioR/9EBT0oo0
         4vgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMWVVeR1YjdpDhIvr0poly+vNbozAHCVcfJW63oeBrpxcniXVEP6RytPSTY2efLLK4fPzSMlstzJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmUoGcn2u71G1P1NOKhmDPnD4h61CcvHhad4QZcgWWIzjmM4uY
	+CuK3hlSFhoRMR0W2cNu7wdIyzlO3c1cBo8qoa7ByE2gYBunkeLadQMXHjOwMGkQ9OU=
X-Gm-Gg: AYBFou1DmupZ9bPKTCXcFUHtZ0WH6OaDYahvPI+V2406hf/Xx9jZpQE7e6uOQjYzpDT
	iI2PQb63UM6WlbCcAAwCqkPIH0VeFMsQpLNx+MCA6G4dbxdaUIOv4Mdsa/oGWGP7GXRfg368kXm
	koR7ZONjz/UguH2CSdnN+wIwe9RYItbRmrsTqpaCrjFBLlCEXtaYSfvmzbNafNhrOBeCYvE32kD
	Hz3y6np6LxO+1y8OJ/hNMUb2RQ+h43aoqchSoveu/vQieWrySSHONUcyl7+ZE0Gor0UMjhxbkL4
	yHnMRE+9vkJFZSjcZmf717WLWgFyjqsimRvjOC7R3h7ZGNzfHMlAIy8fChxVbB4JPJrTofhpM3Z
	JfXMchBm1t07bg5k8uTpGnFTepgqoXFpng+KmeIluB7Xm5HZDIF/V4kd/6AGUIjKkPTjo+K/Y7r
	+2IlPJ0r3Nh8S5DhVHpIiMSGhkG3iLK+FK7xsg8JQTxf33ojGvlf71z9uLVywwcg3V/fYLafY7P
	bDkeQoetFH2WBEBmO3CKdlP1A==
X-Received: by 2002:a17:902:db03:b0:2e9:502a:ddbb with SMTP id d9443c01a7336-2e9a6c201f3mr70422375ad.45.1792422628968;
        Mon, 19 Oct 2026 08:10:28 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1501e25bsm2625435ad.45.2026.10.19.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:10:28 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-rtc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: mpfs: Fix alarm register word order
Date: Tue, 20 Oct 2026 00:10:24 +0900
Message-ID: <20261019151024.2232338-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpfs_rtc_readalarm() swaps the low and high words of the alarm time.
The RTC core reads this value during device registration to initialize
its alarm timer. This can populate the cached alarm and timer queue
with an incorrect expiry time, or leave an enabled hardware alarm out
of the timer queue if the decoded time appears to be in the past.

Read the low 32 bits from ALARM_LOWER_REG and place the masked high
11 bits from ALARM_UPPER_REG in bits 42:32. This matches the layout
used by mpfs_rtc_setalarm() and the low/high assembly in
mpfs_rtc_readtime(), so the RTC core imports the programmed alarm
time correctly during device registration.

Fixes: 0b31d703598d ("rtc: Add driver for Microchip PolarFire SoC")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested with KUnit under ARM64 QEMU using RAM-backed MMIO and the actual
MPFS RTC callbacks and RTC core registration. All ten tests pass with the
fix, including importing a preloaded alarm and checking its timer queue
entry. Four additional tests covering current-date alarms also pass.
No physical MPFS hardware or suspend/wakeup was tested.

 drivers/rtc/rtc-mpfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
index 60596b0ea9d8..6616ca1f02c7 100644
--- a/drivers/rtc/rtc-mpfs.c
+++ b/drivers/rtc/rtc-mpfs.c
@@ -131,8 +131,8 @@ static int mpfs_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = mode & MODE_WAKE_EN;
 
-	time = (u64)readl(rtcdev->base + ALARM_LOWER_REG) << 32;
-	time |= (readl(rtcdev->base + ALARM_UPPER_REG) & ALARM_UPPER_MASK);
+	time = readl(rtcdev->base + ALARM_LOWER_REG);
+	time |= ((u64)readl(rtcdev->base + ALARM_UPPER_REG) & ALARM_UPPER_MASK) << 32;
 	rtc_time64_to_tm(time, &alrm->time);
 
 	return 0;

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.55.0

