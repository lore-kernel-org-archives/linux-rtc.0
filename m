Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5842E01B;
	Wed, 16 Sep 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593916; cv=none; b=F5yezGZwi6+e25kfRjErdt5RJE6VvJf95rnIx/gB+eAEEu29azXDgdl1ztT44t2EmLGKUHuiLd3u2mTTouAPg2/zheAjSBs67n3CkH9RV26M32Pnz0zCXLyoerFobNw1oaRKIM2pzopCIFA/WFWEDtWEzHyu5OPzetaAIcaFyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593916; c=relaxed/simple;
	bh=uL8D4YQOwuPQBcSuHvK9GC7klfT/e6+cXJGsjlIAGFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uVL4dstUG7wY09PGm3Fjq7fYK79Y09jmiObeFooupN66JphQwrUihgIH60DAktHXwW+XkGZjD3cgLWvDA4f/eOrkN++D3ccdJadav6m36LCXgfU8yFce/LtWhbEHw0ReWxYIRClgq/OU0SPDhXUZRc4x/0y+xbdJkbzrXifox9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Ich+XNCC; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Ich+XNCC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=a2NMuympqAJ88QIJlO2+SRts9zW7eK9cF0Oh91CkijE=; t=1789593910; x=1790803510; 
	b=Ich+XNCC4Slz/5JDgr5ACbPs5JEmK+HCWm3x393kub2dxWtjnbx+gQkRlR9eJ7m0SPGSDaua4Yw
	qA+7cJhryOtdmO/pcpcc84Yt2bMe2qoIQgMbxaqhuvOyvaKwA/CEmmzm487ZBKhkUm4cUjgbxEk5d
	H5XOuJpqUf/OppjpsB+9K2Zb8GM0PEDR1UWtynMXpkhbnQxeXSnJkvGI7+aD7RtzIY+0czblY/Fs1
	uXdCcPC7AxzgpHmiz9UbC+f4yyazTPcA5kwrCRImVbGe14obhRR6i12K2M/5DJH4C5EQi0nTC75bQ
	nECnslEKTjNCggSWPWhB+oHh0PymyOQlLf6A==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 16 Sep 2026 23:24:15 +0200
Subject: [PATCH v2] rtc: bd70528: properly enable wakeup
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-rtc-bd-v2-1-ee5c15937d25@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAP4Iq2oC/zWNywrCMBREf6XctSlJpI+48j+kizxu7VVMJIlFK
 f1304q7OXBmZoGEkTDBqVog4kyJgi8gDxXYSfsrMnKFQXLZciVaFrNlxrHOdYajsEdhOBT5GXG
 k9z50GX6cXuaGNm/tzZgo5RA/+9MsNu8/yrmSTdPXJfRK9Uww7V1Enc53fHjtsCY/BhjWdf0C8
 hoHmbAAAAA=
X-Change-ID: 20260916-rtc-bd-7d7b0e1c31b0
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andreas Kemnade <andreas@kemnade.info>, linux-rtc@vger.kernel.org
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=uL8D4YQOwuPQBcSuHvK9GC7klfT/e6+cXJGsjlIAGFU=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmrOcUCDJvLzDTs05Se1h+rO3hI+sZ0b+Xys/Lz/rAHP
 ZO+9KW2o5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgImIbWdkmCLh9OUAf8wt/Y2L
 XnvPqW/y5kpbYqLx7bacf6V03FSzRQz/PV7MKm7l3NjBEJ6x3v59smxh4E4fnvADsw8fPDxj1rU
 lDAA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Wakeup on RTC alarm now only accidentially works when wakeup for the power
button connected to the same PMIC is also enabled. Fix that by properly
specifying the wakeup irq.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
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

