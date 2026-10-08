Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9B22F388;
	Thu,  8 Oct 2026 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443670; cv=none; b=EJMaLbjvcHXPc8CXGILRf0ylHoUPb6rGaXlExTfa7yajbGwBg4e+FiAF+EwHiZeOjRf7IxPTjUi+Pt9FKea8XUzWspFIwqoE5qsqJGDEwEz6rYXkvZ5Cae3ILQx4WJFSn+salls7ifKsPnmI4wH05AoXzNz/8hxaPoJ7IRbOXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443670; c=relaxed/simple;
	bh=NtTOjm1y/Ni7aXQD4GxBmll2cnjrfScwo9IaqvNgBlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfEuFkPFVmrfJ9eutJZz0YT9o3EDQw92IsW+f+qMHr90aO5t8fcag5F7Tu/a77xjkwRmb/REUO9d6cJCV4vM8exBSOdG2CrCD/I8G4oYtvbPm7F6Wvgbl2qSYQMT9z0aGQt6bXwW443ph5IXm+Kr4tNFXEXyOgZXuLQaGfHGfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtq6bBfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtq6bBfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25DC1F000FF;
	Thu,  8 Oct 2026 07:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791443668;
	bh=gwHMoVyfzMT2YhnalMsX6ipLhz3wjI1ZfMIhyenavwk=;
	h=From:To:Cc:Subject:Date;
	b=Vtq6bBfjn/xRl+zIePIQSp51zb1dr1v+1nr9O7VH/taM/HK2EU/htxnsY92uEjeMD
	 cLsi/HMKz6iHdqfhZ/1Mv1iFmU3y9d6hELQ21VhT8m5RjhDJoFmCEDjpgCO1xyLDpG
	 GpEZ/l7TjXnMnuGLzcx2lt4pWMT6H/IXZw3mJMVgmg8jZImxGK+6aCJfHFhVs1THQf
	 r7OFOF/Zoh2lslZ+vLaywzgLqL6gaf4Dm//P5XUWXWback/uPt992yMRWkhultVMmn
	 IBPj2obkmqitg2meQiQJnTbhva8PdgSzf7eyq7CJjQ3wV/JxhvOu6LVj+wHPvYXYH6
	 IrpZJOSTaM+rA==
From: Michael Walle <mwalle@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] rtc: pcf8563: add SMBus support
Date: Thu,  8 Oct 2026 09:13:05 +0200
Message-ID: <20261008071408.3548442-1-mwalle@kernel.org>
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
i2c block accesses, too.

This was tested on a custom x86 board.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/rtc/rtc-pcf8563.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 7eebdb058067..56e75664c7b4 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -479,7 +479,8 @@ static int pcf8563_probe(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -ENODEV;
 
 	pcf8563 = devm_kzalloc(&client->dev, sizeof(struct pcf8563),
-- 
2.47.3

