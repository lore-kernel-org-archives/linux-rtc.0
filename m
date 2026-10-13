Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FA4FB9A9;
	Tue, 13 Oct 2026 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892992; cv=none; b=nuUPeHOtN3Dd8ynnu6JN46dfNce7GXAFVq6VNrdM96nc82m7koy48JEYRinRVz+UDlRrgf+QIDk5GBCgTTirBnR7kPoY/nU09VUHmCUKdHKbyyPZz+u739XWKSxI4a6aIzE7OduRPoJkpj0hNAoxzBWnVwOcW+Zac/7b38cQUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892992; c=relaxed/simple;
	bh=nsCEk4Xy0Nc/KnAscQDMPn9+yzMDsizp6V9dgG2zarc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVWU5pLkqIkEutsFLPk1UjYLfKivM2vbPeexlTmG5C7JIremo1+Fqw9gl99HM4RxlgCQp7BzgqNr5ASlvUUQB9an1b7JB7GAyYkVGeed8qC9dvXnJRDJOwNihcu7W76dIHNwlh7BDIkHAhBtyWpMecjTNB500bbP3BLdpHlIm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibp9Pc08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibp9Pc08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A671F00893;
	Tue, 13 Oct 2026 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791892991;
	bh=f5BzAqkkgihy7La10LmXTE9Yq6YBP0nQKPfTxcUA0g0=;
	h=From:To:Cc:Subject:Date;
	b=Ibp9Pc08jJOjT19i0TrZdkrrhGk40hwfoDKNTcUjD4PlBX9lJuI7ZMZAYrtz4lkuG
	 o9bmawX28Mq6Vlhr2i55Fq8ySCloHrlm0tZltj7Og88REuZ/Ju4rVdENaCzex+E21Z
	 rj7Fwr+d82t/RcVaJgCfFK3jAksmaFcMwCxd12aRNO2vtmjJsUWrbCO2ROalCZ4PLD
	 BqJlIK7LBvMtGj4veC+z4eBz6MCCy/nlFtRcp3rnrPzyK/DbsPg5JQqDnd9Zx1KPjI
	 ChfLl58vpEcMjohwki/wxCHK5ncI8xZnlRlBKY4MywkeVQUxdD1eE6KjGga0YRFSFL
	 pWe9+DC7wBvQg==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] rtc: ds1685: power-off fixes
Date: Tue, 13 Oct 2026 14:02:05 +0200
Message-ID: <20261013120208.11268-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three fixes for ds1685_rtc_poweroff(), on SGI O2 and Octane machines.

Patch 1 arms the wake-up alarm only if an alarm is set, so that stale
alarm registers no longer power the machine back on.

Patch 2 replaces the sleep before the PAB write with a busy wait, as
power-off handlers must not sleep.

Patch 3 repeats the PAB write, clearing the kickstart and wake-up
flags with it, until power is removed.

Patch 1 was tested on an O2, and the whole series on an Octane.

Changes in v2:
- New patch 2: use mdelay() instead of msleep() before the PAB write.
- Patch 3 (v1 patch 2): use mdelay() instead of msleep() in the
  repeat loop.

v1: https://lore.kernel.org/all/20261013094930.574-1-kaloz@kernel.org/

Imre Kaloz (3):
  rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is
    set
  rtc: ds1685: do not sleep in the power-off handler
  rtc: ds1685: keep setting PAB until power is removed

 drivers/rtc/rtc-ds1685.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

