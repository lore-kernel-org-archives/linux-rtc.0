Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D985370AED
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731725; cv=none; b=HhIwgnSH27dkHv50X+8lkoaVjWpW4X5eTGUvHfkXTDETnT3Qz2zY3KuSVVx63M7j/NDGJfkX0dl3f0dKtQq0hEVDxuDrMqa5e7nhWJfTVvq/bxgdSNZa3VEK4wx2QxmK0NpD4+jNqOohrIxBkKfu456MWi+DeOGVgOiHpyBpKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731725; c=relaxed/simple;
	bh=JBCNsbbmpvOyQAHYAiNtZ0xGeCHrftQkcKapQT6A/2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUhtqUk5AO4idFvEAIGDS5IoDOws86MxY9q46/41g6NIa2eP67Ojavf1Cga25Ryxxz8h8/5sQ/5Iqm5GbT2PjtGuUj6ILXFv4kLPoW7YWX7eJahdKRdJo2hYSBg4JXyalogOcn3o5yuQJR/Op+MP8TZktniqSWM3mPsxjN8BTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SjpQceZ7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SjpQceZ7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954d29264cso24959625e9.2
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784731719; x=1785336519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjvDxGaz/+Ym5ockvfd8pkGSRzvwp3SWGNBrqT7Ifz0=;
        b=SjpQceZ77mgZf+ejLYOtfS3kyxV78fhR9fUTNotj3zVN2NjCdsYbs/9B13KI479LnN
         4ILw49t2TzeUmSEz4ZS03sZfL6lGDEGFB1owYtBIOl/4+v5knTB9k125kTS8ee0NwT3g
         TUrXBQxRGdHBgxCCEc4QmosW/icbrmyLGqNgyVAxFV1URWszO8fE+0POB356XYqxuF5N
         I/hypn0uK7AojtYOfY1BYoBMPy1gMW7OolO4WU151nruWmUNNM1i692NHoV9U44JdxtH
         jhLsGx0NxUB71XhNhpAL2d5Dv+f/UJseqJ/tXxzu8P+zS0QfdqR4j11+1CtFtXbS1SW3
         tXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731719; x=1785336519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjvDxGaz/+Ym5ockvfd8pkGSRzvwp3SWGNBrqT7Ifz0=;
        b=ZYVfu2nrt0oIvfWDPb030NiZp8NvTYilbJ+wp5zZqkqhcGUo6m2bISzmFw/mGlwD5Q
         6pPTIXvBlmy6btoZ/jWjSIN87aDQDNX9W4xz2VLZi+5RJJO7ceH9y8CYrkVeeggiReXX
         HPGBdBsgHeuyHCB1SgDCJK/iEFGYi3/q2vBYEL7YniIoD1qwk8YF+tHpj7/palVN4i01
         Sivw/RVD2LIuXzhR0qTemXdAjPNoAFXeBfNCzXY1f6EqfsdUjatjZZxWyrEwOqrosblI
         VdE2yHT4lvljfpSf1GUeb74lNO4OuepEwQ4gEmxRwtrfV/MX487SotXi7bDTit3k/Edx
         GFwg==
X-Gm-Message-State: AOJu0YxFwLMg84OXLi1MdAABCmZp9XHh1J7r3uSlIxcd0VPN19/lHO0U
	pfBRb38NhHIQ9uYsrTzC1JJDLoOWswEnLn9AslxF78r2C7qmz7U/O+Ch75g/ahNuAHI=
X-Gm-Gg: AR+sD10H4S4zYatQZ9lEUAzS9T+R6OQItldvHVtFWX2I37EXrOkkTcXvR9MT3swdbcO
	fsJlGuaUaz6cGYCHRHm/Heu/dQvKxs8JMou5NbAbaCxnzque+40uLCl1EeFKSPElw/mLmFSEOOv
	UlR7DUMlYu2VrqGsH0301lspfv7+w2jc1VW43Sf1oSxgYHnPgVt4/iNH0yhSFEJCTXpTeu2Jf7g
	NkWggkkqVUY4mcYCoBZTwECdOKqAg27+Uo6zEwegUdaPaBH7nHhQILdSGXU4TKtuArwxEv3vTRg
	aCYS9m9zq1X1R0TGereGCwZ9BtONUFKVzLrs2eRdljJk2pKyaM9wEAbQ09y1lD+hxGWdi8DQpab
	s0lDDMFZMnjmThbM/78C18pgT+CGNfJB9OTOYnaoM0bgd3+a/5cTitQZ7ieLPLm3IW7aeJLTQYl
	Fe
X-Received: by 2002:a05:600c:21da:b0:495:3e08:ad24 with SMTP id 5b1f17b1804b1-4954a51b524mr185452815e9.33.1784731719082;
        Wed, 22 Jul 2026 07:48:39 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a589:14b5:ba97:3626])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-495653c8760sm139823645e9.14.2026.07.22.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:48:38 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 22 Jul 2026 16:48:21 +0200
Subject: [PATCH v6 3/4] clk: sunxi-ng: sun6i-rtc: split main oscillator div
 and gate
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-a733-rtc-v6-3-631cca28cc9a@baylibre.com>
References: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
In-Reply-To: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=JBCNsbbmpvOyQAHYAiNtZ0xGeCHrftQkcKapQT6A/2Y=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYNg8H3wMJRC9rFCS2UiRPc6rFEZssU9BeWOM0
 IVN3Kqk3IiJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamDYPAAKCRDm/A8cN/La
 hc8MEACv28/V5ccSfgbQoFHihys/2ZxbPthoGPKW5mVRQE+g/Oz7L+SPyZBpuZsgvMxiFpLUVvA
 CMHDqN+3rNai6f57DbVEELC4zx/u8jRB/ZDoZGgGjMhxTdFO/+39KxpLcInS1n0/GBFkHAIMMkQ
 9tFoo//qXYoacnTNxLHTLjJFoBa/cWgZEEwBNjHIWJMcHsc44QIDzsKQgN7CRprENs5KmmZOR1f
 JumgVe1k3xqIx+7pUpwA7oGi3Ymem4bw5zu1GJxb79mx4FRqYPlL24E9tbIbmneKe0luhQcRDvX
 1kv3GBIbMrOmq0zqvRfU2eAqlGtUQQ9AwEzmV9DbQ0Xn0HVlQMx7L1MbL/UQaQ2vDjoQdHU59s5
 YpSj8Hp7HN70Wxg3Fw7TuvO3oz9pjNkUCovCEVrKVDCJO9G04cicBnu6uYfnxMdOxKE0qQC7gnU
 1lsHznk3OGrrxG53Mf+1RRTTANJROZmFPa9khK5gJS4MHaEbaw5koNWbVqwvTzri0cYFUx3lkOJ
 2fjEsIKt5TELlf1UJSijMcDTZWxdb5xoM23tOtNfHcSYmRYeS6/nePsghZsDNWakso8H5e3G8KE
 uqaFMLAGUbZOStYwp+kEz+oBYtn3TfZl+lzv2oggN/1xZylqxWUMsuj7yX9TpXLSu/g+nmNSN5r
 qc+du/pM9mHomng==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On the a733 the "osc24M-32k" clock has the same gate bits as the previously
supported SoC but a different divider implementation.

Instead of a fixed 750 divider, the divider is selected based on the
rate of the oscillator. It can be seen as a simple read-only divider.

On the A733 the gate and the divider are on different register which is
not supported by sunxi combined clocks. These element will be split on the
A733. Split them for the older SoC as well to keep on sharing the gate
definition.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 20 +++++++++++---------
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h |  3 ++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index b24c8b196e66..25dd87e78eb7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -218,17 +218,18 @@ static const struct clk_parent_data osc24M[] = {
 	{ .fw_name = "hosc", .name = "osc24M" }
 };
 
-static struct ccu_gate osc24M_32k_clk = {
-	.enable	= BIT(16),
-	.common	= {
-		.reg		= LOSC_OUT_GATING_REG,
-		.prediv		= 750,
-		.features	= CCU_FEATURE_ALL_PREDIV,
-		.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc24M-32k", osc24M,
-							   &ccu_gate_ops, 0),
-	},
+static struct clk_fixed_factor osc24M_32k_div_clk = {
+	.mult = 1,
+	.div = 750,
+	.hw.init = CLK_HW_INIT_PARENTS_DATA("osc24M-32k-div",
+					    osc24M,
+					    &clk_fixed_factor_ops,
+					    0),
 };
 
+static SUNXI_CCU_GATE_HW(osc24M_32k_clk, "osc24M-32k", &osc24M_32k_div_clk.hw,
+			 LOSC_OUT_GATING_REG, BIT(16), 0);
+
 static const struct clk_hw *rtc_32k_parents[] = {
 	&osc32k_clk.common.hw,
 	&osc24M_32k_clk.common.hw
@@ -286,6 +287,7 @@ static struct clk_hw_onecell_data sun6i_rtc_ccu_hw_clks = {
 		[CLK_EXT_OSC32K_GATE]	= &ext_osc32k_gate_clk.common.hw,
 		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
 		[CLK_RTC_32K]		= &rtc_32k_clk.common.hw,
+		[CLK_OSC24M_32K_DIV]	= &osc24M_32k_div_clk.hw,
 	},
 };
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
index 9ae821fc2599..ab7b92b47f59 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
@@ -9,7 +9,8 @@
 #define CLK_EXT_OSC32K_GATE	4
 #define CLK_OSC24M_32K		5
 #define CLK_RTC_32K		6
+#define CLK_OSC24M_32K_DIV	7
 
-#define CLK_NUMBER		(CLK_RTC_32K + 1)
+#define CLK_NUMBER		(CLK_OSC24M_32K_DIV + 1)
 
 #endif /* _CCU_SUN6I_RTC_H */

-- 
2.47.3

