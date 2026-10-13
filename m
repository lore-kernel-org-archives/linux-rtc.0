Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EAA509EE4;
	Tue, 13 Oct 2026 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892995; cv=none; b=TH6mkq331GSiTaGQDoB/0PWGfKV18gIiNc9htvnZOy5irKbouLa9J5OGD4wMSJ9iWjMxbvbaW1ah8e/CxorH5FmYPJaWo1RHBJR/i2ufoWMXTLaZ7bCmGEI0jh7bAyrLUv9mxnru0gUeE1JOzWO9G5/wZBtV0DSiHtI9LA+jLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892995; c=relaxed/simple;
	bh=qbLvI1qAxUz1CTbCQDjSTRdT3bs/6WabK9RkJzPALvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWSIL7gfmbNxDxXypsv3j7tMU5VjXFuX8bxVzwXqKWqQLGJILUtY/1i/cjoXl8XzEs86G9neqRIhGgAb5foS8HMT7BL+otqNQ1BayrIdg2b0Ytb5MoLdMj6k3onsNt6XcxHOxfKvgeY/ShqQaxNzxrJR6xVSs88Kjg88RUOYg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgMQ6QSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgMQ6QSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAF91F00899;
	Tue, 13 Oct 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791892994;
	bh=l5fhRoudEbnRAz7ld6xp5CxxnGp1UcvMNAjW4WYsqLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LgMQ6QSAWHKJIL2GBn58iaODxT6WtQVyEzS9doiZHYglAB4PDVmJtnHAcZcXT07nV
	 C1H8YRCwOQ00qh8m+AYgiBl/hdWMRZiEPOtNmnOLS8PlLk+701b4ev+8J9WzWiSxMK
	 bkvUjDk3P3Bc/fq0XVlfF67sCHoyTD4m3KtPtuz9LmNeQz1nf7rRRJqN1fgdjDYWnk
	 GzrkJ3kZfZWMbvXU+/9RrrSx0qE2ec+pBH/VGwfV47eV/jLwuOO39DsWJRYADpvbXf
	 N0JErN6ByydWPI3d3SaANAzyKX6fFtmfJQ7rxs1q55rgQGWSEa0bTVkkqJonYMk9s+
	 VWd1cAFeNRoWQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/3] rtc: ds1685: do not sleep in the power-off handler
Date: Tue, 13 Oct 2026 14:02:07 +0200
Message-ID: <20261013120208.11268-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013120208.11268-1-kaloz@kernel.org>
References: <20261013120208.11268-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Power-off handlers run from an atomic notifier chain and must not
sleep. Use mdelay() for the delay before setting PAB.

Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-169477@kernel.org/
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/rtc/rtc-ds1685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 94c89333c5d5..123ab9fc9c8d 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1426,7 +1426,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 
 		/* Set PAB to 1 in Control 4A to power the system down. */
 		dev_warn(&pdev->dev, "Powerdown.\n");
-		msleep(20);
+		mdelay(20);
 		rtc->write(rtc, RTC_EXT_CTRL_4A,
 			   (ctrl4a | RTC_CTRL_4A_PAB));
 
-- 
2.47.3

