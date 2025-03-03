Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4F1D5ACE;
	Mon,  3 Mar 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041470; cv=none; b=aIwatEw+c+QNVhSzN/fF6iX7l6hW2zOzyDZ5etzO3ntRoovV4BAp1y3DwCpo7mbBIi/FFQcoDvqOhWId7wwpTq9yUUw7URsnzA6eYwesjBQEBo6FzDBONW1/uBdMB0UypG0+TlUeMIdEMYHV7IxiJGpbajJlEe+k+HhWoehRUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041470; c=relaxed/simple;
	bh=kRB2zkYf/MX3EH8+HXsfkfmDRcbPK3pSWmPbtHmjeUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Asxagw99Y0QjQ6yddRTuPRXsSsE/NJncuEFfMAT7HuHRYHkdEm1B/1ejashObqd432J7uOYtLUJslADuTgQJyfw8f9iHLWuITlqLhRunbOrfzoKDMwRTUWGZsFDdMtqbPXFeYp4BjkCS84/Bh+jeCaUnunJSo3+FKgA61yezOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YbX7LzZ4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YbX7LzZ4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5E58433D9;
	Mon,  3 Mar 2025 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741041467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/tDXSSQvSCEAhs2ZWN0tCKS6oFr/F21tFqfr3cV91Y=;
	b=YbX7LzZ4yiRWkqxC2PQ7QpJgJI3p79e6BwfmHqJxI/LRrpgxycVXSXZ/YRvewsWKswYoyy
	4nXk+tSPqyX9BFfbKZykvKqNTofWcuBnRxZtj5espDKwsXveBb58yeksZCTf4kj5elVMqq
	2inNqHY8Ww0ynScIH9zUzCUaLlkYf5MIjkXvnN1fVBfUhotonbichiCrJE/Sum6RTtng4H
	MUYoJ9DxUJqq6pUm9naaCIYGuh48IQ+EkZBPMuhxcpO2qogaInxK9GZVVdyuxvLRQ1OuoG
	b4ZHklFaNasV5YhoOZDm1hPwWSPZCLnVnecpiaIoRUeQom1C06ZimBo4Asp39Q==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ds1307: stop disabling alarms on probe
Date: Mon,  3 Mar 2025 23:37:44 +0100
Message-ID: <20250303223744.1135672-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -85
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmnecuggftrfgrthhtvghrnhepgedtffeugeeftedtfffhiedtjeefieeuveelffetledvueeludeggedtjefgveevnecukfhppeejjedrudehtddrvdegiedrvdduheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeejjedrudehtddrvdegiedrvdduhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhttgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

It is a bad practice to disable alarms on probe or remove as this will
prevent alarms across reboots.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 872e0b679be4..5efbe69bf5ca 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1807,10 +1807,8 @@ static int ds1307_probe(struct i2c_client *client)
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (want_irq || ds1307_can_wakeup_device) {
+		if (want_irq || ds1307_can_wakeup_device)
 			regs[0] |= DS1337_BIT_INTCN | chip->bbsqi_bit;
-			regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
-		}
 
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
-- 
2.48.1

