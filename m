Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421161;
	b=YusV0REAC3KhIse9OgqiN+67Z3nyZKUIUzddC8m0Xd7UUN7Sh10aGTK6hfu6vMG3R0m5
	 Irwe0b/UsYrZOtTj90dCIn51AEHmHYVatmRPUeYL7o0HtO4t3M+xTwjq2IrMzkaEJIVu2
	 Wwuxo6Kl+tSjN7ShZNVSuivWVxsry6VypzVYxHcOfh21U/McKpkQr8U7fIkUBRPtes/aa
	 zXNsi3hTAJl9xKUuEOuzDzoMrYP6ttzEmhpc8jsDGRKrfI+TS2zTfn3oVveG6anT6NX7t
	 oqloeWgQnmixWSPJEgnGDUpzTRZ+ZE88XG3Ni14pu8NQaPgqEryKmpF7WiUF+T3DBmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421161;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=S+DkpgM/f1BqR3wKUmIV5ajih0kouMUjo0kYGu1jT0k=;
	b=EJHZL7XVa0sj+zqI+Rn1G8o5xauZFQFaYD6yyg8M4Hce5nAiSXQA2HVFgxtDp+bwA4Km
	 0Ec9d8HHTo3MftYoB2oYKPVqPhRUN500w4rVu5y2hw/7AL6rqQofgfV4zYs6Ki7QQIO2s
	 /7wXkf1bU+VQIHZTF+p28xFA+vN5iMXePl+yEGq0y7HSLgSRDI02b2dzn9QFuHRvw8GjG
	 ZWXjTGFsfw01dYKkW5IyEelFke2qXByLeZzC26KiZV59IlpN+UX3hxWaBZFGHlV2rHWk0
	 caT/UU4gSB/LSUzyf6/H9LwRz/xzNzQk6rgXoIVUOh2uKVjKzBBefTa6mCDGnxaphSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xfA18C18;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GJ1CFMw9;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C682606DB77;
	Mon, 23 Nov 2026 08:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C682606DB77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xfA18C18;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GJ1CFMw9
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795421159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+DkpgM/f1BqR3wKUmIV5ajih0kouMUjo0kYGu1jT0k=;
	b=xfA18C189GoXJtY7yiDb2e125DcFrLlebB/xo89fTpEW758VpYsLYa297IoR91uQSTVqW3
	6dwPXo/q0Wv1GrqOpsCr6F5CHsuTxSnRw5/4AZHF8ZAIwddFlpsiIcHkwJrOb1vA14TWEU
	8zugvjh4piQOQUPGNtcPzE3oS+8rCgpLM4htE99/4HHEPRFxqWiidpbcwwUxlqlWX83tDC
	sGegi8ZZ+eIiXN1WPkdNH+QhrkH1/U9CGlglo5izU0AJ69rThEnQeo7kHosLsdlorR3LEP
	0Y49b7WuANSJKM+Nh06q/kciNFS+bYALta+3JdSSKsb6DucHaV94h157P5jH2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795421159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+DkpgM/f1BqR3wKUmIV5ajih0kouMUjo0kYGu1jT0k=;
	b=GJ1CFMw9VNXn4I/An3+XxZs1+/8/iK+WGZOsNjNjZmoyJaqkOoopDCqOpaJ4QL0uzJjZWx
	mBhaXSG2USBOy1DQ==
Date: Mon, 23 Nov 2026 09:05:09 +0100
Subject: [PATCH v2 1/4] time: Avoid 64-bit by 64-bit division in
 time64_to_tm()
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
Message-Id: <20261123-time-time64-to-tm-v2-1-117cf8afebce@linutronix.de>
References: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
In-Reply-To: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Cassio Neri <cassio.neri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795421157; l=1104;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Su6vtivmDdtDqpZXHC9ufYwCuQh7ogCQMpovA+8YW00=;
 b=Mw/GgNbA8sQpnopd1zpBs/rM5iI79EEP9Clio42OAZmYtZkP0TV3OVcAJbskgxyNfXoO790qv
 3SH/2fwtZDlD3BwpuaHFbHt69zV6aOShyUTafaRAzD89CfZtQqDnQkO
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
index aed3af950fa0..d6ae53f67521 100644
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -107,8 +107,8 @@ void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 	udays	= ((u64) days) + 2305843009213814918ULL;
 
 	u64tmp		= 4 * udays + 3;
-	century		= div64_u64_rem(u64tmp, 146097, &u64tmp);
-	day_of_century	= (u32) (u64tmp / 4);
+	century		= div_u64_rem(u64tmp, 146097, &u32tmp);
+	day_of_century	= u32tmp / 4;
 
 	u32tmp		= 4 * day_of_century + 3;
 	u64tmp		= 2939745ULL * u32tmp;

-- 
2.56.1

