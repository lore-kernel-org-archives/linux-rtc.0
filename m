Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3E3E024B;
	Tue, 13 Oct 2026 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885035; cv=none; b=MGIHw2zvRIoHb+APTYeIlO9A2aXHWRXxm4XcPEvByiOnnvskqAZ63kkhrOnuAwqibHz9mqM4KmYzxJY8NXngMr+yYWAq4NTaq+87KNe6lIPDutpZl4Ls9fvDXTlaXwQkR9vhmAYgJVJNVVpLPNN0zi1nghmrkgjslcXbgRYBMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885035; c=relaxed/simple;
	bh=7i25SUvDXCuzcHvzLFVyPkUVv3Xfzguoos+J/kmQLgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYrv4kz7ngLXEGenRHifdn73+LCh+8OKUYXddP21XvFXAy8hY14wPBX/eGL5uapoznJngwO7G9y8LHmlzfpkWZhppGq1wgCtZ2UjQu5nQ1Q9WDNbgn3MB4cWI1M6itfbrjfa0hxXxKN++3ISqQ8VC4BpqNUcTN9Z0KmXvrMZaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc+Vq78z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc+Vq78z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58041F000FF;
	Tue, 13 Oct 2026 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885033;
	bh=lVLNtYZaKp/NfCDngrl67OkDk00aa97RwcKr4OWwUk8=;
	h=From:To:Cc:Subject:Date;
	b=Wc+Vq78zRDbJSb+e6/0+9pnwsfgYUNayzK0wteMfax6ltbDYRf9/bg93UGc9LWuc5
	 tXNG31Nf0ipVn0JxtLrKUorjzF2SA4gH11NsS/vAWYmCbmUcKXU7Q+v4pFmINR3cRq
	 fLmjmtC62ZemSy23q2nVlTM+HCAa+BvPjQmDUwx3LJ8dPcX0/hqCytCduyf04CIsus
	 AzAu44K0csbJfSOqw0bSx6L4ixefPGApURdOZFaJ+yH9apclJIfeRwctgDTA+mAvqN
	 WU+MDTyf177eNwqN3z5Ra8sP4JReLmmr6kuWuxSBLcxzFqXGGo84uLGAk8AvA6+o5+
	 aH32njUVcbY1A==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rtc: ds1685: power-off fixes
Date: Tue, 13 Oct 2026 11:49:27 +0200
Message-ID: <20261013094930.574-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for ds1685_rtc_poweroff(), on SGI O2 and Octane machines.

Patch 1 arms the wake-up alarm only if an alarm is set, so that stale
alarm registers no longer power the machine back on.

Patch 2 repeats the PAB write, clearing the kickstart and wake-up
flags with it, until power is removed.

Patch 1 was tested on an O2, patch 2 on an Octane.

Imre Kaloz (2):
  rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is
    set
  rtc: ds1685: keep setting PAB until power is removed

 drivers/rtc/rtc-ds1685.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

