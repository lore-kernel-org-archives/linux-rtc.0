Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559D474263;
	Fri, 21 Aug 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306968; cv=none; b=nrQ7v7ESSW5fmmchrnGdfmFhg1ax1eZWJvCLsaptMQUzBNKvqbEMAcdzCddzswoi4CmHm5SyAxgF8BnRQHvmjgnXZswT8nC5JwJi9m7TONVn36OAW8/H70acIyimarBqFE3uhehJ3jG4yh4YgvDmca2PwZltPxRhlORRrvZDR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306968; c=relaxed/simple;
	bh=Y1cnM13DbNn478LytvpG9P7pye30E44hNwfIROfSdrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpccFJamR3LY64GUJu+gKY2fT8XNAlfANrEj/AQV8gE/Km2IOdFmwXwu/g9OV0F1/eVjIN+ARLJbzUvLi9JyU/BFiMr7KCDrdeqH6n2+mPsaJUDFZcOSWXfTF2TtpKreTXY85bC1Xxx7WPb0pwyJ96X9j8bXTSiIEe3vfeb6sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26911F00A3F;
	Fri, 21 Aug 2026 10:09:19 +0000 (UTC)
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
Subject: [PATCH 3/5] rtc: nct3018y: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:09:04 +0200
Message-ID: <6dba18b645aeea279a67f4625d5ec48037c76f0c.1787241693.git.geert+renesas@glider.be>
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
 drivers/rtc/rtc-nct3018y.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index 700a395fad3a63b6..2f7ad57057a4b8a1 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -459,8 +459,8 @@ static struct clk *nct3018y_clkout_register_clk(struct nct3018y *nct3018y)
 {
 	struct i2c_client *client = nct3018y->client;
 	struct device_node *node = client->dev.of_node;
+	struct clk_init_data init = {};
 	struct clk *clk;
-	struct clk_init_data init;
 
 	init.name = "nct3018y-clkout";
 	init.ops = &nct3018y_clkout_ops;
-- 
2.43.0

