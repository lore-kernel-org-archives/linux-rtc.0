Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465641;
	b=gUMvCXBWM0U4qqqsGrYYf3qiA4QtR91C5Zul4gkBq4r906ANz4YfSYm2K1u14hrrpMKe
	 V/UGLvEwdEJtDBmLiL3TZs2H6dTidV9iHJ9rkxKPCCnujCGl71rqT9DmPE4rYBB1/RFsk
	 bxDykSk8+EdQ8A0s4Xhq6cO5RhnoYc0nttPp0mZGqG324yhb2NP3dEC8eXO1rETJ7BAjc
	 gtdBcNK6+dgEelgv4k6QfCnF42yPblg64W3FE0S/wzvZWEYhwY5DjBchW5UGFWKKXnSDX
	 tD19z5ZGFpw/hcIWe4/abwvK9YAaWZtrwOku+HmwV18dn6p9xdiMr2jsSZn6C/gE8QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465641;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=jcMtL1Zrr8FgmDH364k+EyO/0ONgC+NzakjBvuyY5b/b9GZaRtyVrUmYlesNwI2r2f5M
	 dH2e3tlx/64jD/qSF1fMCPiBWLkyokI4gCk62Xl+04meikqaAMeYAeQZ3mGeOowCbhdE9
	 mYjXsyHwJXX3lkZgWJ9+0GfiypiQtIvhFEamx39xNjmzMJK12fwHtMtXYV+KXTJtoSIV4
	 JBD246AaJgBWk/I/Ddlk6mtd4YAgvEtXyW0ucXFlLtrb5rfRwbv5ZpZ2oSDZqlDg9z1C+
	 NbBTXMB6CXzX/2sejY/CR1WTDQJvyeu9o1GPGN2o1Sshmiqq1AvcY0piq3D+tJ71cnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4rBn3cY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD05606A690;
	Mon, 23 Nov 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4rBn3cY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465640;
	b=kxx3v+l/i+xO/D2PxWxac86nTrdO0s8rfzYX+X2bWXJWDtfXShJiO/FnbAVnbPp5FpCC
	 c3jANZfnKrOhQrWxV8WG3UL4LE9Athw11IzTOA1x2JStMRPQrdKg+QLtu2s6ArAeXmOK6
	 Wy8dzA/Hohs/s+mqN8bfLz7atid6B1wLVV3Pxerc+N/mZw4ze1eEX5c6zfki3uzqTXJ3Z
	 xzmLSGRK73LxuWI+N+psV3E0p6YAqZ8IXoEfnGLpFLC+GKwbkb+g7WWAR9jKlDB5xVdBQ
	 TzYcPUfsRFoQtqY2RD30D3dAwWlGMKkuphemuUyQGC+EkZOvJvP+T926HN2JLosnUFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465640;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	b=laNK2jk6uVmGL+qdBP7NPAJWNC1C/2oitQC9Cp4pfLbDZYIpeBH5xQ89TraQ7tj1rk8W
	 LA9bTLNmWVImQ3Vq/rHwqjz1mkTqQtWeVbmfvL3ukyC1yPpX2MCnSlaQvKn3Z3JqpS1PP
	 Mj0qeoRpQYpGpfWz/gc8mcvy2co3/Ws7kuT8/DJwBV6c/msdvgcfDuj2G2M+GpC+tVgX3
	 B3HR9xAx6xChAsC5AHvaFRfjWrd28Lady+oEOtjlL2HFnvXGbk55OL6W7MPbMoOru4JC8
	 VmmA4Dy0WYxgTPlglMxfSjy7AWTESfq1i4dIUDobUMqAek9WlVZs9c6NBj6xry+9J1A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E7F591F000D1;
	Mon, 23 Nov 2026 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465640;
	bh=YstasX83SpUpR7sJnrgBdW2Exikec0Kt7UwYg9xB36Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z4rBn3cYXr4PEJzkBkDfYfkwJpq/aFtpBPsju/f0IWqCuGLLAjRcQvBfs5LkOpbhc
	 mUrPiJApGf7Xpb3pqCDb5jLO3xAP8PLcl0cpgcN2kE9ynesI5geVpMRM22ECvl3Pym
	 mbHDsa+waDQp0JtM8uBTZyDlZJDJjoyI9yrPESrRfsWHOEazFOYpez/sVV+vMAQDH6
	 lMtnwbc5IwwPmYnkR9YQFFbEfctPT1Czlh65fJYpzAU3mTGv3eJ1iKV8glqDoGSa4i
	 wphOU/sERlTXj+wwJqkBkT608p9ndwDinxk1v9mrPBMiysPXD+g5ZS8rO3xm5Kk4Vf
	 liVC/SjPaOc1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 292114C6ED;
	Mon, 23 Nov 2026 20:27:03 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:27:03 +0300
Subject: [PATCH v2 3/3] MAINTAINERS: Add Cortina Systems CS7542 RTC support
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-cs7542-rtc-v2-3-31ab43f2cc8e@gmail.com>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465620; l=864;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=V966SZMepm42nKofeQHA+zZwJm4nGNGjIsMkGKj6kQA=;
 b=wA45opt4vjFyPK+e5SX5jemXgfYqH0uOMn52kHqQwBqF6TR5ZlmLB7IFfai+TmlOaxhjs7p0S
 jtOF9TABQBjDIA3P0AgfoyhRLcF0x/2CzFMUx6/iGQcAPZjFN6W6ONN
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Route changes to the CS7542 calendar clock driver and binding
to their subsystem mailing list and the platform maintainer.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb..e7f97fb96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2949,6 +2949,13 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
+ARM/CORTINA SYSTEMS CS7542 RTC
+M:	Fil Dunsky <filipp.dunsky@gmail.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/cortina,cs7542-rtc.yaml
+F:	drivers/rtc/rtc-cs75xx.c
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>

-- 
2.53.0


