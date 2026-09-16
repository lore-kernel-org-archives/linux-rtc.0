Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033A4E3EF6
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554341; cv=none; b=pwx+T4lzH1DWJjUFv7d/CdBdOXSnoAP8dkbPJWJT42Vg097SlWxej5990GV2LxTF4Y+NLFA05CChsFfhjUjflocyGOqagW0emagmhAY3AWp78Uy4uF+ja9Sf6Ts4EJI/EKh26lWbsk9fDfIUe/TVGeKPEt3Cr0ZBAwS9gEHji0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554341; c=relaxed/simple;
	bh=mWXgjyyi/opK9juHva65Z9uXJ6Nvmc4nZLFkL3jNTCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2hn1ESafq7uIbMpzWtIikyqQONvlj0HpbbNWsBY49r2QTAa18sLo2n1223rgLMgs12dw5E7zmlEJFchCW+n2/uuHfehYiCcA/RL0dCfoN0Q0vRGbzB7aIdOtapjE4qg55dsFNGyeij033iI3LyA4dsLYR7i9xnWaFF6rHKbMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J+U+ewFK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J+U+ewFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=e5Y66/jrSsxtvA
	+3jkqvBmMj5YOAXyfEWuQ7W+jFODE=; b=J+U+ewFK7ntZUGQAjkUK461rItSsBP
	o8A+j79gdW7bMgcrC4b2OIV+X39JtryK9IyQMKmqf7vvjeebO7JmnWuQGybwpzck
	msyq2B6WdGvJFPAMiX/2EH8pu33h2zQoTvaQnF0VqU3zE8DtU8lIfOgoPQKsOojG
	ovCKSJihsuFb53FiMoHC+UXiZEXfghV8iChaE5Lk64bFksyoyKbNubKY5s4oclsH
	ixy+rZ/YQsIZjzryTs8sWvnjmBcgem3v37l/jdE/Rvgh3uOaFzMNzBUab1P64Wn5
	Bb6CLgoEroHxUDA+2FPGlKs/p6UMGsPyPB8ITcKoyle5gJ5/qVMNigoQ==
Received: (qmail 1502810 invoked from network); 16 Sep 2026 12:25:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 12:25:21 +0200
X-UD-Smtp-Session: l3s3148p1@8cWhFZdbeIMujnt4
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
Subject: [PATCH v2 0/4] rtc: rzn1: cleanups, R-Car Gen5 enablement
Date: Wed, 16 Sep 2026 12:25:15 +0200
Message-ID: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds RTC support for the Renesas R-Car Gen5 SoCs.

Changes since v1:
* don't support non-interrupt mode in general, but implement it only for
  X5H while still requiring irqs for all other SoCs
* add tags to cleanup patches

Thanks for all the reviews of v1!

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
  dt-bindings: rtc: rzn1: add R-Car Gen5 support
  rtc: rzn1: add R-Car Gen5 support

 .../bindings/rtc/renesas,rzn1-rtc.yaml        | 33 +++++++++---
 drivers/rtc/rtc-rzn1.c                        | 54 ++++++++++++-------
 2 files changed, 61 insertions(+), 26 deletions(-)

-- 
2.53.0

