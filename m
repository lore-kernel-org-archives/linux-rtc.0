Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761684766A5
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477341; cv=none; b=bLMWLfhjBG9PEDjWYaUjCaHESJsqlsuuHYwhNZ6OScxJEucoWK16RXlzQUZW+jSltUTJN/xGoobB97r7bPTy3tshQs5gNT8dwlji8rQOX5wd70o9OmPbn654FcR57RQgadGvQt9rtR7MxXhBWf7vCuCrHlAuPp2qQKSAsOk8kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477341; c=relaxed/simple;
	bh=9jLxGPmQdjY7gophUedDuJ2AuFWVcIwvtw1u92qrHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOdoPgEaLC7iaEEttqpWIu0M6/AhIrzQYDWs0JMEb1lOR6xsljYVefAF5V6ujqcEnj4bAAhXkfJ1tcJwERLMYRSHy+yQKFGW2k7FRvmA02vcnuoV002NwxXFNxL4jjKnkTbZxCJNgEqv2JBYMZwdipLnOO95063DPLOvfO3vK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPdzFfGd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPdzFfGd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495635a85d2so678595e9.0
        for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477336; x=1787082136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QD+8mdn/ihWEyfoj8EZu5dauxKHrsP3QtiGEL9IzKhM=;
        b=dPdzFfGdprY3Wp1x6P/E7SU5UPRnWIvagalniuNyq2IWoRYtQSKekajzB0oT1OcGwl
         2YAP3cXFbe1LMOBYpRqN1pVvR4T3nktX3f1OTVkLVMV4TiqmyDcnd14XuXJQvIkxxRuf
         vPoC/kizprfyCxQnHbrOpHr+0RYeTBCb6DtGWruCCAz67YTjbqH7lWYOMr+E5p4bf7Tb
         MhLg1MsLGXZOOvWzRHNCTxmiNI4cNo/mnAi730gOoAqrFEZTF6LE5GkTDTKb0uN+N26z
         2xVWTsl19gwdzaRV403SP4nyS0D/6ey3IeggIib96ycRi5LiI5QJo2LByM1Yx/jVXuq5
         phIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477336; x=1787082136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QD+8mdn/ihWEyfoj8EZu5dauxKHrsP3QtiGEL9IzKhM=;
        b=stQMq5ondyJmXosEpDXG1mD1tnADGM1rH32oH6bhXryj76nNHEoYhtRzhfgnCTcu13
         f8sj3ieJfv54IebEm2IFaLm5cEr9StY/RuCdYaN5pg8ErriQ9ESzISYLEFtp7OjBCvYn
         HdvgJ+VEmE6y+ogFK1e+2Kb4Z3RyfUvyfckYI3ZZFYPePgznZJTnA+yIi2AbKrtvCTS9
         bfgPTRHNMc8g1vZ3B8qiey/FQ/qkGcoDAwymjNqkhZFN6GEffqu+D5JwuuZNAV75ahaT
         3+Vr//p8jQ9fQYFImr7JXRxtOJ6iAnvHa/m9qvWZYzx+5qLms+D7QudETDhBa1RLHqdY
         jiRA==
X-Gm-Message-State: AOJu0YxJAmO7kJrhkDKmvX2oIoNSg0i4CO6a+Lj5Ji7gcS6fpEHZMAcG
	sBCTEzqQkJQ6WWIOk5890pwynyJip+JboiKhc0ZJoXX3/3KhO49np3kt
X-Gm-Gg: AR+sD129KU4+uIZWkQSFSqIDqAoqAbeYVpEIHUhUAwdcP8r/j4sVK04kz4w0Ew2Zj10
	WyKQ2TOnGjOrXbexARC6gQYLsPieMlXvbLi2AdrGVwoJqCq0WG0rChL/yVvui/XPtc9/rRm5Vy7
	xTwdOobFWpfQJ45M5+TgzpIJ3MN5O8YlBD/+7tIGXZCH3iel0ZUl9Nmna1ACOi4T1JFm8IF20pH
	yxUyj++j4Q2kGBSU52C7z48HUBO5L2YsTmpNnMvTUBbdVbGbw5dbroO/OHTu/UP7QmHhg3EvJyc
	Cwb0cJFkDQURYtpKCNdLCZYFM5VQReeAVUGB4vpKrgZIlFxIl+oPoWEHkYya/V1ILE6cKCcrtOu
	x3m8qs9xfphNTEJz+G00kIOM59Wwdkitt+DZ7TNBusbbmAfkG+jWcNG5m46Q+c1ohON1iJiopvy
	8fPvHMh5vOO8xPZx+OnJqIRwEsOhK/IJIgMQqsBYAIHhjjm8ZHo9hUplmUMz1nFB6z
X-Received: by 2002:a05:600c:46ca:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4997a65397amr28604315e9.11.1786477336477;
        Tue, 11 Aug 2026 12:42:16 -0700 (PDT)
Received: from antoniarch ([78.213.143.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b22784fsm2606535e9.2.2026.08.11.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:16 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v5 0/9] rtc: abx80x: add support for abx81x
Date: Tue, 11 Aug 2026 21:40:25 +0200
Message-ID: <20260811194034.28937-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patch series adds support for the ABX81X RTCs, which are essentially
SPI versions of the ABX80X RTCs. The first patches (P2-P4) contain bug fixes 
(added after sashiko's review in v1-v3), then (P5-P8) we have some cleanup and
reorganization changes (converting the driver to use the regmap API was
needed for this), followed by the actual ABX81X support.

The v5 is identical as v4, I send it like this because sashiko failed to
apply the patch series for some reason:
https://sashiko.dev/#/patchset/20260810193826.210683-1-apokusinski01%40gmail.com
I have no idea why it happened, the patches apply cleanly on v7.2-rc1,
sashiko's report is not helpful unfortunately.

Kind regards,
Antoni Pokusinski

---
Changes since v4:
  None
Changes since v3:
* PATCH 2 ("rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()")
  New patch
* PATCH 3 ("rtc: abx80x: add mutex protection for register writes")
  Replaced "guard()" with "scoped_guard()" in "abx80x_ioctl()"
* PATCH 4 ("rtc: abx80x: properly handle shared IRQs")
  Disable all the unused interrupts in "probe()"
* PATCH 6 ("rtc: abx80x: use regmap instead of I2C specific API")
  Changed the type of "flag" arguments in "regmap_read()" from "int" to "unsigned int"
---
Changes since v2:
* dropped patch "rtc: abx80x: move part autodetection before RV1805 configuration"
* PATCH 2 ("rtc: abx80x: add mutex protection for register writes")
  New patch
* PATCH 5 ("rtc: abx80x: use regmap instead of I2C specific API")
  - return PTR_ERR(regmap) on I2C regmap init error
* PATCH 8 ("rtc: abx80x: add support for ABX81X")
  - return PTR_ERR(regmap) on SPI regmap init error
---
Changes since v1:
* PATCH 1 ("dt-bindings: rtc: abx80x: document ABX81X RTCs")
  - added missing "spi-peripherals-props" reference
  - added abx815 compatible strings to the trickle charger enum list
* PATCH 2 ("rtc: abx80x: move part autodetection before RV1805 configuration")
  New patch
* PATCH 3 ("rtc: abx80x: properly handle shared IRQs")
  New patch
* PATCH 5 ("rtc: abx80x: use regmap instead of I2C specific API")
  - changed regmap_read() argument types from `int` to `unsigned int`
---

Antoni Pokusinski (9):
  dt-bindings: rtc: abx80x: document ABX81X RTCs
  rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
  rtc: abx80x: add mutex protection for register writes
  rtc: abx80x: properly handle shared IRQs
  rtc: abx80x: add irq to struct abx80x_priv
  rtc: abx80x: use regmap instead of I2C specific API
  rtc: abx80x: replace read-modify-write pattern with regmap helpers
  rtc: abx80x: create abx80x_i2c_probe()
  rtc: abx80x: add support for ABX81X

 .../bindings/rtc/abracon,abx80x.yaml          |  18 +-
 drivers/rtc/Kconfig                           |  25 +-
 drivers/rtc/rtc-abx80x.c                      | 663 +++++++++++-------
 3 files changed, 451 insertions(+), 255 deletions(-)

-- 
2.55.0

