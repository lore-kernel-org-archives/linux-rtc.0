Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE89377541
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935495; cv=none; b=KDOFbxBBiN5NlR4tUBn8fKPIxjh4Iv6GvF7K1RxhGMJI36ULt+j/gG26oTtlwiNT4bKnLokW231LjYSSyd/lRxpPn4T8ibKBMEh1TdpmdqghsoZo6TUeB94KhYQagycPyGXe7S8rkoVqq7Di623Dk3drf3VtIG+zYtAOjsjbgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935495; c=relaxed/simple;
	bh=a2Z5JjwNxud3x1Fk4ilxgstYmDcVs6aSO2HZ5JIEbIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnYSqET7WS0BU/hoE3rFvLVJEHzZeRmvKmIFkGIlq8sRUOeD0arvMLzl3yanzqedRFoYjC0itSYsCPsFVUem6IU/VsewyXfm67vmamQTj12eOaH/QzQ+Jymn8v8GHD14FmjqvHNOXLbNIu/5kvyZX4cYIqMyDFkGeJTDk+uirKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=der95ZNv; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="der95ZNv"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260828164448e59846eb30000207bd
        for <linux-rtc@vger.kernel.org>;
        Fri, 28 Aug 2026 18:44:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BZcCro/FSTR14TT7n6Isl1Irs+JM+nnMtBgNPo3XYiE=;
 b=der95ZNvtlPWTgIUUun2SOCyEiPO5yNDYTRXwyqOLuVuWHiVOi8WBskQmUkzDCONGlmGIv
 6afTbDlxsYq12OM9x5LPPUqJWTVhCCKhQHJlh5K3E8jAOUPBmrwv3NBEsLGkc66cx+y9Jwof
 kz4hI1I1QIGMtdWf9/YPfjWSLUDq4aQ3z6I4cHgOmsqXC37VWgL60V37oD2yxx+P2Vuw6Ugj
 fa1sBg6QYKtUxpPEtSVSfY+1queMwSUdO3anWmWVSPvaPAE3CDF5nib/pjHRhzmqXN1TvZtm
 OAn/oyAdZkFkDuLdG9zwrQBgmKD7a7ZB6jq7UzWdu31i3/0gXrxC+yzQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] rtc: pcf85063: use devm_of_clk_add_hw_provider() for clkout
Date: Fri, 28 Aug 2026 18:44:39 +0200
Message-ID: <20260828164445.3907839-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

pcf85063_clkout_register_clk() registered the OF clock provider with the
deprecated of_clk_add_provider() and never removed it, so the provider
kept pointing at freed data after unbind, leading to a use-after-free the
next time the device-tree clock was resolved.

Switch to devm_clk_hw_register() and devm_of_clk_add_hw_provider(): both
the clock and its OF provider are managed resources now, and the provider
is torn down before the clock on unbind.

Register the clock on the parent i2c device instead of the rtc device.
devm_of_clk_add_hw_provider() must use the parent, which owns the
of_node, and the clkout_hw it points at lives in the driver data
allocated on the parent. Tying both to the parent releases them together
on unbind, before the driver data is freed, and keeps their teardown
ordering guaranteed by a single devres list. Registering the clock on the
rtc device instead could defer its unregistration past unbind (e.g. while
a /dev/rtcN fd is open), after clkout_hw has already been freed.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- new patch (pre-exising issue found by Sashiko)

 drivers/rtc/rtc-pcf85063.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 8cb9ffc73f6d9..ac9ab1c376c0b 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -495,12 +495,13 @@ static const struct clk_ops pcf85063_clkout_ops = {
 	.set_rate = pcf85063_clkout_set_rate,
 };
 
-static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
+static int pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
 {
-	struct clk *clk;
+	struct device *dev = pcf85063->rtc->dev.parent;
 	struct clk_init_data init = {};
-	struct device_node *node = pcf85063->rtc->dev.parent->of_node;
+	struct device_node *node = dev->of_node;
 	struct device_node *fixed_clock;
+	int ret;
 
 	fixed_clock = of_get_child_by_name(node, "clock");
 	if (fixed_clock) {
@@ -510,7 +511,7 @@ static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
 		 * registered automatically when being referenced.
 		 */
 		of_node_put(fixed_clock);
-		return NULL;
+		return 0;
 	}
 
 	init.name = "pcf85063-clkout";
@@ -524,12 +525,12 @@ static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
 	of_property_read_string(node, "clock-output-names", &init.name);
 
 	/* register the clock */
-	clk = devm_clk_register(&pcf85063->rtc->dev, &pcf85063->clkout_hw);
-
-	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret = devm_clk_hw_register(dev, &pcf85063->clkout_hw);
+	if (ret)
+		return ret;
 
-	return clk;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &pcf85063->clkout_hw);
 }
 #endif
 
-- 
2.55.0

