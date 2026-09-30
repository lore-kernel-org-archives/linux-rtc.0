Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D89448394;
	Wed, 30 Sep 2026 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767901; cv=none; b=nwYe4tsFVJR9pIEhC/YUcsvv/GfgBaUfusgvyR/O2FHy1+cSDCs2isRwVeEiKQY1zUvagWI2yYRoDjlvf6JchyB8f5IAAr8dIdJzRf/3hea+bgCPWeg8fPlQiAb68/5aAlMufVm9TH+N+QVbg8XrXiqHw6/qU5NZBv14hj2t/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767901; c=relaxed/simple;
	bh=nRPTJtFFp2iWqJ2IlpdzhC316XNMEgwAbnBucyMqrAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fg2aisiJOUEtSgfBP/AsBazmAer6co9JSKAAwZD32wFkXtompuc4QvDzytCqXF+PdIQjYMHxdMKschKb0ReFXY2b5shlsTa1xp0DP5rkUrN15wYUSQgaCRvMupDPe1pKKN89b0WkNzFEUeSD4OYoBqrhIl7yrUsQUosCtSv+oY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGorODrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGorODrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E511F00893;
	Wed, 30 Sep 2026 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767899;
	bh=gYXHW6HBQLGHFoAypcSyD6Tjez47r9lYj9tHE1sEqRQ=;
	h=From:To:Cc:Subject:Date;
	b=FGorODrwx6v4EH8yKnQ17kC+ZYTZQpKE0rDoznrZ1p3rnjxq9EeDu1YJilarqbnrz
	 p8zRz1hL3wMrBGa6D5zsnM4aCyISyUV0j6Ie4gK1kr+gRgSbFmEWszIbTZe4hKBSdU
	 Apj36CFCIkdFahCWhNovu8k9pJh+fZFnNCi/jhREdptTL+9pw9G3T03T2TGeq7QyjK
	 Ic/kyMcHj+xPeoEd29NM4rOBH84Gefvp9uR6sVkjWnOf4sRJXnqUzsDUfOi2A9LfZS
	 //NPwHIoPuWKex+rtUVp9DBzpvFPGsi1nMv9qqyryExmQIfIEutXXNa1y+4xDCRMfG
	 q+Z1AdcZrOqpQ==
From: Michael Walle <mwalle@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] rtc: pcf8563: add SMBus support
Date: Wed, 30 Sep 2026 13:30:53 +0200
Message-ID: <20260930113126.720555-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap") the driver
uses regmap to access the RTC. Regmap itself will figure out if there is
a suitable I2C or SMBus host controllers. Thus, don't restict the driver
to just I2C controllers and make it work on SMBus controllers supporting
i2c block accesses.

This was tested on a custom x86 board.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/rtc/rtc-pcf8563.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 7eebdb058067..eee9bc752b52 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -479,9 +479,6 @@ static int pcf8563_probe(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
-		return -ENODEV;
-
 	pcf8563 = devm_kzalloc(&client->dev, sizeof(struct pcf8563),
 				GFP_KERNEL);
 	if (!pcf8563)
-- 
2.47.3

