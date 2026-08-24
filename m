Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8E4078E9;
	Mon, 24 Aug 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569516; cv=none; b=pf7HiLDzSCHlWfKC0ANdtwRqYuFcGr2GiydmtWNpD+KjX4WcCaRLX0zd+NLocUTH17xtmn4bfmfCL4ZMgrC9mcfuAZXmvAK7F0AbUdL0fkPfl8s6TdkEzRoqCrlnkUzHl3h+Q0YPCFXKufyW8BE+ph3FDT5QyVp4rbR/H3uL6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569516; c=relaxed/simple;
	bh=AnsbDWQJ2lGb2eMDLJUjwRJCOUPu9mZnYfSXfQ3YjE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJXAXs0TMYe/HL83MUiLPu+eQvgJtq8mGQ2zUTIrIcCiheo7IfDAj0dKFNwOGOV7uxyNcsbvtkCWj6fRXP/S299QHFSI064RXx7iTpTkQyM1DuAOgb2nR7/1/SHIIxuqH3ZjwGTO1GHm01Ir2LZrL1NeKy42Z1S1f2lIWUhoSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=EiFaRAT3; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="EiFaRAT3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9223B11C1CB;
	Mon, 24 Aug 2026 13:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787569500; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KOC577lCkY4tA5KLq3piINHj5q+XrsdlflSJ4iY0XHc=;
	b=EiFaRAT3M0PXnvSDBBbT76rFe2XeHnRcI5Bk1CsiC8/YdWiolZn9w+uzaxq5mmqwJgqAvw
	J5sLTZHd77KUp0yy3kiGMAvWAfOEeJzGQ7eQ+ddgyJ6mp/FQxqxj2l5LB0k6L/0kDSMORW
	3tsWwmIu6izZjQNCg/Hf538ijJf+dCLIIoZMI8miU1HnWYMfNiUiAirFRimdeGOunTO1iY
	bLlYZgSQvSPogDT5WTtqVirXzeFQHII4w3N4jzp7cnSCBFErqLF+MrruXOvz5ICGYWcLwY
	tqjI+0ZCU8SnYBF0ngomvyVHNpPnzrfpRBJgAV2Jp0MUCSC/i/mOlOiQA+Bn+w==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v1 0/3] rtc: rs5c372: add Ricoh R2223x support
Date: Mon, 24 Aug 2026 13:04:23 +0200
Message-ID: <20260824110452.4038870-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Ricoh R2223x is an I2C RTC from the same family as the r2025sd and
r2221tl which the rtc-rs5c372 already supports. It shares the R2x2x
control register layout, so only the new type must be added to the driver.

The ricoh R2223x drives a clock output and offers an eco mode that
lowers its current consumption while running from the backup supply.

The trivial-rtc binding does not cover this, so give the device its
own binding in patch 1. Patch 2 adds the R2223x to the rs5c372 rtc
driver, and patch 3 implements the eco-mode enable setting.



Heiko Schocher (3):
  dt-bindings: rtc: add ricoh,r2223x binding
  rtc: rs5c372: add support for Ricoh R2223x
  rtc: rs5c372: support eco mode on R2223x

 .../devicetree/bindings/rtc/ricoh,r2223x.yaml | 58 +++++++++++++++++++
 drivers/rtc/rtc-rs5c372.c                     | 41 ++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml

---
base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6

-- 
2.55.0

