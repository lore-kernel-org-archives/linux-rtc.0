Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438A3F23D7
	for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301917; cv=none; b=tJ3OgSpjAmtg8F10kWI9y/43j1FyTLqoXLJRwSfYzT8Y26y/wGaCRWaw14SLYD+tZwwQE3IX35FgMrwDTeGnjr5LXcyCh/Ad/kRkdlLQHiXajm0VLTlBRjVTZTfti06K0E4J+SYpN+umYS87KoLkE0lGDdvQcKIR/fmeWYGfUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301917; c=relaxed/simple;
	bh=Q2OlWVW2kYyvJ4ck9C1HFEDQQxKC0CvD5EifWl3TI8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3MGQxToZ6IzkpkyN8ybNAbxn5RuuzEjXdVMfIR8/BhZXSs9+3zyzLQ7OImOCDxMTckefZypIzxlWtMJFzUk2747+cnxz96IeVaNMSc9In83e8zU8DewXaLiqiyAHAliUyZisq9UIY15MDVgSLBY7ng2slXEgggZsjcCME/Ji5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pt4jX6MG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pt4jX6MG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so4084350f8f.1
        for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784301909; x=1784906709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AxMkzfTuRNAdYSsxT6YGmZwozzVZOIfJAMqM6UE3eUk=;
        b=pt4jX6MG8WgKHvEXfyqwKzgyqnClMuQKTkZW2yL8eZGTnVvsXYt6rdTRrTRL6T6OOs
         iAjNLv8GanrpjJNzvVxoBFofpeDJOhnXeXWmNL7VVshMurdXgiyBRdiff5/3cqkZJMVz
         CxKhxVUULspR59+Tcf+yWVtZrbVXIpppWVm+LkwpU8wbjM3qWg4cG+LdHLS0rj6Lyr4B
         M5FeyD/Sl8WAbZFg4NxMGB7pNtfPi4W2GMcXjimDbC0KfadAb5Hsgq63jXBD67/jblwA
         hS28D/Y3ncUnDk8rkkiRxi82m6HYrREFkqNGCyDA5+QHsFyyIzv2p9hf7VtrzIvB3UhV
         5kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301909; x=1784906709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AxMkzfTuRNAdYSsxT6YGmZwozzVZOIfJAMqM6UE3eUk=;
        b=Czx6fxrVeOCckQlvC2rZAFgFnCu870i+AXc3KSZ8mE5T528FRGvX8WTpzxe0mcCWbb
         nXd9EX7kH4ElJPcMV3m5WVinQKYOnB9CgaUoXh4FgMRz/u9Pzhmv2LbZS3FFK2i9ngq1
         NYPEROed5dFgshL6WsbFZUUKCdNJy0t7Hl+K3DwaOZDY/2N2+jYBnyWEEtd6OpNOUhmG
         uTd1qXrd3UIh/xTA1F8Jm+CVIPuP9FFBaoet02HlyUUFAQeJFBSRF+8Ta0wKY1nK7/du
         5D2Et13JNX9WJk7oDywmD1eULZQfZHOEYPn+aedAWvM7LS+cjFjEL65G9oroTFaanHUo
         xzfQ==
X-Gm-Message-State: AOJu0YyxdL2CN3peTv6VUYHshpjDkx5SZZHSZ+I4k13fsQMsHLcUY4an
	RMRsi6zhEl3TJyG8amo8UylVh/yBGNtKSSTH2nLNNWAnMeiBNPlyF0bRxPnUtOlLZUbrEvuVI9B
	+oOt0
X-Gm-Gg: AfdE7clZkxAoc8k3vhdTWw+JBGHGflJZViRtH49Je2lzw2aLxwtlF7XkDVqkaBdu848
	/VBWsXb2Jl4GLQCrZHA/AEHpKujbsz9L3VbfUdnhk7sr3DSyPQ8y+ljzTgtx/ny8NwYhnOzFd9c
	SG5rSLXcFxOwjHi+6A81gHN0AK+6ZcnRlNMnKYLmCBPGcPVvi9oe32AtLzXUlaEtf83iM6vp8GR
	yxys5dPSSWfSsTAlncer4Z07SpFyw6Me6jMlGRb/z++lOyuGlEfKl2z7iRS/rFyPSuL1KEz57Yh
	k7WuQVSU592b/yV6YX0N8+vmvjSggJI2otpTtHt57ELio2smk+QFEl9xP26bfhyvTRSbciv7A+l
	GeazdGvkgtOiV+7W7WEEORfVLxiHBUZoCRo4L2BFJGTBZOXlAjSrlYMDFt4gwm1wQNT7fFenIEH
	rt
X-Received: by 2002:a05:6000:43cc:10b0:47f:673c:42cc with SMTP id ffacd0b85a97d-47f673c431amr1140040f8f.27.1784301909172;
        Fri, 17 Jul 2026 08:25:09 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:8e22:8a15:f33f:dc60])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e49500sm4498478f8f.2.2026.07.17.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:25:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 17 Jul 2026 17:24:51 +0200
Subject: [PATCH v5 1/4] clk: sunxi-ng: mux: fix determine helper rate
 propagation
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-a733-rtc-v5-1-3874cc26abf7@baylibre.com>
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
In-Reply-To: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Q2OlWVW2kYyvJ4ck9C1HFEDQQxKC0CvD5EifWl3TI8I=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqWklMaJ5nQazW/CvZptCQwUdPHVXC+ogZgt8OQ
 joxR/uuJXOJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCalpJTAAKCRDm/A8cN/La
 hV5oD/9dlma9q3nUzL/D6R2ufySBp084Z81IAZgEr67zxgghSUFHEQ9bzvO/nc0VNLsU3M9IUh0
 4ZA/rOJ3oCRhfPhPx7moFNZeGHRDeIX+EPwqmmPwmtx52xUfjIJ4690J+m605pZvymTm4cY+jQd
 gceE0frmEqbyIEfu0gnDV6rq30G/RTR+dZot1y/hJxUzXOF3mNCRkPZdgYONXejfRwg1DLjVCU7
 WUgNfNii1Yhug11rQimQoyZX6GR+Av38uXBpHyyk9dNFu8zWx/yGNFjy0rS3pbeFeMPwCCzNjkS
 FWZAKrctBq+rV8TfjjkG04l6ebo7GcRWVZMhH1v05Tuh+cUwq2uVbWNBUr9tZZLeVJZo8MpEJoV
 KIf+AJ7R0G6KntjDdI2EzYv3iPhI/2tzidO4bq1N9GsO8WAruQVxS1ZvOKihwxHemA/GVFvRiJb
 3rOXM/36rTpfpNONyHxYOnBTosYJsRivG2X/FLEudqtCWgI6a6Lr0WJqcwR4MQWfXnyavgRajQV
 xDGUQzByRORUMmKK4g6jdmMG6An0wMtis3VF55mqs4XTb+ba4VcS4MqoM7pW9+No+NZpARzRsi6
 tJJGUPS3YNZFzaML2l4TXz/DDS3jsefb24rDGoAo++hpgYLMai4uKq0qeYNncyB06BqezdA3bS/
 kGIQCWWwp+aAl5w==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Applying the pre divider on the parent rate is wrong because, while
handling rate propagation through determine_rate(), the framework will
likely round the parent rate again while cycling through the possibilities,
throwing away the prediv applied. This means, the parent rate will then
be wrong when the prediv is unapplied from a parent rate on which it
was never applied to begin with.

The right way to do it is to unapply the prediv from the requested rate,
which is the wanted rate at the input on the clock element, and pass this
to framework to do its thing.

Change the determine rate mux helper in this way.

Fixes: 1c8d7af61b37 ("clk: sunxi-ng: convert from divider_round_rate_parent() to divider_determine_rate()")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 56 ++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 09230728c400..75ec3457324c 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -92,66 +92,64 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		struct clk_rate_request adj_req = *req;
 
 		best_parent = clk_hw_get_parent(hw);
-		best_parent_rate = clk_hw_get_rate(best_parent);
-
+		adj_req.best_parent_rate = clk_hw_get_rate(best_parent);
 		adj_req.best_parent_hw = best_parent;
-		adj_req.best_parent_rate = ccu_mux_helper_apply_prediv(common, cm, -1,
-								       best_parent_rate);
+
+		/*
+		 * This effectively treat the predivider as a postdivider.
+		 * It stays mathematically correct and ensure whatever
+		 * round() will do stays correct while walking the tree.
+		 * It may query the parent rate too while handling rate propagation
+		 */
+		adj_req.rate = ccu_mux_helper_unapply_prediv(common, cm, -1,
+							     req->rate);
 
 		ret = round(cm, &adj_req, data);
 		if (ret)
 			return ret;
 
-		best_rate = adj_req.rate;
-
 		/*
-		 * best_parent_rate might have been modified by our clock.
-		 * Unapply the pre-divider if there's one, and give
-		 * the actual frequency the parent needs to run at.
+		 * parent_rate might have been modified by our clock as part
+		 * of the rate propagation mechnanism. Same goes below.
 		 */
-		best_parent_rate = ccu_mux_helper_unapply_prediv(common, cm, -1,
-								 adj_req.best_parent_rate);
+		best_parent_rate = adj_req.best_parent_rate;
+		best_rate = ccu_mux_helper_apply_prediv(common, cm, -1,
+							adj_req.rate);
 
 		goto out;
 	}
 
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
 		struct clk_rate_request tmp_req = *req;
-		unsigned long parent_rate;
+		unsigned long rate;
 		struct clk_hw *parent;
 
 		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
 
-		parent_rate = ccu_mux_helper_apply_prediv(common, cm, i,
-							  clk_hw_get_rate(parent));
-
 		tmp_req.best_parent_hw = parent;
-		tmp_req.best_parent_rate = parent_rate;
+		tmp_req.best_parent_rate = clk_hw_get_rate(parent);
+		tmp_req.rate = ccu_mux_helper_unapply_prediv(common, cm, i,
+							     req->rate);
 
 		ret = round(cm, &tmp_req, data);
 		if (ret)
 			continue;
 
-		/*
-		 * parent_rate might have been modified by our clock.
-		 * Unapply the pre-divider if there's one, and give
-		 * the actual frequency the parent needs to run at.
-		 */
-		parent_rate = ccu_mux_helper_unapply_prediv(common, cm, i,
-							    tmp_req.best_parent_rate);
+		rate = ccu_mux_helper_apply_prediv(common, cm, i,
+						   tmp_req.rate);
 
-		if (tmp_req.rate == req->rate) {
+		if (rate == req->rate) {
 			best_parent = parent;
-			best_parent_rate = parent_rate;
-			best_rate = tmp_req.rate;
+			best_parent_rate = tmp_req.best_parent_rate;
+			best_rate = rate;
 			goto out;
 		}
 
-		if (ccu_is_better_rate(common, req->rate, tmp_req.rate, best_rate)) {
-			best_rate = tmp_req.rate;
-			best_parent_rate = parent_rate;
+		if (ccu_is_better_rate(common, req->rate, rate, best_rate)) {
+			best_rate = rate;
+			best_parent_rate = tmp_req.best_parent_rate;
 			best_parent = parent;
 		}
 	}

-- 
2.47.3

