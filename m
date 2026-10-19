Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444777;
	b=K48Fmv7VLZfD44Za11InImbWDVut13Fxl08FSQHay0+pmkeCwaUC9vR2e7ctILqHzU3v
	 InO80GDmoh45cF/SuDAl+hrnzt09dZAxBbOFpGEPqLqdwJln+6pQ33kTNP+aW5F2Zj4pa
	 /z6Ac6JphMWoqa9bJw5i0doU3LT/8v+w8KsVjY1YWolMGME9BtwiUy8NZ6ApbZkvERmYw
	 E7ixgTZdiMoW1iTM/BJshVXtVrtG6F5j7EiV1uCPnpKtq1jpYf8J14YVMSFNhMJCwnISP
	 F/svb/i+H2MMwDMnbIQuhamtRXuYC8BB2s1KkiVDFYCct0Z4yKCTkIWxd5ox1u31jXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444777;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=aryosNOMiAB/e0Cj/QtW/CHFdWkG3IJ12osJNSzCuS0=;
	b=OkRE3sT/y6+I14do1NTZIF0Y4uCnYAtVjCL1UfrWCf7I22Ye3kbMR0aQ+4LZBlJsdLb5
	 ZFGP7R1d1GXyehGHMzigU0DczkW3SFuIKOTpgDi/BJNLOvONEGqmCSMIPOgEDY9DBaGlw
	 teB5UV6+D27/vbh+3XePyjeMc4FDcNECK+Mvvv4TUE4KiE+aFdrHn6IMTrt3jjxW99iN0
	 kqtsAaSLShimhCMbwVdD/U5vEH7oN3x4fV/d5cOZX3lu3h1EAyo+R9gYdWjdbg9a2OtAt
	 bV7HLigitgGcYeDgZanrIxUufp9KFSYHjrP8nFI6kfakGTKlQR1fSfkQoweHrG36SMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EMXswMYF;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028C606A31E;
	Mon, 19 Oct 2026 21:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4028C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EMXswMYF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E08201A1246;
	Mon, 19 Oct 2026 21:19:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B4EB560582;
	Mon, 19 Oct 2026 21:19:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E237910328C52;
	Mon, 19 Oct 2026 23:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444771; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aryosNOMiAB/e0Cj/QtW/CHFdWkG3IJ12osJNSzCuS0=;
	b=EMXswMYFWs2itqL5CwcP7CXUFjIH6lk274gruBgqP9aPqSkXbpt1TNFczeVIAAJEmH6rMA
	z0xEC/jF2yHXY0bW8/yB3JRRU8LYia0yrbG1iazyz9w1G/K1uENqwAhyhuMiHptUZKAf5p
	Y+lBLAiKtfzpC0SGeRLQU3MZpL+e19nptWQ8kClVuTkUhA7ZZpMmaHo6tGPX6Lxxf60zh8
	QaMzj80QWdmnVrwcW7fYRKCOMUdl30gK2xDTFdETK1QjHlH9EV/ejPs3dZayASCN7Ad2td
	P0AeazDwGPpHnDm96BFOUSqkv8dKEohdvH6V7DVC3Dp3I89slh8aM4XRNcmMmQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] rtc: m41t80: use guard
Date: Mon, 19 Oct 2026 23:18:12 +0200
Message-ID: <20261019211827.126262-11-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-m41t80.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index ec86ca3f2c4c..1385cb43864b 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -162,19 +162,15 @@ static irqreturn_t m41t80_handle_irq(int irq, void *dev_id)
 	unsigned long events = 0;
 	int flags, flags_afe;
 
-	rtc_lock(m41t80->rtc);
+	guard(rtc_ops)(m41t80->rtc);
 
 	flags_afe = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
-	if (flags_afe < 0) {
-		rtc_unlock(m41t80->rtc);
+	if (flags_afe < 0)
 		return IRQ_NONE;
-	}
 
 	flags = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
-	if (flags <= 0) {
-		rtc_unlock(m41t80->rtc);
+	if (flags <= 0)
 		return IRQ_NONE;
-	}
 
 	if (flags & M41T80_FLAGS_AF) {
 		flags &= ~M41T80_FLAGS_AF;
@@ -189,8 +185,6 @@ static irqreturn_t m41t80_handle_irq(int irq, void *dev_id)
 					  flags_afe);
 	}
 
-	rtc_unlock(m41t80->rtc);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

