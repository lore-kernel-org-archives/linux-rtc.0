Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB903B9D99
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177163; cv=none; b=N1T1wCMVWob66LXZfmmoHv+BkP1Kz/L1sC7RL59qoZWYXZltRamuTTQHKoV94gEV4u8zStF+Uk0+rbno1HUmnyf3bDWdkJv+M2FhBKPJ/jPKeluIGNZ3gdsiY6gidHX43GnN9MOYVX0URAo52auTbuhE1AhKVu2ShqbIEIRHCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177163; c=relaxed/simple;
	bh=ANPqvCRGwc3kfpGV3566usZnTG0fF7b/v30Ov/cXTYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSRN0exPXFvPYk5MUl/16r//avdbHJEyuYA2NVWimjqahZPGjC3ZXaaI/rqmY9L8p1Z8QIe78kt3/+gRV25LR+40A9iGo84+Zzo5gShLxJ7LalBcfHCYORLC2Xd0aoFndMmTcu+2kFTiSZSZVd24dkTE/8U0E2jUzJQNwPMv0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Z7I2z3ee; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Z7I2z3ee"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4648424002D
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 00:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1787177157;
	bh=7qkqme4rz5RuKO+2sV66ykbV33lOIbDA2sred83QjpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=Z7I2z3ee07VDR4Z6L/yA0PqHpZcwLa2VsnAJLUm+8r98oH+xEsNw522ChUz6uXOPk
	 Dj/cTsQ0RPftrPAYn8r0ktYL6yIJra8LLkkFZkgBHYrT0ng+ltMkfQKyIfiECQcKD8
	 QlaYpMW3vshifLiU8ynGuVDOy/ODi6jvT4/0oMhoKne6DPW+0xb3MbVfn4d2Iq+zUj
	 sopNcvE+eQCKjzuo5xlH/eh+XJfM8KQREhpTYaNs2YGqSyj18RmYr5jKTs4EsS6Biq
	 DUWbLQ7tHWJrdOtimo6SRdFQXjZgKld4GSPDA1SQesZ+Yemgy1knypMIy77eb9XNH/
	 az/VQOFwTymaQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hQLHR48SMz9rxL;
	Thu, 20 Aug 2026 00:05:55 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 19 Aug 2026 22:05:56 +0000
Subject: [PATCH v5 4/6] rtc: s35390a: force 24-hour mode
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-rtc_s35390a_int1-v5-4-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
In-Reply-To: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4920;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ANPqvCRGwc3kfpGV3566usZnTG0fF7b/v30Ov/cXTYw=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqhii98Tb8rcTDsMiljgH87mfpa3y8zAyqeAFoY
 YQ1TsrsoImJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaoYovRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JOmw/7B+PtXu+rO1dortPSY7miqoP1+eAUWIg
 5z3Eke7tOMGIqR7Kc0A5wVF8Qqd+pHUt1YOTbyewxUqnzwGW/mCFFlp8x6FheEXIKbo3kpAsOh2
 yBWGuBR8V6EAq2AEviFLMG6OleSD1fS1jvhk04BLLrUnp5t86xZsk+2H2QPG5BRs881UU4PKGWD
 D2rsqBizUqSpx1dckb2OPI62cRAL59K+DSYcpcZRlHWfepioFFyhzyDV6a8oDW+kZNTJ2KAWBRd
 PMj+oxAIsHbUzFTrIYyG2gT6HuZmD/0eXRk7v5ZnCSwOnB3Hwo9GBhMfrVFUfK4lelzD3rmv/1O
 5g30xZByjFQFERDcTNMvRhO86+ypAIPatby3hsZVuc4XqpjFbA8wIfSHrTWjsOa1IPJQSeZobsl
 ijc/bqA4bkAI2QkhGxbmZQic9Lm6yp8yyROt7soGVnYF2dZTTOWKqqui3VenVF8o3kj566W/8ss
 gHUf4ulY9WA6qb2WVGicGUgeDA2gbVX9OclReWV7NIQB9laAvkubKJjou3f/GPi8oDVATc9Wfyu
 /AoKauEujQb+vgO57PH7PffKtFxeH6qnWJUuSnkIwF+KXZ1oMx88RrjExXugiKmviQllE72QBZX
 ZFAtcoObPcfKIXPxXQ61DVbtiIGkh9mzZVbEQGQJCSl5Q6IwXEd0=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Instead of trying to remember the current 12/24-hour mode, which could
result in time corruption if out of sync, we force the use of the 24-hour
mode. Set to 24-hour mode if in 12-hour mode on startup and assume
24-hour mode. The 24-hour mode is already forced on reset.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/rtc-s35390a.c | 67 +++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 575bb256eb25..b34a3f7e8476 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
-	int twentyfourhour;
 };
 
 static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
@@ -181,31 +180,6 @@ static int s35390a_disable_test_mode(struct s35390a *s35390a)
 	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf));
 }
 
-static char s35390a_hr2reg(struct s35390a *s35390a, int hour)
-{
-	if (s35390a->twentyfourhour)
-		return bin2bcd(hour);
-
-	if (hour < 12)
-		return bin2bcd(hour);
-
-	return 0x40 | bin2bcd(hour - 12);
-}
-
-static int s35390a_reg2hr(struct s35390a *s35390a, char reg)
-{
-	unsigned hour;
-
-	if (s35390a->twentyfourhour)
-		return bcd2bin(reg & 0x3f);
-
-	hour = bcd2bin(reg & 0x3f);
-	if (reg & 0x40)
-		hour += 12;
-
-	return hour;
-}
-
 static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -225,7 +199,7 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[S35390A_BYTE_MONTH] = bin2bcd(tm->tm_mon + 1);
 	buf[S35390A_BYTE_DAY] = bin2bcd(tm->tm_mday);
 	buf[S35390A_BYTE_WDAY] = bin2bcd(tm->tm_wday);
-	buf[S35390A_BYTE_HOURS] = s35390a_hr2reg(s35390a, tm->tm_hour);
+	buf[S35390A_BYTE_HOURS] = bin2bcd(tm->tm_hour);
 	buf[S35390A_BYTE_MINS] = bin2bcd(tm->tm_min);
 	buf[S35390A_BYTE_SECS] = bin2bcd(tm->tm_sec);
 
@@ -256,7 +230,7 @@ static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	tm->tm_sec = bcd2bin(buf[S35390A_BYTE_SECS]);
 	tm->tm_min = bcd2bin(buf[S35390A_BYTE_MINS]);
-	tm->tm_hour = s35390a_reg2hr(s35390a, buf[S35390A_BYTE_HOURS]);
+	tm->tm_hour = bcd2bin(buf[S35390A_BYTE_HOURS] & 0x3f);
 	tm->tm_wday = bcd2bin(buf[S35390A_BYTE_WDAY]);
 	tm->tm_mday = bcd2bin(buf[S35390A_BYTE_DAY]);
 	tm->tm_mon = bcd2bin(buf[S35390A_BYTE_MONTH]) - 1;
@@ -325,8 +299,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	else
 		buf[S35390A_ALRM_BYTE_WDAY] = 0;
 
-	buf[S35390A_ALRM_BYTE_HOURS] = s35390a_hr2reg(s35390a,
-			alm->time.tm_hour) | 0x80;
+	buf[S35390A_ALRM_BYTE_HOURS] = bin2bcd(alm->time.tm_hour) | 0x80;
 	buf[S35390A_ALRM_BYTE_MINS] = bin2bcd(alm->time.tm_min) | 0x80;
 
 	if (alm->time.tm_hour >= 12)
@@ -381,8 +354,7 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	if (buf[S35390A_ALRM_BYTE_HOURS] & 0x80)
 		alm->time.tm_hour =
-			s35390a_reg2hr(s35390a,
-				       buf[S35390A_ALRM_BYTE_HOURS] & ~0x80);
+			bcd2bin(buf[S35390A_ALRM_BYTE_HOURS] & 0x3f);
 
 	if (buf[S35390A_ALRM_BYTE_MINS] & 0x80)
 		alm->time.tm_min = bcd2bin(buf[S35390A_ALRM_BYTE_MINS] & ~0x80);
@@ -459,7 +431,7 @@ static int s35390a_probe(struct i2c_client *client)
 	unsigned int i;
 	struct s35390a *s35390a;
 	struct rtc_device *rtc;
-	u8 buf, status1;
+	u8 buf, status1, time[7];
 	struct device *dev = &client->dev;
 	struct nvmem_config nvmem_cfg = {
 		.name = "s35390a_nvram",
@@ -503,10 +475,31 @@ static int s35390a_probe(struct i2c_client *client)
 		return err_read;
 	}
 
-	if (status1 & S35390A_FLAG_24H)
-		s35390a->twentyfourhour = 1;
-	else
-		s35390a->twentyfourhour = 0;
+	if (!(status1 & S35390A_FLAG_24H) && err_read != 1) {
+		unsigned int hour;
+
+		status1 |= S35390A_FLAG_24H;
+
+		err = s35390a_get_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(time));
+		if (err < 0)
+			return dev_err_probe(dev, err, "reading 12-hour time failed\n");
+
+		/* converting to 24-hour time */
+		time[S35390A_BYTE_HOURS] = bitrev8(time[S35390A_BYTE_HOURS]);
+		hour = bcd2bin(time[S35390A_BYTE_HOURS] & 0x3f);
+		if (time[S35390A_BYTE_HOURS] & 0x40)
+			hour += 12;
+
+		time[S35390A_BYTE_HOURS] = bitrev8(bin2bcd(hour));
+
+		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &status1, sizeof(status1));
+		if (err < 0)
+			return dev_err_probe(dev, err, "setting 24-hour mode failed\n");
+
+		err = s35390a_set_reg(s35390a, S35390A_CMD_TIME1, time, sizeof(time));
+		if (err < 0)
+			return dev_err_probe(dev, err, "setting 24-hour time failed\n");
+	}
 
 	if (status1 & S35390A_FLAG_INT2) {
 		/* disable alarm (and maybe test mode) */

-- 
2.54.0

