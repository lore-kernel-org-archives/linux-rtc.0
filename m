Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263970;
	b=4CZP9nc4NakWCd2UF69gd4WkRQIN8BYDyxUpSOmNAVRXseOxvTtmPx79sfyh+LSSNfYV
	 eBtJGOAHEpLLbrH+6NRbAG4/gl5RlWPxQOHfRtHYSLdPZ5knF5X+PEL8iWZPvzAw+tV2A
	 VXui3YGdS7Jiixhfwc0g52yr5yxTjBSqBMT3yZ+5wFQrQHBEEeWqG4tYe+8p7UGWklgyC
	 5kT4dxjLUcBvDupcjSquQ0g1bkGY44lIAhrm2lJB6p4wG+vzJCxewKDh0W9oBIZlD0OZn
	 SvUdKvrYFZ5B+SkSENEyvJ6Ej/rrpqzBJVXyexQTbDl2peUDtXc9vefz5EQSxujqbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=M49RK9HiJQNS+Qmt1vgda4fZQUt82z29/On03EM9+r4=;
	b=OIUElg0mhhGasACEdlBAUF8xKCsLIvFcWTavIPuBSrPjJs/2yX3qYGeTihXjGCU49QUu
	 mZ61nyfXZs+Add/FWTry9P2G+X8UX5bMBqVfEAuSlZ1zIci0Jo9aCoqvGfDFzhnbVqpvL
	 zSa9TsKuO5fRhqmYgf9GBwBlwrfuCyB0aJpbftm+NY+VcCwaSu3CCNORnoMrU4cvEfXMS
	 /31NyQsERz1NbpDNFSru45oGyvssa6pMcqGUOj3lS4nhp2eBmVmFoYzLiR30tBgyEczda
	 ORYpDu2Jtrc6E7sTIVAendgQMkARIlp5RJWp+4KWpFx24KL1l1ayGNucofIhDNtNSvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6OaZqd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335260A260B;
	Mon,  9 Nov 2026 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6OaZqd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71481F0089F;
	Mon,  9 Nov 2026 22:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263969;
	bh=M49RK9HiJQNS+Qmt1vgda4fZQUt82z29/On03EM9+r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n6OaZqd2bjUMM0fUX8GXq9DP3o64s7R6hinYNyI4sV9Qaad73HeAuuWOJoptpIEbO
	 xrMSXIaENODDErKOMNr9N7g4QJzveJD3UYK+iuzCULM3Sq/RPtA9GL6pLTKea5aFiw
	 RNP+DGvJWzhWrSIjYfIy6gHKJ5LOnrmQh9lg5r0TfOcpICdwby3JsK/sUoZs0ROXfl
	 Yku2M9DccZHwY7CLpuDVJRERQedzS8dFLZQOA5JbTVUPeNOFu8dhql8VlDT+XK5/99
	 hYCDAe6wWFgeBCvVx+ZC3SqiZEbvDHFP7iFVulIU4+QGahKX7ERpc2mE6lpX4pJOu7
	 vhL2m7aRPrE/Q==
From: Thorsten Blum <blum@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 2/5] rtc: gamecube: Add missing newline to SRAM bias debug message
Date: Mon,  9 Nov 2026 23:39:04 +0100
Message-ID: <20261109223902.84918-7-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=683; i=blum@kernel.org; h=from:subject; bh=gqeDuL1WFBgSOMJgPhM4vc8C4WhBbQNYnppvjTIjY4I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmfvCem3W+wFmhO32jq3vBa/ZzNvWxzuX7DnbVK09IrV dbNrEjpKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgInkL2dkeL31w6TfDNNiLRTa 16+JUVU30b2a8EtRe8Ik1V/iGd84uxj+WX433i72ymqbd1nHaiOGPZ6xnDa7VA4LT+42kziwWvo 1FwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add a newline to the SRAM bias debug message to terminate it properly.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-gamecube.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 0299f27106c0..25290f162cbc 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -339,7 +339,7 @@ static int gamecube_rtc_probe(struct platform_device *pdev)
 	ret = gamecube_rtc_read_offset_from_sram(d);
 	if (ret)
 		return ret;
-	dev_dbg(dev, "SRAM bias: 0x%x", d->rtc_bias);
+	dev_dbg(dev, "SRAM bias: 0x%x\n", d->rtc_bias);
 
 	dev_set_drvdata(dev, d);
 
