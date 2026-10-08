Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404131B131
	for <linux-rtc@vger.kernel.org>; Thu,  8 Oct 2026 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490806; cv=none; b=D388dqqjZei2n7vsF2B2hX6bN3VWw0/v8g7pHT5yW6BUMxOWJJ6twvrsy+3qZRNe4cSlgqJdTZ67N/ob/g5OzSg0EWQyjNvDfnnhxd3XmmN0CsWA3YxA5LmtIwdHF1JeNhqZXXOiPhcdOOUSAtVOmPc5JDwFTUrAi8V96IoYqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490806; c=relaxed/simple;
	bh=VcW5lX/0GFj4wZ6y5LNa7QfU2FOTMYFQ9Aapc+Wl1B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfQz3sUaBxBc5zTU73RtRAoxWSNGnMfTokMIxwDIhP17MczlXOHE4KN2s5f3DVo3gQp5yTAKkKH61YB6lTDG821rIH5HAu4ThONwEG/BGfpHkRUR/6WulmO1lzETJ6BXAv4bo2QsLcjt+F/DDu/gVCOwFDQsOYXTxfBBJ4zQc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eDewcVAp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eDewcVAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=gIHd/cEMLbu2CQ
	6QuVPfO/9MhsaaKq2EpnBNUxmUOuA=; b=eDewcVAp+Asle+9iEHW2ujSaLrvgcw
	dmpoxKmQExy1KK3N4QWPr6pJiRc79mvImAqQHvJdXV44Wgz5vdM/2BBnN+dlF8KC
	3tylP8i4KLXF8TxO9fuXV8ps/O0jHRslbrsG7VpLVt3WVS1zilIg5dopenwMxaZk
	YZa/CG7ScScJHhO7RF4sGfS9bBVNb5RZgubkgBs6EfjOOvoWlNxzs19kGi9kkTxa
	UeRK+NtMUQRhdNC86iGGyEQodV+af7zIbbnv0cvtC/TbHr6f+QrWMA3AY1jeZivv
	NIiI07jx3/Wj2Po7HoLP8vRKnvfuU2p98BH1ucU0grxySoPBeFg1sb3g==
Received: (qmail 883508 invoked from network); 8 Oct 2026 22:20:00 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Oct 2026 22:20:00 +0200
X-UD-Smtp-Session: l3s3148p1@62DL9FldUrbDesiu
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: rtc: rzn1: add resets property
Date: Thu,  8 Oct 2026 22:16:53 +0200
Message-ID: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTC on R-Car X5H does have a reset unlike the other versions.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Passes both DT checks. Kind of fixes 3b3fdc9fd40d ("dt-bindings: rtc:
rzn1: add R-Car X5H support") in -next, but we don't use Fixes: for
bindings, or?

 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
index b448725671ec..5a869e6c0ae7 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
@@ -51,6 +51,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -85,7 +88,11 @@ allOf:
       properties:
         interrupts: false
         interrupt-names: false
+      required:
+        - resets
     else:
+      properties:
+        resets: false
       required:
         - interrupts
         - interrupt-names
-- 
2.53.0

