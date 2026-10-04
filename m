Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311037F748
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152951; cv=none; b=HlHlr7ToOPucTcm2mbQy30OJGSmrtdQr4E8TexbjFCKSg89e1ntWM3EIgPbA009xKsu38+3orse81OS2NrwLTL2TsDW1X5zSk9CwMsG9xG77pIZQld7UXlFexHv2GvosYBKD05uuSie/3VSEhZkB3nQJIz5meyqdMNZmnHo5yMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152951; c=relaxed/simple;
	bh=Aesyo/XDVIJFxKR36YrAJDFjzW6U69fG6Hh+FvEej9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1xtDsmdmL8k4JuX4fdpi41ddeuq6oiUMorxHNuTFlxfHD2ecQHdfa06c6gux8bTqaTL3pFbkuQEnN1JaPz4WtztMf0oRWoY+uMEZW0Tg34EhchWITCQyXY0TuP6/DZa7Oa1jn0uMGpY1S+3TlDK3vbERH/beug1ztYL92TWWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPs7toGF; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPs7toGF"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc794a06e5fso556802a12.3
        for <linux-rtc@vger.kernel.org>; Sun, 04 Oct 2026 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791152949; x=1791757749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kvv70F+iiRq14pIcsIa/NBOXEYCFn2M6VVXOkr13wi8=;
        b=lPs7toGFhI/3eOg4eeEK6mikGFQ8KPgRJGwf/kQT4AurgWKO6WfyUQQ3+cWac5eQEV
         BYTamT4L5rLSGmXfs2FM/SidLfDVoSI07KQW2+NijMokNyE5MEUrcYdKbMimfrwmUo5Q
         ezxz8j7ITf/hDDoN+DYAjhZTuiEQJpfcvtQQMWsrlkhRNKm5k0x05UI486JvgEHRHXQk
         nrHNj3pPwKXRZRxTNNN1XAmt9JiCVVy01ZJxOkHUI/sk868Y7AWuu2gNCnw5RVbN6s9F
         gI0/qbNausuoiDCCeO7n816PFh+4JUbrtzBIt/DEPA5g6QsPb2b1Me5uh9tJhQfZ0E3h
         oJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791152949; x=1791757749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kvv70F+iiRq14pIcsIa/NBOXEYCFn2M6VVXOkr13wi8=;
        b=NqU+Tq+1waLlFtRNeHvnCeoK+c8Af1VsHdBoJ9KPYfnuv7nhwrSlSUcexYNksBUx1d
         RvoG2SlqkatyXO+/fc3htCX8RqI4hln09E5/5JFf4x9hQG3yxDGDczPWuekDb+N/Oih1
         gMVOQIwPBZiVkrLMCGIG3uWnM1tDqaaAPsFS/+9/6fAQWWrpGovgsA8Ct7091UKIdyXw
         8K6PBbP+S3lK3Dj5FS3NTmX3XS2FDLm7lDAiZImRgE3jEmFVhC0Npu6DjSK/MVKhiWom
         1Oe44iFcpsba2/qYcvFEwOyiHr3wzke+ZZjs/Yl0/aKGD34Te/f+NjvCAvGca5Fmpugf
         0XXg==
X-Gm-Message-State: AFuF++mivH4twht0ONUYVrwRMBLH/sqhV4KuBICYH5QORnxfHpct6Yy8
	z0pIlxEvD8dkT3bLDuuW3OL1eBIE3Ld4wLlNJoyYp0jH1M2oxbSmpXD05IMpF+ij
X-Gm-Gg: AYBFou1EefAswqOzdtKhstEo8wKQbA8V7vl3IZQIq20jCUnw2WU95VKbMSCZeGv0+1B
	Ija0LOEWbWZYX6TuaM8ovdA5katuMjtzkwc26j9xEFERKKTTorDjIXTc8fBj70lYlIHFNqOWClK
	Q17/2LlSwXih8WeV6dvVFAWqbZb+TuaDr9oYDt7oDCJQW8cEm+06/4WEU6/CbGZOJjRnsTheRc8
	hpWxJTjAufXItK4qdrbYxXYeMkJWUgYdw8JgB3O98ffQxDA2g4n/k6YL8sFX/+iHYDzmakZoD+U
	G+lR0zsbQJXYi7APyXZuNBTnntdJy6U3HWtgIpmqzPXkvnT8BKM6aAE6LfgE7rzlASSJUIsKVz2
	mCs9NBxM80ClI8BsM0GD3GNq8slTKXYBZ3olrGwodyGZXjNYgzQS1qNqBtr7FVMOU13o3zOzBkp
	T9jNZr7GJ3LB9+Z3ZhHlU7xoh17yY0N1aclvHV/dnlDVbAz5KhTFCvh0OV1M1AGv2NtzD4aZYZV
	ZjkI+LQ0qOTW+YCZdvsogCHkER+oP3C2nhMMyrJwSjaf8QmNmAy5XIOlnQHafuPitgq96aSselm
	iQfE9bZjwDvF0X0b3ev4E8AS9CbOqsezNYclg9zo4ArEVslm
X-Received: by 2002:a05:6a21:670b:b0:3d8:5a37:549c with SMTP id adf61e73a8af0-3e0bc9f8ccdmr9151189637.7.1791152949454;
        Sun, 04 Oct 2026 15:29:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c599e7asm2820705b3a.34.2026.10.04.15.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 15:29:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rtc: mpc5121: request IRQs after allocating the RTC device
Date: Sun,  4 Oct 2026 15:29:07 -0700
Message-ID: <20261004222907.437878-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe requests both IRQs with devm_request_irq() before
devm_rtc_allocate_device(). Devres releases resources in reverse order,
so on unbind or probe failure the RTC device is put before the IRQs
are freed. A handler running in that window passes the stale rtc->rtc
to rtc_update_irq(), which schedules work on the freed device.

On unbind, remove() first disables the alarm and update interrupts, so
only a handler already running on another CPU is affected. On a probe
failure after the IRQs are requested, remove() does not run, and an
alarm left pending, for example a wake alarm from before a reboot, can
fire in that window.

Request the IRQs after the RTC device is allocated and set up, right
before registering it, so devres frees them and waits for running
handlers before releasing the device. An interrupt arriving before
registration is harmless, as rtc_update_irq() only schedules work on
an allocated device.

Fixes: d53d4ae981d0 ("rtc: mpc5121: simplify probe")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/rtc/rtc-mpc5121.c | 48 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index b90f8337a7e6..4a03c5280a24 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -307,30 +307,9 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, rtc);
 
-	rtc->irq = irq_of_parse_and_map(op->dev.of_node, 1);
-	err = devm_request_irq(&op->dev, rtc->irq, mpc5121_rtc_handler, 0,
-			       "mpc5121-rtc", &op->dev);
-	if (err) {
-		dev_err(&op->dev, "%s: could not request irq: %i\n",
-							__func__, rtc->irq);
-		goto out_dispose;
-	}
-
-	rtc->irq_periodic = irq_of_parse_and_map(op->dev.of_node, 0);
-	err = devm_request_irq(&op->dev, rtc->irq_periodic,
-			       mpc5121_rtc_handler_upd, 0, "mpc5121-rtc_upd",
-			       &op->dev);
-	if (err) {
-		dev_err(&op->dev, "%s: could not request irq: %i\n",
-						__func__, rtc->irq_periodic);
-		goto out_dispose2;
-	}
-
 	rtc->rtc = devm_rtc_allocate_device(&op->dev);
-	if (IS_ERR(rtc->rtc)) {
-		err = PTR_ERR(rtc->rtc);
-		goto out_dispose2;
-	}
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
 
 	rtc->rtc->ops = &mpc5200_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtc->features);
@@ -356,6 +335,29 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 		rtc->rtc->range_max = U32_MAX;
 	}
 
+	/*
+	 * Request the IRQs after allocating the RTC device, so devres frees
+	 * them, and waits for running handlers, before releasing it.
+	 */
+	rtc->irq = irq_of_parse_and_map(op->dev.of_node, 1);
+	err = devm_request_irq(&op->dev, rtc->irq, mpc5121_rtc_handler, 0,
+			       "mpc5121-rtc", &op->dev);
+	if (err) {
+		dev_err(&op->dev, "%s: could not request irq: %i\n",
+							__func__, rtc->irq);
+		goto out_dispose;
+	}
+
+	rtc->irq_periodic = irq_of_parse_and_map(op->dev.of_node, 0);
+	err = devm_request_irq(&op->dev, rtc->irq_periodic,
+			       mpc5121_rtc_handler_upd, 0, "mpc5121-rtc_upd",
+			       &op->dev);
+	if (err) {
+		dev_err(&op->dev, "%s: could not request irq: %i\n",
+						__func__, rtc->irq_periodic);
+		goto out_dispose2;
+	}
+
 	err = devm_rtc_register_device(rtc->rtc);
 	if (err)
 		goto out_dispose2;
-- 
2.56.0

