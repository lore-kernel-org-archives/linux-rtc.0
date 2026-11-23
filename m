Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421161;
	b=PktIKvJpv8Khs9Le4JEgBgZeQJJnPhge0vtpPC9v3AJJ6LtlA29/IpG4RSIYz1y87CrW
	 UiVsGUMZJod/TNTtNPPNWUKgJvkMX0EjBOqyqNNWfH555/hSxbePFA4VQyvzWoBK4ULrr
	 HYfqrJMDmZ+rQoUQjNLHj4aw7rGXKRyMBOp36GrqDstizx0J/sqQ1u2J3ufDQcwq2v46g
	 Ho/3HFLqpMi3EWHm+XbK3RIYSczUzkZ07iiI5qUvaU0pcPIs5A2GnTkHCxGyyUOaAxuUk
	 yykMouPuG/lA1r1ivMkAbykWoENH52a4jQOygJNHAx4fOm6MG6rBHTKzvEnermaROpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421161;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=LjV+Ox4TE21vMNK04mNobesBogr9Fvu6zs6F4qpkuq0=;
	b=L5jzetpFowLg+lU5JIw8OOMg4/0LseTHrmpdkUkjnzt+UNe6t4krI9+TPAJ5cokmM9b5
	 yS/KeHOX8WFMtBvzowqXYFFWdT4A+yZCPe0q7MdNBU/eH5U3TGoQhU4Rqe+VXeAhhYkvK
	 UpMWOsrmSaObAaM53+twN82d9DoNSviMvLzq6G4aGRJWgYahImdln37YlIIjx2+JzRgo9
	 CWYBypi1EkUHWkDoDd+19ujVsSF2DGwzlVI0gwkjdenyiMVm32WjUoyCGu22d6w1VkBPB
	 xprB+Y0m65kZXGrWZy1mrRcDDhHIG8l6iXcfrmEJTnFbQYEHxrE7uB3nj7sRntAkgsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UOIajxxD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZgWU9pih;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C661606DB76;
	Mon, 23 Nov 2026 08:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C661606DB76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UOIajxxD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZgWU9pih
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795421158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjV+Ox4TE21vMNK04mNobesBogr9Fvu6zs6F4qpkuq0=;
	b=UOIajxxDicB31l+FN/k9CFaSvwHgGLYYEyUz4COO/yxrtEtOfjjCyM6Y++hDJryuMDQ3NG
	+BxGCe0W/+YWAKGoltPHFZFUDb8jirFceEY0SuRnPbhoc1u0wj3KVYHCUOyEV8HlF/c5sq
	rG3ZmSA9QQDSZ6LBZ0NuTTg/deFDjKgtWeakpPWLL2WkaGD9J+jmI0YM20JVU6KDFFrevJ
	627+wbXH8FQ60+lTzPjt/VaWs27UuuzPDSGK/mNASaN1Imrgg/lgvCMcqTEMUZbmnd/jDw
	nSdmVgDDbOo5yqztPEld3ocZ30L2IyKPkyepfU0xZN+HiXvFYAAyi4HYdb4LfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795421158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjV+Ox4TE21vMNK04mNobesBogr9Fvu6zs6F4qpkuq0=;
	b=ZgWU9pih09AwVXcRLXmbZe3sF43Nf/tygwoQtRv2QAOy+Ib88mnLR44NAon+6X3ePchcCU
	dTL+8UqyQr080DBw==
Subject: [PATCH v2 0/4] time: time64_to_tm() cleanups
Date: Mon, 23 Nov 2026 09:05:08 +0100
Message-Id: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQqDMBBEf0X23C1JLFF76n8UD5qsdaEmkqRiE
 f+9qb32MvAG5s0GkQJThGuxQaCFI3uXQZ0KMGPnHoRsM4MSSou6lJh4oiP0BZPHNGGjRWfq3th
 KDpB3c6CB18N5bzOPHJMP7+Nikd/2Z2tE+ce2SBSoteipqVRnB3N7snul4B2vZ0vQ7vv+AY2wB
 A+2AAAA
X-Change-ID: 20260831-time-time64-to-tm-960ac8bcd71f
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Cassio Neri <cassio.neri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795421157; l=1308;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5aeNb4E1fa55rGB+2CaiPtCfC08gFGaBi4bblaP4n14=;
 b=qac9w+jUZRpevZjGqc312YVsvtoDpQi4VP20YzMgu0SA9e7/73HiWeGZXQw6mw1TYXgdPc1H7
 Hh5LgJbbYmDAnsRdtnib+7/VzoSkNVXzCH3PQs/TDVVaLLU+DYuwsm0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Speed up time64_to_tm() and its tests a bit.
Also drop the custom implementation of rtc_time64_to_tm() and its test.

The series could be split. Then patches 1 and 2 go through timekeeping
while 3 and 4 go through RTC.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase on tip/timers/core.
- +To Cassio.
- Link to v1: https://patch.msgid.link/20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de

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
base-commit: 0359ecff58853a491dd0f09792fea8e87235ae06
change-id: 20260831-time-time64-to-tm-960ac8bcd71f

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

