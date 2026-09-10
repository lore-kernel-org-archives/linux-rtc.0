Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24573BBFAF;
	Thu, 10 Sep 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032387; cv=none; b=s3+RWDxqgLx1PDshIgtZqn9G6Grb7OQ2tJkEwMrWsLOekNzq9NwLZUh43ZjZEepjGSjvi7yz7E9xcswZb2g8AeeKF8uw8G2v/aaM7d9MiWkvkiF46k/6jGOuKq6yEsovp236l5AP1iNEDkPk5o4xMq5OvTgWGl1Bkq8YuLgxo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032387; c=relaxed/simple;
	bh=PT+zu3eJj5Z8+sFNHe0reprq7zWW/wywTm3s9389Tlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5CuFKDuhPkcE20T09kQYuPEDrrGRi629lYooasQmDeQUWVXvUA3Y21WT04K5Hu7GvxSK7mx6q/fdGKs/NXE9bVgyZWlc/o4qk4Un2j7yFyQwgk53PfmllZ3RsF3vfU2LBlQj+35mQEn8H0Fg2oYAxJt22UdQb0twrBl3XBt/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=H9jaVCTK; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="H9jaVCTK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:Cc:To:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BecIlZLVPRK6Og3q+et9cNLE9eAXmRvv2XefvnpOvvY=; t=1789032379; x=1790241979; 
	b=H9jaVCTKRN9wFE6hMnYiEEYPgHh6K23qzJNyehtrnY38p2nJazwVfyg/6N8Tl2/Wp/7Fp2RkE0R
	8A9sj4HvFxUdtPk7cDOtR8Tx1E/7QJXuWosyjSFxoG5Nq0UtiF7vOpougCnRXkPBIJSCNes98otY1
	/1t6g7UB6Ufunf7rIhj/DMxUUw53dGzCXfU0Jjre+Jd3LddK5c3vC9oKazjb8uKdjAfbSRdmWPaAC
	JBYdEWiFs7O1BCBQn6LElBDUPTrG5ZvqXHKd6N5rQobl4jivq0ILc2u2c5nzLSZ5Aapu8QFFGqz+k
	Y9pW46jPCROj3hZajK8xr+H6GDUxCHMskUGA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: mazziesaccount@gmail.com,
	alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] rtc: bd70528: properly enable wakeup
Date: Thu, 10 Sep 2026 11:25:58 +0200
Message-ID: <20260910092558.1008998-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wakeup on RTC alarm now only accidentially works when wakeup for the power
button connected to the same PMIC is also enabled. Fix that by properly
specifying the wakeup irq.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/rtc/rtc-bd70528.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index 482810b61495d..dc86882562abd 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 
@@ -320,6 +321,7 @@ static int bd70528_probe(struct platform_device *pdev)
 
 	device_set_wakeup_capable(&pdev->dev, true);
 	device_wakeup_enable(&pdev->dev);
+	devm_pm_set_wake_irq(&pdev->dev, irq);
 
 	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc)) {
-- 
2.47.3

