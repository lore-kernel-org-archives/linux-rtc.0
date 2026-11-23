Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421161;
	b=kUcAyGSYpzikt8wNQwi77Pxi2KWg2ppcTD8OSvqWX5mQtghfgF7xeFxNLo191CQw8Vv7
	 BihrS+dnMqzMhT5QzUfXmhEvw3H8WI4j17nSx4tYhn5/5uNBZAej7CsYTPDVlyf5W83Bq
	 czPL4bAkLLdJUDtPsp394tPnhjta/TkMYPY+c5dyT0mY74OEPQ1x5UOOzRsqLbXcKsRuK
	 B39d7kKgHXKX7qDxtQvLbrjWkVPuLHe8ONRqKkgq+9Ol5t1BIRRUA2kH6pjSGp9m8+57e
	 EyYm4DQV0+OJvbCFN33RXeAOZeyI4Mz15KlwrIvms+I3+sGpZMaJM+fk1DL+GMuZk3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421161;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=/6xKh0Y76+vQBXTX9pxqtoDemLDsQ1nSGr83z7rX4JM=;
	b=aDaPs4pqs8D+cFCws6YLFQiPNYxeI/tF8fBJy3GZm88SqB5FmGknuW8hQUTSinGZyWrP
	 RLk+YzeJf7C+wYsg+K6oNeWvlKNV6Juys6Xhpt8gZzX02W43n2cQIFiv7J+S8C06WEmfx
	 2c7BBnJO3JxirgyStmUusYyeS/7DWwggiRCab1QUFuc3NMsL91MVOyPsoA03B8AxW6WY+
	 UVAoCf/DCmh31XusgOKoQfjC+nbQLu3g6pdQsqjVHrQgVQgqAEjat2WIQ/2Ek+l5fAPCV
	 VqRkzR1VpgoxGqzOlnlsRJ0TUPJ26zgZPGgrMnfFHzvLI+j5pT9mYXpsW2Qq2P9l6LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="LL/yONXR";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nkKZHq7S;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFC606DB7B;
	Mon, 23 Nov 2026 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DDFC606DB7B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LL/yONXR;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nkKZHq7S
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795421159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6xKh0Y76+vQBXTX9pxqtoDemLDsQ1nSGr83z7rX4JM=;
	b=LL/yONXRwlGJx9yD5dYoJs6M8Txm/mGSpGRYH/bLP0KMfiuyAjKVD67f+K+rz4u7au73A8
	cOJTWRS1mWi6r0hsJLgYuuRilhAP0utx4auS3L7CcaHYvbCj5SM34KKxM/0dLwgziY/+nA
	V0bwnWeJy9sPd+I2xxFA8htc/Ux8cF4azJmpJZF/y7nz2QCC7FIu3MXsG1XwNDlAaCh2iG
	UpQpZ6VgSYPg6vyRpNBSHZdP1sW8kM9muxAKv21Dic5LEfJueQyKR2miqn53u9MF0FKVPd
	vohpEKqdpsmssPbPRtIfL0OqtjjPd/a3i57K8dpCXwOLTG8fsp+uqSAq8NhLwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795421159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6xKh0Y76+vQBXTX9pxqtoDemLDsQ1nSGr83z7rX4JM=;
	b=nkKZHq7SGxP0nHhvjnBSQ7kNNjIj5I/a41Hrb/+FGVIAr0lumPzEWLVo82/KYVWZn0ISsl
	a37wCXbmPAGmH/Bw==
Date: Mon, 23 Nov 2026 09:05:10 +0100
Subject: [PATCH v2 2/4] time: test: Avoid unnecessary divisions in
 time64_to_tm() test
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
Message-Id: <20261123-time-time64-to-tm-v2-2-117cf8afebce@linutronix.de>
References: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
In-Reply-To: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Cassio Neri <cassio.neri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795421157; l=1277;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ta5/U3sTyAE1woCYesMyeJ0BDSsJ99j4RW/hkwicfpo=;
 b=J0kOxXMLgpAsEhrIfl3X6owaJZauGaT+4sDXbZx0iGcJ8+t5SPyHOGL4YWHbDOk4vVPtuyB6F
 mINPRmyXEnyCw5yMkC+6UzCb+wZo3QtqhP+iXQuyQlrHLR1gXDBnh/u
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
index 8b718767b3ba..41e504aa2883 100644
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
2.56.1

