Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263977;
	b=gieNve3ctnRkbdsJ1OEEVUSS9tg3ZO7gP5vzSDjwOOQnwoH8Ol3s5cpN8EXHRjWG65RX
	 mS49TlNRCtcoe0F3wneCO1C6wDE4F8TEVN5/t5WO193Zu9X1kE7c7MIR8SVip/qAl0Zif
	 mhLIXRQIyxT32OYEYqNPtfrShc/bNHFNJJwzTRPM6hKK3AYZvF6tRapN/aS339Dus/Owz
	 Odlp3nZBJQ4nwX2r5BwGGdGFNqx/LoY0VTDeE1m5G21Z90LARJfBITqoVvuJ+EoC0f3+X
	 H6AJYNWYHOly5jklBszvGXc87jyC+cJlvPAnSGXExGfRBmMrbmkQE8R+T8pLtwco7Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263977;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=Gmypcnb6J/0vCb61wsuk2A+h+sq1CgN8U/TRykuFfbE=;
	b=1uXSVsyksDAXPK1LHx2UQGF1Ih5gofWZihrQV1RxUZ0XpNf5kr/Q8ak4ufBni8/K41D+
	 bFnnWu8wmQp24+BeLOwPmC2mC9E8MKuXGvlC/QPOYtiZrWWMfxhakp2sDYq/9XL9VQM0o
	 I/vgnMQdPULhqQ3TEm5kPbLKPx3U+cCZK8xKswT4bkx4CvmrmH7U85bolxPsnyB4BECEw
	 Po0HITTIBBgNsYlioz5TUrXVU6UCfeLgFmPpFCpxlTrI6baECneeMV8GpgqKNZyfVk1Wy
	 MPrGAxAF5eMN3/tOjSLK1t67uv+kHQPiRL9uk+dmzZueOt91PB5rVifD4856XIe4APw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7AA+NRq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E360A3817;
	Mon,  9 Nov 2026 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7AA+NRq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0531D1F0089F;
	Mon,  9 Nov 2026 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263976;
	bh=Gmypcnb6J/0vCb61wsuk2A+h+sq1CgN8U/TRykuFfbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7AA+NRqgXegg189MkS0DXSVOteaCiP7SSpFw5/oXrCb9XipKvQ8ciqlrdVx+unk2
	 xva8f2hQlA2Yp1smWgLnpIN4x5KVsOfMdbvpylJMc4gevncA0qkxpQAnU0ix9ka1GU
	 vEKVeko+jF9McaAkWl8SOGP73ef6vPH8O638teHVtaRSX/QEZ9XpmDl1DswKtaDm8S
	 WKKCMzsViiER6tCKZUy8nzRJI/ks+gDFDzn3wxUfjlt5ULv7yHa5bnctpXoWSdryno
	 ctlKJuwGJ/6wiOZepWToZk19HlvlHdGZsyyCXgUfuEKs9gwTrKVBSqFTqC7rHZ6f3s
	 DcWnMNofT2zaw==
From: Thorsten Blum <blum@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 5/5] rtc: gamecube: Use register definitions
Date: Mon,  9 Nov 2026 23:39:07 +0100
Message-ID: <20261109223902.84918-10-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; i=blum@kernel.org; h=from:subject; bh=n8cUo6wFw1rnJHIM5ga/qrBswu/bSsYSCGaoJ/HjMh4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmfvCf/LjRt+v6EK+BdxoOgWUaWf02qLnXpJPSciJd5/ tbhW9mcjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZgIRw7Db7ZVz4Q5j9srxEef iYg7xf9U6vuX8gWf4k1t9taomvv0uzH8M4x7+LZson3euSuFMqIZ+7T+/ThS4bRD4sTiQ1lvTvd 9ZwYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use the register definitions to replace the hard-coded addresses to
improve readability. Add RTC_SRAM_LAST for the SRAM range end.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-gamecube.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index ec672bee0134..dc4299f71f8f 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -73,6 +73,7 @@
 #define RTC_COUNTER	0x200000
 #define RTC_SRAM	0x200001
 #define RTC_SRAM_BIAS	0x200004
+#define RTC_SRAM_LAST	0x200010
 #define RTC_SNAPSHOT	0x204000
 #define RTC_ONTMR	0x210000
 #define RTC_OFFTMR	0x210001
@@ -283,11 +284,11 @@ static int gamecube_rtc_read_offset_from_sram(struct priv *d)
 }
 
 static const struct regmap_range rtc_rd_ranges[] = {
-	regmap_reg_range(0x200000, 0x200010),
-	regmap_reg_range(0x204000, 0x204000),
-	regmap_reg_range(0x210000, 0x210001),
-	regmap_reg_range(0x210004, 0x210007),
-	regmap_reg_range(0x21000c, 0x21000d),
+	regmap_reg_range(RTC_COUNTER, RTC_SRAM_LAST),
+	regmap_reg_range(RTC_SNAPSHOT, RTC_SNAPSHOT),
+	regmap_reg_range(RTC_ONTMR, RTC_OFFTMR),
+	regmap_reg_range(RTC_TEST0, RTC_TEST3),
+	regmap_reg_range(RTC_CONTROL0, RTC_CONTROL1),
 };
 
 static const struct regmap_access_table rtc_rd_regs = {
@@ -296,10 +297,10 @@ static const struct regmap_access_table rtc_rd_regs = {
 };
 
 static const struct regmap_range rtc_wr_ranges[] = {
-	regmap_reg_range(0x200000, 0x200010),
-	regmap_reg_range(0x204000, 0x204000),
-	regmap_reg_range(0x210000, 0x210001),
-	regmap_reg_range(0x21000d, 0x21000d),
+	regmap_reg_range(RTC_COUNTER, RTC_SRAM_LAST),
+	regmap_reg_range(RTC_SNAPSHOT, RTC_SNAPSHOT),
+	regmap_reg_range(RTC_ONTMR, RTC_OFFTMR),
+	regmap_reg_range(RTC_CONTROL1, RTC_CONTROL1),
 };
 
 static const struct regmap_access_table rtc_wr_regs = {
@@ -312,7 +313,7 @@ static const struct regmap_config gamecube_rtc_regmap_config = {
 	.val_bits = 32,
 	.rd_table = &rtc_rd_regs,
 	.wr_table = &rtc_wr_regs,
-	.max_register = 0x21000d,
+	.max_register = RTC_CONTROL1,
 	.name = "gamecube-rtc",
 };
 
