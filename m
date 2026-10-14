Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FB3F484D
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006372; cv=none; b=C0veRTRSsnos35YVFtWfmgV8TRbrIP/MhIPxU2W7tRnEPIC/0S/2qeKOTVt/ZBfWxjccjXzTeCeSdOgr1tYnbNJWL9EcYcD1JJN2h9fvXa2yjGbQryL/poTX0nKt0r58iXSQ5/MltuKw5+xeN+E0Z5ZDPMy6KeA6eKEQjifRHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006372; c=relaxed/simple;
	bh=CHwRqVxsnHjeGl/EzDs6jplQ1XElmScr9zvEPr3Dl1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjY2xpUIod5tyXgRhcfedViE58zsv2nZAdCzpfd6zEyw1RKYtk1HEFbexma5J4vdnSXL/ITpgOcVjH+44SnLbU4swQhzEVMQQY8dBC9iawlrO9ivsWZzcCx7dTRw7riiJxTHKTp6X9PYxRpQnqNkIYEUMIJU9cyE9Mx89AOAY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILl0pySJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILl0pySJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso675460f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792006369; x=1792611169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUucbabIGrn3bRd3fXdHgTzW7jRpxaxIBGMPCbeA8Ms=;
        b=ILl0pySJKBbi98wfZoE1sxM+70xPA5Cs9aj5bq+bjmglfOcFj9uT8f/FJOEr5+XdP2
         VByc1rE6xONhMI8+yeZiB9F2fU5Fw1UJbRH0S9wrpbukS6uwd3/ys+HL/0vupkoSazo7
         SAHmppH4LCdmzwPE/SkYWtf5LFKxsSyIYwRMKQE6xjV4cMa/AA1SzFUUqFodJzOQEr/4
         2T2CmzcgvYQhgoiIpDJHQWbujfaclGYi/CaMfeKUHk+hzzhO72B1qdQOEbhNytPsMdx0
         jsXYG1RP0pX8QCHr/qv/WOLpMSTHJNaQhfc2BneaS5tOKL0s1yDTxVNRzrY4xJeUdZ5P
         7MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006369; x=1792611169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUucbabIGrn3bRd3fXdHgTzW7jRpxaxIBGMPCbeA8Ms=;
        b=avs9FAjOq+ZDOnLWeCw6h/13DSNN/NY1j0DPQ885pcbrxemb+2wytF5ERVEPav6fnq
         xcKCv9BzSRyjXQuuLdd/6md2s0f8B2ADRYUZq1CWbX8EFuzF4xyHxjobVH/GuUGQtAx0
         kIZH0dPyaNC5EPp+8QftTWF0AwiP/FMPIuRHbthmDM/+5pMMOPE6VPwvLHMF8va/crUd
         aIpx+YG5uI89HtddkZYPtFWHEImWwwOupZ5N48bR3S2YhJ8y6hUBdayZCqbjYah3awR/
         XZK/W0cynhUReiShcYDKtjYxOsCJsEXEp8rrEimxLvOvuo9ymCdV+ligy+IXoa3hZ+z+
         Noww==
X-Forwarded-Encrypted: i=1; AKwUvBzrO+i0yzKbq/zvUN8/rLD4IlYfnKsNNrKvccPg0S5fJnOs6zjPpZsLisd3Ue6Y+XziGlsg/XRSnHk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9qSFJhOBmiMmVE7z8+3o5BWdL23jYH7QNTPUdlJWVhUf9rUXr
	fkQB8GkNu8roFUHwVJv7MDjTLeqRH1xZC0/n2+/tUTrVVdKkYdXzSt7e3Gnge+tuVZ1LWw==
X-Gm-Gg: AYBFou2jcE3AchILrmG76RMcZwo2/fJcDFsCoGT393iv8n2W1ZvoI4BIJh+VC6zesW5
	oMVgeqb38YeTct+n55E/TcY+gQii3mhNI2FenWCEcWTnY2Tflz6vPVhQSa8y1F+Bk5fllomqFtN
	TS/aGdYGlKsNtejU/DupzOCL9zjWeQklWhZK4ma4xrLpNzX7Q+KcdyyOJtLJlTKDh51Un/+3s9Q
	y7YQxOb/0okybzOcJmGpEwIcMiMocuNvOB8UhlxgUzwV4sSHhESx1LwYPoSbw7f17A0efrGYOXW
	W7hzWeK3VN1W9fCWoIh4Yh05X9ST5mhjn5wkviddUTSzJ04r92WpBY6cSWq84gX7Jkm7OND3Eqw
	/j+hhNH1dpxtvFWXmK1XHV2nmCz17+0viT2TM3DDDlK9Bf7tMgDT7sPipbRI0WUiToebk2NIxRK
	Ad4lt8HNOu35RBg5bGDMrYo7gE/vGuRmVM5AeSH8uDu4b41KRhmn7wPloEOsHEcUXvWaNc3UZrD
	rUYE+vweaAlvRBqpjWnfH6QBDylxq0m
X-Received: by 2002:a05:6000:298e:10b0:48b:5e2:52c7 with SMTP id ffacd0b85a97d-48dba77cf13mr25773200f8f.8.1792006368804;
        Wed, 14 Oct 2026 12:32:48 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4e8csm13151463f8f.23.2026.10.14.12.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:32:46 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pablo Mazzini <pmazzini@gmail.com>
Subject: [PATCH] rtc: sun6i: fix error handling in sun6i_rtc_clk_init()
Date: Wed, 14 Oct 2026 20:32:20 +0100
Message-ID: <20261014193220.38055-1-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set sun6i_rtc only once all clocks are registered, and unwind fully on
error.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7fc60880e409..dd293e8324b8 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -231,6 +231,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	const char *iosc_name = "rtc-int-osc";
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
+	struct resource res;
 	u32 reg;
 
 	rtc = kzalloc_obj(*rtc);
@@ -267,9 +268,6 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	}
 	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
 
-	/* Yes, I know, this is ugly. */
-	sun6i_rtc = rtc;
-
 	of_property_read_string_index(node, "clock-output-names", 2,
 				      &iosc_name);
 
@@ -280,7 +278,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 								300000000);
 	if (IS_ERR(rtc->int_osc)) {
 		pr_crit("Couldn't register the internal oscillator\n");
-		goto err;
+		goto err_unmap;
 	}
 
 	parents[0] = clk_hw_get_name(rtc->int_osc);
@@ -309,7 +307,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 					  &rtc->lock);
 	if (IS_ERR(rtc->ext_losc)) {
 		pr_crit("Couldn't register the LOSC external gate\n");
-		goto err_register;
+		goto err_losc;
 	}
 
 	clk_data->num = 3;
@@ -317,12 +315,22 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
 	clk_data->hws[2] = rtc->int_osc;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	/* Yes, I know, this is ugly. */
+	sun6i_rtc = rtc;
 	return;
 
+err_losc:
+	clk_unregister(rtc->losc);
 err_register:
 	clk_hw_unregister_fixed_rate(rtc->int_osc);
+err_unmap:
+	iounmap(rtc->base);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
 err:
 	kfree(clk_data);
+	kfree(rtc);
 }
 
 static const struct sun6i_rtc_clk_data sun6i_a31_rtc_data = {
-- 
2.52.0

