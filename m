Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876649D59C
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671564; cv=none; b=I/DYG6Hcml1moCYjvH0PzYwVJkjXy5AvYS6tgUpkuJxRo7lq+HN/i7esM6rHQ3gLoPLrxhTDkNwQyz5cuQEvDi45GfIiyeUGnTvTtCb2Ybm39N7O5U/N7GE1abjGLlkwCE1kxhDou0bN2m6MvsDpMJJtM2G8VrbWusAVVxdzlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671564; c=relaxed/simple;
	bh=u8kouydruPHCgSUHMEw9uc1s122IWPg6r9U9ZRV+K8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2sB49nDmg2Mbqwz7XQQOP587rULyPoqn3m4AdHp83mDtYOpNxVMLlFYjv/HqfixUWx0FxZs7F4CerKnFuZNxIgTabjyg0HFqzduSiMtdE7WYf1jBpawCtGTCTUmL8Feu+0faY5lk1ooC1R+nXwBtaeU/MZ5Ig1PdAMaQBcwlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aDM50SwT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aDM50SwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=ZquVgNnFWnWCeG
	+cjVkP/9mi81ZKnZ3GaAPTVii0NJk=; b=aDM50SwTODebvrClsyMMzFaJrSvgUu
	p7Y1/cHV6ABjYKFhElW+Z/M2cajBqGopS0V1S6ZcddhbTQsWJ1idfj/OIZYJkOzO
	o0uMXoM2YmmMjovspE65t5ECeDaFfkJlvow3MAXWWn3GCdWLwbR36nb+pC0IBLO+
	mSfPE89GLC3wf65QnVcQlT7q6m6SV2ymog2gXCSOpUV+BzePA7W/0y89BaCZvCTx
	e9naKpRaxY1dpLmqDuIpFxEIFusSvFTGpxmG/nWBlOTp1TRObXnXW3Agyhl31XTt
	RRzFTznXv0theXaHOUDj6luz03GWFFaVfdpD4da5Q+yVh6azCHi+aAFQ==
Received: (qmail 2157788 invoked from network); 17 Sep 2026 20:59:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 20:59:16 +0200
X-UD-Smtp-Session: l3s3148p1@KCBlYbJbDMAujnsL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rtc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 0/4] rtc: rzn1: cleanups, R-Car X5H enablement
Date: Thu, 17 Sep 2026 20:59:03 +0200
Message-ID: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds RTC support for the Renesas R-Car X5H SoC.

Changes since v3:
* clear RTC_FEATURE_UPDATE_INTERRUPT when no irqs
* added tags

Thanks for all the reviews of v3!

These patches have been tested on the original RZ/N1D board and the new
X5H Ironhide board. 'rtctest' passed on both SoCs. On X5H, some tests
are skipped, of course, because no alarms are supported.

'dt_binding_check' and 'dtbs_check' did not find any issues, for both,
RZ/N1D and R-Car X5H. I also verified for both that it rightfully
complains when irqs are different from what is expected.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/x5h/rtc-experimental

Looking forward to comments.


Wolfram Sang (4):
  dt-bindings: rtc: rzn1: drop unneeded 'start-year' from example
  dt-bindings: rtc: rzn1: add SoC names next to their IDs
  dt-bindings: rtc: rzn1: add R-Car X5H support
  rtc: rzn1: add R-Car X5H support

 .../bindings/rtc/renesas,rzn1-rtc.yaml        | 30 ++++++++---
 drivers/rtc/rtc-rzn1.c                        | 52 +++++++++++++------
 2 files changed, 57 insertions(+), 25 deletions(-)

-- 
2.53.0

