Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC94B95D7
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643646; cv=none; b=T8Wduf/ZPcceEewH0nuqZcuEZ16tsHsZerCqQTMItkVlUmK9qYQYUDRynKam3mwjQxlnZ0mSQuH/sGzntVDqzifN/4on5jdIlUl6JFFY03lluWcrsm0mwZgFeZBrT15g/hQV8dgERIPtDww7YWRY+JC+r6c0hJkG0xOt4+HaB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643646; c=relaxed/simple;
	bh=RWEM1vXg6B0rjO/xzeRw2xVXvn2nvQCQjnL3OJLy1wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6LjBi/nAmG5ueBRAUJK1/eXTgT3ru9c7KDdXsYUtLBpLeBMjU9I0Dyc6rox4RIEkVMdgvGwFfGbz867dnCGbtk8r/nQEhtzjL82nXBwA+fSjGmGJ8iSdOAXtpqUEZryLHcTEca+skIIUmlgkiImuWh7TIG6hApvjTE/jcLQ8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iXm1At/h; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iXm1At/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=5mhpBttZ9maKZ9
	oMAMBRgQbCr9Eepm2HE80S9LJIx2E=; b=iXm1At/h9a9q6QxcBKwuOS82zM7exu
	9OsRzAXlcgGqvPgNJBT9+IyMk/AT7tqbDjEWLubzZFk8NkDI0prB1tsHe97/so4A
	ombr7mfOQt5RqIzq0TryUgh3d9hJIqUZEISGSSaRsK1h7/bG4579RYe0EJ6gp8xT
	n2XzVwln7faPKVhp1WR26pF/Gki89OPR6Y3q9KLYkPEXh1w9CXizMCiTPOwv3jty
	WDafNTAvHjH+ABc9Ukfasm5U0DdhEGDIpzqrOwlV45SMbun9YZTS4qDQF4x6IQlR
	wgss8MSwWUDOH4A64N7a/GQ9DE+ZUyhJgETUB7mEc4gtMZ2rPyaWkxrQ==
Received: (qmail 2005111 invoked from network); 17 Sep 2026 13:13:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 13:13:55 +0200
X-UD-Smtp-Session: l3s3148p1@zaom4atbZtsujnsL
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
Subject: [PATCH v3 0/4] rtc: rzn1: cleanups, R-Car X5H enablement
Date: Thu, 17 Sep 2026 13:13:44 +0200
Message-ID: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds RTC support for the Renesas R-Car X5H SoC.

Changes since v2:
* X5H is not compatible with the generic Gen5 family. So, only support
  X5H for now and add the Gen5 family later once HW is available
* added tags

Thanks for all the reviews of v2!

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
 drivers/rtc/rtc-rzn1.c                        | 53 ++++++++++++-------
 2 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.53.0

