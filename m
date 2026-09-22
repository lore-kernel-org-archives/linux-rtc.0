Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783B5592F5;
	Tue, 22 Sep 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083228; cv=none; b=YvAZApDcWCYt6loE3x0X/GxGoJY6l25HWlaR4pgzXdDZfRA9397Heb1L5xR7WLK89ZySbCcMmld+gl4/F4rYd8y6ciAosw6Pie+vIk2EJaseK8gpUrq8Xk4F0FQMJEwQ+h//W1r+DzVnMMG15NWQWpMOJ3+Zt3ox1YfZgVrALNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083228; c=relaxed/simple;
	bh=etjLrqqZMpV4B74+p2SkN+VrpCZZKQsEYs8teHRXpQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q0F1tWPmiR9LCSMXbVGUe/JY5uhVSEk8f+WUblpPUj4Ze4cn/mfQLvbzK0vm15W76CheM6DtyRDqZwcKXAGHjRh79ydmdyuGVHp2JNUhEwXNqjBYRaVnMP9USb6q86ruFQgzeUxoYNqCN/bqQQOC4vAkg0OHJUdS0ty9jhln8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hsoWQC5t; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hsoWQC5t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZyEljCztyQjfKt/xpWjeVjgmLFom7cWRFWqUBY9MPX0=; t=1790083227; x=1791292827; 
	b=hsoWQC5tGyuUtscfNUzH4UL/Snw00N9mVkdNn6pPxZ3ZxCkH5xpQHGsptAJ+kKooUAVeeuTnz//
	bSA2De73tcTzVvsA+3IbXiqF8f0qhE/lKYNNaGalFipGfSVeuzi7RbDZx7VLITEUdmXBktvoyZj04
	wOL6DPU/lcYU7mjU6w7q5AZHqyVqC9xKSy6KtU4JJwozqJxRYxgXo9GQcSFKtljEYn80M6DkjoFAs
	ifF4U60qUO0ydji5oQUoMjXc4QWApA3NRboMfSHl/sCYNECuhOnXyaB66gp+21wGR1Z7yitae2y1I
	Gmrrr/pUR4VyUSQU4+af+clljRFkHbvscacg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 15:20:15 +0200
Subject: [PATCH v3] rtc: bd70528: properly enable wakeup
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-rtc-bd-v3-1-7f2580c55d58@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAI6AsmoC/12OywrCMBBFf0VmbUqSkrZx5X+IizymNoqpJDUop
 f9uUlHE3Ry4596ZIWJwGGG3mSFgctGNPkO93YAZlD8hcTYzcMobKllDwmSItqS1rabITM00hRy
 +BezdYy06HN8c7/qMZip2SQwuTmN4rkuJldynlFLJheiqfHRSdoQR5W1AFfcXvHplsXK+H6HUJ
 v4rfr9JPEuIwjAh69Zy8Wcuy/ICZWU3MOoAAAA=
X-Change-ID: 20260916-rtc-bd-7d7b0e1c31b0
To: linux-kernel@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=etjLrqqZMpV4B74+p2SkN+VrpCZZKQsEYs8teHRXpQQ=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbGiZl6kxZoxXu8D5u7ZX3B/llvwg0XUgzbarYVeGkv
 SWjzuFORykLgxgXg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABMxMWX4X3zvj+r62Pwfp3im
 m+YtidRctrnGVP+jicDRlg9C8c9WvGFk+ONrO6l7enn+HMEi7rK2g2f+fkz//LrxfKkWyxr/4pr
 LDAA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Wakeup on RTC alarm now only accidentially works when wakeup for the power
button connected to the same PMIC is also enabled. Fix that by properly
specifying the wakeup irq.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
---
Changes in v3:
- no changes in code, add fixes tag
- Link to v2: https://patch.msgid.link/20260916-rtc-bd-v2-1-ee5c15937d25@kemnade.info

Changes in v2:
- add error check
- Link to v1: https://patch.msgid.link/20260910092558.1008998-1-andreas@kemnade.info

To: Matti Vaittinen <mazziesaccount@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-bd70528.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index 482810b61495d..a58cf85bc1beb 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 
@@ -321,6 +322,10 @@ static int bd70528_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, true);
 	device_wakeup_enable(&pdev->dev);
 
+	ret = devm_pm_set_wake_irq(&pdev->dev, irq);
+	if (ret)
+		return ret;
+
 	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc)) {
 		dev_err(&pdev->dev, "RTC device creation failed\n");

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260916-rtc-bd-7d7b0e1c31b0

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

