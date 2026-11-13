Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609218;
	b=0IMk1QXYirmxJ5UTO55RngCqjXOVkLSGCpIhAcO5y4CFzNq9HMhBvifBSoA5vR7AXlrL
	 /m5J4pJ6PYVRRMbZOLcwO9v97uJ2tMIvZQpRYfF1CQ0zE6LSuthEec11idRyMDurAe3u5
	 gH+RxwLTYo+2b2pg8zFo8JhCaNBuxqBXHzZm9MZZBaDxCy4OA1I3PjzcD5ozb1MQ1IczO
	 0T1jO0xykorksx3MogrqPT87LXCwlBH9MYhjGogde38zGlorEX6N3wP0YR+5eR1tfzy0R
	 rHkFS8gBvYDOD7fuhYKLXqG21gpCutRNZNAWqd3K9/FqcJc2jr8KxxyZlZIlXyLg7dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609218;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2hAcwHHxwsuzZBb2Xr9VuIK0jqUogfFZXLMnVu53bds=;
	b=ATXzmn+C7eS0wwqO70ew0taD35UrF7+WXov1L2faitclmp3NGH06S6ExKb5dZ825P74o
	 y/MoEJnJpnKpRhGWaUjP8EKyf2eO1Y6Sx23XAVKofds25PCZfrL2EnRu4mVxxBXkyac39
	 PjkdRnVUsdGqozQzByO7v6rL+D1Pp9nL94WCo2PyfWUykX1QCWm/dtBhaTGtwGAlMlWuJ
	 HCKLjr0HWteCKe+XNXkMLU2ADka6Ay697oagl0u5Bz3zK437rgyTqNNJNr6OqPgsEFkW8
	 ZDafFYBOfv7IcAMZVDRMKyVW7UXVH7+Iv1I6KKfTZ8Zp1jxGPNnmNn9BuK66MN7iBdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV2QCBUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B8606A33F;
	Fri, 13 Nov 2026 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV2QCBUk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609218;
	b=dzzmXe6EOZUnCWCtCyX6KvaZZaIqecjvSw7Ihx+zuBvWbgLp6gh64xyKX8TpcHXvjvw9
	 v76KpEGQ5KwrM9KjwjFczpr7r9p2d9Bc+rKZY4nuQx86unFW/JG0KQxh76wWozyyw20Bh
	 IBoAzxPvDb8O7C8PnVqBroByWv5+M8CijlDTt8bTke3UpPx0GzRu2TpvLbyAmPWS4r/Au
	 1LfHnALVFJw925Z6S6z2U//9BtiJ877BBlRqM81JeVHhDGEt6hSN4mbD4YddwsncRNtNN
	 SeXQogDJc8npcvFZvmcbuZR/US9JKdABR6pCL+W5tFUzW+SwMo+7cUMKZbKkaUZ/qmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609218;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2hAcwHHxwsuzZBb2Xr9VuIK0jqUogfFZXLMnVu53bds=;
	b=zkdvl/0ZFb1FpxlIGKUO7fJ149Hb8jHBh3fjEDiS+tlD+6Bm9yVWE0pc+CIAyGAObLHB
	 wkUkfOTEZDjnrUNLLH0VRplDT7PvTkcjp5RByloPTX01PJR63jYuO26QKH0EfBtboSvAL
	 sW5g7GUxkInSp7HUe/Ixhu4AkEOj4/3M+rMBEddznGcKAgGjD5IU5AGlPPNxZcsZUnZt4
	 vmeVMJD5Z+Fn4YjmTdZnfSHiPsnmXhb7vBE6MYjp4Drgc1lk5JytVbI1KX88QK34Qn7kX
	 9LiyzDmDKUIur/nZDByJJKecbyn4vGw+VHUV5qCGCTjhhamqLVZKj2Gtb929+g9hDgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 359C41F0089E;
	Fri, 13 Nov 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609218;
	bh=2hAcwHHxwsuzZBb2Xr9VuIK0jqUogfFZXLMnVu53bds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FV2QCBUk2dFIqW9Sn4MhR5LOeAQRxbIE+193UXDCtDilblOtjVZQX+pjVDAu+XwtV
	 9VgSVlAhu8ZSOkTKE4r4jxC/PuTMcu05YxHbiE/o2xhMHZ8tFFalM5sJJnIsuvMTz2
	 XlkOYVkefUoz4DukDyaLwYyRI2SvzBUnJD6OfOpfHrhLTZP455+y2WilPeyHpFfANd
	 SZ4MN2BNr+UjHclc+2wsrCMV9wKFVR1cvv5iGkVUT7M43u0hoiZARcjPne5SrlaoGk
	 4C+0yT60mFBEQyJz5U+rG31MOjFxtqA+odRqx+fQ0GIEARrHcFqISuP40NlsGzrvBD
	 ro/5salgoOc/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 937C549B84;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:38 +0800
Subject: [PATCH 12/19] dt-bindings: pinctrl: add the Allwinner V861 pin
 controllers
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
Message-Id: <20261114-v861-v1-12-eb71ec3ee523@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=2426;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=OVFVAovojWhCjL1CcvpMpyxRiwB/0HvBnEwl/vSd8Os=;
 b=I8y5zq/wfjE0lbgnncurtQ07hgFzNrVSMhKq4SHgkIBrpZNMZEux/+meGG5waFVfmHGj730hC
 i4FabMIA2qFD386KAufZP4MB4on1RyqcbMFigp86/eUPgTrGQwyuMCx
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The V861 main and always-on pin controllers follow the A523 binding.
The always-on one has a single interrupt bank, so also allow a single
debounce value.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../pinctrl/allwinner,sun55i-a523-pinctrl.yaml     | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a523-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a523-pinctrl.yaml
index d7d0ba32ced4..3c2924df17b9 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a523-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun55i-a523-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/allwinner,sun55i-a523-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Allwinner A523 & A733 Pin Controller
+title: Allwinner A523, A733 & V861 Pin Controller
 
 maintainers:
   - Andre Przywara <andre.przywara@arm.com>
@@ -26,6 +26,8 @@ properties:
 
   compatible:
     enum:
+      - allwinner,sun252i-v861-pinctrl
+      - allwinner,sun252i-v861-r-pinctrl
       - allwinner,sun55i-a523-pinctrl
       - allwinner,sun55i-a523-r-pinctrl
       - allwinner,sun60i-a733-pinctrl
@@ -35,7 +37,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    minItems: 2
+    minItems: 1
     maxItems: 11
     description:
       One interrupt per external interrupt bank supported on the
@@ -62,7 +64,7 @@ properties:
       Debouncing periods in microseconds, one period per interrupt
       bank found in the controller
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 2
+    minItems: 1
     maxItems: 11
 
 patternProperties:
@@ -149,6 +151,29 @@ allOf:
           minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          const: allwinner,sun252i-v861-pinctrl
+    then:
+      properties:
+        interrupts:
+          minItems: 7
+          maxItems: 7
+        input-debounce:
+          maxItems: 7
+
+  - if:
+      properties:
+        compatible:
+          const: allwinner,sun252i-v861-r-pinctrl
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        input-debounce:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:

-- 
2.55.0


