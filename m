Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBC44C64E;
	Fri, 21 Aug 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306976; cv=none; b=VghjiehAcWS+4fUcAIVhAU9VZ+J6Ojy3zDnpmSWVhkZn4EvqHIGM89tdb4hEIq2L8nCWRBmoLwHZX5zgWQp42linNUTKh24veRStU2xgF0KpzSOWHZavK5w/T5qR4/kceOWXrXuHLUGahmFwCl1/lfrP9wip2DxFqJGQcYJ6iSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306976; c=relaxed/simple;
	bh=1NDotMnprE3SWVPCxjPZ6pzHM3rEzKNuGmcWynexwgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc2WR1qyv/MLljLi7wLfTvFDPTwSuvQ+R10MDm+k0P6iChrnd/Kd16KUSxtrYWQ8coLYcfDb6ofCreSamyuf773l/HMUWwUUzw75Otgdn9PPA5NqoGqZ4Sn55ugKZdTorcr+CtqQ1/1SgUA4supSPi0zzYaQfvkL9MJvabBpF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50E1F00A3A;
	Fri, 21 Aug 2026 10:09:25 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>
Cc: linux-rtc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/5] rtc: microcrystal: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:09:06 +0200
Message-ID: <6e7b5258ff73e93fe23dd83cf56f806ee60fa7a9.1787241693.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787241693.git.geert+renesas@glider.be>
References: <cover.1787241693.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/rtc/rtc-rv3028.c | 2 +-
 drivers/rtc/rtc-rv3032.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index d96f6bb68850dadb..d25e33d0835eea04 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -816,7 +816,7 @@ static int rv3028_clkout_register_clk(struct rv3028_data *rv3028,
 {
 	int ret;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *node = client->dev.of_node;
 
 	ret = regmap_update_bits(rv3028->regmap, RV3028_STATUS,
diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index 6bafdec637aeadd0..687faaef42b257e5 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -752,7 +752,7 @@ static int rv3032_clkout_register_clk(struct rv3032_data *rv3032,
 {
 	int ret;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *node = client->dev.of_node;
 
 	ret = regmap_update_bits(rv3032->regmap, RV3032_TLSB, RV3032_TLSB_CLKF, 0);
-- 
2.43.0

