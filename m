Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C835494801
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318226; cv=none; b=cnSWR0Nx/Stpt5vVjMGgZQXiVGMgKRJJgb091ZTAUxexssyFqwEWVX7S/LonRYemy+0U59rCi14GHQQ6MHJTUTmDhbzI4vYNP+px8jrNTwaZvrGAhKLSVCWSJrbrbadFUFw6HUen08iBlELsb39ixdOIp3bW5YvwnF5ifBzKR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318226; c=relaxed/simple;
	bh=Rfp9zD+AGtMykHgxraJrydRglaXqcINy3OxmCxjWxBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBMNGPd4DwE3ZBLSG0RlQ/pXUcC129UJLoaLuoB5T0YAY4hMgBo/DMsS49X9BeQDTzpRvNoQXqHbMVYMNGw8TSYhVKT9rtIeAXdorpbjE7RoeqoaBpzYeuda32waKMSHQgwDwDQ2RsWKM16TLi4SdOxOatzoCQXDAuhAEzT1tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk7psQmL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk7psQmL"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso605478a12.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787318210; x=1787923010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MD/tlVb6F1Cs+xT8QKsJqaYk8IH2DGL1DxA0T5Wod/Q=;
        b=Kk7psQmLvoDAl6hkd/yStmxCuAk2ZmhHZCx5B3u9feY+DhJmhAN8aAuP9lA3VtmyCb
         MZw4Vy+k1atzgPDdnq+hMwV+fLehNnJ5uzwCis1tym8pyyFBd20QJPqwLs3UZvoLyDCS
         Z0lHDBRwASO+RxlOo9yjyjb8c3VRD/2eoawCtZpN0tRuBBBjIiuCyHn+qjDYcfVxxe16
         8yz/XPWCkf50/PCtyVdrrRi8Sc6mq6asi7SAXGiCZw8zTcw52T/iCB16rta4k87H6u5f
         QwvJDF6wqLPPPO5ZhhFDzpxiXLCoeNqDbUuJE88Ss8GVwiQTnsYObNnyNIgvgw2R5jM2
         ODqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318210; x=1787923010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MD/tlVb6F1Cs+xT8QKsJqaYk8IH2DGL1DxA0T5Wod/Q=;
        b=nmQ0khoXrqIY45/nmr9qgtLANeMKzX8NDt+hHTB817a21s9ICKqnnwn/F9A0CvP3pv
         zIcbOSTWjzTXHM42mySEPfsOYI74cAVV60mQMhZLLsfuoYrQEXVn25Jse8jIR7UEXUpl
         kdB/Kgld9TsR/ZUekGzYnF/KTNEafcPYQPoM0YJC/ITGm4KusoxHjvQdpy+aghXLX8H+
         4QJ0ZhwZKNTWrYUZDxkU1vk5yJfNC7un7DNg2bWMTuUQ9Z1nRbtSghafHZkZwYsG2eOn
         3sX1Uyj1fgt5XiFvIUUalivX22IFzPa/ce5+v8wLG6a3ADjgkQyVcJlGdOAn5F9eR+rp
         k1og==
X-Gm-Message-State: AOJu0YyE7dIfMmSa0KOnWxAFs13Hc8OlksBpRQXlxSedgOHMFk/gXXkY
	fxa0hZQfMB6v4iddaq3xq3oGuR+KsL8erz5DJ4UVqkE8CfGHZJTnDI5O
X-Gm-Gg: AR+sD131sjR6VVWokDFOkEzddcpkq4jY/Fcyg+YETrsu9Z661DjzUrC3wpvDsTeMLAF
	JzjYk/xTq0JpJ7AqgqaoErKu9288yfEVYugeSx8ychvDaPJfRZSpFEs/rJnjTMm83+nrMUzHalV
	QIIfW50b/JRXh5zdf4OiRO7LORREAOrPfxy4dyt9mPqKVS9kbVpyOdKVVU7K7fxG7clNC3Ah4SC
	RE3Bp4DSNxz8BzHLfc6uy6L6Lb/bbTM21MIMEQ75GvF6RS/PBhqiu9Xf8OhJHmcBH3F6kEfSPuq
	LYmb5oI8QBaIC5tA3h8C92msVgGgLZcgtCXNPbK/rWqe8hfzoUlyZ9swejfpNbPUxapkNsUd+H0
	vEDtOi9a8EwQtAuysmeYqtFf46Njh+KV0LtCnracAmcVpktRIvYJlzyQ/GXPfU+PyUex3o4y4Yx
	LYNZuvTjVTFw9Oe5l51VPwnWlnN10zItWrLrHdCvhiF7aqUlkneSsMRk1ouYVQTQNfW9/GE7sU6
	IBgItoD
X-Received: by 2002:a05:6a21:58b:b0:3c3:875d:7053 with SMTP id adf61e73a8af0-3cd2febf6c4mr12831954637.8.1787318209868;
        Fri, 21 Aug 2026 06:16:49 -0700 (PDT)
Received: from localhost.localdomain ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15568cb22sm2878114a12.25.2026.08.21.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:16:49 -0700 (PDT)
From: chenguoming88s@gmail.com
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guoming Chen <chenguoming88s@gmail.com>
Subject: [PATCH] rtc: ds1307: drop redundant dev_set_drvdata() in probe
Date: Fri, 21 Aug 2026 21:16:44 +0800
Message-Id: <20260821131644.71794-1-chenguoming88s@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guoming Chen <chenguoming88s@gmail.com>

i2c_set_clientdata() is a thin wrapper around
dev_set_drvdata(&client->dev, ...), so calling both in ds1307_probe()
stores the same driver-data pointer twice. The two calls were introduced
together in the regmap conversion in commit 11e5890b5342c ("rtc: ds1307:
convert driver to regmap").

Keep i2c_set_clientdata(), which matches the convention used by every
other I2C RTC driver in the subsystem, and drop the redundant
dev_set_drvdata().

Signed-off-by: Guoming Chen <chenguoming88s@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index fd3858b6569e..5913210183b8 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1891,7 +1891,6 @@ static int ds1307_probe(struct i2c_client *client)
 	if (!ds1307)
 		return -ENOMEM;
 
-	dev_set_drvdata(&client->dev, ds1307);
 	ds1307->dev = &client->dev;
 	ds1307->name = client->name;
 
-- 
2.34.1

