Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033439;
	b=nrwZrD2sEUmeptBgwD/5Z/arHKgMNMjxVzySXnyQ+iDuzBgGEcp2sZ67EM0/XkOFDggU
	 zqjBetgA1JynPynE3S160+7vH7UH4iHBKjvgxqIA86LgyXZaZ/9GBIt6dIekzfNoXdzM5
	 Qz3GhHmBfm6OeS5LfxEF40i5nKkdCQm5x+iDCMkVJy+M/e5fAwyEnSK3492JDYR7WDhm6
	 BUb3ZRJP2u5mXwtUVkHDvNdml0MdyLTS92Il8+Vy+7QSPQQBMoBOxQwe9DF8V0mgQpKcM
	 4GIVYydXJ2wrVsOGQGkIQqyIt1TWc9C2bbAQcVHob1Xk3Uhivd6Gvyw6omwEKKnjSNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t0SasdD5O78Tua3GaSrEY4WvAvJVfv0N4XP5fK5UX6k=;
	b=pdhJr2jUnlMefplCa32IOm38Puw+s7jR8SdXF6gMQX4VHnKT62LPC9wqTmqh+3wYtylv
	 qLott1fQb3mHAWQyyrJy71YaqtKqxrb9l4jxoNOGFua+mntDZabzKS8oACW5Db56QfF1z
	 5c0lNsT5BmH8ktVOwJakKEl5vNJ3QhLECSQWTYJGx5VPNZceaiA+IrWaJfT9VcDJgz+f+
	 YRKFuAmnv1iL7EPXl4KmRczomNai4s3XKbr7mp3w5Ly9RUhteCQpN/axTCM8ZEBl8Jz0e
	 aV6o7r2bWrb+oEfTHR0AcUHsBKOdEI81nlb7OC6OcSEIXkMAntEmS4zbqVGDd2EzUHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R52Okyr8;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4156606A332
	for <linux-rtc@vger.kernel.org>; Sat,  7 Nov 2026 06:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4156606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R52Okyr8
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9d7791b00so10157905ad.0
        for <linux-rtc@vger.kernel.org>; Fri, 06 Nov 2026 22:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033438; x=1794638238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0SasdD5O78Tua3GaSrEY4WvAvJVfv0N4XP5fK5UX6k=;
        b=R52Okyr8y2WeBJ90NdR32XbxQ4qgbDLtcRNASwCSEPonXO5Kc5v1Pd5JlH7qxg8t7c
         HPY9y5VlzGvRuhP4EaDj7pc7SUMPeyuDIQTQiLL1DUvL9dIqtGl4Nzt2muqstyyb7q2v
         PdKzpQhDr7TUrNFAC5DkaiGkscPsqeALksYrgIGWZnMrELUFQYBAu36r3nLl8hwCx8wo
         c8VvuWTirrGqgVcKY1fghZht8PDF26snR6l+PqYD0WOqF1kQlvUjzY+EsQA7Bmbh8jkj
         VsJT3HQTR+TrAfRHK7Qla5uR4B6przejXtwubtfe6IGpJF+HeO7J1TIXySmkxCLAwBW3
         /sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033438; x=1794638238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0SasdD5O78Tua3GaSrEY4WvAvJVfv0N4XP5fK5UX6k=;
        b=XPyvfhH+eAxFeOOInkaRNy5xeM3AnqcU0GBbtTDAT7uURTenW9AN5BIJKDcF/YYGg/
         PXX/dc2N6/xboKqiyn+b+P4IToaKOXRDvodQua3Ez/U2hIuLyWJSTw551Cw4w5WsM/Vh
         TQ/gO5lYQ2HK3jG6j+XwUg2UzTJEx+b0Bt1tqAkxWIQcRzWexoLuTkNja8/C2gQr90cf
         1HgKZH2nWphh9GWK8hNvzZPstMHmr9r2lRvYK4eqcTa4EIUyllcSCxgzvxxZMSuW37kV
         h84tHGJfBCxaSFtvTBxsg3OLjWHcZpz3C1azoHAnvlkDH2Lu9b6GtFkeY/gUUNvPTePX
         dYsw==
X-Forwarded-Encrypted: i=1; AL+hErFnyTg7EyXMr53eXmvMN1ER9D9PS9hRWvqM6dFBoB+NaqeawOX1pTqgBxe9fO5uqa3XKKwAzS97MyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wEHlGrbViF/OfuzIOkFyJT9XpYtGGUiR9srn3np0n+o5pSXev
	N5nn8wYKN404oDeHpdEisPetrleDGm1fQo83ZmmGx0PgMiHb1Dm4KG0jhqpeUUhn
X-Gm-Gg: AYBFou3wGzS0vn/87IVaDoYCFDArF5cfk+dV02c2WHRxdHMk+Ru6K+BMeWPnRe/bovQ
	EuvnoK+2zA99Qe+bW3ScAtIk1I0g68P+UzQlT5uTtTAS186nNLm/FN2pk9YC2q3E4yS7GYyFJSG
	BvMjCpXLxN+gb+9w98nq3y+UNAwZn+yfKsFQHQCiq71RIwR6N6nUBHljn7F8r7ZS9cs4P/74JKD
	tQ0cYP0jeuT/Dq8yNkCgVdBFd11YTniFLQ/5tbspMdndnzMzCrMKVL3Wm/D0n/4XgaKI7YVBluh
	NZtCLmYfAj1bQmuZVxTE4JRTDDE0idyA3UIFvwChcxbuaclEYSwcdMYOhlQTK8KJFMcliN1d0wd
	YpXdbfFMPR7yLocuwsaqGJS515MX+8BjlSj6MHga4UgTsDRe+vsd7Pgk2SQYOJudbJUDwl8buGG
	u6wIv2zGqBS80W2qk1YrOBZXlUolZU2eX9mciyds551472P4GuhTJVd6ojTCkJLzNql/+53NNAY
	DIGuG1HoSTGDFcdkW1TNLzy0dit9Gl42zVFap8YmJzrq7Pjc0LGqGJS03hW48EuTvpRfxIxKmc5
	WR3EaUjWVLlkANeIWp0RX2tODYiF0NWuoXCXTRr+dUjTqYcEzbbOEmoBN9v9kVM4D8K0pQ==
X-Received: by 2002:a17:90b:510f:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3b0db724f88mr4471992a91.50.1794033438122;
        Fri, 06 Nov 2026 22:37:18 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc23b547sm1597066a91.0.2026.11.06.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:37:17 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: CL Wang <cl634@andestech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: atcrtc100: drain the alarm work before the RTC device is freed
Date: Sat,  7 Nov 2026 15:37:11 +0900
Message-ID: <20261107063711.3388440-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

atcrtc_alarm_isr() schedules atcrtc_dev->rtc_work (atcrtc_alarm_clear),
whose handler obtains the atcrtc_dev via container_of() and dereferences
rtc->rtc_dev (guard(rtc_ops)(rtc->rtc_dev)).

atcrtc_probe() requested the alarm IRQ with devm_request_irq() *before*
allocating rtc_dev with devm_rtc_allocate_device(), and INIT_WORK()'d
rtc_work last with no teardown cancel.  Because devres unwinds in reverse
registration order, on unbind the RTC device is freed before the IRQ, and
rtc_work is never cancelled at all: an alarm interrupt arriving around
unbind can run atcrtc_alarm_clear() after rtc->rtc_dev (and the devm
driver data) have been freed -> use-after-free.

Allocate the RTC device first, then register rtc_work for device-managed
cancellation with devm_work_autocancel(), and only then request the IRQ.
devres now frees the IRQ first (so it can no longer schedule the work),
then drains the work while rtc_dev is still valid, then frees rtc_dev and
the driver data.

Found by code review; not reproduced (requires ATCRTC100 hardware and an
alarm interrupt racing device unbind).

Fixes: 7adca706fe16 ("rtc: atcrtc100: Add ATCRTC100 RTC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/rtc/rtc-atcrtc100.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-atcrtc100.c b/drivers/rtc/rtc-atcrtc100.c
index 2433df3..51a38f0 100644
--- a/drivers/rtc/rtc-atcrtc100.c
+++ b/drivers/rtc/rtc-atcrtc100.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -301,6 +302,26 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to get IRQ for alarm\n");
 	atcrtc_dev->alarm_irq = ret;
 
+	atcrtc_dev->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(atcrtc_dev->rtc_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(atcrtc_dev->rtc_dev),
+				     "Failed to allocate RTC device\n");
+
+	set_bit(RTC_FEATURE_ALARM, atcrtc_dev->rtc_dev->features);
+	atcrtc_dev->rtc_dev->ops = &rtc_ops;
+
+	/*
+	 * Register rtc_work for device-managed cancellation after the RTC
+	 * device it dereferences and before the IRQ that schedules it, so on
+	 * unbind devres frees the IRQ, then drains the work, then frees the
+	 * RTC device and driver data -- never the reverse (atcrtc_alarm_clear()
+	 * touches rtc->rtc_dev).
+	 */
+	ret = devm_work_autocancel(&pdev->dev, &atcrtc_dev->rtc_work,
+				   atcrtc_alarm_clear);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&pdev->dev,
 			       atcrtc_dev->alarm_irq,
 			       atcrtc_alarm_isr,
@@ -312,12 +333,6 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to request IRQ %d for alarm\n",
 				     atcrtc_dev->alarm_irq);
 
-	atcrtc_dev->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(atcrtc_dev->rtc_dev))
-		return dev_err_probe(&pdev->dev, PTR_ERR(atcrtc_dev->rtc_dev),
-				     "Failed to allocate RTC device\n");
-
-	set_bit(RTC_FEATURE_ALARM, atcrtc_dev->rtc_dev->features);
 	ret = device_init_wakeup(&pdev->dev, true);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
@@ -330,9 +345,6 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to set wake IRQ\n");
 	}
 
-	atcrtc_dev->rtc_dev->ops = &rtc_ops;
-
-	INIT_WORK(&atcrtc_dev->rtc_work, atcrtc_alarm_clear);
 	return devm_rtc_register_device(atcrtc_dev->rtc_dev);
 }
 
-- 
2.43.0

