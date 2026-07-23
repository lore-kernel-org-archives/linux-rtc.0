Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C171437105
	for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799615; cv=none; b=BdVsBTkxnV4OQg30pfTn0xdcbABtCmSXA2ZG4kT8iZPqq9dIWRuwsk+1QFlFc7Fmp29syu6+dyD6de+aE+WaiPL/wOKkCTqQzLP6kqEz8S4Qj+gx7RYObac/UWH5GX2gYu2smcWxVepDAKAI0f59MTqNU9jYZVyHA6MzIFLU/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799615; c=relaxed/simple;
	bh=JBCNsbbmpvOyQAHYAiNtZ0xGeCHrftQkcKapQT6A/2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IX7gJzoYMWC+cVk4dBQco1AKeQz9skkcdva0YWjn6kg3FVQtgg/rPSypLV6SVrmIeSxe040Mgqo7NJ6ejgotC4QDhHFo58KirMMU3qYF6ljeoF8ccWtvLpdfn/8+HDR1ZJG6oewekHpgfkSBfcmmPVhUDfQUIQGqEWm4NWj9fl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=I6ZKG45r; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="I6ZKG45r"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49571fea44eso2486495e9.2
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784799610; x=1785404410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjvDxGaz/+Ym5ockvfd8pkGSRzvwp3SWGNBrqT7Ifz0=;
        b=I6ZKG45r9lSxmnsIBBW+WTfARHgr2knBeW99sFU55aaTq/fH7in0WJ3x6cH4+cvxj1
         i+C+fglAf5mjy/dtFKOtKg64xwgEQVBcT36wV8TRhjeD9TxkDifw9/a7/G6ugdog3vxU
         atYDWP/3SFjcH/6tdgzConLkBnTq6Um2Qi9x+KryeXIZjp+v/cyTtwYVpUmS4/BbXf/Q
         k3VNflON95vMyAQcgZQ4TxvBsf2PtQpIpbGQ0oJAS82U3wFlHhg3/8kkngb6YG319sA5
         HAHm07K7Iwzy+edDCHPiOy9kP/E71r5E5gIGWG2PYDSsQEa6iSeET3TM1+IFpSZnUBMm
         lZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799610; x=1785404410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjvDxGaz/+Ym5ockvfd8pkGSRzvwp3SWGNBrqT7Ifz0=;
        b=Upa0acwhi7YrZP8TC3J6U0jYFaI6A9Mn4nBMJM3c6/N7kbUmOqAt5pbT3sIeM87m2N
         SVNgscKK29nw2fQzaTXd72+UwmpV2YqQoZCb1oH6IIEPR0BYpQGQFCEgIYcPNroQqoVN
         8o0Dd44ehJwxw0hRb6QTrUAwFKkDK7OvoynItlLBiSMs0/c4hhys/l/9TNB0tfumLh3s
         CJYsfIQ/DNXF+ApjC9B6y3JxIGAuDP/qR6ZLdHP07y2AO9lItQDFNO1HxJL5BrcSQzUt
         7k91xJHuXsRQ1GtrGV2SbTsZmGDwx73mKvgu80TF62iWiZvgY3lz4txsBCcBVlK0buDM
         JXfg==
X-Gm-Message-State: AOJu0Yxp5+B4OHml4hHnfP+qxmg3zk106oDJ3IXalCCp6iK8KrZBvkuC
	jU5kHNHaPd9YjS5SiloSUgDaP/AvES2B5nnhsiku1/z1Utt58V89UHLeavanJj7JpFE=
X-Gm-Gg: AR+sD11PJVo8/JqpDArOj2+6dG/mgmP7JS6jb9P0/nwHRbgzJdxRgUkGx0amLCN6g2J
	WU+26os/RRPhtRtkMj8IJDIJ8I+mfMTEEKsSIp6YDRPdMu2PPcfbH6TZSwXDg/iKh0u5Sfep+LT
	tRDvOdw9JHjIGl7UjClTjASB3KHGQgGxAWaxAOVgqND1/v89f5XBz/Xyzf7dWqiUS2DIaQ/l5vx
	Xj1CMa1tz7C9U8d2si75TIJlZWXAUhJkcWubJgs3IN+IuxFD2g7Km2BsgLlZLnvliiV9Nt0swd0
	Xd2PYOCfmLMah4JwgAuPJCkrGLZQW8VArJFBLMlQK8OqkQyDGK0GltysXjcvHn/+tYBAmiy2E/o
	855Zrk3+s/Eu7C13biSmQYhAOI/z8LdKTDqDtwqmEEcdUQs33b4ogPmrpEO5r+CpOHnLOw7db1q
	SV9ciUSJGwR/I=
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr23593405e9.36.1784799610474;
        Thu, 23 Jul 2026 02:40:10 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:3274:dbb5:2710:802b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85c6f076sm14217894f8f.34.2026.07.23.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:40:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 23 Jul 2026 11:39:53 +0200
Subject: [PATCH v7 3/4] clk: sunxi-ng: sun6i-rtc: split main oscillator div
 and gate
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-a733-rtc-v7-3-8fd68aab94ae@baylibre.com>
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
In-Reply-To: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
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
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYeFvjq1VgqkrnRX4lgbpVG1CsAXk0OXhBpCAY
 2cCxet3nn2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamHhbwAKCRDm/A8cN/La
 hf+4D/9zXNDTBscW+MTjTDh5NosjbTzIiSUcS/dzhnCjmVmQ22U54ZbigzSwc6euLyNEtodPs1C
 /83GyQHXZt+edY9PQwiZPYblQf+aVW1yKbeYf6FFTVVge5OGW3uMbf9OafZ444Ub/xyM7n9nGTL
 XW7lMm7/LwIzHt4uT1zqEwBFeGSWbtpq42X5f5XSAWzj0D/Sfg/UNEzJt+Rs+um4Vl4r6c13Ch2
 jgSCFGwtao3MN98b2BVBehZnTVyzXa3tKeJ74cHMVt1fIqo42wGGN4MW6hIyGnpcKhRZVBUTPpj
 nImEEQ/hlmQBjgiMcaKdGtY/IN8KqnMZxLGR807JujAmNNxr2G6VLFHBf69hKJMuRSFapjHy3f+
 6g8EfwUeZcwlSHhe5v9kw7q4+t1Zn9dFcxPktxBOmr8jtipsQ+Foc6AxBT5/zYW3c/9kz7rr7hT
 /MHiWwdeMGFzyCU1iVvoPB8GrWdMpoL6V89Iin13MOxCvLchXPPD2prKYFPK6dxhZggyxOWl16M
 87kPE9H1TtPTKfcVmm+e2FKcEVn4s/R8VC+ea3KAS9sOw8scj8hQZU7GuSCX+FTvMUZstkPhCzJ
 9N08h3ySwaNa7DjKju7KfJTrOTYdqNgr4IKfsaevnZUUtEgvNDH5hQDqy7wzqNj2ezZl7zu5VEQ
 YE3e07IaksL7KFA==
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

