Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586092;
	b=hVLw6u1bxF3USHiNI88teac42q2M6yIX0n5xm61jGKrjjuwIeJFCdL2SsH++hHcOMTaZ
	 38esQoWWsG7KVMArUwzWsvQ7lGaU1hOi3BNN5mNg01AlX8FHRLLfnPKlgggiF5CK4Azzk
	 044x8wim5gLCgKGzy4Pzbj/Q2Xny5gih9d+Qbof+B7jZmuLf2AlrbWe8TY+j3KJjSYb5Q
	 0uUYguM9Irut0rfVj42Kp851ftS7swjGv+3dILdZ93xqRL54V0+GL6WKg32w9zhuV+kI0
	 c6qgCFO0sv2PuNcT2FYAKzHoibVyPOwtirf5ZsmpzlKMi41RZk++DSMu8z3Ist/OJcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586092;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:Content-Type:
	 Content-Transfer-Encoding;
	bh=JF81kG9hAuUqy/Tj1qGYsWeIAgr1fcWEX8K/O5R0+GA=;
	b=LvwpjkaFq2S763kPAhZDCAjoMfVVG1/oIjyFpTOrznFrzqUHx488Zj/zkvnfmMJinSC1
	 Cxhc6ZQ8zQcI6nbNPaWBUZtTx1duHWxMR+mKG/T0Nshn89dmbjeexR0DBHNOx1VwqBFLC
	 rMer9Y7msYgvlYeguvbZ62nIgTjVP9QoEbDTiDwovq5wB7fUY3UqFgaJbtxgDGu6YrVJ0
	 8DAcBWaWpPBFsONWl9FaI5MfsmIis3uXpAGJdhNJEVfUXB3IHwGWDCmWt8h0TpxigbjQz
	 sH+M4vnkW8QEWBbR9GneHaZhrKNpTLCbdd44a8QCUzvOn5fW3Z5aLwBgK7rTnU8L1vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2YiC636;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252B606A324;
	Mon,  2 Nov 2026 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2YiC636
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01461F000C1;
	Mon,  2 Nov 2026 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793586092;
	bh=JF81kG9hAuUqy/Tj1qGYsWeIAgr1fcWEX8K/O5R0+GA=;
	h=From:To:Cc:Subject:Date;
	b=N2YiC636dG4Eo0GL+KqAHucjxawPILDdvycSvQli6XSquPAD+XZJXgv1cIBszi1CB
	 Gio9YQ4KSaAaEq6eB2WzbeXtFNbK+JigiZ9jzaJTWG2kwbF6zP01z86E2ez+NqkOAO
	 DFuVJw3Flh0WdybReWTUgaqToZ7W/7MwKJG7iI5Ll7h/iQD2bRIhWuJkN/gl1HaXK/
	 k5edm8+UWyIAAVXO9GTfrg6Gmkwa9Zi5C904wxF+gPKA709bCYvQGmU3CUEjaNeiR+
	 ryDgoPv10Itk2zfgsCCey7iy3cFB4AXZvDAEpdZ/gJ7nBL3LSEQESisBlDJvjFiJi5
	 NKT2c5fhm6ZuQ==
From: Thorsten Blum <blum@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: gamecube: Fix supported time range in gamecube_rtc_probe()
Date: Mon,  2 Nov 2026 03:21:10 +0100
Message-ID: <20261102022110.206609-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=blum@kernel.org; h=from:subject; bh=MnrlBC9H8YKe7zInnpuAb8x5n99j51p15T2rJigXzEY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnPP08riMq3ft2ybrrdrLuTGHPyKqwSL3ecj52z5/p72 cidNtrSHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRJ98ZGQ6F8/Q75c3cf8c3 8uAvs4M3D+7kP+5xetXEv4yFpdHv5eIZ/pmIzOc4cnjNIRmJBOUWwROp2z3nPTzDG+ewabn2qw6 7dmYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gamecube_rtc_read_time() adds the SRAM bias to the 32-bit RTC counter.
However, gamecube_rtc_probe() sets the supported time range from 0 to
U32_MAX without taking the bias into account.

gamecube_rtc_set_time() subtracts the bias from the timestamp, and if
the timestamp is smaller than the bias, the result is negative and wraps
when passed to regmap_write(), storing the wrong time.

Add the bias to the supported range to match gamecube_rtc_read_time()
and gamecube_rtc_set_time(). Setting a time below the bias now returns
-ERANGE. This also allows setting dates beyond the 2106 limit. Update
the comment accordingly.

Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Not tested on hardware.

 drivers/rtc/rtc-gamecube.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 889028cecf4a..276e1f889d34 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -347,12 +347,9 @@ static int gamecube_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-	/* We can represent further than that, but it depends on the stored
-	 * bias and we can’t modify it persistently on all supported consoles,
-	 * so here we pretend to be limited to 2106.
-	 */
-	rtc->range_min = 0;
-	rtc->range_max = U32_MAX;
+	/* Shift the range since the RTC counter is offset by the SRAM bias. */
+	rtc->range_min = d->rtc_bias;
+	rtc->range_max = (timeu64_t)d->rtc_bias + U32_MAX;
 	rtc->ops = &gamecube_rtc_ops;
 
 	return devm_rtc_register_device(rtc);
