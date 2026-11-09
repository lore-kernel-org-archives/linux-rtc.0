Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263972;
	b=YQfONEfiB/0i5+pXHondJvMDq1cF57MLhRK48df+0pestxtIl6p1qvT7x4VWFDp83gJA
	 PtkOkiIlDPGFcnMua+YUMI4VB+MYC8TAQWCUTzgPeppvS8g2ISustwE1AtUfT4ciaM75S
	 uh6CMdwjuhHFTmwTGUtTpfvXoQlPkDBLMNUxEQO9iwe5K3vT+5JGs1PRBE0ZZIZ8uYo3g
	 FwUCifS4sYna/gMFtvlFr43mokEx+Zm2BBpEkf/pcHnMyK3dQehWAnA4KVCI934w2PnV+
	 7RYycu5C0UfbCHD1R961Jc1fNqAZa8pqtX/eCJtMGyrCvLpXiKiVZzyZtUlrCIjTbug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=f5/2hkILPXv0OuM9j0i0kcGnJ/LQc2BCy9kfJaT94AU=;
	b=Pptl+x0z1v2jqjnc+WAETDumtF1AMzFJE2QG/Z5rlWyg7cEWp0Uz1V+D4543Z9Zpouos
	 S5xmouTNNd+8T5GkuzAKod7Xh1MJDPzAmaH6whKUYBFF2scpp8uskHqYWoBCvaJn/aHqr
	 lNHutINQ1CyOima9WHiGKCHBIFR8Mf0gthOUEdvE2V8yeqo8XjJb+m9ZLAh8fAurZCBUg
	 0Gj7PtVOB+xybOc2GwbF3/idQRXOcnc6ncVc4eq/29naU/xLLUPW6V2Jzl2umS/Hgx/lD
	 OimE7A77StDWxOUNPlaHZIMej1YpYIbGWBHdUWzO6D/1kdb0sp6/6jP+0jyTAjjqSkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPztWOiT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15460A261C;
	Mon,  9 Nov 2026 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPztWOiT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AE41F008A4;
	Mon,  9 Nov 2026 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263971;
	bh=f5/2hkILPXv0OuM9j0i0kcGnJ/LQc2BCy9kfJaT94AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPztWOiTfHZ4Syf9q8K1e6p2aIy+Q992lEJ9gbhJqm11avFz9qQanq2OdPPJ50Quj
	 ZIJd61yCYeIskSgeSdmVMzA+NPg9egOxMFGofHiqmOyUhgRm2d2VxTbbBZueehf0Ly
	 +nnn8bi0f8qLhfvm/0gWUKsMhlrRfGMHFDP0XvD9KRZKWQap4ahgi3HBC2GkUf1n2u
	 42ZZTmes4ycNXsTtm/hOCgQP7l33Vn7Z9WMQXCpizPXcgfoNryx6KtaoxmUWFhgZ0N
	 BdwMy7/PmsfVyHBjnlJfsyBXJCi04a5DcW9wuq5XL0RAA5RdkA4hM225fVUAGVJ3ZS
	 IorPX2Am/1kaA==
From: Thorsten Blum <blum@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 3/5] rtc: gamecube: Explain why fast_io is enabled
Date: Mon,  9 Nov 2026 23:39:05 +0100
Message-ID: <20261109223902.84918-8-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109223902.84918-6-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=blum@kernel.org; h=from:subject; bh=zskyso+rUT301hnHv1pnxXBrBGePIoKKof6B9YF/1x8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmfvCcVt8/Wlau+U8EUvkxiw9Xi9Ta2O/qmvlw3/XEP5 2SbknaejlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZiI9XFGho2F6xLcTA4ZLTzx XT9F/sZ+9pwt1xTmS6xUUE05aNP+dSsjw9Vq7fM8c/7qaM2+/7+79xubgZSupDaDzr/1C5pND7j u5QcA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Replace the TODO with an explanation of why fast_io is enabled.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-gamecube.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 25290f162cbc..4b45274effdf 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -152,7 +152,7 @@ static int exi_write(void *context, u32 reg, u32 data)
 }
 
 static const struct regmap_bus exi_bus = {
-	/* TODO: is that true?  Not that it matters here, but still. */
+	/* Transfers use MMIO and busy-wait for completion without sleeping. */
 	.fast_io = true,
 	.reg_read = exi_read,
 	.reg_write = exi_write,
