Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE036B915
	for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321035; cv=none; b=pKFzEIgrVai9WcbmiZ/d2W7GQp8S+1dTHW1rQicvHqfKXCg92lVqIOuRps2T6rZHPxt/nxaXDcbzug+dZ14c+TmnwfTwDJs6TTmtzz7FBBDH+5hxThIQK9y9mUocXlrlpMtRMJYee+JHKpyRHZBBgzBx13au0eHTkFOlRcIdPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321035; c=relaxed/simple;
	bh=IRyzIC8VRC/jjqvZPY07sbaPLOM0r7aLFQkJo7n68u8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oz0NuAZdE5QPJd87p2jZKxp10dB2cMCC+aBOsyKQU5ONfGL+xWfhPCk/2Zz2PIjKnBaQ9EbpFQN+3wuyQaedPCbopxZTH9JtcvcfMvOcRVaqEbwFr0O78K1wBEyarZdr6fBdixxxtSf23jnJQfpHvrQvm4+3rsPSnQCU19rA61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knN1U0/X; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knN1U0/X"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144df39b6cfso444929c88.1
        for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790321033; x=1790925833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSELEHI//YEAphEyKZ5VJ4gtHaeIaGb6UIVWXzz2yZI=;
        b=knN1U0/XqZLtS091uV9wJCLY4auo02vPT+fL4UUNO8Y9PMfBJcze/keAlS56FhWAW2
         /pKDY9FV6+muJv+e69oMw+AvfH7p88eIztswARitnwTjhvNgFLgSV3dOeqLaOgB4AQvL
         1SkbJqoOhL/El/2kx2JxYtWVb6Y84uUQHV8MRnTkFTi2mohpVm+dnJQ02dM+erY+dy98
         G3G2yDXEJmRSTUyR0g5Ru/9tk6URpLB1Ia2fr0XWodG/8/nwx8pVeoy9t1N/4tqkOe62
         hj7lZkN1xTHIWgU9+rHq7N/EFR84jqIOLqIGciXbfvo1+mqkwHKSyQ2vTdB2ULF9lnYV
         LQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321033; x=1790925833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSELEHI//YEAphEyKZ5VJ4gtHaeIaGb6UIVWXzz2yZI=;
        b=xCe98vmPFt4F8PDXaOQmhJZsOD9TXW0hJqVE51hLMngQd8CO5cPJSGb16VV4SDlMVB
         mmESokuLX1AuG+ETFpJNYvQqITRuc/fbuAjlajKwRsa42UPBoEMJImQsNT5Z/1ZztzOn
         hI7+qIZboNwRUMRLUnpsb5nxlA57b7r7dTmfDTT8KscIHplB4sqgDX/Ts7x/AnP1b2Gb
         rP6auynqaBc5fE4BzF0YjVmqvcu0+ZwcqregWTJ59ljVazS8UCaHQhyRpsQ03nrGBb8X
         FFxD6xWtvMfJh7R8rFCW7KYz3XkKVhQIQzayNPh1ArVBtFxCBSmnv0DAsIGAtUi3QQ1b
         l7lA==
X-Forwarded-Encrypted: i=1; AKwUvBwE44rFhVwJRELRPJ5s9CK7nxVOZvoc614H0q/UBZcOsHJtVlhn+DbXBNBtwfF2YzBhuB9xfTPec64=@vger.kernel.org
X-Gm-Message-State: AFuF++k+RDbOO4kwcwUMc5li9T9fy28E/L3qaxg6WRuXttkc0pZfMqxU
	fXwxXT5RfnonDHQ+bavScVNYTUO3731ElkUieL73JBmeiMN5LmqNa88F
X-Gm-Gg: AYBFou2sMG9HD5z72xjmORVIILH55dPFpuOmAWIYRRBG/njq3BfMxyM/xDduon/nQZT
	U0NOkG4Jh8ohnGmYoUUBlAKgdsqufOVtcY+w8T47ZxfYKfQB9v4GvLIB72Tnob2Pb9oM7zjFutS
	HbtkWhZC59XKCSWbBM+IrtzDEyrlsPcZeHrt+aJwfxTRVeJvUDhSc3bhGKsFdO/H4aUhrFh6N4b
	QwC2G8V9Q80YwNeReNUHzaLqcTHYXFxTd1zcfP2j8ceWDKdW53FC8FnWkUe8IHy2y9iaLxkdj2I
	hNsmnyc2caKHwyvaauJ+RDHLBkEOoAAC9RENSUUpoyLaCEpja5BLVB4fj1OIr8pyKAV/NfbMPzM
	9KnooczQWMdtpr5N9JrbU3F5HaVkSFDm3J2txB/0qZVErfAcnxJC515m8AaMr133fRNbpNPfemH
	af+k8q7snN58iOAO5KNQ1YuBuvw5ZpeZ1dM6RfsfA22Uh5YnKnAKxp9Eu55N29EJsGtqj0cemGK
	tQVFu721SdALsqo
X-Received: by 2002:a05:701b:4243:20b0:13f:c85d:17bb with SMTP id a92af1059eb24-14503f8500dmr4207164c88.1.1790321032704;
        Fri, 25 Sep 2026 00:23:52 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb6b9sm3656437c88.1.2026.09.25.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 00:23:52 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtc: ma35d1: fix unchecked IRQ error and IRQ-before-rtcdev ordering
Date: Fri, 25 Sep 2026 14:23:45 +0700
Message-Id: <20260925072345.2632042-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_get_irq()'s return goes straight into devm_request_irq()'s
unsigned int param unchecked -- a negative -EPROBE_DEFER becomes a
huge positive number, so probe fails outright instead of deferring.

The IRQ is also requested before rtc->rtcdev is allocated. devm
teardown is LIFO, so unbind or a later probe failure frees rtcdev
before the IRQ, and an alarm firing in that window has
ma35d1_rtc_interrupt() touch freed memory.

Check irq_num for a negative return, and move the IRQ request to
right after devm_rtc_allocate_device() (its irqwork is already
initialized there) and before devm_rtc_register_device(), so unbind
unregisters the device before the IRQ is freed, not after.

Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260918161925.2639130-1-congnt264@gmail.com
Assisted-by: LLM
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
Changes in v2:
- Sashiko found 2 issues on v1: dev_err_probe() on the irq_num check
  duplicated platform_get_irq()'s own internal error log, dropped;
  and requesting the IRQ right before devm_rtc_register_device() still
  left a window on unbind where the device is unregistered from
  userspace after the IRQ is already freed. Moved the request earlier,
  right after devm_rtc_allocate_device() (its irqwork is already
  initialized there), so unbind unregisters the device before freeing
  the IRQ, not after.

 drivers/rtc/rtc-ma35d1.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
index cfcfc28060f6..ae68e5c89e15 100644
--- a/drivers/rtc/rtc-ma35d1.c
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -236,11 +236,8 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->irq_num = platform_get_irq(pdev, 0);
-
-	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
-			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
+	if (rtc->irq_num < 0)
+		return rtc->irq_num;
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -254,6 +251,11 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
 
+	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
+			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
+
 	ret = devm_rtc_register_device(rtc->rtcdev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register rtc device\n");
-- 
2.25.1

