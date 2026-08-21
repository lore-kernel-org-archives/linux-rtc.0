Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C73A4F51;
	Fri, 21 Aug 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306967; cv=none; b=MPZ24WgtbsX4JpFBQdlh6SvURLbqfYlSuOkj5ZamvOyfZRg3eSeR+hL3bI+5sSppIB6pohUCV0ybucZ+ldEQ60fLo2vYIOv7WoMuelFOBnrFRw1BGFulmPc50u5C8pOjCwdRxntSA7YFwOnVQllqV+C2QbyWbklVV5WPBazBMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306967; c=relaxed/simple;
	bh=zXbiwCZ4scIWdcrHWh3HpPkNLtdE7CJJTNiV8PrumkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtVAwcbhfJ7cXOwIi6/Ywg1Voxw97hkeeXiuLx5qLWGOOglA/akgYbIdfvYeUPZixpKcVt1qfLyMANQmGamn9yGPfp+/vMr9hJM9/5mxeAEB/kp2aNteKcW8X430yTYP6SoBm4jJv4aW8btg5HG7VVSlfoW3QFB1bYSpxrhgFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EB41F000E9;
	Fri, 21 Aug 2026 10:09:13 +0000 (UTC)
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
Subject: [PATCH 1/5] rtc: hym8563: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:09:02 +0200
Message-ID: <657f2b3a871074087aee0b7a70bf527ab0f48da8.1787241693.git.geert+renesas@glider.be>
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
 drivers/rtc/rtc-hym8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 3156aa5f2d9ff264..1d52cc3def02ef22 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -376,8 +376,8 @@ static struct clk *hym8563_clkout_register_clk(struct hym8563 *hym8563)
 {
 	struct i2c_client *client = hym8563->client;
 	struct device_node *node = client->dev.of_node;
+	struct clk_init_data init = {};
 	struct clk *clk;
-	struct clk_init_data init;
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, HYM8563_CLKOUT,
-- 
2.43.0

