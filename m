Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FD34F27F;
	Thu,  3 Sep 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421618; cv=none; b=b9mpdMAh2utEL2oXgNWWCza5PzZiUpHM4yPHVar7TkREYRwWbEkoOgB4WY/p6AVjqL2jglBaUPmRmJwmP+eB/BdDQtjpUIy/OkU9c+/XhdyQCkG0zJFO9Ab7BsdkePonFK03hmQi9730Gd16uYb+jtYrrry/v1nILPe71elafo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421618; c=relaxed/simple;
	bh=spMD8vZ7M1VL4J8XbtU3xQnEOII+8rCIt1dRwSRZxDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0CKAObpBhzRfzFoR+gCoShAQ0yIzUOAlONcIBTQ6noWVcHEEKiDVMcAweVlC/ZnqGdHYXXjc/qoBLDu2t5r9bVLT27bHix0zg8/E9BfL5GBoab9RNEhTGCMAg1/+23ZkmkvL+yPF9/LH7CTe0oDL14AaRHXJYGMrV9Em4jopGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+0ng5P1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYoZwfqG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+0ng5P1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYoZwfqG"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDi9D7UWYmW+7+A4cGT4drFBnCH6B2iiSY+Aul2GqFM=;
	b=g+0ng5P1EHTqwg9xNtKdRNFd4/ydxGkmNeAqdiGWDtqPBXDkdKQkyBU2ahCu8+tx6rAZiq
	qhIg9ufPrm1CC8tK8O5Vw7A7eYOS7BwPIs1RLibnugY1CIflXUZk6Thqf3MPUUCFWWTJXm
	CEOT43CUvTiqYNFW9zc5neDG2JbLWdbeZtXXXpXzM8kzqzFPxT3eRRT/mwDaq/3Y6eEnNj
	wR9Yph7gyE2VTkepQ6SOEFwqwtIJ4p5V5+cr+oRrJabJStMamgedMFJHoZP3idZfOX8I9B
	WLQFYzUWXSsna/4D1pfIUKzsQCsgB/rYYD9y9U9H61TAs1UVNFhkTG2cxqY2PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDi9D7UWYmW+7+A4cGT4drFBnCH6B2iiSY+Aul2GqFM=;
	b=cYoZwfqGxPB0W+vYuqVJb6woLGUp2xzeUqZxpqnLWPwvFyp7KiFMufFxvRWGawo6SwS608
	oA2neaf2HAImCnAw==
Date: Thu, 03 Sep 2026 09:46:50 +0200
Subject: [PATCH 1/4] time: Avoid 64-bit by 64-bit division in
 time64_to_tm()
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-time-time64-to-tm-v1-1-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
In-Reply-To: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421614; l=1104;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=spMD8vZ7M1VL4J8XbtU3xQnEOII+8rCIt1dRwSRZxDw=;
 b=VcVocKPY9nygpEwwoJoJThN2jtRjwv13u8pqIh312YQdjtARz/i9MASjku5q9AdRPJvBqDf/+
 lXHJVXmu/vWCI38Ws3zCVwRyYMLYgAPh3REYygGiDJ2lTfbnsnhN18h
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

As the divisor is static and known to fit into 32 bits, a 64/32 division
is enough. The 64/64 is unnecessary and very expensive on architectures
without native 64/64 division instructions.

This brings the time64_to_tm_test_date_range() runtime from 45 seconds
down to 30 seconds in an emulated 32-bit ARM machine.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/timeconv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
index 59b922c826e7..779b91898276 100644
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -105,8 +105,8 @@ void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 	udays	= ((u64) days) + 2305843009213814918ULL;
 
 	u64tmp		= 4 * udays + 3;
-	century		= div64_u64_rem(u64tmp, 146097, &u64tmp);
-	day_of_century	= (u32) (u64tmp / 4);
+	century		= div_u64_rem(u64tmp, 146097, &u32tmp);
+	day_of_century	= u32tmp / 4;
 
 	u32tmp		= 4 * day_of_century + 3;
 	u64tmp		= 2939745ULL * u32tmp;

-- 
2.55.0

