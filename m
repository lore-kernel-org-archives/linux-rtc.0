Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609214;
	b=uqtVXyKs32IoWoFzCRCH8YTuFlyNlR1zCmxBhzG6khbQQB6fwhad2idMmlHevBn2J+/W
	 KdKWO1MiErtgM8S+EgDHFhjUVs9cxUIWWXYoRyBdAjD4sVoO+ySMF2EnYHveRjMQeXiJz
	 Gs/JgUwNTKD0gZ++TcxRJgpGXuul5hebqdXEyXEauBwbJm2fVHzOYBuotA6RmQ61QCyI1
	 Qy0WvZJDd9i2eBleZBb7oPEXl+95j/Fm3LI/NosHHqLikJoQT1tnqxkcXjBVcmnUBMXoG
	 Q7JlOtDGYtQRr35NnW7Wi5qXrCHabWgSIDZU7y2Zyc0hrsFOXsaj1CeuZSpY6aukXgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609214;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SVUoyJCmjOfWaoa4/ZIG/PW30Z2w09I5kCJhkQJiNH4=;
	b=g2xqJ7pzSBtZbSy493g6ad9d5Uiobzs1oGf7YhBs9hLg7MysrzH/Zth/A7rOEEzO0bAT
	 +TeaZCnaKjDLIlgN+UkU5ue7s16IfzD8nK6qo8bvfZauhcKdW37VtbAxRQgUb0bUX/Lbs
	 7JGCaS8Ok/ZX7CgUKRCoSKwhp08nTx56WvSjUlo+P/gANC3B3DiVCW1kmKO7IC7QuCtyz
	 ylDF/hM/w349S9pJRwv+uJZH9Mvonyj/ezis3xbHG4oNZlCupbs+rrYtTkQfI+E1s0odm
	 Ryk9uqbX0HaOGzUpRU0+hMRAzF37zRk5DPslNKpAWD29QDe9N21uiaF1hdUrK89Fjnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uz3Gf3IO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF4606A8B2;
	Fri, 13 Nov 2026 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uz3Gf3IO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609214;
	b=f1AsNJRCs4doNRyApKQvZhVKnCBInawI7GNr7S1NWhOtencxJrCq04OL6n58VXy/FHOa
	 Hrs4VgZRrrNRLEWT3H3/+ivImqecNK/OtOHs4TxrxiCEtdYx+CbDJxV2KkLQkTxuOJgDb
	 NnJtpZQB9ujbNnlL2X0IL7A1Xn88EdfpwUQ+88Gr69gZcS5JOM45iatW89nz/0g3yHxjr
	 t52+5nd6zC2FoyvcCeUH+3iwaUpKNi/nfmK7QzCIti8qy3Q0/ofOC+u9Qq5B49sOjbfRv
	 S8xcbPHrzOrL07er9+2Ez+MuZryJ6Vr27OjkZYogIyFLayhxAnECqIV7+3IYKhbp2XA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609214;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SVUoyJCmjOfWaoa4/ZIG/PW30Z2w09I5kCJhkQJiNH4=;
	b=11C6K67yUaccJLUD9wIQ4lylCgGspnmCielY/w9ClpfhXtzdPxBKNXS9GiQUL18hoVR6
	 C2z93CEyYaoTHf7bw/+PHhFg9yfvxa7SW+kbAVJZVVz1rx9vwfsJ4DY+PDY8hDUG6HLWZ
	 Lx2b7lcN/ezgZrSgq0EOXUsHo1g0NKZ9EmokHSKfEnCt3D9GfAXcIj8mvht2Z+f3XA29P
	 AjIdq+sei+yahJANaFkItj16ecooRMtVgJSs8+l39031SSwFVioqr0OALcX4e0TK83a0I
	 JA+PpbLkgeA2FZJRjUgNbcaRQW40xPFTeCxxIPZ1Ni7599R0/wPgMP8NROQtGKBxHtQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 457661F000C7;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609214;
	bh=SVUoyJCmjOfWaoa4/ZIG/PW30Z2w09I5kCJhkQJiNH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Uz3Gf3IOKNKbUDyvkF5yaDg8wQsDqi0rMBuduIekeoCD/6A9UioyqL7rVKrZWmlU8
	 FPl/GU+zv7gx4EJSnDFcwHjbqhaOClEIgUe2nWh4h2pM5ac6BUYUWEOwFaWQnzBs1p
	 A/+U8KCS3QGNcuu3eBCtdPxGnKIvHYH0lXJyPEdqPGCefT4Vgx6gAZ2/kpl/yRUg8b
	 FmdzAGoGQ2de11gM7oYElfJWc3dwWStWBbjj5PwezeDNoX1qx71pACm1jKbjLXNBcL
	 aFWX3O2lNarTBWsEsFRxgKhMrXWyoqyp/MNRbpaZ8xOMohCJOC1TFF1CbUo8wNpLA0
	 EL/bAMhFVWQFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C646149B60;
	Fri, 13 Nov 2026 22:33:32 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:29 +0800
Subject: [PATCH 03/19] dt-bindings: interrupt-controller: add the Allwinner
 V861 PLIC
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
Message-Id: <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Han Gao <gaohan@iscas.ac.cn>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=972;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=cSnoa1dpGjZSXjdnCsHi40WSrs62RIT7HSiX9HoaPgc=;
 b=iUCPT/4oCEjTnz7lZ0cOcZBIisCUgfbo9jK2u2Xc9FyQvXvPzQoULCXlDT0a+Q1dNOOOi9xgL
 MKKxhwkgxw9CXLKvgiG+vXeQx0tfqqYzy1tVyBu4gG6x4SKQKLVJ3ZW
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The V861 uses the XuanTie C900 PLIC implementation, like the D1. Add an
SoC-specific compatible with "thead,c900-plic" as the fallback.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index cde4bb691897..6178fea9bbdc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -72,6 +72,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - allwinner,sun252i-v861-plic
               - canaan,k230-plic
               - sophgo,cv1800b-plic
               - sophgo,cv1812h-plic

-- 
2.55.0


