Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8D472F62;
	Fri, 21 Aug 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306969; cv=none; b=DvsRgv6YF2vbapq3NC/Q9z5yf7gP1PCP3ssIFxZqtczYFptZTr80EEoD8Sxo1EHZkIZ8gGztCYxuO//IgQXCPo3cIF/IML2k3/dxRmysmE0JynDeDBkqiA3SaaaCZbnHKMQw27O4FqU3ZcXGF+r7LbA0E9c6HXpvtRRuW0+RBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306969; c=relaxed/simple;
	bh=+vuvfem57GnYXZHGUo2wzBaedj/h7//ZRCreSnrqwuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpXjDN2lJZGN0svrgRBR1skjXxDp4iPai9o/V35j9M4IjSVE6Np0k9UwQOjzS37FPtg8Rezz+/ye1msqWgkdDr4D9Ilw+MFLcu+yrA4dbWbSRJ/KCC1Yi2wBcbONRcZViQOnrR+M6PsVSw+dhFlT/Uen6ZI8GuJEDkgvnj55blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C170E1F00A3D;
	Fri, 21 Aug 2026 10:09:16 +0000 (UTC)
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
Subject: [PATCH 2/5] rtc: m41t80: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:09:03 +0200
Message-ID: <c5290fb9a28b45d6bcec724d5897f8bcbf96ea50.1787241693.git.geert+renesas@glider.be>
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
 drivers/rtc/rtc-m41t80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 3c8c379392c14078..ec86ca3f2c4c85f8 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -574,8 +574,8 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 	struct i2c_client *client = m41t80->client;
 	struct device_node *node = client->dev.of_node;
 	struct device_node *fixed_clock;
+	struct clk_init_data init = {};
 	struct clk *clk;
-	struct clk_init_data init;
 	int ret;
 
 	fixed_clock = of_get_child_by_name(node, "clock");
-- 
2.43.0

