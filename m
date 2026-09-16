Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1046EC6B
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594311; cv=none; b=R2LjVaMIYundWDUWum6SyG1xwD7+co7pso80XwSGF4+pHH3aOYRKS+tPcDN1xY4OxtNEbrfvHsReJ9qiBBd0F/L/8I0Oc7wT8Xpjj1QM6hxatYVu/hu90CA3fwMoa4MkmU66dZOZsrr+plX3XDhzMEtKiY1ypMK1BdVMH/imQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594311; c=relaxed/simple;
	bh=ZsvSXiqNsLfAr4LFp0pHrZUCYOdwEgL7ci7xfjV8a/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLf3/VGtuzGteI69TRlkrNf1iIDbUM72Qxx6mITF21offjnkL3N4Y9cX4K8lKF2I6+6NspxVTMBje2tPr06EjmSQQ9XBf0fTVWx894PtYRDaKyYGlN6ib36g3b8ECeM8GMmVgcpSGc06WythgnlvHW6ehOzY/ScNfv8ud6e8qUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=F89/2q7y; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="F89/2q7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=pt82lu3/+jIj3w
	zczHyzszgf1Ot58wJ9a0yknfQ7aTI=; b=F89/2q7y9kgdmQwyGm7GdCQ5XcrONU
	q/qBCNFtrtP8KwMfwtJFLfyPCuTZx5Nk/9SG6QbN80rCDrwuBBdLMn5xroxofGyP
	EBRJUOUdzhIXbuetICt6D05Q7JbjavUObqxl37MZaBElMx8x+r46i7IO06S6rujb
	XTfPpX3+RXD+ZzjHgEDFqap+ZoFcSjsZyF7holThd6q+md/uC/9BE9xiPdg5og21
	4s/qDYcIVPV7gvUJwvAgAJKYWsSpaybJqf2GwZN+bHgFUncVQl3YQizl7m4cqT2P
	81KR2P19wvqH87IW9QAL5CWR1WhcLlS/n47wPYjeLRPg8AQy9vt8cn7A==
Received: (qmail 1715316 invoked from network); 16 Sep 2026 23:31:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 23:31:39 +0200
X-UD-Smtp-Session: l3s3148p1@4wx9ZKBb1sQujnt4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-rtc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/3] selftest: rtc: rtctest: improve handling of skipped tests
Date: Wed, 16 Sep 2026 23:31:08 +0200
Message-ID: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are some fixes for issues I found in 'rtctest' while checking RTC
drivers. Details are in the patch descriptions. Patches 1+2 have been
tested on HW. Patch 3 has not been tested, just follows the pattern of
patch 2, but may need more discussion in general. Please read there.
Looking forward to comments!


Wolfram Sang (3):
  selftest: rtc: rtctest: don't mention skipping twice
  selftest: rtc: rtctest: make missing UIEs really skip
  RFC selftest: rtc: rtctest: skip properly if setting alarm fails

 tools/testing/selftests/rtc/rtctest.c | 49 ++++++++++++---------------
 1 file changed, 21 insertions(+), 28 deletions(-)

-- 
2.53.0

