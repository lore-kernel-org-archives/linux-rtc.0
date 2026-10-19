Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444767;
	b=JOQDlSv10vQKr3XOB5aoB5GgZKltvzcNuAezX5SzYVVSiFHUga5ZHTKu3S1Aht2SfTmo
	 EaMZxt7HWBZao965G3C5y0G8fAEnyMAEckEb8OozbX/wukAV+rJKAgNGftrv55t/toN3G
	 zELeqK7bQm4dvqVgFiImNA1YW9YYo8wfXcrOKEcOXUt1sn4JLyGepttixjMfXN+zazddD
	 kWpy4FfWOZE0wWMcJTxiGSr/k5n7yBmbWHtfGGoIQFfg+Bjr3Fo20Ik6DMkEScyGydk05
	 gSCC3vyw0bwi7D/Hy5jL2lRqFfoI1iC+RHT8FeLpx50UNO35AECaeGMqRvpV/XtiY4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444767;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=wNAq+21OcUbQpHXlhfVLWXEOjHxIoNjX4RhgZZq2i2Y=;
	b=jbJZHIExfZuuH8TD9QY1S6zgeQEHTtu9WR5Ta47mGCLE1eNDVDitFyYGvWBrr05s2Meg
	 26t/1CNN38bUW70Eh5qIw+PKaIKsBqIXNA8GjNsaajQdtR/c08hmkuO+lxQvrJ/pAiBmi
	 XdKcrNboRxlOjsuTIdQPgFeMbPfpblouJ2rEBmN4QH5buR8W5SLzcE/0QKt8T6dGCSC/t
	 nae/ubvqEwDxirWhwNisr7tcE3/mIMLTX4iVbIh8w9WuX+ppoJU/Bx+C8+KmhO0KrvFCV
	 SE4Dmb+0k3QNC3BMhcSwCOL4qhk9sv4TK/UIryR5H5cnVtxm9zsp23g/1WrtzR9KahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bvY03MSE;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0551B606A320
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0551B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bvY03MSE
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B547B4E4127B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:19:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 831C760582;
	Mon, 19 Oct 2026 21:19:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B306D10328C22;
	Mon, 19 Oct 2026 23:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444761; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wNAq+21OcUbQpHXlhfVLWXEOjHxIoNjX4RhgZZq2i2Y=;
	b=bvY03MSE6zkQ6mkkhRgn7HgR2Ab/wI65yq63M0dcdqVUG7fpgFcITckfrC59QFlqwuKiyZ
	O8C+Z/m9Q0FmQ7InB6vVR0YI0YKrJebzfpMDxHXTaGiLqt4VPpnUNgCDSx5DN0FQVSLgfe
	naubrtw2qI/unOhK2WqwYPYQAoVo9gJVEh6hcA0Zz4qNjPQCGaGWemm3LM5LF6mWtNbjjf
	diJGYalT/w+MiXApPILzMVeNqYBYHjsbN9t/Sb9t+aM4PJbLyoTuL9PsykraMsNZK3FyKR
	uTFi9eT54RAd5Vynxt6RNvTqQv3Mz39zbQKTHsS9iGFNpuK5qc/kOVcwMrVGMw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] rtc: ds3232: use guard
Date: Mon, 19 Oct 2026 23:18:10 +0200
Message-ID: <20261019211827.126262-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Use guard() to simplify error handling

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds3232.c | 50 ++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index d1ef9e0dad34..f6407c631d6d 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -389,45 +389,39 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 	int ret;
 	int stat, control;
 
-	rtc_lock(ds3232->rtc);
+	guard(rtc_ops)(ds3232->rtc);
 
 	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
 	if (ret)
-		goto unlock;
+		return IRQ_HANDLED;
 
 	if (stat & DS3232_REG_SR_A1F) {
 		ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
 		if (ret) {
 			dev_warn(ds3232->dev,
 				 "Read Control Register error %d\n", ret);
-		} else {
-			/* disable alarm1 interrupt */
-			control &= ~(DS3232_REG_CR_A1IE);
-			ret = regmap_write(ds3232->regmap, DS3232_REG_CR,
-					   control);
-			if (ret) {
-				dev_warn(ds3232->dev,
-					 "Write Control Register error %d\n",
-					 ret);
-				goto unlock;
-			}
-
-			/* clear the alarm pend flag */
-			stat &= ~DS3232_REG_SR_A1F;
-			ret = regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
-			if (ret) {
-				dev_warn(ds3232->dev,
-					 "Write Status Register error %d\n",
-					 ret);
-				goto unlock;
-			}
-
-			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
+			return IRQ_HANDLED;
+		}
+		/* disable alarm1 interrupt */
+		control &= ~(DS3232_REG_CR_A1IE);
+		ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
+		if (ret) {
+			dev_warn(ds3232->dev,
+				 "Write Control Register error %d\n", ret);
+			return IRQ_HANDLED;
 		}
-	}
 
-unlock:
-	rtc_unlock(ds3232->rtc);
+		/* clear the alarm pend flag */
+		stat &= ~DS3232_REG_SR_A1F;
+		ret = regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
+		if (ret) {
+			dev_warn(ds3232->dev,
+				 "Write Status Register error %d\n", ret);
+			return IRQ_HANDLED;
+		}
+
+		rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.56.0

