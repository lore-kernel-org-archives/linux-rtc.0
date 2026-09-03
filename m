Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99A249EB;
	Thu,  3 Sep 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421618; cv=none; b=oUS8UD6P6EizrLl5//z1qJn3MGphvDf44dnMRMFijmDT/n3mlAUO297bqbae9l6oU2hl+jdXppipOH2gUuAxCEBzPDHZL5vKLFfyc9pnHnEsXu4JXrJKFNzngY90hhdsSMpmWsVMUdKMS3SfkPA1580u4Zw598d5bTT/7q58RL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421618; c=relaxed/simple;
	bh=0alexXOhZ3pe8wwcPjr1HedjSmNCRv9G8JVAkGbb1Pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RMyY/kRw1+kb7mAUQSO++19NYduo/WbuDQoJARKvAJbvTNDr4A1QxI13TuIMKeih52E+Xu9FdZ1k7PpQcjfwTNf0q25cJ2Z6Y/kPATRglpy5f4p2YeLH4b4hYvxjE7WfMWS53/yHC/ONjCQlpmps3CCMuiNRTSU+bW6x0HXrQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n6VXsavR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+UmEGJu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n6VXsavR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+UmEGJu"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xol/V+/hywJjcXli4Mhoxh/JGosWE3k6n8FZuFhDHPM=;
	b=n6VXsavRSqljJ+gYz5Z/HOJECVFMmfmZWjJWUh63VMG8uBZ5qqB1MvaOUnAmC/Ptxn5yVI
	NRoQF2REwmFImiBjSt/sRwon2O55DTR4kYJqArMnHcr0/KJfdnUzblKzBkk7ykrrlDB4bH
	xoFbOQJP761eFDE7wGgPNFgWiwiN6PlzofbTSRjilSj0D93Q4nAZqKCAI0xAhHpxJkWj/i
	Gtmf8on6GtMT/nYq4eO6eHztiTNNNi/uTici7gruSrgczYHZCtoTdQ9GID3MtrqiDkCqvS
	kLLSIUMEq1ykN+qrEx3F7ftXJ0ZMV9MYYv19YxxTsblveUsvPy5ahV+2TecEkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xol/V+/hywJjcXli4Mhoxh/JGosWE3k6n8FZuFhDHPM=;
	b=w+UmEGJuonaTsrz29FDKj0Voj8v82wHlaa2v0j9D86vK/JMpdpNTKJLU2U9EctJGCpmsHn
	FZLtJjzTEZC8tnAw==
Subject: [PATCH 0/4] time: time64_to_tm() cleanups
Date: Thu, 03 Sep 2026 09:46:49 +0200
Message-Id: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2ND3ZLM3FQwYWaiW5KvW5Kra2lmkJhskZScYm6YpgTUV1CUmpZZATY
 zOra2FgCqd0B+YwAAAA==
X-Change-ID: 20260831-time-time64-to-tm-960ac8bcd71f
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421614; l=1158;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0alexXOhZ3pe8wwcPjr1HedjSmNCRv9G8JVAkGbb1Pk=;
 b=j0JPZ6MToVAa8JONORlC+2a2H2bW576vTZQYxIz6pC3844++UjNG8fKupPKikaizIoHgYa3Ep
 zIxeYIsUBW7DNrCGHr6t5IzYJc5WSQM6cGrIy//fEGiJo5/5Yq88+tn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Speed up time64_to_tm() and its tests a bit.
Also simplify drop the custom implementation of rtc_time64_to_tm()
and the test for it.

The series could be split. Then patches 1 and 2 go through timekeeping
while 3 and 4 go through RTC.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (Schneider Electric) (4):
      time: Avoid 64-bit by 64-bit division in time64_to_tm()
      time: test: Avoid unnecessary divisions in time64_to_tm() test
      rtc: lib: Implement time64_to_tm() in terms of time64_to_tm()
      rtc: test: Remove test_rtc_lib.c

 drivers/rtc/Kconfig        |   9 ----
 drivers/rtc/Makefile       |   2 -
 drivers/rtc/lib.c          | 117 ++++++---------------------------------------
 drivers/rtc/test_rtc_lib.c | 106 ----------------------------------------
 kernel/time/time_test.c    |   6 +--
 kernel/time/timeconv.c     |   4 +-
 6 files changed, 20 insertions(+), 224 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-time-time64-to-tm-960ac8bcd71f

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

