Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED3381E88;
	Tue, 25 Aug 2026 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642378; cv=none; b=n4IyT4sW5HF6ZEANbMceDuZXkE1SFGsui+3fyWkwhFQ3efBZkU7YcljQQSJWZXkGKkYFhP+5X/ZEKfEsVrWFNwW9Ic6cno+kSDG+EJhyX5lpMs8I9JXj6ALl6HCfxP6zXsuGnWw6g9cjf0iJjJFPpFIU3+m/rL400gD/wgt3je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642378; c=relaxed/simple;
	bh=dlC/Ek5EP/2kZcYmlKPUIlAhRIuJKkz4m41PgrxDrs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCXS76MtZmN8H1CHoLDsKUcY3gtDX77DgR881MhvPmVoR2r+Zc796C354gEskO1SyZ7ebTPmR6Xy3COukHQC0ox5GfB5Prefx3DVrFN+4FSYkxU+J8tFMU16cIEcOX7ZC1EBMr9ISyAPVnaEdZ5EUoihFhhqHN2gReciIETAgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Q3kPndtb; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Q3kPndtb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50A8A11CBFD;
	Tue, 25 Aug 2026 09:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787642369; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=2CbjXARxxC+IvwNS/3iRUtHjs69OcKoxnN9624Q/9t4=;
	b=Q3kPndtbqfQl3CTJuFaNlYFIk4cwfgmj7rpNRxsmXGnDrIy9ezdk9rEqrGePk0ZgB36jvI
	mtWIioxwY7pzM4G12IQxdyGPGTH268AWS4rzHhDuR6imgiALE3MFc7GeagMgOItQDLr7wv
	2r+XZ1ld38YaCF4B2s69fETqgT9FOPxqBnyW7DhaL97PNAsFrqwLk/ZcStm32fPJcn+3x9
	9OZ2SUqGaluqdNyPFRqm5SieLeCo7DUgPJe3eZNb1Ytum1q15dw/glu25qwojmq7YOIRSM
	78XK5o1CjFVEiDAJ2VbGa7CMJ3mJvDIUKw0rAijs7K/ocUo66W20Zifl0QLCJg==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-rtc@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v2 0/3] rtc: rs5c372: add Ricoh R2223x support
Date: Tue, 25 Aug 2026 09:19:15 +0200
Message-ID: <20260825071927.4090460-1-hs@nabladev.com>
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
driver, and patch 3 implements the eco-mode setting.

v2 answers the sashiko review of v1 and a local run of the same review
prompts. This resulted in 2 changes:

Patch 2 now handles the new type in rs5c372_ioctl(), where RTC_VL_READ
read CTRL2 bit 4 as XSTP although the R2x2x parts have PON there and
RTC_VL_CLR did nothing at all, and in the two offset helpers, where the
R2223x fell back to the coarse trim resolution.

Patch 3 now applies the device tree setting in both directions. V1 only
set the eco bit before, so a board that dropped the property kept running
in eco mode, because CTRL2 is backed by the backup supply.

Not touched sashiko reviews (some from local run):

- #clock-cells stays out of the required list. Requiring it would
  reject every node that does not use the clock output; the other
  discrete I2C RTC bindings with a clock output keep it optional too.
  Also the clock output can be disabled per hardware pin CLKC. So
  #clock-cells is optional.

  https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=1

- additionalProperties: false together with $ref: rtc.yaml# means the
  properties from rtc.yaml are not allowed here unless they are listed.
  Only start-year is, the others can be added once a board needs them.
  microcrystal,rv3032.yaml is built the same way.

- ricoh,eco-mode is a vendor boolean. Whether the RTC may run in eco
  mode depends on the backup cell the board is fitted with, so it
  describes the board and not a runtime policy.

Changes in v2:
- Added Reviewed-by from Conor, no code change in patch 1
- Fixed the sashiko review of v1: handle the new type in
  rs5c372_ioctl(), rs5c372_read_offset() and rs5c372_set_offset()
  https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=2
- Added sashiko review for patch 3 in this patch, as it fits better here
  https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=3
- Fixed results of a local run of the sashiko review prompts: apply the
  device tree setting in both directions. v1 only set the eco bit, so
  the mode stayed on when a board dropped the property.
- Leave rs5c372_probe() through goto exit like its other error paths,
  instead of returning directly.

Heiko Schocher (3):
  dt-bindings: rtc: add ricoh,r2223x binding
  rtc: rs5c372: add support for Ricoh R2223x
  rtc: rs5c372: support eco mode on R2223x

 .../devicetree/bindings/rtc/ricoh,r2223x.yaml | 58 +++++++++++++++++++
 drivers/rtc/rtc-rs5c372.c                     | 52 ++++++++++++++++-
 2 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml

---
base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6

-- 
2.55.0

