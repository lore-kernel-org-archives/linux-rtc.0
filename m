Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0659340281
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420737; cv=none; b=HvfC1YSym8cHUaf7NV6eYAzcpyg59M03a95t2TYi9dBSfT1Ivu1VxOfjl8JZHmpKvqBPAKtcBp9xTeT+FuOXSlgaI5ooi4GNdpIpdIV1fh6D2VHgVK/uf7s/Q780G0CV6v+E8DX2EhU3OgR6/bXr1AHOCgdiCJNk3ZBy1F/tB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420737; c=relaxed/simple;
	bh=Mm8MDkiPx9OLq7268TUMPOqdMkNS9z46rvGxalwmJqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ola/H8ERx4zjwML9j3tb7wq1A540j36ej8T2Re7bEu8swKsedS/ohHT3tttXYjZrfValMUonXDxn8oU6JV2Mt7MRIVvJLCxpjTfu22xnl7jrRkfy2ubGJdW5Pw2T5RGxeVICVrCLhE1aMWtj8wkkVdgvfxsx20PU60XYCRmI0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZMqM5M08; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZMqM5M08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Tdek9Fr7Sy2rqq
	Bf+S+jPMExvc/M65Xv4rh4n8OfQTs=; b=ZMqM5M08rqcvKZHvSfF1grY9n393UE
	0uf/NVG1riAfqX6fnwk8A/8Fc4y2RJ1HDSe+n+ZQeg6MM5R5rmzKBTnLYmX3b0RQ
	G7CVRRJ6n0VfcpizQM691yV/ChcIYaKwdRlVvCqCilEEYgAEWk2Pb86UZifRwc4j
	HSWfQXEjZ88wYuL9jfU4DywJylKfW3BC55s8s23PmxhJUQnQ/MRDy7NKSZUMahKs
	Y98elHklPajYu0qzSGZkgTBpwVK8PrKC34p7Dc6j1C7NFgJgJ1QM4Uik22bGCeRN
	fvhg7kME4gWxWTJhwG2mXSqw9sYQJZ8Aiv0iZjd0IyiKbNP//8HoF2ZQ==
Received: (qmail 892779 invoked from network); 14 Sep 2026 23:18:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2026 23:18:44 +0200
X-UD-Smtp-Session: l3s3148p1@1l6e+ndbcrYujnvr
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rtc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/6] rtc: rzn1: cleanups, no irq support, R-Car Gen5 enablement
Date: Mon, 14 Sep 2026 23:18:25 +0200
Message-ID: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main intention of this series is to enable RTC support for the
Renesas R-Car Gen5 X5H SoC (patches 5+6). Because interrupts are not
wired there, patches to make interrupts optional are included (patches
3+4). Some cleanups I came up with are prepended (patches 1+2).

These patches have been tested on the original RZ/N1D board and the new
X5H Ironhide board. 'rtctest' passed on both SoCs. On X5H, some tests
are skipped, of course, because no alarms are supported.

'dt_binding_check' and 'dtbs_check' also did not find any issues.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/x5h/rtc-experimental

Looking forward to comments.


Wolfram Sang (6):
  dt-bindings: rtc: rzn1: drop unneeded 'start-year' from example
  dt-bindings: rtc: rzn1: add SoC names next to their IDs
  dt-bindings: rtc: rzn1: interrupts are not required
  rtc: rzn1: make interrupts optional
  dt-bindings: rtc: rzn1: add R-Car X5H support
  rtc: rzn1: add R-Car X5H support

 .../bindings/rtc/renesas,rzn1-rtc.yaml        | 19 +++---
 drivers/rtc/rtc-rzn1.c                        | 59 +++++++++----------
 2 files changed, 38 insertions(+), 40 deletions(-)

-- 
2.53.0

