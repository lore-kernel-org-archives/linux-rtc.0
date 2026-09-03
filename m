Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B8367B95;
	Thu,  3 Sep 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421619; cv=none; b=LsP1C7qViIY3md/JHUrXkDe90+LG0x7DQCU5ESwt9cLt17qqTVtizu1fcz2vfIvXhfHacQznWcmj8X7Ys2uFG8WcyKYHg+nFLM5qIyQSEFVCzCeTKvlWeNH1x//wR+h/oN2CEkwJelbXgs3AtxgYXBDWVa7c3HtApF1CjsGBfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421619; c=relaxed/simple;
	bh=c/r00Kc56rRp8nKCPC7Nq1p+PVKOYNpiEVhF/GQ11V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5jAzsaA/tFGokpQQ7oZmzTJZ6J997qwmqSJaHE3jqH05ZrLx+Uzo+DtKbzAR1HY3OOGB7efF+JFgR5yYL+O1GTkNzhArchr2szxUQrl+DDAzdvZC4WJZO/3rMXtpZ5owSP7jN4T6ANArDpP83IK8FYcR0md6a1tQ2qMcwsqPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySimOkGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/ZkWrH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySimOkGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/ZkWrH2"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jovYjJSbPo3ySjvlgqdVO09m9BSHrSPSClOaS55PBy0=;
	b=ySimOkGKJbyb3ho9VXdgYeaqfygtg1gsDIOKBfEQEjf7LJ8MoQL8BdFCLLfvLclDcKeZgl
	SpkPLboxOHmMmjvN/K+55cdGVH1In8fOy2Rba6QU0Mjdf7DBe1dZttVc6hipgGklFU4zWm
	xJi92WeXcobnvajyQgZ4zAUqBtr+FRudQY3TlncSrFNTuD11XnnB7hiknfHt4Lg02PdhZw
	CAoVJpvTodZwfvmcRuCG5Pt+a9IdArJiX669Fc357AkJCxtNZTHDYrA/L19kF3/nXWSxKd
	ZnFBy8NkY5+k9JlDGQJg8uZboqjuSTINBczfysbyoYrjNsgJiLpsFlzbAsDs3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jovYjJSbPo3ySjvlgqdVO09m9BSHrSPSClOaS55PBy0=;
	b=P/ZkWrH2NrSDxW016hfijKEwVzvDOLqVev0NNU+UC0IP2Bl/VwXM16N55O9xukF/ymXoO7
	kNwXfd0F9aKuSvBQ==
Date: Thu, 03 Sep 2026 09:46:51 +0200
Subject: [PATCH 2/4] time: test: Avoid unnecessary divisions in
 time64_to_tm() test
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-time-time64-to-tm-v1-2-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
In-Reply-To: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421614; l=1277;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=c/r00Kc56rRp8nKCPC7Nq1p+PVKOYNpiEVhF/GQ11V4=;
 b=T9OHYtxuMVYzMXprMDavI7kUo53194cqI2Zqz3q/HlbUh8hsmHaORDs8XUs35xmVriSjT43aI
 mviIcwwV8/4C/jiYMIBWOBB2ZsN+Dvlx1THrWRcWL8JUvtq0zXnD6gz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The time64_to_tm_test_date_range() test case is slow.
One big part of this slowness is the division done in the test loop to
calculate the current day from the current seconds. As each test loop
advances the time by one day, that division can be avoided.

Remove the division and instead increment the 'days' variable directly.

This brings the test's runtime from 30 seconds down to 15 seconds in an
emulated 32-bit ARM machine.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/time_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 1b99180da288..70b20c5c7336 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -69,12 +69,12 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 	time64_t secs;
 	s64 days;
 
-	for (secs = -total_secs; secs <= total_secs; secs += 86400) {
+	for (secs = -total_secs, days = div_s64(secs, 86400);
+	     secs <= total_secs;
+	     secs += 86400, days++) {
 
 		time64_to_tm(secs, 0, &result);
 
-		days = div_s64(secs, 86400);
-
 		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
 			year, month, mdday, yday, days
 

-- 
2.55.0

