Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624858;
	b=2dDh8GSSGxxrYe4h1JK0pjrNZZcHOTVLDll7BFzPxb1cjh6FgQpscC5qs9dpH+zhak0K
	 kBI8eI+knhu4NXSHcVgbAz7ul4Eqsj9fJjFtZyTWFuTK0/tbN8+8a8Kx0h4fz1U5qpiKu
	 7y9iQjSWWqSnG5FBU0hIIycxrYHUb2BqCAOHY0/s0EpYrAQEF8EAQk+kG9mR41/OGSwbU
	 Wv0bh+VGAaYxhJelGHbLi/z0BjVMG60g6YLm9V3X+utulQVBGd89TcICib7hlzsZeAV4B
	 X5KpJnjl+3Ana47hh1ncieXyBPX6sfNudgyDZ02sg+G9adPsH8B6wr1UuH0YBvevBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624858;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Vjtbg0ZDAhw+N1qo63UozJWX21CxJvQ/AjeOgy46flo=;
	b=LIcdT1s1K8TX3DKiaUOPWHh5HARwsl7KyWutfr7cawSzk+hTZyfe+gNKN8tGZFAtarAw
	 d9oivw43gzLERB1rERi+jgwvDJWxYFGkuS25cTA8nbHuyCWtTWF3lhik2uAkTuV4Mc0kj
	 kbdEY5fMlQTD3QsD8YsYERwJpkfWuAFKrbzpBbNqY+EDAZR7Y3XaEijxp37KOXcZGi/Vs
	 akANDkfgdNblaEsT8e0IBdLhObH9aJ3tBxR6BZBLh0j0YXR2Vblatv1jiIiPTl1dJx3ki
	 8bSI3/bKBlBUCfzzClAUVo10riwKSss33Qs7PfRVCWOJJ650QyCO5qfHHGz4Ke5H5bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yHIlMa68;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111460A2601;
	Mon,  2 Nov 2026 13:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A111460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yHIlMa68
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 037561A1413;
	Mon,  2 Nov 2026 13:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5B2660750;
	Mon,  2 Nov 2026 13:07:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5793A103290E8;
	Mon,  2 Nov 2026 14:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793624855; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vjtbg0ZDAhw+N1qo63UozJWX21CxJvQ/AjeOgy46flo=;
	b=yHIlMa68boQ5jp8tGATQo8e1TT4D7y3agiH1fFAdEtIRi4BRkSqvMTAFdHrbsLjn+EIO6T
	+viHtie05x13KKEfNUiEhhtFs2Dy3l3V/U0HY/xXGmqnMKaCfwURBSoqOlzbIoXdSP2OCD
	kidDs28dXMxXh/ALGg1XsNRkovvoaDIrUAtirU47U0ZGJjMHoaIocd+ZnVgXNfS3AuWXet
	c+ImP2RV93qJL3Q1cn8RwZGg4RQq0sRPmbOVcvaCY81r4lzUOBaRBM/59ATExEQ1eplkkx
	T91LcN7A31SsTkixZQ2G4N2G6Ju7QQF/R3rTL9mMJQBl43bRkn4aYpv2/WssXQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 3/3] rtc: pcf2127: Disable the 100th counter for PCF2131
Date: Mon,  2 Nov 2026 14:07:11 +0100
Message-ID: <20261102130712.25104-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102130712.25104-1-herve.codina@bootlin.com>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
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

The PCF2131 has a 100th counter. This counter is enabled by default but
100th seconds values are not used in the RTC subsystem.

In order to save energy when the PCF2131 is powered by its battery,
disable this counter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 1bb84f72cf5f..d090e7d063c4 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -35,6 +35,7 @@
 #define PCF2127_REG_CTRL1		0x00
 #define PCF2127_BIT_CTRL1_POR_OVRD		BIT(3)
 #define PCF2127_BIT_CTRL1_TSF1			BIT(4)
+#define PCF2131_BIT_CTRL1_100TH_S_DIS		BIT(4) /* Replace PCF2127 TSF1 bit */
 #define PCF2127_BIT_CTRL1_STOP			BIT(5)
 /* Control register 2 */
 #define PCF2127_REG_CTRL2		0x01
@@ -1455,6 +1456,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		ret = devm_rtc_nvmem_register(pcf2127->rtc, &nvmem_cfg);
 	}
 
+	/*
+	 * PCF2131 has a 100th seconds counter enabled by default. 100th seconds
+	 * are not used.
+	 *
+	 * In order to save energy when the RTC is powered by its battery, fully
+	 * disable this counter.
+	 */
+	if (pcf2127->cfg->type == PCF2131) {
+		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+				      PCF2131_BIT_CTRL1_100TH_S_DIS);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * The "Power-On Reset Override" facility prevents the RTC to do a reset
 	 * after power on. For normal operation the PORO must be disabled.
-- 
2.56.0

