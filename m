Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A233BBAD
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731718; cv=none; b=qE1Ze5COZ60JnhotPrhED+uKSPq65unwQCP0LRfxCSNAaonNPtAaLG4qj08BagjNiupoWeEj0J/wYHWW5wyIUeTvdyf0ldlebqOAvzk04BDqdKXvhtc3p+8tAkVKrQVSDMRpoBUJ2Ad00quubFipUJ81TWvgwATeV+YRMvN0aYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731718; c=relaxed/simple;
	bh=h886BmU9pfC+RezdnkZ3J5Ik53qoiogLhSBSntAHgiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvvmC621XVCY+Lj80yq92JQAOfmzZxwNr4+7lQjSAYFEtgOc7c5ilvGjqWbaMNqerYgh7kF6ZoAlJJUxeMBpz4WeFgKoZO8a7X6oMnCMeCBX5vBcYiyJqhFWANvB9wYltRiCskeyugFAxWIjfN0GT/6jWfNWNybrXfQsUgduukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dJniUK3h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dJniUK3h"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so11136914f8f.1
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784731715; x=1785336515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unyjlYSQAHCuBkgYy9GiPNfKBr8X4sZKbeG1doQS/7s=;
        b=dJniUK3h8iJkQSNGisgAhKUCHX1qHCTGfkFLoIBB14AB/mR+2IrjMPqSF7Xd99qEvZ
         ZExzUuKH+uUCO3YMEaIi3knMm4rlukchVro55n+LMK2vq+eUrBGKeuxAGrGeABi4AOK6
         qffdUm6ZYpAy+oTI1/N7gbe5g39rWZDoS4xnjYtRlOprRYF7S7uZl58frA0vaqkDtsVB
         i+GXwLmMAn4ivq2Et5II88x499Ltscu85zx5pqBO0f0i5cdUcMSa8+SbByV2UlQNXR8x
         w/po/TG3ILN/of5nGtP+EBQkApLLllC16BlFIVeweOsBgA1LUo4WAD89aKO5CO3vEJ2j
         GT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731715; x=1785336515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unyjlYSQAHCuBkgYy9GiPNfKBr8X4sZKbeG1doQS/7s=;
        b=kKOSCnfAlYpHYvRBNwAIuAYxtZMDEze675EB0uoxm4LIUkFOtv/0vDJ0W8gZgFnbAH
         fOiNuWM6L6fwMGhghJiPB9D+GxxJRlPhbClq1Gx+DN/skI1vYWQzeuWgTIA2sAt8DA5a
         j/vpM1Uo3gGJZl+1yp3l13+TO4/SMlyOCr6Ppy5rxZC5oRD0cxdcrafxLTnTIR2s/SMd
         FtHQjgj2OFbmcvWO/5mmT7jXYJAQXJEG1zw+C43ekRrTZYM1lfIGQTqObE2Rc5bss3Rm
         DMV09VNzG0pvJap8IDurDkmQbiaBAEFskOmjFOemPCal1FI8w5eZUvc15wrsHTZJbK2x
         lp6A==
X-Gm-Message-State: AOJu0Yy1f63EVKb7UUKqwF5STKnqACMSEt+UKq5pHIwu5oEfTqXwt2D/
	AJ9pEGv7AZuUu7uu21PBq4WFUsFg2OAFG3uK1LR4GHJHQQ8UGXQWwhXGGnJ5yVZmOhA=
X-Gm-Gg: AR+sD11rWMAOQvvP7AGBmYN9Jf/NS6zHIIja7LWJVKIwwevC813yl454le39KjSOAOE
	hbx1wsWZjcyaVXOJMjV5AR397d2irf5ssptSz2RzK0g1NH3l49Uh1YzoJFsuzXZ5/os7sBgLX/q
	VJLML1jIfsmV0k5qGzk5DSHgtx/gCnJ8+GTNqAs1ZV6qrdKfs1FoxR7Qht6ERu7mBcveOYMTTBz
	+pPH4UznWtN27MZNqYAyUweHYfvfrNj4vxQ7cP7nGZB1CVvrHHqfcvUH5BxwoZerPRa0p6rrLHL
	Sscugc212LO1S7gcO6QbWAAiijetgKL0mzr7RQFzj/sBtWeiNieOc1DSK0G0J2jR+UTHew1DB9f
	cneg3Vh5VdCrAVfZ1zYXxV2VxwApB8z9ZIyYunImPLO4QOE5ivEv5GcycKa8df5mSeojJI+MxTM
	aG
X-Received: by 2002:a05:6000:1883:b0:47f:5ec2:d54 with SMTP id ffacd0b85a97d-47f622fd23cmr26607833f8f.5.1784731714820;
        Wed, 22 Jul 2026 07:48:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a589:14b5:ba97:3626])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85b9a5d9sm6412303f8f.5.2026.07.22.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:48:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 22 Jul 2026 16:48:19 +0200
Subject: [PATCH v6 1/4] clk: sunxi-ng: mux: fix determine helper rate
 propagation
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-a733-rtc-v6-1-631cca28cc9a@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4256; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=h886BmU9pfC+RezdnkZ3J5Ik53qoiogLhSBSntAHgiM=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYNg6uyta/DkLplo2mqfFr0j3C/ackC1oBeDSi
 v/Kdomzy+OJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamDYOgAKCRDm/A8cN/La
 heNmEAC0b7q6lwuTPE/5GdnaLgm4KEnZMK/5Ab9WcKRFsjyAkSUDgxBrsg8F0oNqu0IPjzYFOJA
 1s8fBxBfn2PRXIh3DrGULfbL+R+qA3wx1RxQmeOVIDEzxVSY4y1GTzwRWgs7IgchF9nr+YhGn6H
 bVmBqo03Aly2UteOQtcyg8QMA+Vq70Z+CfOQJ9xFbZG1jMywPFyVGfMbZKMoLwgvti8oS1fvLvU
 v9ez3PTmofHI7Yh/dqjxlPJdY8/mVI2dNm/G69mODoU69AcQOY58k20qySvdS80UX2gMI9U16ma
 DrwXV4q6/GIq7jVQpfJGXa447Q3OZsodLTXtr7ivRIxefJNwFVFTzJ54YctO8ePepKdIKVAiWA3
 BqDBFGAAFufNNjhHqzUmxgNhoScAKx3wYHjuqV2iDk18JJT4YhVXS7uGs19cq9nLRwOwD4/tKQa
 O03g+vGul2Abc8JuMNSoIQEVw5uFbfrQG6jDdFAxGo30jFWVcm6T4N9+dmMYdUPWKGALKNpO1P+
 4qVXaENjXqBtGRDiRQR+9x0QMazD2F8KGNA0+d+vs1/pJHNfbE72Zt/wkyn8FtemqP+H7U3E0ha
 CU9NM1QNRhj5ibYdPdfSn5RA5l+1ob8oqUsZvxOSt1tp2Hh7FntrDRIJHYFd3+BEJRiB5S9QCp+
 W7y0ilfnsEMIPhQ==
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
 drivers/clk/sunxi-ng/ccu_mux.c | 57 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 09230728c400..4503c9780c39 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -92,66 +92,65 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
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
+		 * This effectively treats the predivider as a postdivider.
+		 * It stays mathematically correct and ensures whatever
+		 * round() will do stays correct while walking the tree.
+		 * It may query the parent rate too while handling rate
+		 * propagation.
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
+		 * of the rate propagation mechanism. Same goes below.
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

