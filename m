Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5BD4746AE;
	Fri, 21 Aug 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306974; cv=none; b=R0YDuBRV2ZWYBhpCA5BzMEYQpfgU0UHIIClGCNqYeIhqLmpScGm61e+Rct8wXBwxY4Xif71UDyu9AR9sHOq5acBhrrfAN+xRn+1sitjbZlvFuDQEOY1n9/Uo3m58eaP10NaKKaTDNnKqQkiPFq3di8gd8zekvo/F0ewiT5TSh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306974; c=relaxed/simple;
	bh=PLsXZDyyOQfp7NL7PkvOQqF6+yH4c+dQZH0U/FOnh3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmUPfJB91W1ZJnk+bJxIjGInQq0iQncU/EmgOh7Zi0FypEC5HNVYPLBdfM3oK4BqYt3GBc9S5l6nnf76yMNlNMDOaoEht0xpyMp9eiDS4tZJLsd4b9pWIj4JvBL3JC7T3UA1GH0neglyaG8J2zY4lliIDs+DDc+lHNmkOuM6JkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F011F00A3E;
	Fri, 21 Aug 2026 10:09:22 +0000 (UTC)
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
Subject: [PATCH 4/5] rtc: philips: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:09:05 +0200
Message-ID: <8281eaf605069aac2211d83233e11285b8e8ca84.1787241693.git.geert+renesas@glider.be>
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
 drivers/rtc/rtc-pcf85063.c | 2 +-
 drivers/rtc/rtc-pcf8563.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 01e209d88f5f357f..8cb9ffc73f6d9001 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -498,7 +498,7 @@ static const struct clk_ops pcf85063_clkout_ops = {
 static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
 {
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *node = pcf85063->rtc->dev.parent->of_node;
 	struct device_node *fixed_clock;
 
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 81d13733b1e9372f..5503eb61df13f4a6 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -425,7 +425,7 @@ static const struct clk_ops pcf8563_clkout_ops = {
 static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
 {
 	struct device_node *node = pcf8563->rtc->dev.parent->of_node;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	int ret;
 
-- 
2.43.0

