Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC13D5C31
	for <linux-rtc@vger.kernel.org>; Fri,  9 Oct 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581048; cv=none; b=G+hOS6Rhf2W+G01UfmM/hNYgA3MBoLEFMFX8xQVMc23jbkggDdUPZed9CKhuqz4945PnhX1tNYjWP4KqVQTXRMVWvfombrHfexyoNYX6Sd66JMuQe/pBoWvG5uIeaCAVqgHvJk+IF7nP9UBgKVe7nS1RFkh+p5h18+rviy9owGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581048; c=relaxed/simple;
	bh=V+WcjE84F9DEyLX+ydzFWzzz7j2O1j5XOdxYSwS4IAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYHezsYIdCHPpsuU9zLnVC8rrngmEmgN4UDDT7yQVgmbzC++RgqbiT3Hsjbr5ouOORk5OLI/nb6BRnu+IdKeAfcM4exhuo+BA67uYNRivi/aVbZwlz2j2NwO+LFziqvLaqotxScjfig0c4ZXznei7rLQkMquBgrE7FosustVW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=szuW3fR5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="szuW3fR5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 190E64E411B7;
	Fri,  9 Oct 2026 21:24:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A35F360754;
	Fri,  9 Oct 2026 21:24:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A0F411D70BDC;
	Fri,  9 Oct 2026 23:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791581038; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PBSnCLWmvp9UMzVMQQAPa0zEQYkleCTI/JN2+z+kCSo=;
	b=szuW3fR5HF6jwAewlf6TqfoJnVMsL2YBctQX6y3tGQ+5yRFdiDiAEsSpgGHbz9p8kQjx+y
	NB4GEM8/nbEa1c0pTP4RDwQPgwEsO5kgpHE/8jS4pTFPIQxkeFOuOAdiBjBdPX6pbetCQO
	Bhg0TJ+hbfv8HhvdXWMcMctwgWg5TOM5f0Cyw8snzAm3HnMy17R0Y4XU1TKtQIZMMl2Y2Y
	pksfZsHaEpfTkP6Z722qs/HGMJ09uccmOgaX439E5s/pn+1D4Q6ISOWpTjAAQeyP2uLDbP
	kkJ5DQoEJo01eHhHoIqXK+KyzBcp+KstePyAickVBHTWCn/653bU1q6zhBYZkg==
From: alexandre.belloni@bootlin.com
To: Shubhi Garg <shgarg@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-tegra@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: nvidia-vrs10: remove locking in IRQ handler
Date: Fri,  9 Oct 2026 23:23:47 +0200
Message-ID: <20261009212347.490403-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Remove locking in the interrupt handler as it is not necessary to be locked
while calling rtc_update_irq().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-nvidia-vrs10.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-nvidia-vrs10.c b/drivers/rtc/rtc-nvidia-vrs10.c
index b15796698558..caac63f4e0fc 100644
--- a/drivers/rtc/rtc-nvidia-vrs10.c
+++ b/drivers/rtc/rtc-nvidia-vrs10.c
@@ -358,11 +358,8 @@ static irqreturn_t nvvrs_rtc_irq_handler(int irq, void *data)
 	if (ret < 0)
 		return IRQ_NONE;
 
-	if (ret & NVVRS_INT_SRC1_RTC_MASK) {
-		rtc_lock(info->rtc);
+	if (ret & NVVRS_INT_SRC1_RTC_MASK)
 		rtc_update_irq(info->rtc, 1, RTC_IRQF | RTC_AF);
-		rtc_unlock(info->rtc);
-	}
 
 	/* Clear all interrupts */
 	if (nvvrs_pseq_irq_clear(info) < 0)
-- 
2.55.0

